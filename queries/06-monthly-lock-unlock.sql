-- Monthly Lock vs Unlock Volume (Bar Chart)
-- Returns: GLM locked and unlocked by month

SELECT
    DATE_TRUNC('month', evt_block_time) AS month,
    SUM(CASE
        WHEN "to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c
        THEN CAST(value AS DOUBLE) / 1e18
        ELSE 0
    END) AS glm_locked,
    SUM(CASE
        WHEN "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c
        THEN CAST(value AS DOUBLE) / 1e18
        ELSE 0
    END) AS glm_unlocked
FROM erc20_ethereum.evt_Transfer
WHERE contract_address = 0x7DD9c5Cba05E151C895FDe1CF355C9A1D5DA6429
AND ("to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c
     OR "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c)
GROUP BY 1
ORDER BY 1
