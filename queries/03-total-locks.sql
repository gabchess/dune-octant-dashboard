-- Total Locks (Counter)
-- Returns: Count of lock transactions

SELECT COUNT(*) as total_locks
FROM erc20_ethereum.evt_Transfer
WHERE contract_address = 0x7DD9c5Cba05E151C895FDe1CF355C9A1D5DA6429
AND "to" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c
