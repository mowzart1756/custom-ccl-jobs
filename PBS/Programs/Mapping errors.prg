drop program wh_pbs_mapping_errors go
create program wh_pbs_mapping_errors

prompt
	"Output to File/Printer/MINE" = "MINE"   ;* Enter or select the printer or file name to send this report to.

with OUTDEV

SELECT INTO $OUTDEV
/*
NOTES:
Retrieves codes that are incorrectly mapped due to hospital type and prescriber type.
 */

	DOMAIN = CURDOMAIN
	, PBS_CODE = P_L.PBS_ITEM_CODE
	, SCHADUAL_PROGRAM = P_L.DRUG_TYPE_MEAN
	, P_D.BRAND_NAME
	, PRESCRIBER_TYPE = UAR_GET_CODE_DISPLAY(P_P.PRESCRIBER_TYPE_CD)
	, P_D.PBS_DRUG_ID
	, MAPPED_SYNONYM = OCS.MNEMONIC
	, SYNONYM_ID = OCS.SYNONYM_ID

FROM
	PBS_LISTING P_L
	,PBS_OCS_MAPPING P_O_M
	,PBS_ITEM P_I
	,PBS_DRUG P_D
	,PBS_PRESCRIBER P_P
	,ORDER_CATALOG_SYNONYM OCS


PLAN	P_L
    WHERE
    ;PRIVATE HOSPITAL CODES ETC THAT SHOULD NOT BE MAPPED
    P_L.DRUG_TYPE_MEAN IN ("DB", "HS", "IN", "PQ", "TY")
    OR	P_L.PBS_ITEM_CODE IN
    (
        SELECT PBS_ITEM_CODE FROM PBS_PRESCRIBER P_P_0
        WHERE P_P_0.PRESCRIBER_TYPE_CD IN
            (
                SELECT CV.CODE_VALUE FROM CODE_VALUE CV
                WHERE CV.CODE_SET = 4386008
                ;CODES THAT ARE DENTAL AND OPTOMETRIST CODES BUT NOT ALSO THE OTHERS WE WANT TO MAP*/
                AND CV.CDF_MEANING IN ("D", "O")
            )
        AND	P_P_0.PBS_ITEM_CODE NOT IN
            (
                SELECT P_X.PBS_ITEM_CODE FROM PBS_PRESCRIBER P_X
                WHERE P_X.PRESCRIBER_TYPE_CD IN
                (
                    SELECT CV.CODE_VALUE FROM CODE_VALUE CV
                    WHERE CV.CODE_SET = 4386008
                    AND CV.CDF_MEANING IN ("M", "W", "N")
                )
            )
        AND	P_P_0.END_EFFECTIVE_DT_TM > SYSDATE
	)

JOIN P_P    WHERE P_P.PBS_ITEM_CODE = P_L.PBS_ITEM_CODE
            AND	P_P.END_EFFECTIVE_DT_TM > SYSDATE
JOIN P_I    WHERE P_I.PBS_LISTING_ID = P_L.PBS_LISTING_ID
JOIN P_D    WHERE P_D.PBS_ITEM_ID = P_I.PBS_ITEM_ID
JOIN P_O_M  WHERE P_O_M.PBS_DRUG_ID = P_D.PBS_DRUG_ID
            AND P_O_M.PBS_DRUG_ID != 11111111.00
            AND 	P_O_M.END_EFFECTIVE_DT_TM > SYSDATE
JOIN OCS    WHERE OCS.SYNONYM_ID = P_O_M.SYNONYM_ID

ORDER BY	P_L.PBS_ITEM_CODE

WITH TIME = 20,
	NOCOUNTER,
	SEPARATOR=" ",
	FORMAT
