drop program wh_validate_snomed:dba go
create program wh_validate_snomed:dba

prompt 
	"Output to File/Printer/MINE" = "MINE"   ;* Enter or select the printer or file name to send this report to. 

with OUTDEV



/**************************************************************
; DVDev DECLARED SUBROUTINES
**************************************************************/

/**************************************************************
; DVDev DECLARED VARIABLES
**************************************************************/
declare SNOMEDCT_CD_VAR = F4 with Constant(673967.0),Protect
declare LAST_UPDATE_VAR = VC with NoConstant("Not-Found"),Protect
declare FINALHTML_VAR = vc with NoConstant(" "),Protect
;declare MAX_DATE_VAR = DQ8 with NoConstant(0.0),Protect
declare NAME_UPDATED_ACTIVE_VAR = VC with NoConstant("Not-Found"),Protect
declare NAME_UPDATED_INACTIVE_VAR = VC with NoConstant("Not-Found"),Protect


/**************************************************************
; DVDev Start Coding
**************************************************************/
;Package Install Date
SELECT INTO "NL:"
	LAST_UPDATED = MAX(N.UPDT_DT_TM)
FROM
	NOMENCLATURE   N
WHERE	N.SOURCE_VOCABULARY_CD = SNOMEDCT_CD_VAR
HEAD REPORT
	LAST_UPDATE_VAR = FORMAT(LAST_UPDATED, "DD-MMM-YYYY HH:MM;;D")
	MAX_DATE_VAR = CNVTDATE(N.UPDT_DT_TM)
WITH TIME=10


;Get an example of an active updated snomed item
SELECT INTO "NL:"
	SNOMED_ITEM_NAME_ACTIVE = N.SOURCE_STRING
FROM
	NOMENCLATURE   N
WHERE	
	N.SOURCE_VOCABULARY_CD = SNOMEDCT_CD_VAR; snomed rows
	AND
	N.ACTIVE_IND = 1;Active Item
	AND
	N.UPDT_DT_TM >= CNVTDATETIME(LAST_UPDATE_VAR)
HEAD REPORT
	NAME_UPDATED_ACTIVE_VAR = SNOMED_ITEM_NAME_ACTIVE
WITH MAXREC = 1, TIME=10

;Get an example of an active updated snomed item
SELECT INTO "NL:"
	SNOMED_ITEM_NAME_INACTIVE = N.SOURCE_STRING
FROM
	NOMENCLATURE   N
WHERE	
	N.SOURCE_VOCABULARY_CD = SNOMEDCT_CD_VAR; snomed rows
	AND
	N.ACTIVE_IND = 0; Inactive Item
	AND
	N.UPDT_DT_TM >= CNVTDATETIME(LAST_UPDATE_VAR)
HEAD REPORT
	NAME_UPDATED_INACTIVE_VAR = SNOMED_ITEM_NAME_INACTIVE
WITH MAXREC = 1, TIME=10


set FINALHTML_VAR = build2(
	'<!doctype html>'
    ,'<html>'
    ,'<head>'
	,'<meta charset=utf-8>'
	,'<title>Medication Administration Scanner Override Reason</title>'
    ,'<style>'
    ,'</style>'
    ,'</head>'
    ,'<body>'
    ,'<h1>Snomed Package Validation Checks</h1>'
	,'<h3>Last Update (Package Install Date): </h3>'
    , LAST_UPDATE_VAR
	,'<br>'
	,'<h3>Updated Active Item: </h3>'
    , NAME_UPDATED_ACTIVE_VAR
	,'<br>'
	,'<h3>Updated Inactive Item: </h3>'
    , NAME_UPDATED_INACTIVE_VAR
	,'<br>'
    ,'</body>'
    ,'</html>'
)

;Send the html text to the window
SELECT INTO $OUTDEV
HEAD REPORT
    FINALHTML_VAR
WITH MAXCOL=35000, TIME = 10

/**************************************************************
; DVDev DEFINED SUBROUTINES
**************************************************************/

end
go
