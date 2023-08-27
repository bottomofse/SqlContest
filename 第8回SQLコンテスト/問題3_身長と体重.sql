WITH T_AVG AS (
SELECT
    AGE AS AGE
    , GENDER_CODE AS GENDER_CODE
    , ROUND(CAST(SUM(
        CASE CATEGORY_CODE
            WHEN '10' THEN AVERAGE_VALUE
            ELSE 0
        END
    ) AS REAL) / CAST(SUM(
        CASE CATEGORY_CODE
            WHEN '10' THEN 1
            ELSE 0
        END
    ) AS REAL), 1) AS H_AVG
    , ROUND(CAST(SUM(
        CASE CATEGORY_CODE
            WHEN '20' THEN AVERAGE_VALUE
            ELSE 0
        END
    ) AS REAL) / CAST(SUM(
        CASE CATEGORY_CODE
            WHEN '20' THEN 1
            ELSE 0
        END
    ) AS REAL), 1) AS W_AVG
FROM SCHOOL_HEALTH
WHERE SURVEY_YEAR = '2019'
GROUP BY AGE, GENDER_CODE)
, T_PER AS (
    SELECT
        S.AGE AS AGE
        , S.GENDER_CODE AS GENDER_CODE
        , ROUND(CAST(SUM(
            CASE
                WHEN (S.CATEGORY_CODE = '10') AND (S.AVERAGE_VALUE >= A.H_AVG) THEN 1
                ELSE 0
            END
        ) AS REAL) / CAST(
        SUM(
            CASE
                WHEN S.CATEGORY_CODE = '10' THEN 1
                ELSE 0
            END
        ) AS REAL) * 100, 1) || '%' AS H_PER
        , ROUND(CAST(SUM(
            CASE
                WHEN (S.CATEGORY_CODE = '20') AND (S.AVERAGE_VALUE >= A.W_AVG) THEN 1
                ELSE 0
            END
        ) AS REAL) / CAST(
        SUM(
            CASE
                WHEN S.CATEGORY_CODE = '20' THEN 1
                ELSE 0
            END
        ) AS REAL) * 100, 1) || '%' AS W_PER
    FROM SCHOOL_HEALTH S
    LEFT OUTER JOIN T_AVG A
    ON S.GENDER_CODE = A.GENDER_CODE
    AND S.AGE = A.AGE
    WHERE S.SURVEY_YEAR = '2019'
    GROUP BY S.AGE, S.GENDER_CODE
)
SELECT
    A.AGE AS AGE
    , CASE A.GENDER_CODE
          WHEN '20' THEN 'MALE'
          ELSE 'FEMALE'
      END AS GENDER
    , A.H_AVG AS H_AVG
    , P.H_PER AS H_PER
    
    , A.W_AVG AS W_AVG
    , P.W_PER AS W_PER
    
FROM T_AVG A
LEFT OUTER JOIN T_PER P
ON A.AGE = P.AGE AND A.GENDER_CODE = P.GENDER_CODE
ORDER BY A.AGE DESC, A.GENDER_CODE DESC;