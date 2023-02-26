WITH TMP AS (
SELECT
    RANK() OVER (ORDER BY C.TOTAL_VALUE) AS RANK,
    C.SURVEY_YEAR,
    C.PF_CODE,
    C.KIND_CODE,
    C.TOTAL_VALUE
FROM
    CONVENIENCE C
WHERE
    SURVEY_YEAR = '2019'
    AND
    KIND_CODE = '100'
ORDER BY
    RANK ASC
)
SELECT
    CASE COUNT(*) % 2
        WHEN 1 THEN ROUND((
            SELECT
              T.TOTAL_VALUE  
            FROM
                TMP T
            WHERE T.RANK = ((SELECT COUNT(*) FROM TMP) / 2 + 1)
        ), 0)
        ELSE ROUND((
            SELECT
                AVG(T.TOTAL_VALUE)
            FROM
                TMP T
            WHERE T.RANK = ((SELECT COUNT(*) FROM TMP) / 2) OR T.RANK = ((SELECT COUNT(*) FROM TMP) / 2 + 1)
        ), 0)
    END AS SA_MEDIAN
FROM
    TMP T1
;