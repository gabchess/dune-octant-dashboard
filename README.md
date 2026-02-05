# State of Octant - Dune Dashboard

**Live Dashboard:** https://dune.com/gabe_onchain/state-of-octant

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

## Author

Built by [@gabe_onchain](https://x.com/gabe_onchain)

February 2026
