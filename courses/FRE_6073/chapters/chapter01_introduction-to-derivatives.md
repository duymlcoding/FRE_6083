---
title: "Chapter 1: Introduction to Derivatives"
author: "Based on John C. Hull"
date: "2025"
---

# Introduction to Derivatives

This chapter introduces the fundamental concepts of derivative securities, their role in financial markets, and their practical applications. We'll explore what derivatives are, why they matter, how they're traded, and how market participants use them.

## What is a Derivative?

```{admonition} Key Concept: Definition of a Derivative
:class: tip

A **derivative** is a financial instrument whose value depends on, or is derived from, the value of another asset, known as the **underlying asset**.
```

### Examples of Derivatives

The four main types of derivatives are:

1. **Futures**: Standardized contracts to buy/sell an asset at a specified price on a future date
2. **Forwards**: Customized contracts similar to futures but traded over-the-counter
3. **Swaps**: Agreements to exchange cash flows based on different variables
4. **Options**: Rights (but not obligations) to buy or sell an asset at a specified price

```{note}
**Common Underlying Assets:**

- **Financial Assets**: Stocks, bonds, currencies, interest rates
- **Commodities**: Oil, gold, copper, agricultural products
- **Other**: Electricity prices, weather variables, insurance payouts
```

**Physical Meaning**: A derivative's value moves in response to changes in the underlying asset. For example, a stock option's value changes as the stock price fluctuates, even though the option itself is a separate contract.

---

## Why Derivatives Are Important

Derivatives play a crucial role in the global financial system by enabling efficient risk transfer and price discovery.

```{important}
**Key Functions of Derivatives:**

1. **Risk Transfer**: Allow market participants to shift unwanted risks to those willing to bear them
2. **Price Discovery**: Provide information about future expectations of asset prices
3. **Market Efficiency**: Enable hedging and arbitrage, keeping markets aligned
4. **Leverage**: Allow large positions with small initial capital
```

### The Scale of Derivatives Markets

```{note}
**Market Size:**

- The notional value of global derivatives markets exceeds $600 trillion
- This dwarfs the global equity and bond markets combined
- However, notional value overstates actual risk exposure
- Net market value (actual risk) is a small fraction of notional value
```

### Embedded Derivatives

```{seealso}
Many financial transactions contain **embedded derivatives** that may not be immediately obvious:

- **Callable bonds**: Include an embedded call option for the issuer
- **Convertible bonds**: Include an embedded option to convert to stock
- **Mortgage-backed securities**: Contain embedded prepayment options
- **Insurance contracts**: Many insurance products are essentially options
```

**Physical Meaning**: Derivatives are the "financial plumbing" of the modern economy, allowing risk to flow from those who don't want it to those who do.

---

## How Derivatives Are Traded

Derivatives trade in two primary markets, each with distinct characteristics.

### Exchange-Traded Derivatives

```{admonition} Key Concept: Exchange Trading
:class: tip

**Exchange-traded derivatives** are standardized contracts traded on organized exchanges like the Chicago Mercantile Exchange (CME).

**Characteristics:**
- Standardized contract specifications
- Centralized clearing through clearinghouses
- Transparent pricing
- Lower credit risk due to clearinghouse guarantee
- High liquidity for standard contracts
```

**Major Derivatives Exchanges:**

| Exchange | Location | Primary Products |
|----------|----------|------------------|
| CME Group | Chicago, USA | Futures on commodities, indices, interest rates |
| Intercontinental Exchange (ICE) | Atlanta, USA | Energy, agricultural commodities |
| B3 | São Paulo, Brazil | Brazilian equity and currency derivatives |
| Tokyo Financial Exchange | Tokyo, Japan | Interest rate and currency futures |

### Over-the-Counter (OTC) Market

```{admonition} Key Concept: OTC Trading
:class: tip

**Over-the-counter (OTC) derivatives** are customized contracts negotiated directly between two parties without an exchange.

**Characteristics:**
- Customized contract terms
- Negotiated directly between parties
- Less transparent pricing
- Higher credit risk (counterparty risk)
- Flexibility to meet specific needs
```

**How OTC Trading Works:**

- Traders at banks, hedge funds, and corporate treasuries contact each other directly
- Contracts are tailored to specific needs
- Historically traded by phone; now increasingly electronic
- Master agreements (ISDA) govern standard terms

**Physical Meaning**: Think of exchange-trading like buying a standardized product at a store (fixed sizes, specifications), while OTC trading is like having a custom product made to your exact specifications.

---

## The OTC Market: Evolution and Regulation

### Pre-2008 OTC Market

```{note}
**Characteristics Before the 2008 Crisis:**

- **Largely unregulated**: Minimal government oversight
- **Banks as market makers**: Major banks quoted bid-ask prices
- **Master agreements**: ISDA Master Agreements standardized legal terms
- **Some centralized clearing**: A few transactions used central counterparties (CCPs)
```

### What is a Central Counterparty (CCP)?

```{admonition} Key Concept: Central Counterparties
:class: tip

A **Central Counterparty (CCP)** stands between the two sides of a transaction, becoming the buyer to every seller and the seller to every buyer.

**Function:**
- Eliminates bilateral counterparty risk
- Manages default risk through margin requirements
- Similar role to an exchange clearinghouse
```

### Post-2008 Regulatory Changes

The 2008 financial crisis revealed weaknesses in the OTC derivatives market, leading to comprehensive reforms.

```{important}
**Objectives of Post-Crisis Regulation:**

1. **Reduce systemic risk**: Prevent cascading failures from counterparty defaults
2. **Increase transparency**: Make markets more visible to regulators and participants
3. **Standardize clearing**: Move standard products to central clearing
```

### New Regulatory Requirements

```{note}
**Key Regulatory Changes:**

1. **Swap Execution Facilities (SEFs)**:
   - Electronic platforms similar to exchanges
   - Required for standardized OTC products in the U.S.
   - Increase price transparency

2. **Mandatory Central Clearing**:
   - Standardized transactions between financial institutions must use CCPs
   - Applies in most major jurisdictions

3. **Trade Reporting**:
   - All trades must be reported to central repositories
   - Regulators can monitor market activity

4. **Margin Requirements**:
   - Both initial and variation margin required
   - Even for bilaterally cleared transactions
```

**Physical Meaning**: The post-crisis regulations transformed OTC markets from an unregulated "wild west" into a more structured system with safety mechanisms, similar to how building codes protect against structural failures.

---

## How Derivatives Are Used

Market participants use derivatives for several distinct purposes, each with different risk/reward profiles.

### 1. Hedging

```{admonition} Key Concept: Hedging
:class: tip

**Hedging** is using derivatives to reduce or eliminate an existing risk exposure.

**Objective:** Reduce uncertainty about future prices, not to profit from market movements.
```

```{admonition} Example Problem: Currency Hedging
:class: tip

**Problem Statement:**
A U.S. company will pay £10 million for imports from Britain in 3 months. The current exchange rate is 1.2230 USD/GBP. The company is concerned about the pound strengthening (becoming more expensive).

**Given:**
- Payment due: £10 million in 3 months
- Current rate: $1.2230/£
- Concern: GBP appreciation

**Find:** How to hedge this risk
```

```{dropdown} Solution

**Step 1: Identify the Risk**

The company faces **currency risk**:
- If GBP strengthens to $1.30/£, cost = $13,000,000
- If GBP weakens to $1.20/£, cost = $12,000,000
- At current rate: $12,230,000

The company wants certainty.

**Step 2: Choose Hedging Instrument**

Enter a **long forward contract** to buy £10 million in 3 months at $1.2230/£

**Step 3: Analyze the Hedge**

**Unhedged Position:**
- Exposed to full currency fluctuation
- Cost varies with GBP/USD rate

**Hedged Position:**
- Locked in cost: £10M × $1.2230/£ = $12,230,000
- No matter what happens to exchange rate

**Outcome Table:**

| Spot Rate at Maturity | Without Hedge | With Hedge | Difference |
|-----------------------|---------------|------------|------------|
| $1.20/£ | $12,000,000 | $12,230,000 | -$230,000 |
| $1.2230/£ | $12,230,000 | $12,230,000 | $0 |
| $1.30/£ | $13,000,000 | $12,230,000 | +$770,000 |

**Final Answer:** **The company should enter a long forward contract for £10 million at $1.2230/£. This eliminates all currency risk, providing budget certainty.**

**Note:** The hedge removes both upside and downside - the company won't benefit if GBP weakens, but also won't suffer if it strengthens.
```

### 2. Speculation

```{admonition} Key Concept: Speculation
:class: tip

**Speculation** is taking a position in derivatives to profit from an anticipated market movement.

**Objective:** Earn profits by correctly predicting price changes.

**Key Difference from Hedging:**
- Hedgers reduce existing risk
- Speculators take on new risk for potential profit
```

**Why Use Derivatives for Speculation?**

- **Leverage**: Control large positions with small capital
- **Short selling**: Easy to profit from price declines
- **Flexibility**: Many ways to express market views

```{warning}
**Speculation Risks:**

- Can lose more than initial investment (especially futures)
- Leverage magnifies both gains and losses
- Requires accurate market timing
- Transaction costs can erode profits
```

### 3. Arbitrage

```{admonition} Key Concept: Arbitrage
:class: tip

**Arbitrage** is simultaneously buying and selling related assets to lock in a risk-free profit from price discrepancies.

**Characteristics:**
- No initial investment required (or minimal)
- No risk - profits are guaranteed
- Exploits market inefficiencies
```

**Physical Meaning**: Arbitrage is like buying a product in one store and simultaneously selling it in another store at a higher price - you lock in the profit difference with zero risk.

**Example:** If gold trades at $1,800/oz in New York and $1,805/oz in London:
- Buy in New York for $1,800
- Sell in London for $1,805
- Lock in $5/oz risk-free profit

**Important:** True arbitrage opportunities are rare and disappear quickly as arbitrageurs exploit them.

### 4. Changing Portfolio Characteristics

```{note}
**Other Uses of Derivatives:**

1. **Change liability nature**: Convert floating-rate debt to fixed-rate using swaps
2. **Modify investments**: Change portfolio exposure without trading underlying assets
3. **Tax efficiency**: Achieve desired exposure with better tax treatment
4. **Regulatory capital**: Reduce capital requirements for certain positions
```

**Physical Meaning**: Derivatives allow you to "rewire" the risk characteristics of positions without the transaction costs and market impact of buying/selling the underlying assets.

---

## Types of Market Participants

Three main types of market participants interact in derivatives markets:

### Hedgers

```{note}
**Hedgers:**

- **Goal**: Reduce or eliminate existing risk
- **Examples**: Airlines hedging fuel costs, exporters hedging currency risk
- **Mindset**: Willing to give up potential gains to avoid losses
```

### Speculators

```{note}
**Speculators:**

- **Goal**: Profit from anticipated market movements
- **Examples**: Hedge funds, proprietary traders
- **Mindset**: Accept risk for potential returns
```

### Arbitrageurs

```{note}
**Arbitrageurs:**

- **Goal**: Lock in risk-free profits from price discrepancies
- **Examples**: High-frequency traders, market makers
- **Mindset**: Exploit inefficiencies with sophisticated technology
```

**All three are necessary for efficient markets:**
- Hedgers provide order flow
- Speculators provide liquidity
- Arbitrageurs keep prices aligned

---

## Hedge Funds

Hedge funds are major users of derivatives and play an important role in derivatives markets.

```{admonition} Key Concept: Hedge Funds
:class: tip

**Hedge funds** are investment funds that use sophisticated strategies and can take both long and short positions, use leverage, and invest in diverse assets.

**Key Characteristics:**
- Not subject to the same regulations as mutual funds
- Cannot offer securities publicly
- Typically available only to sophisticated investors
- Use complex trading strategies
- Major users of derivatives for hedging, speculation, and arbitrage
```

### Hedge Funds vs. Mutual Funds

| Feature | Mutual Funds | Hedge Funds |
|---------|--------------|-------------|
| **Disclosure** | Must disclose investment policies | Limited disclosure |
| **Redemptions** | Shares redeemable anytime | Lock-up periods common |
| **Leverage** | Limited use of leverage | Can use significant leverage |
| **Regulation** | Heavily regulated | Lightly regulated |
| **Investor Base** | General public | Accredited/sophisticated investors |
| **Fees** | Typically 1% annual | Often "2 and 20" (2% + 20% of profits) |

### Common Hedge Fund Strategies

```{note}
**Hedge Fund Strategies Using Derivatives:**

1. **Long/Short Equities**: Buy undervalued stocks, short overvalued stocks
2. **Convertible Arbitrage**: Exploit pricing inefficiencies in convertible bonds
3. **Distressed Securities**: Invest in companies in or near bankruptcy
4. **Emerging Markets**: Take positions in developing country assets
5. **Global Macro**: Trade based on macroeconomic trends
6. **Merger Arbitrage**: Profit from merger/acquisition price spreads
```

**Physical Meaning**: Hedge funds use derivatives as tools to implement sophisticated strategies that would be difficult or impossible using only cash instruments.

---

## Chapter Summary

```{important}
**Key Takeaways:**

1. **Derivatives** derive their value from underlying assets
2. **Main types**: Futures, forwards, swaps, options
3. **Trading venues**: Exchanges (standardized) and OTC (customized)
4. **Post-2008 reforms**: Increased regulation, mandatory clearing, greater transparency
5. **Primary uses**: Hedging (reduce risk), speculation (profit from views), arbitrage (lock in risk-free profits)
6. **Market participants**: Hedgers, speculators, and arbitrageurs all play essential roles
7. **Hedge funds**: Major derivatives users employing complex strategies
```

```{seealso}
**Looking Ahead:**

In Chapter 2, we'll dive deep into **forward and futures contracts**, exploring their mechanics, differences, and how they're used in practice.
```

---

## Practice Problems

```{admonition} Practice Problem 1
:class: tip

An investor owns 1,000 shares of stock currently worth $28 per share. A two-month put option with a strike price of $27.50 costs $1. The investor decides to hedge by buying 10 put option contracts (each contract covers 100 shares).

**Questions:**
1. What is the total cost of the hedge?
2. What is the minimum portfolio value the investor has locked in?
3. If the stock falls to $20, what is the net value of the hedged position?
4. If the stock rises to $35, what is the net value?
```

```{dropdown} Solution to Practice Problem 1

**Part 1: Cost of Hedge**

Cost = 10 contracts × 100 shares/contract × $1/share = **$1,000**

**Part 2: Minimum Portfolio Value**

- Each put guarantees the right to sell at $27.50
- With 1,000 shares: 1,000 × $27.50 = $27,500
- Minus hedge cost: $27,500 - $1,000 = **$26,500 minimum**

**Part 3: Stock Falls to $20**

Without hedge:
- Stock value: 1,000 × $20 = $20,000

With hedge:
- Exercise puts: Sell 1,000 shares at $27.50 = $27,500
- Minus hedge cost: $27,500 - $1,000 = **$26,500**
- Gain from hedge: $26,500 - $20,000 = $6,500

**Part 4: Stock Rises to $35**

- Stock value: 1,000 × $35 = $35,000
- Puts expire worthless
- Net value: $35,000 - $1,000 = **$34,000**
- (Foregone gain of $1,000 is the insurance cost)

**Final Answer:** The hedge costs $1,000 and guarantees a minimum value of $26,500, protecting against downside while still allowing upside (minus the premium paid).
```

---

**Next Chapter:** [Chapter 2: Forward and Futures Contracts →](chapter02_forward-and-futures-contracts.md)
