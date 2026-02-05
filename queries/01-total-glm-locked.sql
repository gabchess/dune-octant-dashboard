-- Total GLM Locked (Counter)
-- Returns: Current total GLM in the Deposits contract

SELECT
    SUM(CASE
        WHEN "to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c THEN CAST(value AS DOUBLE) / 1e18
        WHEN "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c THEN -CAST(value AS DOUBLE) / 1e18
    END) as total_glm_locked
FROM erc20_ethereum.evt_Transfer
WHERE contract_address = 0x7DD9c5Cba05E151C895FDe1CF355C9A1D5DA6429
AND ("to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c
     OR "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c)
