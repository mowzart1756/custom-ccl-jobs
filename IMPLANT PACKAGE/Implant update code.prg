UPDATE INTO NOMENCLATURE   N
SET
    N.ACTIVE_IND = 1
	, N.ACTIVE_STATUS_CD = 188.00 ; Active
	, N.ACTIVE_STATUS_DT_TM = CNVTDATETIME(CURDATE,CURTIME3)
	, N.ACTIVE_STATUS_PRSNL_ID = 0.00
	, N.BEG_EFFECTIVE_DT_TM = CNVTDATETIME(CURDATE,CURTIME3)
	, N.CMTI = NULL
	, N.CONCEPT_CKI = NULL
	, N.CONCEPT_IDENTIFIER = NULL
	, N.CONCEPT_SOURCE_CD = 0.00
	, N.CONTRIBUTOR_SYSTEM_CD = 673955.00; Client
	, N.DATA_STATUS_CD = 25.00 ; Auth (Verified)
	, N.DATA_STATUS_DT_TM = CNVTDATETIME(CURDATE,CURTIME3)
	, N.DATA_STATUS_PRSNL_ID = 0.00
	, N.DISALLOWED_IND = 0
	, N.END_EFFECTIVE_DT_TM = CNVTDATETIME("31-DEC-2100")
	, N.LANGUAGE_CD = 151 ; English
;	, N.LAST_UTC_TS = ; need to figure this out
	, N.MNEMONIC = _MNEMONIC_
;	, N.NOMENCLATURE_ID
	, N.NOM_VER_GRP_ID
	, N.PRIMARY_CTERM_IND
	, N.PRIMARY_VTERM_IND
	, N.PRINCIPLE_TYPE_CD
	, N.ROWID
	, N.SHORT_STRING =
	, N.SOURCE_IDENTIFIER
	, N.SOURCE_IDENTIFIER_KEYCAP
	, N.SOURCE_STRING = _Billing_Code_
	, N.SOURCE_STRING_KEYCAP = cnvtupper(_Billing_Code_)
	, N.SOURCE_STRING_KEYCAP_A_NLS
	, N.SOURCE_VOCABULARY_CD
	, N.STRING_IDENTIFIER
	, N.STRING_SOURCE_CD
	, N.STRING_STATUS_CD
	, N.TERM_ID
	, N.UPDT_APPLCTX
	, N.UPDT_CNT = P.UPDT_CNT + 1
	, N.UPDT_DT_TM = CNVTDATETIME(CURDATE,CURTIME3)
	, N.UPDT_ID = REQINFO->UPDT_ID
	, N.UPDT_TASK
	, N.VOCAB_AXIS_CD
















    N.END_EFFECTIVE_DT_TM = CNVTDATETIME("31-DEC-2100")

WHERE
    N.NOMENCLATURE_ID =
        (
            SELECT
                X. NOMENCLATURE_ID
            FROM
                NOMENCLATURE X
            WHERE
                N.ACTIVE_IND = 0
                ...
                ....
                ....
                TO DO

        )
