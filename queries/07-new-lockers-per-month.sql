-- New Lockers Per Month (Bar Chart)
-- Returns: Count of first-time lockers by month

WITH first_locks AS (
    SELECT
        "from" AS locker,
        MIN(evt_block_time) AS first_lock_time
    FROM erc20_ethereum.evt_Transfer
    WHERE contract_address = 0x7DD9c5Cba05E151C895FDe1CF355C9A1D5DA6429
    AND "to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c
    GROUP BY 1
)
SELECT
    DATE_TRUNC('month', first_lock_time) AS month,
    COUNT(*) AS new_lockers
FROM first_locks
GROUP BY 1
ORDER BY 1
