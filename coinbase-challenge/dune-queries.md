# Coinbase FY 2025 Revenue Model - Dune Queries

## Query 1: Base L2 Monthly Revenue (Sequencer Fees)
**Purpose:** Shows Base chain's fee revenue by month. This is Coinbase's "Other revenue" driver.
**Visual:** Bar chart, monthly

```sql
-- Base L2 Monthly Fee Revenue (ETH + USD)
-- Sequencer fees = base_fee + priority_fee (Coinbase keeps these)
-- L1 fee = cost Coinbase pays to post data to Ethereum (expense, not revenue)
SELECT
    date_trunc('month', block_time) AS month,
    SUM(
        CAST(gas_used AS double) * CAST(gas_price AS double) / 1e18
    ) AS total_fees_eth,
    SUM(
        CAST(gas_used AS double) * CAST(gas_price AS double) / 1e18
    ) * (
        SELECT price 
        FROM prices.usd_latest 
        WHERE blockchain = 'ethereum' 
        AND symbol = 'WETH' 
        LIMIT 1
    ) AS total_fees_usd_approx
FROM base.transactions
WHERE block_time >= DATE '2025-01-01'
  AND block_time < DATE '2026-01-01'
GROUP BY 1
ORDER BY 1
```

**Alternative using gas.fees table (better if available):**
```sql
SELECT
    date_trunc('month', block_time) AS month,
    SUM(base_fee + priority_fee) / 1e18 AS sequencer_revenue_eth,
    SUM(l1_fee) / 1e18 AS l1_cost_eth,
    SUM(base_fee + priority_fee - l1_fee) / 1e18 AS net_profit_eth
FROM gas.fees
WHERE blockchain = 'base'
  AND block_time >= DATE '2025-01-01'
  AND block_time < DATE '2026-01-01'
GROUP BY 1
ORDER BY 1
```

---

## Query 2: USDC Total Supply Over Time (Weekly)
**Purpose:** Tracks USDC market cap growth, which directly drives Coinbase's stablecoin interest revenue (50/50 split with Circle on reserve interest).
**Visual:** Area chart, weekly

```sql
-- USDC Supply on Ethereum (weekly snapshots)
-- USDC contract: 0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48
-- Mint = Transfer from 0x0, Burn = Transfer to 0x0
WITH daily_mints AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CASE 
            WHEN "from" = 0x0000000000000000000000000000000000000000 THEN CAST(value AS double)
            ELSE 0 
        END) / 1e6 AS minted,
        SUM(CASE 
            WHEN "to" = 0x0000000000000000000000000000000000000000 THEN CAST(value AS double)
            ELSE 0 
        END) / 1e6 AS burned
    FROM erc20_ethereum.evt_Transfer
    WHERE contract_address = 0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48
      AND evt_block_time >= DATE '2025-01-01'
      AND evt_block_time < DATE '2026-01-01'
      AND ("from" = 0x0000000000000000000000000000000000000000 
           OR "to" = 0x0000000000000000000000000000000000000000)
    GROUP BY 1
),
running AS (
    SELECT
        day,
        minted,
        burned,
        SUM(minted - burned) OVER (ORDER BY day) AS cumulative_net_change
    FROM daily_mints
)
SELECT
    date_trunc('week', day) AS week,
    -- Starting supply was ~$44.5B on Jan 1 2025, add cumulative
    44500 + MAX(cumulative_net_change) / 1e6 AS estimated_supply_millions
FROM running
GROUP BY 1
ORDER BY 1
```

**Simpler approach using tokens table if available:**
```sql
-- If Dune has a tokens.transfers or similar decoded table
SELECT
    date_trunc('week', block_date) AS week,
    SUM(CASE 
        WHEN "from" = 0x0000000000000000000000000000000000000000 
        THEN amount_usd ELSE 0 END) AS minted_usd,
    SUM(CASE 
        WHEN "to" = 0x0000000000000000000000000000000000000000 
        THEN amount_usd ELSE 0 END) AS burned_usd
FROM tokens_ethereum.transfers
WHERE contract_address = 0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48
  AND block_date >= DATE '2025-01-01'
  AND block_date < DATE '2026-01-01'
  AND (
    "from" = 0x0000000000000000000000000000000000000000 
    OR "to" = 0x0000000000000000000000000000000000000000
  )
GROUP BY 1
ORDER BY 1
```

---

## Query 3: Weekly CEX-Relevant Trading Volume Proxy
**Purpose:** Shows total onchain DEX volume as proxy for market activity (when DEX volume drops, CEX volume drops harder). Demonstrates the Q4 cliff.
**Visual:** Area chart, weekly

```sql
-- Weekly DEX Trading Volume (all chains) as market activity proxy
-- When DEX volume drops, Coinbase CEX volume drops even more
SELECT
    date_trunc('week', block_date) AS week,
    SUM(amount_usd) AS total_dex_volume_usd
FROM dex.trades
WHERE block_date >= DATE '2025-01-01'
  AND block_date < DATE '2026-01-01'
GROUP BY 1
ORDER BY 1
```

---

## Query 4: Coinbase ETH Staking (cbETH + Beacon Chain)
**Purpose:** Tracks ETH staked through Coinbase, which drives staking revenue. Shows whether units staked held up even as prices fell.
**Visual:** Line chart

```sql
-- Coinbase Staked ETH tracking via cbETH supply
-- cbETH contract: 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704
WITH daily_supply_change AS (
    SELECT
        date_trunc('week', evt_block_time) AS week,
        SUM(CASE 
            WHEN "from" = 0x0000000000000000000000000000000000000000 
            THEN CAST(value AS double) / 1e18
            ELSE 0 
        END) AS minted,
        SUM(CASE 
            WHEN "to" = 0x0000000000000000000000000000000000000000 
            THEN CAST(value AS double) / 1e18
            ELSE 0 
        END) AS burned
    FROM erc20_ethereum.evt_Transfer
    WHERE contract_address = 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704
      AND evt_block_time >= DATE '2025-01-01'
      AND evt_block_time < DATE '2026-01-01'
      AND ("from" = 0x0000000000000000000000000000000000000000 
           OR "to" = 0x0000000000000000000000000000000000000000)
    GROUP BY 1
)
SELECT
    week,
    minted,
    burned,
    minted - burned AS net_change,
    SUM(minted - burned) OVER (ORDER BY week) AS cumulative_net_change_2025
FROM daily_supply_change
ORDER BY 1
```

---

## Dashboard Layout Plan

**Title:** "Coinbase FY 2025 Revenue Model | #CoinbaseChallenge"
**Subtitle text widget:** Brief model summary with $6.88B estimate

**Row 1 (Counters):**
- FY 2025 Revenue Estimate: $6.88B
- Q4 2025 Estimate: $1.45B
- Wall Street Consensus: $1.85B (Q4)
- Our Delta: -$400M vs consensus

**Row 2:**
- Base L2 Monthly Revenue (bar chart)
- USDC Supply Growth (area chart)

**Row 3:**
- DEX Volume Weekly (area chart, shows the cliff)
- cbETH Supply Change (line chart)

**Row 4:**
- Text: Full model rationale summary
