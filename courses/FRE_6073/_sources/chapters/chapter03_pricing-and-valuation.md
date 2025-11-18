---
title: "Chapter 3: Pricing and Valuation of Forward and Futures Contracts"
author: "Based on John C. Hull"
date: "2025"
---

# Pricing and Valuation of Forward and Futures Contracts

This chapter develops the theoretical framework for pricing forward and futures contracts. We'll derive pricing formulas for various underlying assets and understand how to value existing contracts.

## The Forward Price for Investment Assets

```{admonition} Key Concept: Forward Price
:class: tip

The **forward price** $F_0$ is the delivery price that would make a forward contract worth exactly zero if negotiated today.

**Important Distinctions:**
- Forward price ≠ Expected future spot price
- Forward price changes over time
- Forward price may differ across maturities
```

### Forward Price with No Income

For an investment asset providing no income:

$$F_0 = S_0 e^{rT}$$

Where:
- $F_0$ = Forward price today
- $S_0$ = Spot price today
- $r$ = Risk-free interest rate (continuously compounded)
- $T$ = Time to maturity (years)

**Physical Meaning**: The forward price equals the spot price grown at the risk-free rate. This reflects the cost of carrying (financing) the position until delivery.

```{admonition} Example Problem: Forward Pricing
:class: tip

**Problem Statement:**
A non-dividend-paying stock trades at $50. The risk-free rate is 4% per annum (continuously compounded). What is the 9-month forward price?

**Given:**
- $S_0 = \$50$
- $r = 0.04$
- $T = 0.75$ years
```

```{dropdown} Solution

**Step 1: Apply the Formula**

$$F_0 = S_0 e^{rT}$$

**Step 2: Substitute Values**

$$F_0 = 50 \times e^{0.04 \times 0.75}$$

$$F_0 = 50 \times e^{0.03}$$

$$F_0 = 50 \times 1.0305$$

$$F_0 = \$51.52$$

**Step 3: Arbitrage Verification**

Why must $F_0 = \$51.52$? Consider two strategies:

**Strategy A: Buy Forward**
- Cost today: $0$
- Payment at $T$: $F_0$
- Receive: Stock worth $S_T$

**Strategy B: Buy Stock with Borrowed Money**
- Borrow $50$ at 4%, repay $50e^{0.03} = \$51.52$ at $T$
- Receive: Stock worth $S_T$

Both strategies deliver the same result (stock worth $S_T$), so they must have the same cost. Therefore, $F_0 = \$51.52$.

**Final Answer:** The 9-month forward price is \$51.52.
```

---

## Forward Price with Known Income

When the underlying asset provides income (dividends, coupons, etc.):

### Known Yield

$$F_0 = S_0 e^{(r-q)T}$$

Where:
- $q$ = Average yield during contract life (continuously compounded)
- Other variables as before

```{note}
**Assets with Known Yield:**

- **Stocks with dividends**: Dividend yield
- **Stock indices**: Average dividend yield of index components
- **Foreign currencies**: Foreign risk-free interest rate
- **Commodities stored for investment**: "Convenience yield"
```

```{admonition} Example Problem: Forward Price with Dividend Yield
:class: tip

**Problem Statement:**
A stock index stands at 1,200. The index provides a dividend yield of 2% per annum. The risk-free rate is 5% per annum (both continuously compounded). What is the 6-month forward price?

**Given:**
- $S_0 = 1200$
- $q = 0.02$
- $r = 0.05$
- $T = 0.5$ years
```

```{dropdown} Solution

**Step 1: Apply the Formula**

$$F_0 = S_0 e^{(r-q)T}$$

**Step 2: Substitute Values**

$$F_0 = 1200 \times e^{(0.05-0.02) \times 0.5}$$

$$F_0 = 1200 \times e^{0.03 \times 0.5}$$

$$F_0 = 1200 \times e^{0.015}$$

$$F_0 = 1200 \times 1.0151$$

$$F_0 = 1218.12$$

**Step 3: Interpretation**

The forward price (1218.12) is higher than the spot price (1200) by the net cost of carry:
- Interest cost: 5% per annum
- Dividend income: 2% per annum
- Net cost: 3% per annum for 6 months = 1.5%

**Final Answer:** The 6-month forward price is **1218.12**.

**Physical Meaning**: You earn 2% dividends while holding, but pay 5% to finance, giving a net cost of 3% annually.
```

---

## Valuing an Existing Forward Contract

Once a forward contract is established, its value changes as market conditions evolve.

```{admonition} Key Concept: Forward Contract Valuation
:class: tip

The value of an existing forward contract depends on:
1. The delivery price $K$ (fixed when contract initiated)
2. The current forward price $F_0$ (for a new contract)
3. Time remaining to maturity

**Value Formulas:**

**Long position:**

$$f = (F_0 - K)e^{-rT}$$

**Short position:**

$$f = (K - F_0)e^{-rT}$$

```

**Physical Meaning**: The value equals the present value of the difference between what you'll pay (or receive) under your contract versus what the market currently prices for that future delivery.

```{admonition} Example Problem: Valuing a Forward Contract
:class: tip

**Problem Statement:**
Three months ago, you entered a 9-month forward contract to buy a non-dividend-paying stock at $45. The stock now trades at $48, and the risk-free rate is 5% per annum (continuously compounded). What is the value of your position?

**Given:**
- Original delivery price: $K = \$45$
- Current spot price: $S_0 = \$48$
- Time to maturity: $T = 0.5$ years (6 months remaining)
- Risk-free rate: $r = 0.05$
```

```{dropdown} Solution

**Step 1: Calculate Current Forward Price**

For a new 6-month forward contract:

$$F_0 = S_0 e^{rT} = 48 \times e^{0.05 \times 0.5} = 48 \times e^{0.025}$$

$$F_0 = 48 \times 1.0253 = \$49.21$$

**Step 2: Calculate Value of Long Position**

$$f = (F_0 - K)e^{-rT}$$

$$f = (49.21 - 45.00)e^{-0.05 \times 0.5}$$

$$f = 4.21 \times e^{-0.025}$$

$$f = 4.21 \times 0.9753$$

$$f = \$4.11$$

**Step 3: Interpret the Result**

Your contract has a **positive value of $4.11** because:
- You agreed to buy at $45
- Current market would agree to buy at $49.21
- Difference of $4.21 (received in 6 months)
- Present value: $4.11

**Alternative Method: Direct Calculation**

$$f = S_0 - Ke^{-rT} = 48 - 45e^{-0.025} = 48 - 43.89 = \$4.11$$

**Final Answer:** The long forward position has a value of \$4.11.

**Physical Meaning**: You "locked in" a better deal than what's currently available, so your contract has positive value.
```

---

## Forward vs. Futures Prices

While forward and futures prices are often similar, they can differ due to marking to market.

```{note}
**Theoretical Relationship:**

**When interest rates are constant:**
- Forward price = Futures price

**When interest rates are uncertain:**
- If asset price is **positively correlated** with interest rates → Futures price > Forward price
- If asset price is **negatively correlated** with interest rates → Futures price < Forward price

**Why?**
- Futures: Daily settlement benefits from favorable correlation
- Forwards: Single settlement at maturity
```

```{important}
**Practical Reality:**

For most purposes, forward and futures prices are close enough to be treated as equal. Differences are typically:
- Theoretically small
- Difficult to profit from
- Ignored in practice
```

**Physical Meaning**: The daily settlement in futures means that gains/losses are realized immediately. If gains tend to occur when interest rates are high (earning more on reinvestment), futures become slightly more valuable than forwards.

---

## Stock Index Futures

Stock indices can be viewed as investment assets paying a dividend yield.

```{admonition} Key Formula: Stock Index Futures
:class: tip

$$F_0 = S_0 e^{(r-q)T}$$

Where:
- $S_0$ = Current index level
- $r$ = Risk-free rate
- $q$ = Average dividend yield on the index
- $T$ = Time to maturity

**Requirements:**
- Index must represent a tradable portfolio
- Changes in index = changes in portfolio value
```

```{admonition} Example Problem: S&P 500 Futures
:class: tip

**Problem Statement:**
The S&P 500 index stands at 4,200. The index provides a dividend yield of 1.8% per annum. The risk-free rate is 4% per annum (continuously compounded). Calculate the 3-month futures price.

**Given:**
- $S_0 = 4200$
- $q = 0.018$
- $r = 0.04$
- $T = 0.25$ years
```

```{dropdown} Solution

**Step 1: Apply the Formula**

$$F_0 = S_0 e^{(r-q)T}$$

**Step 2: Substitute Values**

$$F_0 = 4200 \times e^{(0.04-0.018) \times 0.25}$$

$$F_0 = 4200 \times e^{0.022 \times 0.25}$$

$$F_0 = 4200 \times e^{0.0055}$$

$$F_0 = 4200 \times 1.0055$$

$$F_0 = 4223.13$$

**Step 3: Check for Arbitrage Opportunities**

If actual futures price ≠ 4223.13, arbitrage exists:

**If $F_0 > 4223.13$ (Futures overpriced):**
1. Short futures
2. Buy the index portfolio
3. Lock in risk-free profit

**If $F_0 < 4223.13$ (Futures underpriced):**
1. Long futures
2. Short the index portfolio
3. Lock in risk-free profit

**Final Answer:** The theoretical 3-month futures price is **4223.13**.

**Physical Meaning**: The futures price exceeds the spot by the net financing cost (4% interest minus 1.8% dividends = 2.2% annually, or 0.55% for 3 months).
```

---

## Index Arbitrage

Index arbitrage exploits mispricings between index futures and the underlying stocks.

```{admonition} Index Arbitrage Strategies
:class: note

**Case 1: Futures Overpriced ($F_0 > S_0e^{(r-q)T}$)**

**Arbitrage Strategy:**
1. **Short** index futures
2. **Buy** all stocks in the index (in proper proportions)
3. Hold until maturity
4. **Result**: Lock in risk-free profit

**Case 2: Futures Underpriced ($F_0 < S_0e^{(r-q)T}$)**

**Arbitrage Strategy:**
1. **Long** index futures
2. **Short** all stocks in the index
3. Hold until maturity
4. **Result**: Lock in risk-free profit
```

### Practical Considerations

```{warning}
**Challenges in Index Arbitrage:**

1. **Simultaneous execution**: Must trade many stocks at once
2. **Transaction costs**: Can eliminate small mispricings
3. **Tracking error**: Portfolio may not perfectly match index
4. **Market impact**: Large orders can move prices
5. **Execution risk**: Prices may move during trade implementation

**Solutions:**
- Computer-generated orders
- Algorithmic trading systems
- Basket trading facilities
- High-frequency trading technology
```

**Physical Meaning**: Index arbitrage keeps futures prices aligned with cash markets through rapid trading when deviations occur, similar to how arbitrageurs keep currency exchange rates consistent across markets.

---

## Futures and Forwards on Currencies

Foreign currencies are analogous to securities providing a known yield.

```{admonition} Key Formula: Currency Forward/Futures
:class: tip

$$F_0 = S_0 e^{(r-r_f)T}$$

Where:
- $S_0$ = Current spot exchange rate (domestic per foreign)
- $r$ = Domestic risk-free interest rate
- $r_f$ = Foreign risk-free interest rate
- $T$ = Time to maturity

**The foreign interest rate acts as a "yield"** because foreign currency deposited earns the foreign rate.
```

```{admonition} Example Problem: Currency Forward
:class: tip

**Problem Statement:**
The spot EUR/USD exchange rate is 1.2000 (USD per EUR). The U.S. risk-free rate is 3% and the Euro-zone rate is 2% (both continuously compounded). Calculate the 1-year forward rate.

**Given:**
- $S_0 = 1.2000$ USD/EUR
- $r = 0.03$ (U.S. rate)
- $r_f = 0.02$ (Euro-zone rate)
- $T = 1$ year
```

```{dropdown} Solution

**Step 1: Apply the Formula**

$$F_0 = S_0 e^{(r-r_f)T}$$

**Step 2: Substitute Values**

$$F_0 = 1.2000 \times e^{(0.03-0.02) \times 1}$$

$$F_0 = 1.2000 \times e^{0.01}$$

$$F_0 = 1.2000 \times 1.01005$$

$$F_0 = 1.2121$$ USD/EUR

**Step 3: Interpret the Result**

The forward rate (1.2121) is higher than the spot rate (1.2000) because:
- U.S. interest rate (3%) > Euro-zone rate (2%)
- Higher U.S. rates make holding USD more attractive
- EUR must trade at a forward premium to maintain equilibrium

**Step 4: Interest Rate Parity**

This relationship is called **Covered Interest Rate Parity (CIRP)**:

$$\frac{F_0}{S_0} = e^{(r-r_f)T}$$

If this doesn't hold, currency arbitrage is possible.

**Final Answer:** The 1-year forward rate is **1.2121 USD/EUR**.

**Physical Meaning**: If you hold euros, you earn 2% interest. To compensate for giving up the higher 3% USD rate, the euro must appreciate by 1% in the forward market.
```

### Currency Arbitrage Example

```{admonition} Example: Currency Arbitrage
:class: tip

Suppose the actual forward rate is 1.2200 (versus the theoretical 1.2121). How do you arbitrage?

**Arbitrage Strategy:**

1. **Today ($t=0$):**
   - Borrow $1,200 USD at 3% for 1 year
   - Convert to EUR: $1,200 / 1.2000 = €1,000
   - Invest €1,000 at 2% for 1 year
   - Sell €1,000 forward at 1.2200

2. **One year later ($t=1$):**
   - Receive: €1,000 × $e^{0.02}$ = €1,020.20
   - Deliver under forward: Receive 1,020.20 × 1.2200 = $1,244.64
   - Repay loan: $1,200 × $e^{0.03}$ = $1,236.48
   - **Profit: $1,244.64 - $1,236.48 = $8.16**

Risk-free profit with no initial investment!
```

---

## Consumption Assets vs. Investment Assets

Assets fall into two categories with different pricing implications.

```{admonition} Key Concept: Asset Classification
:class: tip

**Investment Assets:**
- Held by significant numbers purely for investment
- **Examples**: Gold, silver, financial securities
- **Pricing**: $F_0 = S_0 e^{(r+u-q)T}$ (exact relationship)

**Consumption Assets:**
- Held primarily for consumption, not investment
- **Examples**: Oil, copper, agricultural commodities
- **Pricing**: $F_0 \leq S_0 e^{(r+u-q)T}$ (upper bound only)
```

### Why the Difference?

```{note}
**Investment Assets:**

Arbitrage enforces exact pricing:
- If $F_0 > S_0 e^{rT}$: Short futures, buy asset, profit
- If $F_0 < S_0 e^{rT}$: Long futures, short asset, profit

**Consumption Assets:**

Arbitrage is one-sided:
- If $F_0 > S_0 e^{(r+u)T}$: Can arbitrage (short futures, buy asset)
- If $F_0 < S_0 e^{(r+u)T}$: **Cannot arbitrage**
  - Shorting requires borrowing from someone holding for consumption
  - Holders won't lend below what they value it at
```

**Physical Meaning**: You can't short oil by borrowing it from a refinery that needs it to operate. The refinery values immediate possession beyond just the financial return.

---

## Storage Costs and the Cost of Carry

### Storage Costs as Negative Income

For physical assets requiring storage:

$$F_0 \leq S_0 e^{(r+u)T}$$

Where:
- $u$ = Storage cost per unit time (as a proportion of asset value)

**Storage costs are like negative dividends** - they reduce the return to holding the asset.

```{admonition} Example: Gold Storage
:class: tip

Gold spot price: $1,800/oz
Storage cost: 0.5% per annum
Risk-free rate: 4% per annum
Time: 6 months

**Maximum forward price:**

$$F_0 = 1800 \times e^{(0.04+0.005) \times 0.5} = 1800 \times e^{0.0225} = \$1,840.95$$

If $F_0 > \$1,840.95$, arbitrage opportunity exists.
```

### Cost of Carry

```{admonition} Key Concept: Cost of Carry
:class: tip

The **cost of carry** ($c$) is the net cost of holding an asset:

$$c = r + u - q$$

Where:
- $r$ = Interest cost (financing)
- $u$ = Storage cost
- $q$ = Income/yield from holding

**General relationship:**

$$F_0 = S_0 e^{cT}$$

For investment assets, this is exact.
For consumption assets, it's an upper bound.
```

```{note}
**Examples of Cost of Carry:**

| Asset | Interest | Storage | Income | Net Carry |
|-------|----------|---------|--------|-----------|
| Stock | +4% | 0% | -2% div | +2% |
| Gold | +4% | -0.5% | 0% | +3.5% |
| Currency | +3% | 0% | -2% foreign | +1% |
| Warehouse commodity | +4% | -1% | 0% | +3% |
```

---

## Convenience Yield

For consumption assets, we introduce the convenience yield to explain pricing.

```{admonition} Key Concept: Convenience Yield
:class: tip

The **convenience yield** ($y$) is the benefit from physically holding a consumption asset rather than having a future claim.

$$F_0 = S_0 e^{(c-y)T} = S_0 e^{(r+u-y)T}$$

Where:
- $c$ = Cost of carry
- $y$ = Convenience yield

**Sources of Convenience Yield:**
- Ability to respond to unexpected demand
- Keeping production running smoothly
- Avoiding stockouts
- Flexibility in timing use
```

**Physical Meaning**: An oil refinery values having oil in inventory beyond its financial value because it enables operations. The convenience yield measures this operational value.

```{note}
**Convenience Yield Patterns:**

- **High inventories** → Low convenience yield → Forward curve in contango ($F_0 > S_0$)
- **Low inventories** → High convenience yield → Forward curve in backwardation ($F_0 < S_0$)

**Backwardation**: Current spot price exceeds futures price (convenience yield > cost of carry)
**Contango**: Futures price exceeds spot price (cost of carry > convenience yield)
```

---

## Summary of Pricing Formulas

| Asset Type | Formula | Key Variable |
|------------|---------|--------------|
| **No income** | $F_0 = S_0 e^{rT}$ | None |
| **Known yield** | $F_0 = S_0 e^{(r-q)T}$ | $q$ = yield |
| **Stock index** | $F_0 = S_0 e^{(r-q)T}$ | $q$ = dividend yield |
| **Currency** | $F_0 = S_0 e^{(r-r_f)T}$ | $r_f$ = foreign rate |
| **With storage** | $F_0 \leq S_0 e^{(r+u)T}$ | $u$ = storage cost |
| **Investment asset** | $F_0 = S_0 e^{cT}$ | $c$ = cost of carry |
| **Consumption asset** | $F_0 = S_0 e^{(c-y)T}$ | $y$ = convenience yield |

---

## Chapter Summary

```{important}
**Key Takeaways:**

1. **Forward price** is the delivery price making a new contract worth zero
2. **Basic formula**: $F_0 = S_0 e^{rT}$ for assets with no income
3. **Known yield**: Subtract yield from interest rate: $F_0 = S_0 e^{(r-q)T}$
4. **Contract value**: $(F_0 - K)e^{-rT}$ for long positions
5. **Forward ≈ Futures prices** in most practical situations
6. **Stock indices**: Use dividend yield in formula
7. **Currencies**: Foreign rate acts as a yield
8. **Investment assets**: Exact pricing via arbitrage
9. **Consumption assets**: Upper bound only, convenience yield explains deviations
10. **Cost of carry**: Net cost of holding = interest + storage - income
```

```{seealso}
**Looking Ahead:**

Chapter 4 examines **interest rates and repo markets**, essential for understanding fixed-income derivatives and financing costs.
```

---

## Practice Problems

```{admonition} Practice Problem 1: Forward Valuation
:class: tip

Six months ago, Company X entered a 1-year forward contract to buy gold at $1,750/oz. The current spot price is $1,820/oz. Gold storage costs 0.3% per annum. The risk-free rate is 4.5% per annum (continuously compounded).

**Questions:**
1. What is the current 6-month forward price for gold?
2. What is the value of Company X's forward position?
3. If Company X wanted to close the position today, what would it cost/receive?
```

```{dropdown} Solution to Practice Problem 1

**Part 1: Current Forward Price**

Time remaining: $T = 0.5$ years

$$F_0 = S_0 e^{(r+u)T}$$

$$F_0 = 1820 \times e^{(0.045+0.003) \times 0.5}$$

$$F_0 = 1820 \times e^{0.024}$$

$$F_0 = 1820 \times 1.0243$$

$$F_0 = \$1,864.23$$

**Part 2: Value of Long Position**

Original delivery price: $K = \$1,750$

$$f = (F_0 - K)e^{-rT}$$

$$f = (1864.23 - 1750)e^{-0.045 \times 0.5}$$

$$f = 114.23 \times e^{-0.0225}$$

$$f = 114.23 \times 0.9777$$

$$f = \$111.68$$

**Part 3: Closing the Position**

To close the long position, Company X would:
- Enter an offsetting short forward at current forward price
- Net position: Long at $1,750, short at $1,864.23
- This locks in profit of $(1,864.23 - 1,750)e^{-0.0225} = \$111.68$

**Final Answer:**
1. Current forward price: **$1,864.23/oz**
2. Position value: **$111.68 per ounce**
3. Closing: **Receive $111.68 per ounce** (or $111,680 for a 1,000 oz contract)

**Interpretation**: Company X benefits from the gold price increase. The contract to buy at $1,750 is valuable because current market would agree to buy at $1,864.23.
```

---
