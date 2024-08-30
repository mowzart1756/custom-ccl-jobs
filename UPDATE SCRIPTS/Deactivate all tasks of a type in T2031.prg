; IN DEVELOPMENT!!!!!!!!!!!!!!!!!!!



SELECT *
FROM CLINICAL_EVENT C
WHERE

C.X = "BOWEL CHART"


UPDATE INTO CLINICAL_EVENT	C
SET
	C.ALIAS = "<NEW_ALIAS>"
	, C.UPDT_DT_TM = CNVTDATETIME(CURDATE,CURTIME3)
	, C.UPDT_ID = REQINFO->UPDT_ID
	, C.UPDT_CNT = C.UPDT_CNT + 1
WHERE
	C.CODE_SET = 34 ; Clinical Unit (HOSP_SERV)
	AND C.CONTRIBUTOR_SOURCE_CD = 10630393.00; "WH_LOCAL"
	AND C.CODE_VALUE = <CODE_VALUE_TARGET>