-- GLM Locked Over Time (Area Chart)
-- Returns: Cumulative GLM locked by day

WITH daily_flows AS (
    SELECT
        DATE_TRUNC('day', evt_block_time) AS day,
        SUM(CASE
            WHEN "to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c THEN CAST(value AS DOUBLE) / 1e18
            WHEN "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c THEN -CAST(value AS DOUBLE) / 1e18
        END) AS net_flow
    FROM erc20_ethereum.evt_Transfer
    WHERE contract_address = 0x7DD9c5Cba05E151C895FDe1CF355C9A1D5DA6429
    AND ("to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c
         OR "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c)
    GROUP BY 1
)
SELECT
    day,
    SUM(net_flow) OVER (ORDER BY day) AS total_glm_locked
FROM daily_flows
ORDER BY day
