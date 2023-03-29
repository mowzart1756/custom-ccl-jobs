SELECT
	P.USERNAME
	, C.BEG_EFFECTIVE_DT_TM "YYYY-MM-DD HH:SS"
	, CREATED = P.BEG_EFFECTIVE_DT_TM "YYYY-MM-DD HH:SS"
	, C.ACTIVE_IND
	, C_ACTIVE_STATUS_DISP = UAR_GET_CODE_DISPLAY(C.ACTIVE_STATUS_CD)
	, C_CREDENTIAL_DISP = UAR_GET_CODE_DISPLAY(C.CREDENTIAL_CD)
	, C.CREDENTIAL_ID
	, C_CREDENTIAL_TYPE_DISP = UAR_GET_CODE_DISPLAY(C.CREDENTIAL_TYPE_CD)

FROM
	PRSNL   P
	, (FULL JOIN CREDENTIAL C ON (P.PERSON_ID = C.PRSNL_ID))

WHERE P.USERNAME = "CREDENTIALBOX"

ORDER BY
	C.BEG_EFFECTIVE_DT_TM

WITH MAXREC = 20000, NOCOUNTER, SEPARATOR=" ", FORMAT, TIME = 30