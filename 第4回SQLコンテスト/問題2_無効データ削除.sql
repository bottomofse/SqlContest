DELETE FROM EMP
WHERE
    VALID_FLG = '0'
AND
    EXISTS (
        SELECT EMP_CODE
        FROM EMP_INVALID
        WHERE EMP.EMP_CODE = EMP_INVALID.EMP_CODE
    )
;