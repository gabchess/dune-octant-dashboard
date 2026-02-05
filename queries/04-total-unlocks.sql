-- Total Unlocks (Counter)
-- Returns: Count of unlock transactions

SELECT COUNT(*) as total_unlocks
FROM erc20_ethereum.evt_Transfer
WHERE contract_address = 0x7DD9c5Cba05E151C895FDe1CF355C9A1D5DA6429
AND "from" = 0x879133fd79b7f48ce1c368b0fca9ea168eaf117c
