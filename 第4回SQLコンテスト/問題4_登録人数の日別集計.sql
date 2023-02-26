WITH MONTH AS (
    SELECT
        DATE('2022-08-01') AS CON_DATE,
        0 AS CNT
    UNION ALL
    SELECT
        DATE(CON_DATE, '+1 day') AS CON_DATE,
        0
    FROM
        MONTH
    WHERE
        CON_DATE < DATE('2022-08-31')
)
SELECT
    T.CON_DATE AS REGIST_DATE,
    (
    CASE STRFTIME('%w', T.CON_DATE)
        WHEN '0' THEN '日'
        WHEN '1' THEN '月'
        WHEN '2' THEN '火'
        WHEN '3' THEN '水'
        WHEN '4' THEN '木'
        WHEN '5' THEN '金'
        WHEN '6' THEN '土'
    END
    ) AS WK,
    SUM(T.CNT) AS TOTAL
FROM (
    SELECT
        *
    FROM
        MONTH
    UNION ALL
    SELECT
        DATE(CONFIRMED_AT) AS CON_DATE,
        1 AS CNT
    FROM
        USERS
    WHERE
        VALID_FLG = '1'
    AND
        CONFIRMED_AT IS NOT NULL
    AND
        DATE('2022-08-01 00:00:00') <= CONFIRMED_AT
    AND
        CONFIRMED_AT < DATE('2022-09-01 00:00:00')
    ) T
GROUP BY
    T.CON_DATE
ORDER BY
    REGIST_DATE ASC
;