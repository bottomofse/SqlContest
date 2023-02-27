WITH MRR_TBL AS (
    SELECT
        MIN(MONTHLY) AS YM,
        0 AS MRR
    FROM
        MRR_DATA
    UNION ALL
    SELECT
        DATE(YM, '+1 month') AS YM,
        MRR + (
            SELECT
                MRR_DATA.NEW_MRR + MRR_DATA.EXPANSION_MRR - MRR_DATA.DOWNGRADE_MRR - MRR_DATA.CHURN_MRR
            FROM MRR_DATA
            WHERE MRR_TBL.YM = MRR_DATA.MONTHLY
        )
    FROM
        MRR_TBL
    WHERE
        MRR_TBL.YM <= (SELECT MAX(MONTHLY) FROM MRR_DATA)
)
SELECT
    *
FROM
    MRR_TBL
ORDER BY
    YM
;
