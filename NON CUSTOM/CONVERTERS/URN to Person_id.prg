SELECT
	PA.PERSON_ID

FROM
	PERSON_ALIAS PA
	
WHERE 
	PA.ALIAS = "XXXXX" ; ENTER PERSONS URN HERE
	
WITH MAXREC = 10, NOCOUNTER, SEPARATOR=" ", FORMAT