-- Lock Size Distribution (Bar Chart)
-- Returns: Number of wallets and total GLM by size bucket

WITH balances AS (
    SELECT
        CASE
            WHEN "to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c THEN "from"
            WHEN "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c THEN "to"
        END AS locker,
        SUM(CASE
            WHEN "to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c THEN CAST(value AS DOUBLE) / 1e18
            WHEN "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c THEN -CAST(value AS DOUBLE) / 1e18
        END) AS balance
    FROM erc20_ethereum.evt_Transfer
    WHERE contract_address = 0x7DD9c5Cba05E151C895FDe1CF355C9A1D5DA6429
    AND ("to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c
         OR "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c)
    GROUP BY 1
)
SELECT
    CASE
        WHEN balance < 1000 THEN '1. < 1K'
        WHEN balance < 10000 THEN '2. 1K-10K'
        WHEN balance < 100000 THEN '3. 10K-100K'
        WHEN balance < 1000000 THEN '4. 100K-1M'
        ELSE '5. 1M+'
    END AS size_bucket,
    COUNT(*) AS num_wallets,
    ROUND(SUM(balance), 0) AS total_glm
FROM balances
WHERE balance > 0
GROUP BY 1
ORDER BY 1
