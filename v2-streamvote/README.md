# State of Octant v2: StreamVote Dashboard

**Live Dashboard:** https://dune.com/gabe_onchain/state-of-octant-v2

## Overview

Tracking Octant v2's StreamVote experiment: continuous yield distribution to Ethereum ecosystem projects via Superfluid streaming, backed by yield-donating vaults. Live since Dec 12, 2025.

## Key Metrics

- **17** projects receiving continuous funding
- **1,642** total voting units allocated
- **56+** days of continuous streaming
- **Protocol Guild** leads with 12.8% of allocation

## Projects Funded

| Project | Units | Share |
|---------|-------|-------|
| Protocol Guild | 210 | 12.8% |
| rotki | 183 | 11.1% |
| Vyper | 172 | 10.5% |
| Solidity | 158 | 9.6% |
| L2BEAT | 121 | 7.4% |
| EAS | 116 | 7.1% |
| Dappnode | 110 | 6.7% |
| EthStaker | 102 | 6.2% |
| Shutter | 78 | 4.8% |
| Blobscan | 74 | 4.5% |
| Verifereum | 70 | 4.3% |
| Libp2p | 56 | 3.4% |
| powdr | 54 | 3.3% |
| ethers.js | 52 | 3.2% |
| Grandine | 42 | 2.6% |
| Multipass | 23 | 1.4% |
| Samba | 21 | 1.3% |

## Technical Details

- **Data source:** Raw `ethereum.logs` (contracts not yet decoded on Dune)
- **Distribution mechanism:** Superfluid General Distribution Agreement (GDA)
- **GDA Pool contract:** `0xfEDf505B46968B43257C56f89B0C5f68f1ba1005`
- **Event tracked:** `MemberUnitsUpdated` (`0x58b452da...`)
- **Strategy factories queried:** Sky, Morpho, Yearn (for strategy deployment counter)
- **PaymentSplitterFactory:** `0x5711765E0756B45224fc1FdA1B41ab344682bBcb`

## Queries

1. `01-streamvote-allocation.sql` - Project allocation with names and percentages
2. `02-projects-funded.sql` - Counter: number of projects funded
3. `03-total-voting-units.sql` - Counter: total voting units
4. `04-days-streaming.sql` - Counter: days since StreamVote launch
5. `05-top-allocation.sql` - Counter: top project allocation percentage
6. `06-allocation-over-time.sql` - Time series: how allocations changed since launch

## Skills Demonstrated

- DuneSQL with raw log queries (unverified contracts)
- Superfluid GDA event decoding
- Varbinary manipulation (`varbinary_substring`, `varbinary_to_uint256`)
- Window functions (`ROW_NUMBER`, `PARTITION BY`)
- On-chain address resolution (mapping addresses to project names)
- Dashboard design (counters, bar charts, time series)
