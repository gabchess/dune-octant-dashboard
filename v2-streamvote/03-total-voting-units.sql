-- Octant v2 - Total Voting Units (Counter)
-- Sum of all Superfluid distribution units across all projects

WITH latest_units AS (
  SELECT
    varbinary_substring(topic2, 13, 20) as project,
    varbinary_to_uint256(varbinary_substring(data, 33, 32)) as new_units,
    ROW_NUMBER() OVER (PARTITION BY topic2 ORDER BY block_time DESC, index DESC) as rn
  FROM ethereum.logs
  WHERE block_time >= TIMESTAMP '2025-12-01'
    AND contract_address = 0xfEDf505B46968B43257C56f89B0C5f68f1ba1005
    AND topic0 = 0x58b452da1f241e47a4cf34c1a770df2202ae3743eb13aa99f14cc8c7b5c133ba
)
SELECT SUM(new_units) as total_voting_units
FROM latest_units
WHERE rn = 1 AND new_units > 0
