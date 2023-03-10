SELECT
    I.ITEM_CODE AS ITEM,
    I.ITEM_NAME AS I_NAME,
    C.CL_NAME AS C_NAME,
    S.SIZE_NAME AS S_NAME
FROM
    ITEM I
CROSS JOIN
    COLOR_TBL C
CROSS JOIN
    SIZE_TBL S
WHERE
    STOCK_MANAGEMENT_TYPE = '1'
ORDER BY
    I.ITEM_CODE ASC,
    C.CL_CODE ASC,
    S.SIZE_CODE ASC