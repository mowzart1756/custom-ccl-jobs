SELECT
	O.ENCNTR_ID
	, O.ORDER_ID
	, ORDER_DATE_TIME = FORMAT(O.ORIG_ORDER_DT_TM, "YYYY-MM-DD HH:MM:SS")
	, P.NAME_FULL_FORMATTED
	, OD.OE_FIELD_DISPLAY_VALUE ; diet orders with datestamp
	, O.order_detail_display_line
	, DIET_SUB = SUBSTRING(22, 500, O.order_detail_display_line)

FROM
	ORDERS   O
	, (LEFT JOIN PERSON P ON (P.PERSON_ID = O.PERSON_ID))
	, (INNER JOIN ORDER_DETAIL OD ON (OD.ORDER_ID = O.ORDER_ID) 
		AND OD.oe_field_meaning = "DIETARYMODIFIERS")

PLAN O
WHERE
	O.encntr_id = 49894345 ; Encounter ID for James Testwhs testing patient
	;O.ORIG_ORDER_DT_TM > CNVTLOOKBEHIND("35,D") ; Timeline filter
	AND
	O.CATALOG_CD = 105460833 ; Diet Orders Only
	AND
	O.ORDER_STATUS_CD=2550.00 ; "Ordered" only not "Discontinued"
	
JOIN P
JOIN OD

WITH 
	MAXREC = 15,
	NOCOUNTER, 
	SEPARATOR=" ",
	FORMAT