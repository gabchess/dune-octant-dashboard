-- Top 20 Whale Lockers (Table)
-- Returns: Largest GLM holders with balance and % of total

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
    locker,
    ROUND(balance, 0) AS glm_locked,
    ROUND(balance * 100.0 / (SELECT SUM(balance) FROM balances WHERE balance > 0), 2) AS pct_of_total
FROM balances
WHERE balance > 100
ORDER BY balance DESC
LIMIT 20
