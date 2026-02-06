-- Octant v2 - Allocation Changes Over Time
-- Tracks how each project's Superfluid distribution units changed since launch
-- Filtered to known 17 StreamVote projects only

WITH events AS (
  SELECT
    varbinary_substring(topic2, 13, 20) as project,
    varbinary_to_uint256(varbinary_substring(data, 33, 32)) as new_units,
    block_time
  FROM ethereum.logs
  WHERE block_time >= TIMESTAMP '2025-12-01'
    AND contract_address = 0xfEDf505B46968B43257C56f89B0C5f68f1ba1005
    AND topic0 = 0x58b452da1f241e47a4cf34c1a770df2202ae3743eb13aa99f14cc8c7b5c133ba
    AND varbinary_substring(topic2, 13, 20) IN (
      0xdddd576baf106baae54bde40bcac602bb4a7cf79,
      0x9531c059098e3d194ff87febb587ab07b30b1306,
      0xd6e245ba9e1f71e629d6988d225a34542474a56a,
      0xe2f7cf9c2b12c0bfcdab571f9e50418fc08f4ad1,
      0x27f76533efa21772eab4a89953dfd1f29a2ebff2,
      0xbca48834b3653ec795411eb0fcbe4038f8527d62,
      0x53390590476dc98860316e4b46bb9842af55efc4,
      0xa83a92297b3d80a70cc396bf74424971a9890704,
      0xe55d189beab58cc3e61bb2bc6fe307fb0b5edcf7,
      0xd7bde01888b8a2a97924444009e31c8d8c2391f3,
      0x65fe89a480bdb998f4116daf2a9360632554092c,
      0x856c29e91eb30b8d9154a74a543dcc8d970d5d15,
      0x759c16c76da0e3e2bc5420add6072daf6925f818,
      0x8ba1f109551bd432803012645ac136ddd64dba72,
      0x1a62f45993d1923d6129fb903d2cdd99b3eb79a3,
      0xac60b1f69b8dfafd8234b2dd81ee74ffe3baf9c0,
      0x7b306f6692915bf426c6a8f85c36b347282645f7
    )
)
SELECT
  block_time,
  CASE project
    WHEN 0xdddd576baf106baae54bde40bcac602bb4a7cf79 THEN 'Protocol Guild'
    WHEN 0x9531c059098e3d194ff87febb587ab07b30b1306 THEN 'rotki'
    WHEN 0xd6e245ba9e1f71e629d6988d225a34542474a56a THEN 'Vyper'
    WHEN 0xe2f7cf9c2b12c0bfcdab571f9e50418fc08f4ad1 THEN 'Solidity'
    WHEN 0x27f76533efa21772eab4a89953dfd1f29a2ebff2 THEN 'L2BEAT'
    WHEN 0xbca48834b3653ec795411eb0fcbe4038f8527d62 THEN 'EAS'
    WHEN 0x53390590476dc98860316e4b46bb9842af55efc4 THEN 'Dappnode'
    WHEN 0xa83a92297b3d80a70cc396bf74424971a9890704 THEN 'EthStaker'
    WHEN 0xe55d189beab58cc3e61bb2bc6fe307fb0b5edcf7 THEN 'Shutter'
    WHEN 0xd7bde01888b8a2a97924444009e31c8d8c2391f3 THEN 'Blobscan'
    WHEN 0x65fe89a480bdb998f4116daf2a9360632554092c THEN 'Verifereum'
    WHEN 0x856c29e91eb30b8d9154a74a543dcc8d970d5d15 THEN 'Libp2p'
    WHEN 0x759c16c76da0e3e2bc5420add6072daf6925f818 THEN 'powdr'
    WHEN 0x8ba1f109551bd432803012645ac136ddd64dba72 THEN 'ethers.js'
    WHEN 0x1a62f45993d1923d6129fb903d2cdd99b3eb79a3 THEN 'Grandine'
    WHEN 0xac60b1f69b8dfafd8234b2dd81ee74ffe3baf9c0 THEN 'Multipass'
    WHEN 0x7b306f6692915bf426c6a8f85c36b347282645f7 THEN 'Samba'
  END AS project_name,
  new_units
FROM events
WHERE new_units > 0
ORDER BY block_time
