SELECT
    T1.CLASS_NAME AS CLASS,
    T1.PERSON_NAME AS PERSON,
    T1.AMT AS HOUSEHOLDS
FROM
    HOUSEHOLD T1
WHERE
    PERSON_CODE <> '1'
    AND
    CLASS_CODE <> '01'
    AND
    T1.AMT = (
        SELECT
            MAX(T2.AMT)
        FROM
            HOUSEHOLD T2
        WHERE
            PERSON_CODE <> '1'
        AND
            CLASS_CODE <> '01'
        AND
            T2.CLASS_CODE = T1.CLASS_CODE
        GROUP BY
        CLASS_NAME
    )
ORDER BY
    T1.CLASS_CODE ASC