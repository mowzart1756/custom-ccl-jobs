;NOTES
    /*
    Program: wh_mdm_report
    Date Created: 27th of October 2022
    Description: Report for MDM Care Team Meeting
    Programmer: Jason Whittle

    */



;CREATE PROGRAM AND PROMPT
    ; drop program whs_physician_handover:dba go
    ; create program whs_physician_handover:dba

    drop program wh_mdm_report go   ;drop program wh_mdm_report:dba go
    create program wh_mdm_report    ;create program wh_mdm_report:dba

    prompt
    	"Output to File/Printer/MINE" = "MINE" ,
    	"JSON Request:" = ""
    with outdev ,jsondata

;DECLARE CONSTANTS
	declare 319_URN_CD = f8 with constant(uar_get_code_by("DISPLAYKEY",319,"URN")),protect
	;[1] 319 is the code set for URN on the CODE_VALUE table "URN" is the DISPLAY_KEY for urn


;Call Constants
    call echo(build2("319_URN_CD: ",319_URN_CD))

;Declare Variables
	declare idx = i4 with noconstant(0),protect
	declare patienthtml = vc with noconstant(" "),protect
	declare finalhtml = vc with noconstant(" "),protect
	declare newsize = i4 with noconstant(0),protect
	declare printuser_name = vc with noconstant(" "),protect

;Declare Records
	record data (
    1 cnt							= i4
	1 list[*]
		2 PERSON_ID					= F8
		2 ENCNTR_ID					= F8
		2 PATIENT_NAME				= VC
		2 URN						= VC
		2 DOB						= VC
		2 AGE						= VC
		2 GENDER					= VC
		2 CONSULTANT_NAME			= VC
    ) with protect

;HTML Log
    record html_log (
	1 list[*]
		2 start				= i4
		2 stop				= i4
		2 patient_text		= vc
	) with protect

;Set printuser_name
	select into "nl:"
	from
		prsnl p
	plan p
		where p.PERSON_ID = reqinfo->updt_id
	
	detail
		printuser_name = trim(p.name_full_formatted, 3)
	
	with nocounter

;Add json patients to data record
	set stat = cnvtjsontorec($jsondata)
	
	select into "nl:"
		encounter = print_options->qual[d1.seq].ENCNTR_ID
	from
		(dummyt d1 with seq = evaluate(size(print_options->qual,5),0,1,size(print_options->qual,5)))
	plan d1
		where size(print_options->qual,5) > 0
	order by encounter
	
	head report
		cnt = 0
	
	head encounter
		cnt += 1
		if(mod(cnt, 20) = 1)
			stat = alterlist(data->list,cnt + 19)
		endif
		data->list[cnt].ENCNTR_ID = print_options->qual[d1.seq].ENCNTR_ID
		data->list[cnt].PERSON_ID = print_options->qual[d1.seq].PERSON_ID
		data->list[cnt].AGE = trim(print_options->qual[d1.seq].PAT_AGE,3)
	
	foot encounter
		null
	
	foot report
		data->cnt = cnt
		stat = alterlist(data->list,cnt)
	
	with nocounter

;Get patient information
	SELECT INTO "nl:"
	FROM
		PERSON P
	PLAN P
		WHERE EXPAND(idx,1,data->cnt,P.PERSON_ID,data->list[idx].PERSON_ID)
	ORDER BY P.PERSON_ID
	
	HEAD P.PERSON_ID
		pos = locateval(idx,1,data->cnt,P.PERSON_ID,data->list[idx].PERSON_ID)
		IF(pos > 0)
			data->list[pos].PATIENT_NAME = TRIM(P.NAME_FULL_FORMATTED,3)
			data->list[pos].GENDER = TRIM(UAR_GET_CODE_DISPLAY(P.SEX_CD),3)
		ENDIF
	
	foot P.PERSON_ID
		NULL
	
	WITH EXPAND = 2

;Get URN
	SELECT INTO "nl:"
	FROM
		ENCNTR_ALIAS EA
	PLAN EA
		WHERE EXPAND(idx,1,data->cnt,EA.ENCNTR_ID,data->list[idx].ENCNTR_ID)
		AND EA.ACTIVE_IND = 1
		AND EA.BEG_EFFECTIVE_DT_TM <= CNVTDATETIME(CURDATE,CURTIME)
		AND EA.END_EFFECTIVE_DT_TM >= CNVTDATETIME(CURDATE,CURTIME)
		AND EA.ENCNTR_ALIAS_TYPE_CD = 319_URN_CD
	ORDER BY EA.ENCNTR_ID
	
	HEAD EA.ENCNTR_ID
		pos = locatevalsort(idx,1,data->cnt,ea.ENCNTR_ID,data->list[idx].ENCNTR_ID)
		if(pos > 0)
			data->list[pos].URN = TRIM(CNVTALIAS(EA.ALIAS, EA.ALIAS_POOL_CD),3)
		endif
	
	FOOT EA.ENCNTR_ID
		null
	
	WITH EXPAND = 2

;GET DATE OF BIRTH (DOB)
	SELECT INTO "nl:"
	FROM
		PERSON P
	PLAN P
		WHERE 
			expand(idx,1,data->cnt,P.PERSON_ID,data->list[idx].PERSON_ID)
			AND P.ACTIVE_IND = 1 ; DONT PULL IF THE PERSON IS INACTIVE IN THE DB

	ORDER BY P.PERSON_ID
	
	HEAD P.PERSON_ID
		pos = locateval(idx,1,data->cnt,P.PERSON_ID,data->list[idx].PERSON_ID)
		if(pos > 0)
			;CONVERT DATE TIME DQ8 TO A STRING AND STORE
			data->list[pos].DOB = DATEBIRTHFORMAT(P.BIRTH_DT_TM,P.BIRTH_TZ,P.BIRTH_PREC_FLAG,"DD-MMM-YYYY")
		endif
	
	FOOT P.PERSON_ID
		NULL
	
	WITH EXPAND = 2


;Get Consultant Name
	SELECT INTO "nl:"
	FROM
		CLINICAL_EVENT CE
	PLAN CE
		WHERE 
			expand(idx,1,data->cnt,CE.PERSON_ID,data->list[idx].PERSON_ID)
			AND CE.EVENT_CD = 134666758 ; EVENT CODE FOR 'Consultant' in the powerform
			AND CE.VIEW_LEVEL = 1 ; Make sure the data should be viewable, eg, not just for grouping data in the background


	ORDER BY CE.PERSON_ID
	
	HEAD CE.PERSON_ID
		pos = locateval(idx,1,data->cnt,CE.PERSON_ID,data->list[idx].PERSON_ID)
		if(pos > 0)
			data->list[pos].CONSULTANT_NAME = TRIM(CE.RESULT_VAL,3)
		endif
	
	FOOT CE.PERSON_ID
		NULL
	
	WITH EXPAND = 2

;Add to 'patienthtml' variable, a HTML table for each patient
	call alterlist(html_log->list,data->cnt)
	for(x = 1 to data->cnt)
		set html_log->list[x].start = textlen(trim(patienthtml,3)) + 1
		set patienthtml = build2(patienthtml
			,"<p class=patient-info-name>", data->list[x].PATIENT_NAME,"</p>"
			,"<br>"

            ,"<table>"
              ,"<tr>"
			  	,"<th>URN</th>"
				,"<th>DOB</th>"
				,"<th>Age</th>"
				,"<th>Gender</th>"
              ,"</tr>"
              ,"<tr>"
                ,"<td>", data->list[x].URN, "</td>"
                ,"<td>", data->list[x].DOB, "</td>"
                ,"<td>", data->list[x].AGE, "</td>"
				,"<td>", data->list[x].GENDER, "</td>"
              ,"</tr>"
            ,"</table>"
			,"<br>"

            ,"<table>"
              ,"<tr>"
				,"<th>Care Teams</th>"
                ,"<th>Consultant</th>"
                ,"<th>Clinical Notes</th>"
                ,"<th>Imaging</th>"
              ,"</tr>"
              ,"<tr>"
                ,"<td>", "data->list[x].CARE_TEAMS", "</td>"
                ,"<td>", data->list[x].CONSULTANT_NAME, "</td>"
                ,"<td>", "data->list[x].CLINICAL_NOTES", "</td>"
				,"<td>", "data->list[x].IMAGING", "</td>"
              ,"</tr>"
            ,"</table>"
			,"<br>"

            ,"<table>"
              ,"<tr>"
				,"<th>Pathology</th>"
				,"<th>MDM Question</th>"
				,"<th>MDM Date</th>"
				,"<th>Pre-op/Post-op Discussion</th>"
              ,"</tr>"
              ,"<tr>"
                ,"<td>", "data->list[x].PATHOLOGY", "</td>"
                ,"<td>", "data->list[x].MDM_QUESTION", "</td>"
                ,"<td>", "data->list[x].MDM_DATE", "</td>"
				,"<td>", "data->list[x].OP_DISCUSSION", "</td>"
              ,"</tr>"
            ,"</table>"
			,"<br>"

            ,"<table>"
              ,"<tr>"
				,"<th>Clinic Appointment/Follow Up Planned</th>"
				,"<th>Scopes</th>"
				,"<th>Relevant Bloods</th>"
				,"<th>Cancer MDM or Surgical Meeting</th>"
              ,"</tr>"
              ,"<tr>"
                ,"<td>", "data->list[x].APPOINMENT", "</td>"
                ,"<td>", "data->list[x].SCOPES", "</td>"
                ,"<td>", "data->list[x].BLOODS", "</td>"
				,"<td>", "data->list[x].MEETING", "</td>"
              ,"</tr>"
            ,"</table>"
			,"<br>"
		)
    endfor

;Build HTML Page and substitute in the patient table
	set finalhtml = build2(
		"<!doctype html><html><head>"
		,"<meta charset=utf-8><meta name=description><meta http-equiv=X-UA-Compatible content=IE=Edge>"
		,"<title>MPage Print</title>"
		; CSS CODE IS BELOW
		    ,"<style type=text/css>"
		    ,".patient-info-name {font-size: 120%; border: 1px solid #dddddd; font-weight: 800; background-color:lightgrey}"
			,"table {"
			,"border: 1px solid;"
			,"width: 100%;"
			,"}"
			,"th, td {"
			,"width:25%;"
			,"border: 1px solid;"
  			,"padding: 15px;"
  			,"text-align: left;"
			,"}"
			,"tr:hover {background-color: cornsilk;}"
		    ,"</style> </head>"
		; END OF CSS CODE START OF HEADER
		    ,"<div id = print-container> <div class=print-header> <div class=printed-by-user>"
		    ,"<span> Printed By:  </span> <span>",printuser_name,"</span>"
		    ,"<div class=printed-date> <span>"
		    , "PRINTED: "
		    ,format(cnvtdatetime(curdate,curtime),"dd/mm/yyyy hh:mm;;d")
		    ,"</span> </div> </div> </div>"
		    ,"</div> <div class=print-title> <h2> Cancer MDM Worklist </h2> </div>"
		; PATIENT DATA IN THE VARIABLE BELOW
		    ,patienthtml
		,"</body></html>")

;Send HTML string back to PowerChart for printing
	if(validate(_memory_reply_string) = 1)
		set _memory_reply_string = finalhtml
	else
		free record putrequest
		record putrequest (
		1 source_dir = vc
		1 source_filename = vc
		1 nbrlines = i4
		1 line [*]
			2 linedata = vc
		1 overflowpage [*]
			2 ofr_qual [*]
			3 ofr_line = vc
		1 isblob = c1
		1 document_size = i4
		1 document = gvc
		)
		set putrequest->source_dir =  $OUTDEV
		set putrequest->isblob = "1"
		set putrequest->document = finalhtml
		set putrequest->document_size = size (putrequest->document)
		execute eks_put_source with replace("REQUEST" ,putrequest), replace("REPLY" ,putreply)
	endif


	#exit_script
	end
	go