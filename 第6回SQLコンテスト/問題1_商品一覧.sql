SELECT
    ITEM_POPULAR_RANK RANK,
    ITEM_CODE CODE,
    ITEM_NAME NAME
FROM ITEM
WHERE SALE_END_DATE IS NULL
ORDER BY ITEM_POPULAR_RANK ASC, ITEM_CODE ASC;
