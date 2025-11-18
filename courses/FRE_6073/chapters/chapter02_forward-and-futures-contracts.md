---
title: "Chapter 2: Forward and Futures Contracts"
author: "Based on John C. Hull"
date: "2025"
---

# Forward and Futures Contracts

This chapter explores forward and futures contracts, two fundamental types of derivatives that obligate parties to transact at predetermined prices. We'll examine their mechanics, differences, margin requirements, and how they're settled.

## Introduction to Futures Contracts

```{admonition} Key Concept: Futures Contract
:class: tip

A **futures contract** is an agreement to buy or sell an asset for a certain price at a certain time in the future.

**Key Characteristics:**
- Standardized contract specifications
- Traded on organized exchanges
- Daily settlement (marking to market)
- Minimal credit risk due to clearinghouse guarantee
```

### Futures vs. Forward Contracts

While similar in concept, futures and forwards have important differences:

```{note}
**Key Distinction:**

- **Forward contracts**: Traded over-the-counter (OTC), customized terms, settled at maturity
- **Futures contracts**: Traded on exchanges, standardized terms, settled daily
```

**Physical Meaning**: Think of a forward contract like a custom order placed directly with a manufacturer (tailored to your needs), while a futures contract is like buying a standardized product from a store (same specifications for everyone).

---

## Major Futures Exchanges

Futures contracts trade on organized exchanges worldwide:

| Exchange | Location | Primary Products |
|----------|----------|------------------|
| **CME Group** | Chicago, USA | Commodities, indices, interest rates, currencies |
| **ICE** | Atlanta, USA | Energy, agricultural commodities |
| **B3** | São Paulo, Brazil | Brazilian equities and commodities |
| **Tokyo Financial Exchange** | Tokyo, Japan | Interest rates and currencies |

```{note}
**Historical Note:**

The CME Group was formed when the Chicago Mercantile Exchange merged with the Chicago Board of Trade, creating the world's largest derivatives exchange.
```

---

## Examples of Futures Contracts

```{admonition} Example: Commodity Futures Contracts
:class: tip

**Typical Futures Contracts:**

1. **Gold Futures**:
   - Buy 100 oz. of gold at $1,800/oz. in December
   - Contract size: 100 troy ounces
   - Quoted in USD per troy ounce

2. **Currency Futures**:
   - Sell £62,500 at 1.2500 USD/GBP in March
   - Contract size: 62,500 British pounds
   - Quoted in USD per GBP

3. **Oil Futures**:
   - Sell 1,000 barrels of oil at $40/barrel in April
   - Contract size: 1,000 barrels
   - Quoted in USD per barrel
```

**Physical Meaning**: Each futures contract specifies exactly what will be delivered, when, where, and at what quality standards. This standardization makes them easily tradeable.

---

## Terminology: Long and Short Positions

```{admonition} Key Concept: Position Terminology
:class: tip

**Long Position:**
- The party that has agreed to **buy** the underlying asset
- Profits when the asset price rises
- Obligated to take delivery (or cash settlement)

**Short Position:**
- The party that has agreed to **sell** the underlying asset
- Profits when the asset price falls
- Obligated to make delivery (or cash settlement)
```

### Payoff Diagrams

```{note}
**Long Forward Position Payoff:**

- At maturity, profit = $S_T - K$
- Where $S_T$ is the spot price at maturity and $K$ is the delivery price
- Unlimited upside potential
- Downside limited to $K$ (price can't go below zero)
```

```{note}
**Short Forward Position Payoff:**

- At maturity, profit = $K - S_T$
- Mirror image of long position
- Profits when spot price falls below delivery price
- Losses when spot price rises above delivery price
```

**Physical Meaning**: Long position holders want prices to rise; short position holders want prices to fall. These offsetting positions allow risk transfer between parties.

---

## Forward Price

```{admonition} Key Concept: Forward Price
:class: tip

The **forward price** for a contract is the delivery price that would make the contract worth exactly zero if negotiated today.

**Important Points:**
- Changes over time as market conditions evolve
- May differ for different maturities
- Distinct from the delivery price agreed when contract was initiated
```

### Forward Price for Non-Dividend Paying Stock

For a stock paying no dividends:

$$F_0 = S_0(1+r)^T$$

Or with continuous compounding:

$$F_0 = S_0 e^{rT}$$

Where:
- $F_0$ = Forward price today
- $S_0$ = Spot price today
- $r$ = Risk-free interest rate
- $T$ = Time to maturity (in years)

```{admonition} Example Problem: Forward Price Calculation
:class: tip

**Problem Statement:**
A stock trades at $100 today. The risk-free rate is 5% per annum with continuous compounding. What is the forward price for a contract deliverable in 6 months?

**Given:**
- $S_0 = \$100$
- $r = 0.05$
- $T = 0.5$ years
```

```{dropdown} Solution

**Step 1: Apply the Formula**

For a non-dividend paying stock:

$$F_0 = S_0 e^{rT}$$

**Step 2: Substitute Values**

$$F_0 = 100 \times e^{0.05 \times 0.5}$$

$$F_0 = 100 \times e^{0.025}$$

$$F_0 = 100 \times 1.0253$$

$$F_0 = \$102.53$$

**Step 3: Interpret the Result**

The forward price of $102.53 reflects:
1. The current spot price of $100
2. Plus the cost of financing ($2.53) at 5% for 6 months

**Final Answer:** The 6-month forward price is **$102.53**.

**Physical Meaning**: The forward price compensates for the time value of money. If you buy forward, you don't pay until delivery, so the price includes the interest you could have earned on the cash.
```

---

## Example: Currency Forward Contract

```{admonition} Example Problem: Currency Hedging
:class: tip

**Problem Statement:**
On May 21, 2020, the treasurer of a corporation enters into a long forward contract to buy £1 million in six months at an exchange rate of 1.2230 USD/GBP.

**Questions:**
1. What is the corporation's obligation?
2. What are possible outcomes at maturity?
3. What is the profit/loss if GBP trades at 1.2500 at maturity?
```

```{dropdown} Solution

**Part 1: Corporation's Obligation**

The corporation is **obligated** to:
- Pay $1,223,000 (= £1,000,000 × 1.2230)
- Receive £1,000,000
- On November 21, 2020 (six months later)

**Part 2: Possible Outcomes**

**Scenario A: GBP Strengthens to 1.2500**
- Spot value of £1M = $1,250,000
- Contract price = $1,223,000
- Profit = $1,250,000 - $1,223,000 = **+$27,000**

**Scenario B: GBP Weakens to 1.2000**
- Spot value of £1M = $1,200,000
- Contract price = $1,223,000
- Loss = $1,200,000 - $1,223,000 = **-$23,000**

**Scenario C: GBP at 1.2230 (Forward Price)**
- Spot value = Contract price
- Profit/Loss = **$0**

**Part 3: Profit at 1.2500**

If the spot rate is 1.2500 at maturity:

Profit = (Spot Rate - Forward Rate) × Amount
Profit = (1.2500 - 1.2230) × £1,000,000
Profit = 0.0270 × £1,000,000 = **$27,000**

**Final Answer:** The corporation profits $27,000 when the pound strengthens to 1.2500.

**Physical Meaning**: The corporation locked in a favorable rate. When the actual rate is higher, they benefit by buying pounds cheaper than the market price.
```

---

## Margins and Daily Settlement

A crucial feature distinguishing futures from forwards is the margin system and daily settlement.

```{admonition} Key Concept: Margin Requirements
:class: tip

A **margin** is cash or marketable securities deposited by an investor with their broker to ensure contract performance.

**Purpose:**
- Minimize default risk
- Ensure parties can meet obligations
- Adjusted daily to reflect gains/losses
```

### Types of Margin

```{note}
**Initial Margin:**
- Amount required to open a futures position
- Typically 5-15% of contract value
- Deposited when position is established

**Maintenance Margin:**
- Minimum balance that must be maintained
- Usually 75-80% of initial margin
- If balance falls below this, margin call is issued

**Variation Margin:**
- Daily cash flows to maintain margin at required level
- Results from daily settlement (marking to market)
```

### Margin Calls

```{warning}
**Margin Call Process:**

For retail traders:
1. Account marked to market daily
2. If balance < maintenance margin → **margin call**
3. Must bring balance back to initial margin level
4. If unable to meet margin call → position liquidated

For exchange clearing members:
- Must maintain balance at initial margin level daily
- Also contribute to default fund
- More stringent requirements
```

**Physical Meaning**: Margins act as a performance bond. Daily settlement means that losses are collected (and gains paid) every day, preventing large accumulated debts.

---

## Example of Futures Trading with Margins

```{admonition} Example Problem: Gold Futures Margin Account
:class: tip

**Problem Statement:**
A retail trader takes a long position in 2 December gold futures contracts on June 5.

**Contract Specifications:**
- Contract size: 100 oz. per contract
- Futures price: $1,750/oz.
- Initial margin: $6,000 per contract
- Maintenance margin: $4,500 per contract
- Total position: 2 contracts (200 oz.)

**Question:** Track the margin account over several days given daily settlement prices.
```

```{dropdown} Solution

**Step 1: Initial Setup**

- Position: Long 2 contracts (200 oz.)
- Initial margin required: 2 × $6,000 = **$12,000**
- Maintenance margin: 2 × $4,500 = **$9,000**

**Step 2: Daily Settlement Tracking**

| Day | Trade Price | Settle Price | Daily Gain | Cumul. Gain | Margin Balance | Margin Call |
|-----|-------------|--------------|------------|-------------|----------------|-------------|
| 0 | $1,750.00 | - | - | - | $12,000 | - |
| 1 | - | $1,741.00 | -$1,800 | -$1,800 | $10,200 | - |
| 2 | - | $1,738.30 | -$540 | -$2,340 | $9,660 | - |
| 3 | - | $1,736.20 | -$420 | -$2,760 | $9,240 | - |
| 4 | - | $1,729.90 | -$1,260 | -$4,020 | $7,980 | **$4,020** |
| 5 | - | $1,730.80 | +$180 | -$3,840 | $12,180 | - |

**Step 3: Detailed Calculations**

**Day 1:**
- Price change: $1,741.00 - $1,750.00 = -$9.00/oz.
- Daily loss: -$9.00 × 200 oz. = -$1,800
- New balance: $12,000 - $1,800 = $10,200 ✓ (above $9,000 maintenance)

**Day 2:**
- Price change: $1,738.30 - $1,741.00 = -$2.70/oz.
- Daily loss: -$2.70 × 200 oz. = -$540
- New balance: $10,200 - $540 = $9,660 ✓

**Day 3:**
- Price change: $1,736.20 - $1,738.30 = -$2.10/oz.
- Daily loss: -$2.10 × 200 oz. = -$420
- New balance: $9,660 - $420 = $9,240 ✓

**Day 4:**
- Price change: $1,729.90 - $1,736.20 = -$6.30/oz.
- Daily loss: -$6.30 × 200 oz. = -$1,260
- New balance: $9,240 - $1,260 = $7,980 ✗ (below $9,000!)
- **MARGIN CALL**: Must deposit $12,000 - $7,980 = **$4,020**
- After deposit: Balance = $12,180

**Day 5:**
- Price change: $1,730.80 - $1,729.90 = $0.90/oz.
- Daily gain: $0.90 × 200 oz. = +$180
- New balance: $12,180 + $180 = $12,360 ✓

**Final Answer:** The trader received a margin call on Day 4 requiring a deposit of $4,020 to restore the account to the initial margin level of $12,000.

**Physical Meaning**: Daily settlement ensures that losses are paid immediately. The margin call on Day 4 occurred because accumulated losses pushed the balance below the maintenance level, requiring additional funds to protect against further losses.
```

---

## Key Futures Market Terminology

```{admonition} Important Terms
:class: note

**Open Interest:**
- Total number of outstanding contracts
- Equals number of long positions (or short positions)
- Indicates market activity and liquidity

**Settlement Price:**
- Official price just before market close
- Used for daily settlement (marking to market)
- Not necessarily the last trade price

**Volume of Trading:**
- Number of contracts traded in one day
- Indicates liquidity and market interest
```

---

## Closing Out Futures Positions

```{important}
**How to Exit a Futures Position:**

1. **Offsetting Trade** (Most Common):
   - Long position → Enter short position in same contract
   - Short position → Enter long position in same contract
   - Net position becomes zero
   - No delivery required

2. **Hold to Maturity** (Rare):
   - Physical delivery or cash settlement
   - Less than 1% of contracts result in delivery
```

**Physical Meaning**: Futures are primarily used for price exposure, not physical exchange. Most participants close positions before maturity, similar to how stock traders buy and sell without expecting certificate delivery.

---

## Delivery and Settlement

### Physical Delivery

```{note}
**When Physical Delivery Occurs:**

If not closed before maturity:
- Party with short position decides:
  - **What** to deliver (when alternatives exist)
  - **Where** to deliver
  - **When** in delivery month

This flexibility favors the short position holder.
```

### Cash Settlement

```{note}
**Cash-Settled Contracts:**

Some futures never involve physical delivery:
- **Stock index futures**: Can't deliver "the S&P 500"
- **Eurodollar futures**: Interest rate products
- **Weather derivatives**: Settlement based on index

**Settlement Method:**
- Final settlement price determined by exchange
- Accounts marked to this price
- Cash paid/received
```

**Physical Meaning**: Cash settlement solves the problem of delivering non-physical or impractical-to-deliver underlyings. The contract still provides price exposure without logistical complexity.

---

## Forward Contracts vs. Futures Contracts: Complete Comparison

| Feature | Forward Contracts | Futures Contracts |
|---------|-------------------|-------------------|
| **Trading** | Private contract between two parties | Exchange-traded |
| **Standardization** | Customized terms | Standardized contract |
| **Delivery Date** | Single specified date | Range of dates (delivery month) |
| **Settlement** | At contract end | Daily (marked to market) |
| **Credit Risk** | Significant counterparty risk | Virtually eliminated by clearinghouse |
| **Flexibility** | Highly flexible terms | Rigid standardized terms |
| **Liquidity** | Generally illiquid | Usually highly liquid |
| **Price Discovery** | Private negotiation | Public, transparent pricing |
| **Closing Position** | Requires counterparty agreement | Easy offsetting trade |
| **Regulation** | OTC regulations apply | Exchange regulations |

```{important}
**Key Practical Differences:**

1. **Settlement:**
   - Forwards: One payment at maturity
   - Futures: Daily cash flows (variation margin)

2. **Credit Risk:**
   - Forwards: Must assess counterparty creditworthiness
   - Futures: Clearinghouse guarantees performance

3. **Customization:**
   - Forwards: Tailored to specific needs
   - Futures: One-size-fits-all approach
```

---

## OTC Derivatives: Bilateral vs. Central Clearing

Post-2008 regulations created two clearing methods for OTC derivatives:

### Bilateral Clearing

```{note}
**Bilateral Clearing Process:**

1. **Governed by ISDA Master Agreement**:
   - Standard legal framework
   - Defines default procedures
   - Specifies netting arrangements

2. **Credit Support Annex (CSA)**:
   - Defines collateral requirements
   - Historically: Variation margin only (pre-crisis)
   - Now: Both initial and variation margin required

3. **Collateral Management**:
   - Posted with third party
   - Reduces counterparty risk
   - Daily margin adjustments
```

### Central Clearing

```{admonition} Key Concept: Central Clearing Post-Crisis
:class: tip

**Requirements:**

1. **Standard transactions** between financial institutions **must** use CCPs
2. **Non-standard transactions** may be bilaterally cleared
3. **Transactions with non-financial corporations** may be bilaterally cleared

**Benefits:**
- Eliminates bilateral counterparty risk
- CCP becomes central risk manager
- Netting efficiency
- Standardized risk management
```

### Post-Crisis Margin Requirements

```{important}
**New Margin Rules for Bilaterally Cleared Transactions:**

For non-standard trades between financial institutions:

1. **Initial Margin:**
   - Must be posted by both parties
   - Held by independent third party
   - Protects against default

2. **Variation Margin:**
   - Daily settlement of mark-to-market changes
   - Must be posted

**Comparison to Pre-Crisis:**
- Before: Only variation margin required
- After: Both initial and variation margin
```

**Physical Meaning**: The 2008 crisis showed that bilateral clearing without initial margin was dangerous. The new rules make OTC markets more like futures markets with robust margin protection.

---

## Chapter Summary

```{important}
**Key Takeaways:**

1. **Futures contracts** are standardized agreements traded on exchanges with daily settlement
2. **Forward contracts** are customized OTC agreements settled at maturity
3. **Margins** minimize default risk through daily settlement of gains/losses
4. **Margin calls** occur when account balance falls below maintenance margin
5. **Most futures are closed out** before maturity through offsetting trades
6. **Delivery**, when it occurs, offers flexibility to the short position
7. **Post-crisis regulations** require central clearing for standard OTC transactions
8. **Both initial and variation margin** now required for bilaterally cleared derivatives between financial institutions
```

```{seealso}
**Looking Ahead:**

Chapter 3 explores the **pricing and valuation** of forward and futures contracts in detail, deriving fair values under different conditions.
```

---

## Practice Problems

```{admonition} Practice Problem 1: Futures Margin Account
:class: tip

A trader takes a short position in 3 June crude oil futures contracts. Each contract is for 1,000 barrels.

**Given:**
- Entry price: $75.00/barrel
- Initial margin: $5,000 per contract
- Maintenance margin: $3,500 per contract

**Settlement prices:**
- Day 1: $76.20
- Day 2: $77.50
- Day 3: $76.00

**Questions:**
1. What is the initial margin deposit?
2. Calculate daily gains/losses
3. Does a margin call occur? If so, when and for how much?
```

```{dropdown} Solution to Practice Problem 1

**Part 1: Initial Margin Deposit**

Initial margin = 3 contracts × $5,000 = **$15,000**

**Part 2: Daily Gains/Losses**

**Day 1:**
- Price change: $76.20 - $75.00 = +$1.20/barrel (unfavorable for short)
- Daily loss: $1.20 × 1,000 barrels × 3 contracts = -$3,600
- Balance: $15,000 - $3,600 = $11,400

**Day 2:**
- Price change: $77.50 - $76.20 = +$1.30/barrel
- Daily loss: $1.30 × 3,000 barrels = -$3,900
- Balance: $11,400 - $3,900 = $7,500

**Day 3:**
- Price change: $76.00 - $77.50 = -$1.50/barrel (favorable for short)
- Daily gain: $1.50 × 3,000 barrels = +$4,500
- Balance: $7,500 + $4,500 = $12,000

**Part 3: Margin Calls**

Maintenance margin = 3 × $3,500 = $10,500

**Check each day:**
- Day 1: $11,400 > $10,500 ✓ No margin call
- Day 2: $7,500 < $10,500 ✗ **MARGIN CALL!**
- Required deposit: $15,000 - $7,500 = **$7,500**
- After deposit: Balance = $15,000
- Day 3: Starting with $15,000, gain $4,500 = $19,500

**Final Answer:**
- Initial deposit: $15,000
- Margin call on Day 2 for $7,500
- Final balance after Day 3: $19,500

**Note**: Short positions lose when prices rise. The trader faced two consecutive days of rising prices before a favorable day.
```

---

**Next Chapter:** [Chapter 3: Pricing and Valuation of Forwards and Futures →](chapter03_pricing-and-valuation.md)
