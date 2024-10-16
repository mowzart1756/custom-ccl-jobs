/*
Programmer: Jason Whittle
Requester: Annie.L
Cherwells: 766199, 770993

Use: Pulls back patient concession details for a dyndoc: Pharmacy Admission
#dynamic document

testing in t2031 using WH_GP_DETAILS_PERSON and dyndoc Discharge Summary
 */

; DROP PROGRAM WH_PATIENT_CONCESSIONS GO
; CREATE PROGRAM WH_PATIENT_CONCESSIONS
DROP PROGRAM WH_GP_DETAILS_PERSON GO
CREATE PROGRAM WH_GP_DETAILS_PERSON

%I CUST_SCRIPT:MA_RTF_TAGS.INC
%I CUST_SCRIPT:VIC_DS_COMMON_FONTS.INC

; Store encounter_id from powerchart
DECLARE ENCNTR_ID_VAR                           = F8 WITH CONSTANT(REQUEST->VISIT[1].ENCNTR_ID), PROTECT
; Store patient person_id from powerchart
DECLARE PERSON_ID_VAR                           = F8 WITH CONSTANT(REQUEST->PERSON[1].PERSON_ID), PROTECT
; Store Code value for a concession
DECLARE DVA_GOLD_CD_VAR                         = F8 WITH CONSTANT(4039501.00)
; Create a placeholder variable for the concession var char retrieved from the database
DECLARE DVA_GOLD_VA                             = VC WITH NOCONSTANT("")
; Do the same for the rest
DECLARE CARER_PAYMENT_PENSION_CD_VAR            = F8 WITH CONSTANT(13075331.00)
DECLARE CARER_PAYMENT_PENSION_VAR               = VC WITH NOCONSTANT("")
DECLARE TAC_CD_VAR                              = F8 WITH CONSTANT(4455022.00)
DECLARE TAC_VAR                                 = VC WITH NOCONSTANT("")
DECLARE SAFETY_NET_CONCESSION_CD_VAR            = F8 WITH CONSTANT(4081892.00)
DECLARE SAFETY_NET_CONCESSION_VAR               = VC WITH NOCONSTANT("")
DECLARE UNEMPLOYMENT_RELATED_BENEFITS_CD_VAR    = F8 WITH CONSTANT(14966006.00)
DECLARE UNEMPLOYMENT_RELATED_BENEFITS_VAR       = VC WITH NOCONSTANT("")
DECLARE SAFETY_NET_ENTITLEMENT_CD_VAR           = F8 WITH CONSTANT(10719999.00)
DECLARE SAFETY_NET_ENTITLEMENT_VAR              = VC WITH NOCONSTANT("")
DECLARE WHS_UR_NUMBER_CD_VAR                    = F8 WITH CONSTANT(9569589.00)
DECLARE WHS_UR_NUMBER_VAR                       = VC WITH NOCONSTANT("")
DECLARE DVA_NUMBER_CD_VAR                       = F8 WITH CONSTANT(6797507.00)
DECLARE DVA_NUMBER_VAR                          = VC WITH NOCONSTANT("")
DECLARE EMERGENCY_ID_CD_VAR                     = F8 WITH CONSTANT(14966012.00)
DECLARE EMERGENCY_ID_VAR                        = VC WITH NOCONSTANT("")
DECLARE MEDICARE_NO_CD_VAR                      = F8 WITH CONSTANT(4039507.00)
DECLARE MEDICARE_NO_VAR                         = VC WITH NOCONSTANT("")
DECLARE PENSION_CONCESSION_CD_VAR               = F8 WITH CONSTANT(13079326.00)
DECLARE PENSION_CONCESSION_VAR                  = VC WITH NOCONSTANT("")
DECLARE NDIS_PARTICIPANT_ID_CD_VAR              = F8 WITH CONSTANT(174930721.00)
DECLARE NDIS_PARTICIPANT_ID_VAR                 = VC WITH NOCONSTANT("")
DECLARE DISABILITY_SUPPORT_CD_VAR               = F8 WITH CONSTANT(13079325.00)
DECLARE DISABILITY_SUPPORT_VAR                  = VC WITH NOCONSTANT("")
DECLARE HEALTHCARE_CARD_CD_VAR                  = F8 WITH CONSTANT(4081893.00)
DECLARE HEALTHCARE_CARD_VAR                     = VC WITH NOCONSTANT("")
DECLARE CONSUMER_MESSAGING_CD_VAR               = F8 WITH CONSTANT(152031769.00)
DECLARE CONSUMER_MESSAGING_VAR                  = VC WITH NOCONSTANT("")
DECLARE PENSION_OTHER_CD_VAR                    = F8 WITH CONSTANT(10726213.00)
DECLARE PENSION_OTHER_VAR                       = VC WITH NOCONSTANT("")
DECLARE WORK_COVER_CD_VAR                       = F8 WITH CONSTANT(4443217.00)
DECLARE WORK_COVER_VAR                          = VC WITH NOCONSTANT("")
DECLARE COMMONWEALTH_SENIORS_HEALTH_CD_VAR      = F8 WITH CONSTANT(6797508.00)
DECLARE COMMONWEALTH_SENIORS_HEALTH_VAR         = VC WITH NOCONSTANT("")
DECLARE DVA_WHITE_CD_VAR                        = F8 WITH CONSTANT(4039502.00)
DECLARE DVA_WHITE_VAR                           = VC WITH NOCONSTANT("")


/*
Alias Pool code from the ALIAS_POOL_CD column on the PERSON_ALIAS table
ALIAS_POOL_CD	ALIAS_POOL
    4039501.00	DVA GOLD
   13075331.00	Carer Payment Pension
    4455022.00	TAC
    4081892.00	Safety Net Concession Card
   14966006.00	Unemployment Related Benefits
   10719999.00	Safety Net Entitlement Card
    9569589.00	WHS UR Number
    6797507.00	DVA Number
   14966012.00	Emergency ID
    4039507.00	Medicare No
   13079326.00	Pension Concession Card
  174930721.00	NDIS Participant Identifier
   13079325.00	Disability Support Pension
    4081893.00	Healthcare Card
  152031769.00	CONSUMER_MESSAGING
   10726213.00	Pension - Other
    4443217.00	Work Cover
    6797508.00	Commonwealth Seniors Health Card
    4039502.00	DVA WHITE
*/

; Get Concession - DVA Gold
SELECT INTO "NL:"
    ALIAS = PA.ALIAS
FROM
    PERSON_ALIAS      PA
WHERE
        PA.PERSON_ID = PERSON_ID_VAR
    AND	PA.ALIAS_POOL_CD = DVA_GOLD_CD_VAR
    AND PA.ACTIVE_IND = 1
DETAIL
    DVA_GOLD_VAR = TRIM(ALIAS, 3)
WITH
    TIME = 5

; DISPLAY THE DATA ON THE FRONT END
CALL APPLYFONT(ACTIVE_FONTS->NORMAL)

; Display concession details if they exist
IF(TEXTLEN(DVA_GOLD_VA) > 1)
    CALL PRINTTEXT("DVA GOLD: ",0,0,0)
    CALL PRINTTEXT(DVA_GOLD_VA)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(CARER_PAYMENT_PENSION_VAR) > 1)
    CALL PRINTTEXT("Carer Payment Pension: ",0,0,0)
    CALL PRINTTEXT(CARER_PAYMENT_PENSION_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(TAC_VAR) > 1)
    CALL PRINTTEXT("TAC: ",0,0,0)
    CALL PRINTTEXT(TAC_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(SAFETY_NET_CONCESSION_VAR) > 1)
    CALL PRINTTEXT("Safety Net Concession Card: ",0,0,0)
    CALL PRINTTEXT(SAFETY_NET_CONCESSION_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(UNEMPLOYMENT_RELATED_BENEFITS_VAR) > 1)
    CALL PRINTTEXT("Unemployment Related Benefits: ",0,0,0)
    CALL PRINTTEXT(UNEMPLOYMENT_RELATED_BENEFITS_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(SAFETY_NET_ENTITLEMENT_VAR) > 1)
    CALL PRINTTEXT("Safety Net Entitlement Card: ",0,0,0)
    CALL PRINTTEXT(SAFETY_NET_ENTITLEMENT_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(WHS_UR_NUMBER_VAR) > 1)
    CALL PRINTTEXT("WHS UR Number: ",0,0,0)
    CALL PRINTTEXT(WHS_UR_NUMBER_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(DVA_NUMBER_VAR) > 1)
    CALL PRINTTEXT("DVA Number: ",0,0,0)
    CALL PRINTTEXT(DVA_NUMBER_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(EMERGENCY_ID_VAR) > 1)
    CALL PRINTTEXT("Emergency ID: ",0,0,0)
    CALL PRINTTEXT(EMERGENCY_ID_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(MEDICARE_NO_VAR) > 1)
    CALL PRINTTEXT("Medicare No: ",0,0,0)
    CALL PRINTTEXT(MEDICARE_NO_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(PENSION_CONCESSION_VAR) > 1)
    CALL PRINTTEXT("Pension Concession Card: ",0,0,0)
    CALL PRINTTEXT(PENSION_CONCESSION_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(NDIS_PARTICIPANT_ID_VAR) > 1)
    CALL PRINTTEXT("NDIS Participant Identifier: ",0,0,0)
    CALL PRINTTEXT(NDIS_PARTICIPANT_ID_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(DISABILITY_SUPPORT_VAR) > 1)
    CALL PRINTTEXT("Disability Support Pension: ",0,0,0)
    CALL PRINTTEXT(DISABILITY_SUPPORT_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(HEALTHCARE_CARD_VAR) > 1)
    CALL PRINTTEXT("Healthcare Card: ",0,0,0)
    CALL PRINTTEXT(HEALTHCARE_CARD_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(CONSUMER_MESSAGING_VAR) > 1)
    CALL PRINTTEXT("Consumer Messaging: ",0,0,0)
    CALL PRINTTEXT(CONSUMER_MESSAGING_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(PENSION_OTHER_VAR) > 1)
    CALL PRINTTEXT("Pension - Other: ",0,0,0)
    CALL PRINTTEXT(PENSION_OTHER_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(WORK_COVER_VAR) > 1)
    CALL PRINTTEXT("Work Cover: ",0,0,0)
    CALL PRINTTEXT(WORK_COVER_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(COMMONWEALTH_SENIORS_HEALTH_VAR) > 1)
    CALL PRINTTEXT("Commonwealth Seniors Health Card: ",0,0,0)
    CALL PRINTTEXT(COMMONWEALTH_SENIORS_HEALTH_VAR)
    CALL NEXTLINE(1)
ENDIF

IF(TEXTLEN(DVA_WHITE_VAR) > 1)
    CALL PRINTTEXT("DVA WHITE: ",0,0,0)
    CALL PRINTTEXT(DVA_WHITE_VAR)
    CALL NEXTLINE(1)
ENDIF


; Send the text to Output
CALL FINISHTEXT(0)
SET REPLY->TEXT = RTF_OUT->TEXT

END
GO