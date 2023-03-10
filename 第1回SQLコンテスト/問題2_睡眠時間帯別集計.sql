SELECT
    A.AGE_CODE AS '年齢コード',
    A.AGE_NAME AS '年齢階層名',
    SUM(SP_TIME_5) AS '5時間未満',
    SUM(SP_TIME_6) AS '5時間以上6時間未満',
    SUM(SP_TIME_7) AS '6時間以上7時間未満',
    SUM(SP_TIME_8) AS '7時間以上8時間未満',
    SUM(SP_TIME_9) AS '8時間以上9時間未満',
    SUM(SP_TIME_9OVER) AS '9時間以上'
FROM
    SLEEP_TIME_DTL S
INNER JOIN
    AGE_GRP A
ON S.AGE_CODE = A.AGE_CODE
INNER JOIN
    PREFECTURE P
ON S.PF_CODE = P.PF_CODE
WHERE S.PF_CODE IN ('01000','02000','03000','04000','07000')
GROUP BY A.AGE_CODE,A.AGE_NAME