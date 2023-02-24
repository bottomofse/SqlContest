SELECT
    T.PF_CODE AS 都道府県コード,
    T.PF_NAME AS 都道府県名,
    MAX(CASE T.RANK
            WHEN 1 THEN T.NATION_NAME
            ELSE ''
        END
    ) AS '1位 国名',
    MAX(CASE T.RANK
            WHEN 1 THEN T.AMT
            ELSE 0
        END
    ) AS '1位 人数',
    MAX(CASE T.RANK
            WHEN 2 THEN T.NATION_NAME
            ELSE ''
        END
    ) AS '2位 国名',
    MAX(CASE T.RANK
            WHEN 2 THEN T.AMT
            ELSE 0
        END
    ) AS '2位 人数',
    MAX(CASE T.RANK
            WHEN 3 THEN T.NATION_NAME
            ELSE ''
        END
    ) AS '3位 国名',
    MAX(CASE T.RANK
            WHEN 3 THEN T.AMT
            ELSE 0
        END
    ) AS '3位 人数',
    SUM(T.AMT) AS 合計人数
FROM (
    SELECT
        ROW_NUMBER() OVER (PARTITION BY P.PF_NAME ORDER BY F.AMT DESC) AS RANK,
        P.PF_CODE,
        P.PF_NAME,
        N.NATION_NAME,
        F.AMT
    FROM
        FOREIGNER F
    LEFT OUTER JOIN
        NATIONALITY N
    ON
        F.NATION_CODE = N.NATION_CODE
    LEFT OUTER JOIN
        PREFECTURE P
    ON
        F.PF_CODE = P.PF_CODE
    WHERE
        N.NATION_CODE != '113'
) T
GROUP BY
    T.PF_CODE,
    T.PF_NAME
ORDER BY
    合計人数 DESC,
    都道府県コード ASC
;