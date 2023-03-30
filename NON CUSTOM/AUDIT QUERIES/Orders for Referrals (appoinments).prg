SELECT
/*
Auditing related to project defects
This links an order for an appointment to an order entry format and an appointment type
For Andrew Woo
 */
     CATALOG_TYPE = UAR_GET_CODE_DISPLAY(O_C.CATALOG_TYPE_CD)
    , ACTIVITY_TYPE = UAR_GET_CODE_DISPLAY(O_C.ACTIVITY_TYPE_CD)
    , PRIMARY_NAME = O_C.PRIMARY_MNEMONIC
    , ORDER_ENTRY_FORMAT_NAME = O_E_F.OE_FORMAT_NAME
    , APPOINTMENT_TYPE = UAR_GET_CODE_DISPLAY(S_O_A.APPT_TYPE_CD)

FROM
    ORDER_CATALOG                   O_C
    , ORDER_ENTRY_FORMAT            O_E_F
    , SCH_ORDER_APPT                S_O_A

PLAN O_C
    WHERE
        O_C.CATALOG_TYPE_CD = 77902618.00 ; Referral
        AND
        O_C.ACTIVE_IND = 1 ; Only Active Primaries

JOIN O_E_F
    WHERE O_E_F.OE_FORMAT_ID = O_C.OE_FORMAT_ID
    AND
    O_E_F.ACTION_TYPE_CD = 2534.00;ORDER 

JOIN S_O_A
    WHERE S_O_A.CATALOG_CD = OUTERJOIN(O_C.CATALOG_CD)

ORDER BY
	O_C.PRIMARY_MNEMONIC

WITH NOCOUNTER, SEPARATOR=" ", FORMAT, TIME=10
