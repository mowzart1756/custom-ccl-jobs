SELECT
	P.NAME_FULL_FORMATTED
	, 
	ELH_MED_SERVICE_DISP = UAR_GET_CODE_DISPLAY(ELH.MED_SERVICE_CD)
	, 
	O.ORDERED_AS_MNEMONIC
	, 
	O.ORDER_DETAIL_DISPLAY_LINE

FROM
	; ENCNTR_LOC_HIST   ELH
	; ,
	ENCOUNTER	E
	, 
	PERSON		P
	,
	PERSON_ALIAS
	, 
	PRSNL		PR
	, 
	ORDERS		O

PLAN E
	WHERE 
		E.ARRIVE_DT_TM BETWEEN ; FILTER FOR APPOINTMENTS IN THIS TIME RANGE
       		CNVTDATETIME("01-JAN-2022 00:00:00.00")
			; CNVTDATETIME($START_DT_ENC)
			AND
			CNVTDATETIME("10-JAN-2022 23:59:59.00")
			; CNVTDATETIME($END_DT_ENC)
		E.MED_SERVICE_CD IN (
			87625391.00;Orthopaedic Surgery
  			,
			86504090.00;Prosthetics & Orthoses
  			,
			98636040.00;SP Paed Orthopaedics
		)
		AND
		E.ENCNTR_STATUS_CD IN (
			854.00 ;ACTIVE
			,
			856.00;DISCHARGED
			,
			666808.00; PENDING ARRIVAL
		)
		AND
		E.ENCNTR_TYPE_CD IN (309309.00);Outpatient

JOIN P ; PERSON
	WHERE
		P.PERSON_ID = E.PERSON_ID
		AND
		P.ACTIVE_IND = 1

JOIN PA
    WHERE
        P.PERSON_ID = PA.PERSON_ID
        AND
        PA.ALIAS_POOL_CD = 9569589.00 ; this filters for the UR Number
        AND
        PA.ACTIVE_IND = 1

JOIN PR ; PRSNL
	WHERE 
		PR.PERSON_ID = OUTERJOIN(O.STATUS_PRSNL_ID)
		

JOIN O ; ORDERS
	WHERE
		O.ENCNTR_ID = OUTERJOIN(E.ENCNTR_ID) ; OUTERJOIN => KEEP PATIENTS EVEN WITH NO RADIOLOGY ORDERS
		AND 
		O.ORIG_ORDER_DT_TM >= CNVTLOOKBEHIND("6,M") ; Filter for orders in the last 6 months
		AND
		O.ACTIVE_IND = OUTERJOIN(1) ; Active orders only
		AND
		O.CATALOG_TYPE_CD = OUTERJOIN(2517.00); RADIOLOGY Orders only; OUTERJOIN => KEEP PATIENTS EVEN WITH NO RADIOLOGY ORDERS
		
ORDER BY
    P.NAME_FULL_FORMATTED
	, 
	ELH.BEG_EFFECTIVE_DT_TM   DESC

WITH 
	TIME = 120
	,
	SEPARATOR=" "
	,
	FORMAT









