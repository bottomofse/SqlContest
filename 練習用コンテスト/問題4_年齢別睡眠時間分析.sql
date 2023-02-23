SELECT
    A.AGE_NAME 年齢階層,
    SUM(
        CASE S.TIME_CODE
            WHEN 120 THEN S.TARGET_POP
            ELSE 0
        END
    ) '5時間未満',
    SUM(
        CASE S.TIME_CODE
            WHEN 130 THEN S.TARGET_POP
            ELSE 0
        END
    ) '5時間以上6時間未満',
    SUM(
        CASE S.TIME_CODE
            WHEN 140 THEN S.TARGET_POP
            ELSE 0
        END
    ) '6時間以上7時間未満',
    SUM(
        CASE S.TIME_CODE
            WHEN 150 THEN S.TARGET_POP
            ELSE 0
        END
    ) '7時間以上8時間未満',
    SUM(
        CASE S.TIME_CODE
            WHEN 160 THEN S.TARGET_POP
            ELSE 0
        END
    ) '8時間以上9時間未満',
    SUM(
        CASE S.TIME_CODE
            WHEN 170 THEN S.TARGET_POP
            ELSE 0
        END
    ) '9時間以上',
    SUM(
        CASE S.TIME_CODE
            WHEN 180 THEN S.TARGET_POP
            ELSE 0
        END
    ) '不詳'
FROM
    SLEEP_TIME_DTL S
INNER JOIN AGE_GRP A
ON S.AGE_CODE = A.AGE_CODE
GROUP BY A.AGE_CODE, A.AGE_NAME
ORDER BY A.AGE_CODE ASC