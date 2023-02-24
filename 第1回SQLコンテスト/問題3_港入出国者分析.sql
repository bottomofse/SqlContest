SELECT
    I1.PORT_CODE '港コード',
    P.PORT_NAME '港名',
    I1.AMT '入国者数',
    I2.AMT '出国者数',
    I1.AMT - I2.AMT '差分'
FROM
    IMMIGRATION I1
    INNER JOIN
        IMMIGRATION I2
        ON
            I1.PORT_CODE = I2.PORT_CODE
        AND
            I1.GROUP_CODE = I2.GROUP_CODE
        AND
            I2.KIND_CODE = 120
    INNER JOIN
        PORT P
    ON
        I1.PORT_CODE = P.PORT_CODE
WHERE
    I1.GROUP_CODE = 120
    AND
    I1.KIND_CODE = 110
    AND
    I1.AMT > I2.AMT
ORDER BY
    (I1.AMT - I2.AMT) DESC,
    I1.PORT_CODE DESC
;