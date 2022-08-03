SELECT DISTINCT
	NURSE_UNIT = UAR_GET_CODE_DISPLAY(E.LOC_NURSE_UNIT_CD)
	, PATIENT_URN = P.ALIAS
	, E_SEX_DISP = UAR_GET_CODE_DISPLAY(E.SEX_CD)
	, ENCOUNTER_ID = E.ENCNTR_ID
	, DIAGNOSIS = D.DIAGNOSIS_DISPLAY
	, DIAGNOSIS_TYPE = UAR_GET_CODE_DISPLAY(D.DIAG_TYPE_CD)
	, MED_SERVICE = UAR_GET_CODE_DISPLAY(E.MED_SERVICE_CD)
	, ARRIVE_TIME = E.ARRIVE_DT_TM
	, E.BEG_EFFECTIVE_DT_TM
	, E_LOCATION_DISP = UAR_GET_CODE_DISPLAY(E.LOCATION_CD)
	, E_LOC_BUILDING_DISP = UAR_GET_CODE_DISPLAY(E.LOC_BUILDING_CD)
	, E_LOC_FACILITY_DISP = UAR_GET_CODE_DISPLAY(E.LOC_FACILITY_CD)
	, E_LOC_ROOM_DISP = UAR_GET_CODE_DISPLAY(E.LOC_ROOM_CD)
	, E_LOC_BED_DISP = UAR_GET_CODE_DISPLAY(E.LOC_BED_CD)

FROM
	ENCOUNTER   E
	, DIAGNOSIS   D
	, PERSON_ALIAS   P
	, PERSON   PE

PLAN E
	WHERE 
	E.LOC_NURSE_UNIT_CD = 114893271 ; S GC
	AND E.DISCH_DT_TM
	BETWEEN
		CNVTDATETIME("01-JAN-2022 00:00:00.00")
		AND
		CNVTDATETIME("31-JUL-2022 00:00:00.00")
	
;	AND E.ENCNTR_ID = XXXXXX ; Input your encounter id

JOIN D
	WHERE D.PERSON_ID = E.PERSON_ID
	AND
	CNVTUPPER(D.DIAGNOSIS_DISPLAY) = "*DELIRIUM*"

JOIN P
	WHERE P.PERSON_ID = E.PERSON_ID
	AND
	P.ALIAS_POOL_CD = 9569589 ; URN ALIAS ONLY

JOIN PE
	WHERE PE.PERSON_ID = E.PERSON_ID

WITH MAXREC = 1000000, NOCOUNTER, SEPARATOR=" ", FORMAT, TIME = 5