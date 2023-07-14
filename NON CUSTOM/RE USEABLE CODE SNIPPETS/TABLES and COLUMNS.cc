/* TABLES */
	ACCESSION
	CLINICAL_EVENT
	CODE_VALUE
	DUMMYT
	ENCOUNTER
	ORDER_CATALOG
	ORDERS
	PERSON
	PRSNL
	RESULT
	ORDER_ACTION
	STICKY_NOTE
	ORDER_CATALOG
	OEN_TXLOG
	/* Log of all tx's going through open engine interfaces. */
	CE_BLOB 
	/*The ce_blob table contains the actual contents of a locally stored document. */   

/* COLUMNS */
SELECT
	O_T.CREATE_DT_TM
	, O_T.EVENTID
	, O_T.GROUP_NAME
	, O_T.INTERFACEID
	, O_T.MESSAGE_NAME
	, O_T.MSGID
	, O_T.MSG_DATE
	, O_T.MSG_LEN
	, O_T.MSG_SIZE
	, O_T.MSG_TEXT
	, O_T.MSG_TIME
	, O_T.PART_NO
	, O_T.PART_SIZE
	, O_T.RECEIVING_SYSTEMO_T
	, O_T.ROWID
	, O_T.SENDING_SYSTEM
	, O_T.SEQ_NO
	, O_T.TX_KEY

FROM
	OEN_TXLOG   O_T

WITH NOCOUNTER, SEPARATOR=" ", FORMAT


SELECT
	C_B.BLOB_CONTENTS
	, C_B.BLOB_LENGTH
	, C_B.BLOB_SEQ_NUM
	, C_COMPRESSION_DISP = UAR_GET_CODE_DISPLAY(C_B.COMPRESSION_CD)
	, C_B.EVENT_ID
	, C_B.ROWID
	, C_B.UPDT_APPLCTX
	, C_B.UPDT_CNT
	, C_B.UPDT_DT_TM
	, C_B.UPDT_ID
	, C_B.UPDT_TASK
	, C_B.VALID_FROM_DT_TM
	, C_B.VALID_UNTIL_DT_TM

FROM /*The ce_blob table contains the actual contents of a locally stored document. */   
	CE_BLOB   C_B

WITH NOCOUNTER, SEPARATOR=" ", FORMAT

SELECT
	O.ACTIVE_IND
	, O_ACTIVE_STATUS_DISP = UAR_GET_CODE_DISPLAY(O.ACTIVE_STATUS_CD)
	, O.ACTIVE_STATUS_DT_TM
	, O.ACTIVE_STATUS_PRSNL_ID
	, O_ACTIVITY_TYPE_DISP = UAR_GET_CODE_DISPLAY(O.ACTIVITY_TYPE_CD)
	, O.AD_HOC_ORDER_FLAG
	, O_CATALOG_DISP = UAR_GET_CODE_DISPLAY(O.CATALOG_CD)
	, O_CATALOG_TYPE_DISP = UAR_GET_CODE_DISPLAY(O.CATALOG_TYPE_CD)
	, O.CKI
	, O.CLINICAL_DISPLAY_LINE
	, O.CLIN_RELEVANT_UPDT_DT_TM
	, O.CLIN_RELEVANT_UPDT_TZ
	, O.COMMENT_TYPE_MASK
	, O.CONSTANT_IND
	, O_CONTRIBUTOR_SYSTEM_DISP = UAR_GET_CODE_DISPLAY(O.CONTRIBUTOR_SYSTEM_CD)
	, O.CS_FLAG
	, O.CS_ORDER_ID
	, O.CURRENT_START_DT_TM
	, O.CURRENT_START_TZ
	, O.DAY_OF_TREATMENT_SEQUENCE
	, O_DCP_CLIN_CAT_DISP = UAR_GET_CODE_DISPLAY(O.DCP_CLIN_CAT_CD)
	, O.DEPT_MISC_LINE
	, O_DEPT_STATUS_DISP = UAR_GET_CODE_DISPLAY(O.DEPT_STATUS_CD)
	, O.DISCONTINUE_EFFECTIVE_DT_TM
	, O.DISCONTINUE_EFFECTIVE_TZ
	, O.DISCONTINUE_IND
	, O_DISCONTINUE_TYPE_DISP = UAR_GET_CODE_DISPLAY(O.DISCONTINUE_TYPE_CD)
	, O.DOSING_METHOD_FLAG
	, O.ENCNTR_FINANCIAL_ID
	, O.ENCNTR_ID
	, O.ESO_NEW_ORDER_IND
	, O_FORMULARY_STATUS_DISP = UAR_GET_CODE_DISPLAY(O.FORMULARY_STATUS_CD)
	, O.FREQUENCY_ID
	, O.FREQ_TYPE_FLAG
	, O_FUTURE_LOCATION_FACILITY_DISP = UAR_GET_CODE_DISPLAY(O.FUTURE_LOCATION_FACILITY_CD)
	, O_FUTURE_LOCATION_NURSE_UNIT_DISP = UAR_GET_CODE_DISPLAY(O.FUTURE_LOCATION_NURSE_UNIT_CD)
	, O.GROUP_ORDER_FLAG
	, O.GROUP_ORDER_ID
	, O.HIDE_FLAG
	, O.HNA_ORDER_MNEMONIC
	, O.INCOMPLETE_ORDER_IND
	, O.INGREDIENT_IND
	, O.INTEREST_DT_TM
	, O.INTERVAL_IND
	, O.IV_IND
	, O.IV_SET_SYNONYM_ID
	, O.LAST_ACTION_SEQUENCE
	, O.LAST_CORE_ACTION_SEQUENCE
	, O.LAST_INGRED_ACTION_SEQUENCE
	, O.LAST_UPDATE_PROVIDER_ID
	, O_LATEST_COMMUNICATION_TYPE_DISP = UAR_GET_CODE_DISPLAY(O.LATEST_COMMUNICATION_TYPE_CD)
	, O.LINK_NBR
	, O.LINK_ORDER_FLAG
	, O.LINK_ORDER_ID
	, O.LINK_TYPE_FLAG
	, O_MED_ORDER_TYPE_DISP = UAR_GET_CODE_DISPLAY(O.MED_ORDER_TYPE_CD)
	, O.MODIFIED_START_DT_TM
	, O.NEED_DOCTOR_COSIGN_IND
	, O.NEED_NURSE_REVIEW_IND
	, O.NEED_PHYSICIAN_VALIDATE_IND
	, O.NEED_RX_CLIN_REVIEW_FLAG
	, O.NEED_RX_VERIFY_IND
	, O.OE_FORMAT_ID
	, O.ORDERABLE_TYPE_FLAG
	, O.ORDERED_AS_MNEMONIC
	, O.ORDER_COMMENT_IND
	, O.ORDER_DETAIL_DISPLAY_LINE
	, O.ORDER_ID
	, O.ORDER_MNEMONIC
	, O.ORDER_REVIEW_STATUS_REASON_BIT
	, O.ORDER_SCHEDULE_PRECISION_BIT
	, O_ORDER_STATUS_DISP = UAR_GET_CODE_DISPLAY(O.ORDER_STATUS_CD)
	, O.ORDER_STATUS_REASON_BIT
	, O.ORIGINATING_ENCNTR_ID
	, O.ORIG_ORDER_CONVS_SEQ
	, O.ORIG_ORDER_DT_TM
	, O.ORIG_ORDER_TZ
	, O.ORIG_ORD_AS_FLAG
	, O.OVERRIDE_FLAG
	, O.PATHWAY_CATALOG_ID
	, O.PERSON_ID
	, O.PRESCRIPTION_GROUP_VALUE
	, O.PRESCRIPTION_ORDER_ID
	, O.PRN_IND
	, O.PRODUCT_ID
	, O.PROJECTED_STOP_DT_TM
	, O.PROJECTED_STOP_TZ
	, O.PROTOCOL_ORDER_ID
	, O.REF_TEXT_MASK
	, O.REMAINING_DOSE_CNT
	, O.RESUME_EFFECTIVE_DT_TM
	, O.RESUME_EFFECTIVE_TZ
	, O.RESUME_IND
	, O.ROWID
	, O.RX_MASK
	, O_SCH_STATE_DISP = UAR_GET_CODE_DISPLAY(O.SCH_STATE_CD)
	, O.SIMPLIFIED_DISPLAY_LINE
	, O.SOFT_STOP_DT_TM
	, O.SOFT_STOP_TZ
	, O_SOURCE_DISP = UAR_GET_CODE_DISPLAY(O.SOURCE_CD)
	, O.STATUS_DT_TM
	, O.STATUS_PRSNL_ID
	, O_STOP_TYPE_DISP = UAR_GET_CODE_DISPLAY(O.STOP_TYPE_CD)
	, O.SUSPEND_EFFECTIVE_DT_TM
	, O.SUSPEND_EFFECTIVE_TZ
	, O.SUSPEND_IND
	, O.SYNONYM_ID
	, O.TEMPLATE_CORE_ACTION_SEQUENCE
	, O.TEMPLATE_DOSE_SEQUENCE
	, O.TEMPLATE_ORDER_FLAG
	, O.TEMPLATE_ORDER_ID
	, O.UPDT_APPLCTX
	, O.UPDT_CNT
	, O.UPDT_DT_TM
	, O.UPDT_ID
	, O.UPDT_TASK
	, O.VALID_DOSE_DT_TM
	, O.WARNING_LEVEL_BIT

FROM
	ORDERS   O
    
SELECT
	C_V.ACTIVE_DT_TM
	, C_V.ACTIVE_IND
	, C_V.ACTIVE_STATUS_PRSNL_ID
	, C_V_ACTIVE_TYPE_DISP = UAR_GET_CODE_DISPLAY(C_V.ACTIVE_TYPE_CD)
	, C_V.BEGIN_EFFECTIVE_DT_TM
	, C_V.CDF_MEANING
	, C_V.CKI
	, C_V.CODE_SET
	, C_V.CODE_VALUE
	, C_V.COLLATION_SEQ
	, C_V.CONCEPT_CKI
	, C_V_DATA_STATUS_DISP = UAR_GET_CODE_DISPLAY(C_V.DATA_STATUS_CD)
	, C_V.DATA_STATUS_DT_TM
	, C_V.DATA_STATUS_PRSNL_ID
	, C_V.DEFINITION
	, C_V.DESCRIPTION
	, C_V.DISPLAY
	, C_V.DISPLAY_KEY
	, C_V.DISPLAY_KEY_A_NLS
	, C_V.DISPLAY_KEY_NLS
	, C_V.END_EFFECTIVE_DT_TM
	, C_V.INACTIVE_DT_TM
	, C_V.INST_ID
	, C_V.LAST_UTC_TS
	, C_V.ROWID
	, C_V.UPDT_APPLCTX
	, C_V.UPDT_CNT
	, C_V.UPDT_DT_TM
	, C_V.UPDT_ID
	, C_V.UPDT_TASK

FROM
	CODE_VALUE   C_V

SELECT
	C.ACCESSION_NBR
	, C.AUTHENTIC_FLAG
	, C_CATALOG_DISP = UAR_GET_CODE_DISPLAY(C.CATALOG_CD)
	, C.CE_DYNAMIC_LABEL_ID
	, C.CE_GROUPING_ID
	, C.CLINICAL_EVENT_ID
	, C.CLINICAL_SEQ
	, C.CLINSIG_UPDT_DT_TM
	, C.COLLATING_SEQ
	, C_CONTRIBUTOR_SYSTEM_DISP = UAR_GET_CODE_DISPLAY(C.CONTRIBUTOR_SYSTEM_CD)
	, C.CRITICAL_HIGH
	, C.CRITICAL_LOW
	, C.DEVICE_FREE_TXT
	, C.ENCNTR_FINANCIAL_ID
	, C.ENCNTR_ID
	, C_ENTRY_MODE_DISP = UAR_GET_CODE_DISPLAY(C.ENTRY_MODE_CD)
	, C_EVENT_DISP = UAR_GET_CODE_DISPLAY(C.EVENT_CD)
	, C_EVENT_CLASS_DISP = UAR_GET_CODE_DISPLAY(C.EVENT_CLASS_CD)
	, C.EVENT_END_DT_TM
	, C.EVENT_END_DT_TM_OS
	, C.EVENT_END_TZ
	, C.EVENT_ID
	, C_EVENT_RELTN_DISP = UAR_GET_CODE_DISPLAY(C.EVENT_RELTN_CD)
	, C.EVENT_START_DT_TM
	, C.EVENT_START_TZ
	, C.EVENT_TAG
	, C.EVENT_TAG_SET_FLAG
	, C.EVENT_TITLE_TEXT
	, C.EXPIRATION_DT_TM
	, C_INQUIRE_SECURITY_DISP = UAR_GET_CODE_DISPLAY(C.INQUIRE_SECURITY_CD)
	, C.MODIFIER_LONG_TEXT_ID
	, C.NOMEN_STRING_FLAG
	, C_NORMALCY_DISP = UAR_GET_CODE_DISPLAY(C.NORMALCY_CD)
	, C_NORMALCY_METHOD_DISP = UAR_GET_CODE_DISPLAY(C.NORMALCY_METHOD_CD)
	, C.NORMAL_HIGH
	, C.NORMAL_LOW
	, C.NORMAL_REF_RANGE_TXT
	, C.NOTE_IMPORTANCE_BIT_MAP
	, C.ORDER_ACTION_SEQUENCE
	, C.ORDER_ID
	, C.PARENT_EVENT_ID
	, C.PERFORMED_DT_TM
	, C.PERFORMED_PRSNL_ID
	, C.PERFORMED_TZ
	, C.PERSON_ID
	, C.PUBLISH_FLAG
	, C_QC_REVIEW_DISP = UAR_GET_CODE_DISPLAY(C.QC_REVIEW_CD)
	, C_RECORD_STATUS_DISP = UAR_GET_CODE_DISPLAY(C.RECORD_STATUS_CD)
	, C.REFERENCE_NBR
	, C_RESOURCE_DISP = UAR_GET_CODE_DISPLAY(C.RESOURCE_CD)
	, C_RESOURCE_GROUP_DISP = UAR_GET_CODE_DISPLAY(C.RESOURCE_GROUP_CD)
	, C_RESULT_STATUS_DISP = UAR_GET_CODE_DISPLAY(C.RESULT_STATUS_CD)
	, C_RESULT_TIME_UNITS_DISP = UAR_GET_CODE_DISPLAY(C.RESULT_TIME_UNITS_CD)
	, C_RESULT_UNITS_DISP = UAR_GET_CODE_DISPLAY(C.RESULT_UNITS_CD)
	, C.RESULT_VAL
	, C.ROWID
	, C.SERIES_REF_NBR
	, C_SOURCE_DISP = UAR_GET_CODE_DISPLAY(C.SOURCE_CD)
	, C.SRC_CLINSIG_UPDT_DT_TM
	, C.SRC_EVENT_ID
	, C.SUBTABLE_BIT_MAP
	, C_TASK_ASSAY_DISP = UAR_GET_CODE_DISPLAY(C.TASK_ASSAY_CD)
	, C.TASK_ASSAY_VERSION_NBR
	, C.TRAIT_BIT_MAP
	, C.UPDT_APPLCTX
	, C.UPDT_CNT
	, C.UPDT_DT_TM
	, C.UPDT_ID
	, C.UPDT_TASK
	, C.VALID_FROM_DT_TM
	, C.VALID_UNTIL_DT_TM
	, C.VERIFIED_DT_TM
	, C.VERIFIED_PRSNL_ID
	, C.VERIFIED_TZ
	, C.VIEW_LEVEL

FROM
	CLINICAL_EVENT   C_E
    C_E;CLINICAL_EVENT

SELECT
	O.ABN_REVIEW_IND
	, O.ACTIVE_IND
	, O_ACTIVITY_SUBTYPE_DISP = UAR_GET_CODE_DISPLAY(O.ACTIVITY_SUBTYPE_CD)
	, O_ACTIVITY_TYPE_DISP = UAR_GET_CODE_DISPLAY(O.ACTIVITY_TYPE_CD)
	, O.AUTO_CANCEL_IND
	, O.BILL_ONLY_IND
	, O_CATALOG_DISP = UAR_GET_CODE_DISPLAY(O.CATALOG_CD)
	, O_CATALOG_TYPE_DISP = UAR_GET_CODE_DISPLAY(O.CATALOG_TYPE_CD)
	, O.CKI
	, O.COMMENT_TEMPLATE_FLAG
	, O.COMPLETE_UPON_ORDER_IND
	, O.CONCEPT_CKI
	, O_CONSENT_FORM_FORMAT_DISP = UAR_GET_CODE_DISPLAY(O.CONSENT_FORM_FORMAT_CD)
	, O.CONSENT_FORM_IND
	, O_CONSENT_FORM_ROUTING_DISP = UAR_GET_CODE_DISPLAY(O.CONSENT_FORM_ROUTING_CD)
	, O.CONT_ORDER_METHOD_FLAG
	, O_CS_INDEX_DISP = UAR_GET_CODE_DISPLAY(O.CS_INDEX_CD)
	, O_DCP_CLIN_CAT_DISP = UAR_GET_CODE_DISPLAY(O.DCP_CLIN_CAT_CD)
	, O.DC_DISPLAY_DAYS
	, O.DC_INTERACTION_DAYS
	, O.DEPT_DISPLAY_NAME
	, O.DEPT_DUP_CHECK_IND
	, O.DESCRIPTION
	, O.DISABLE_ORDER_COMMENT_IND
	, O.DISCERN_AUTO_VERIFY_FLAG
	, O.DOSING_ACT_INGRED_CODE
	, O.DOSING_ALL_INGRED_IND
	, O.DUP_CHECKING_IND
	, O_EVENT_DISP = UAR_GET_CODE_DISPLAY(O.EVENT_CD)
	, O.FORM_ID
	, O.FORM_LEVEL
	, O.IC_AUTO_VERIFY_FLAG
	, O.INST_RESTRICTION_IND
	, O.MODIFIABLE_FLAG
	, O.OE_FORMAT_ID
	, O.OP_DC_DISPLAY_DAYS
	, O.OP_DC_INTERACTION_DAYS
	, O.ORDERABLE_TYPE_FLAG
	, O.ORDER_REVIEW_IND
	, O.ORD_COM_TEMPLATE_LONG_TEXT_ID
	, O.PREP_INFO_FLAG
	, O.PRIMARY_MNEMONIC
	, O.PRINT_REQ_IND
	, O.PROMPT_IND
	, O.QUICK_CHART_IND
	, O.REF_TEXT_MASK
	, O_REQUISITION_FORMAT_DISP = UAR_GET_CODE_DISPLAY(O.REQUISITION_FORMAT_CD)
	, O_REQUISITION_ROUTING_DISP = UAR_GET_CODE_DISPLAY(O.REQUISITION_ROUTING_CD)
	, O_RESOURCE_ROUTE_DISP = UAR_GET_CODE_DISPLAY(O.RESOURCE_ROUTE_CD)
	, O.RESOURCE_ROUTE_LVL
	, O.REVIEW_HIERARCHY_ID
	, O.ROWID
	, O.SCHEDULE_IND
	, O.SOURCE_VOCAB_IDENT
	, O.SOURCE_VOCAB_MEAN
	, O.STOP_DURATION
	, O_STOP_DURATION_UNIT_DISP = UAR_GET_CODE_DISPLAY(O.STOP_DURATION_UNIT_CD)
	, O_STOP_TYPE_DISP = UAR_GET_CODE_DISPLAY(O.STOP_TYPE_CD)
	, O.UPDT_APPLCTX
	, O.UPDT_CNT
	, O.UPDT_DT_TM
	, O.UPDT_ID
	, O.UPDT_TASK
	, O.VETTING_APPROVAL_FLAG

FROM
	ORDER_CATALOG   O_C
