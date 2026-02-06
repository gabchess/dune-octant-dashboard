# Dune Dashboards by @gabe_onchain

Onchain data analysis dashboards:

1. **State of Octant (v1):** https://dune.com/gabe_onchain/state-of-octant - GLM locking, community growth, whale activity
2. **State of Octant v2:** https://dune.com/gabe_onchain/state-of-octant-v2 - StreamVote yield distribution via Superfluid streaming
3. **Coinbase FY 2025 Revenue Model:** https://dune.com/gabe_onchain/coinbase-fy-2025-revenue-model - #CoinbaseChallenge entry modeling FY2025 total revenue using onchain data

---

## V1: State of Octant

An onchain analysis of Octant protocol tracking GLM locking, community growth, and whale activity.

## Overview

Octant is a community-driven platform built by Golem Foundation where users lock GLM tokens to earn ETH rewards from 100K staked ETH. This dashboard tracks the protocol's onchain activity.

## Key Metrics

| Metric | Value |
|--------|-------|
| Total GLM Locked | 155.8M |
| Unique Lockers | 1,687 |
| Total Lock Transactions | 2,335 |
| Total Unlock Transactions | 1,002 |

## Contracts Tracked

| Contract | Address | Purpose |
|----------|---------|---------|
| GLM Deposits | `0x879133fd79b7f48ce1c368b0fca9ea168eaf117c` | Lock/Unlock GLM |
| GLM Token | `0x7DD9c5Cba05E151C895FDe1CF355C9A1D5DA6429` | ERC-20 Token |

## Dashboard Components

1. **Counters (4):** Total GLM Locked, Unique Lockers, Total Locks, Total Unlocks
2. **Hero Chart:** GLM Locked Over Time (cumulative area chart)
3. **Monthly Lock vs Unlock:** Stacked bar chart showing activity rhythm
4. **New Lockers Per Month:** Bar chart showing community growth
5. **Top 20 Whale Lockers:** Table with addresses and % of total
6. **Lock Size Distribution:** Bar chart showing wallet size buckets

## Queries

All SQL queries are in the `/queries` folder:

- `01-total-glm-locked.sql` - Counter: Total GLM in deposits contract
- `02-unique-lockers.sql` - Counter: Distinct addresses that locked
- `03-total-locks.sql` - Counter: Lock transaction count
- `04-total-unlocks.sql` - Counter: Unlock transaction count
- `05-glm-locked-over-time.sql` - Area chart: Cumulative GLM locked
- `06-monthly-lock-unlock.sql` - Bar chart: Monthly activity
- `07-new-lockers-per-month.sql` - Bar chart: First-time lockers
- `08-top-20-lockers.sql` - Table: Whale leaderboard
- `09-lock-size-distribution.sql` - Bar chart: Wallet size buckets

## Tech Stack

- **Platform:** Dune Analytics
- **Query Engine:** DuneSQL (Trino-based)
- **Data Source:** `erc20_ethereum.evt_Transfer`

---

## V2: StreamVote Dashboard

See [v2-streamvote/README.md](v2-streamvote/README.md) for full details.

Tracks Octant v2's StreamVote experiment: continuous yield distribution to 17 Ethereum ecosystem projects via Superfluid GDA streaming, backed by yield-donating vaults.

**Key highlights:**
- Raw `ethereum.logs` queries (contracts not yet decoded on Dune)
- Superfluid GDA event decoding (MemberUnitsUpdated)
- Varbinary manipulation for address/uint extraction
- 6 queries: allocation bar chart, 4 counters, time series

---

## Coinbase FY 2025 Revenue Model

See [coinbase-challenge/](coinbase-challenge/) for full details.

Entry for #CoinbaseChallenge: modeling Coinbase's FY 2025 total revenue using onchain data from Dune.

**Estimate: $6.88B** (vs Wall Street consensus $7.28B)

**Tweet:** https://x.com/gabe_onchain/status/2019878913208672452

4 queries backing the model:
- **Base L2 Monthly Net Revenue** - Sequencer fees minus L1 costs, shows Oct spike then Dec collapse (-62%)
- **USDC Supply on Ethereum** - Weekly cumulative supply, grew from $44B to $65B+ through the crash
- **Weekly DEX Trading Volume** - All-chain DEX volume showing Q4 volume cliff
- **Quarterly Revenue Model** - Q1-Q3 actuals + Q4 estimate visualization

## Author

Built by [@gabe_onchain](https://x.com/gabe_onchain)

February 2026
