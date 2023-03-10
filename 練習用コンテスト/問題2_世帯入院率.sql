SELECT
    H.PF_CODE AS 都道府県コード,
    P.PF_NAME AS 都道府県名,
    ROUND(
        (CAST(H.INP_YES AS REAL) / CAST((H.INP_YES + H.INP_NO + H.UNIDENTIFIED) AS REAL)) * 100
    , 1) AS 入院率
FROM HOSPITALIZATION H
INNER JOIN PREFECTURE P
ON H.PF_CODE = P.PF_CODE
ORDER BY 入院率 DESC, 都道府県コード ASC
;