---
title: "Chapter 9: The Greeks and Risk Management"
author: "Based on John C. Hull"
date: "2025"
---

# The Greeks and Risk Management

This chapter explores "The Greeks" - measures of how option prices change with respect to various parameters. These sensitivities are essential for risk management, hedging strategies, and understanding option behavior.

## Introduction to The Greeks

```{admonition} Key Concept: The Greeks
:class: tip

**The Greeks** are partial derivatives of option price with respect to parameters:

**Primary Greeks:**
- **Delta ($\Delta$)**: Sensitivity to stock price
- **Gamma ($\Gamma$)**: Sensitivity of delta to stock price
- **Theta ($\Theta$)**: Sensitivity to time passage
- **Vega ($\mathcal{V}$)**: Sensitivity to volatility
- **Rho ($\rho$)**: Sensitivity to interest rate

**Usage:**
- Risk management: Quantify exposures
- Hedging: Construct neutral portfolios
- Trading: Understand P&L drivers
- Pricing: Verify model behavior
```

```{note}
**Practitioner Black-Scholes:**

Traders typically:
1. Use Black-Scholes-Merton framework
2. Set volatility = implied volatility (not historical)
3. Calculate Greeks at this implied vol
4. Called "practitioner Black-Scholes"

**Why?** Market price is "correct" by definition; Greeks show how it changes.
```

**Physical Meaning**: Greeks are like speedometers and gauges in a car - they tell you how fast things are changing in different dimensions. Just as a driver watches speed, fuel, and RPM, an options trader watches Delta, Gamma, Theta, Vega, and Rho.

---

## Delta ($\Delta$)

```{admonition} Key Concept: Delta
:class: tip

**Delta** measures the rate of change of option price with respect to stock price:

$$\Delta = \frac{\partial f}{\partial S}$$

**For European Options (No Dividends):**

**Call:** $\Delta_c = N(d_1)$

**Put:** $\Delta_p = N(d_1) - 1 = -N(-d_1)$

Where $N(d_1)$ is from Black-Scholes formula.
```

### Properties of Delta

```{note}
**Delta Ranges:**

**Call Delta:**
- Range: $[0, 1]$
- Deep in-the-money: $\Delta \to 1$
- At-the-money: $\Delta \approx 0.5$
- Deep out-of-the-money: $\Delta \to 0$

**Put Delta:**
- Range: $[-1, 0]$
- Deep in-the-money: $\Delta \to -1$
- At-the-money: $\Delta \approx -0.5$
- Deep out-of-the-money: $\Delta \to 0$
```

**Physical Meaning**: Delta tells you how many shares of stock replicate the option. A call with $\Delta = 0.6$ moves like 0.6 shares - if the stock rises $1, the call rises $0.60.

### Delta as Hedge Ratio

```{admonition} Key Use: Delta Hedging
:class: important

To hedge an option position:

**If short 1 call with $\Delta = 0.6$:**
- Buy 0.6 shares to hedge

**If long 1 put with $\Delta = -0.4$:**
- Buy 0.4 shares to hedge (makes position delta-neutral)

**General Rule:**
$$\text{Shares to hedge} = -\Delta \times \text{Number of options}$$
```

### Variation of Delta with Stock Price

```{note}
**Delta Behavior:**

**Call Delta vs. Stock Price:**
```
Delta
1.0 |           ___________
    |         /
0.5 |       /
    |     /
0.0 |___/________________
    Deep OTM  ATM  Deep ITM
```

**Put Delta vs. Stock Price:**
```
Delta
0.0 |_________________
    |                 \
-0.5|                  \
    |                   \
-1.0|                    \______
    Deep ITM  ATM  Deep OTM
```

**At-the-Money:** Steepest slope - delta changes rapidly with stock price.
```

---

## Example: Delta Hedging a Sold Call

```{admonition} Example Problem: Delta Hedging
:class: tip

**Problem:**
A bank sells 100,000 European call options on a stock.

**Given:**
- Stock price: $S_0 = \$49$
- Strike price: $K = \$50$
- Risk-free rate: $r = 5\%$
- Volatility: $\sigma = 20\%$
- Time to maturity: $T = 20$ weeks $= 20/52 = 0.3846$ years
- Black-Scholes price: $\$2.40$ per option
- Delta: $\Delta = 0.522$

**Questions:**
1. What is the bank's initial exposure?
2. How should the bank hedge?
3. What profit has the bank locked in?
```

```{dropdown} Solution

**Part 1: Initial Exposure**

**Liability:**
- Sold 100,000 calls at $2.40 each
- Total premium received: $100,000 \times \$2.40 = \$240,000$

**Naked Risk:**
- If stock rises significantly, bank faces unlimited loss
- Need to hedge

**Part 2: Delta Hedge**

**Delta of position:**
- Short 100,000 calls
- Position delta: $-100,000 \times 0.522 = -52,200$

**To achieve delta-neutral:**
- Buy $52,200$ shares
- Cost: $52,200 \times \$49 = \$2,557,800$

**Net Cash Flow:**
- Received from options: $+\$240,000$
- Paid for shares: $-\$2,557,800$
- Net investment: $-\$2,317,800$

**Part 3: Locked-In Profit**

The theoretical value of the position is:
$$\text{Value} = \text{Share value} - \text{Option value}$$
$$= 52,200 \times 49 - 100,000 \times 2.40$$
$$= \$2,557,800 - \$240,000 = \$2,317,800$$

This exactly equals the net investment!

**With continuous rebalancing**, the bank will earn the risk-free rate on this investment:

$$\text{Locked-in profit} = 240,000 - 100,000 \times 2.40 e^{-0.05 \times 0.3846}$$
$$= 240,000 - 235,412 = \$4,588$$

Wait, let me recalculate. The bank sold the options for $240,000 but their true value is $240,000 (they sold at fair value). The profit comes from the bid-ask spread or from selling above model value.

Actually, if they sold at exactly fair value and hedge perfectly, they lock in the risk-free rate on the premium collected net of hedging costs.

**Final Answer:**
1. Initial exposure: Short 100,000 calls, received $240,000
2. Hedge: Buy 52,200 shares for $2,557,800
3. With perfect hedging, earns risk-free rate on net position

**Key Insight**: The bank has transformed an unlimited-risk option position into a self-financing riskless position earning the risk-free rate (in theory).

**In Practice:**
- Must rebalance delta as stock price changes
- Transaction costs erode profit
- Discrete hedging introduces error
- Goal: Reduce risk, not necessarily zero profit
```

---

## Gamma ($\Gamma$)

```{admonition} Key Concept: Gamma
:class: tip

**Gamma** measures the rate of change of delta with respect to stock price:

$$\Gamma = \frac{\partial \Delta}{\partial S} = \frac{\partial^2 f}{\partial S^2}$$

**For European Options (No Dividends):**

$$\Gamma = \frac{N'(d_1)}{S_0 \sigma \sqrt{T}}$$

Where $N'(x) = \frac{1}{\sqrt{2\pi}}e^{-x^2/2}$ is the standard normal density.

**Same formula for both calls and puts!**
```

### Why Gamma Matters

```{important}
**Gamma and Rebalancing:**

**High Gamma:**
- Delta changes rapidly
- Frequent rebalancing needed
- Higher transaction costs
- Greater risk if not rebalanced

**Low Gamma:**
- Delta relatively stable
- Less frequent rebalancing
- Lower transaction costs
- Position more stable
```

**Physical Meaning**: Gamma measures **curvature**. Linear hedging (delta) works well for small moves, but for large moves, the curvature matters. High gamma means the hedge degrades quickly as the stock moves.

### Variation of Gamma

```{note}
**Gamma Behavior:**

**Gamma vs. Stock Price (Fixed Time):**
```
Gamma
  |      ╱╲
  |     ╱  ╲
  |    ╱    ╲
  |___╱______╲___
  OTM  ATM  ITM
       K
```

**Maximum at-the-money**
- Gamma greatest when $S \approx K$
- Lowest deep in or out of the money

**Gamma vs. Time to Maturity:**
```
Gamma
  |     ╱│
  |    ╱ │
  |   ╱  │
  |__╱___│
  Long T Short T
```

**Increases as expiration approaches**
- Short-dated ATM options have highest gamma
- Long-dated options have lower gamma
```

---

## Delta-Gamma Approximation

For small changes in stock price:

```{admonition} Taylor Series Approximation
:class: tip

$$\Delta f \approx \Delta \cdot \Delta S + \frac{1}{2}\Gamma \cdot (\Delta S)^2$$

**Linear term (Delta):**
- First-order approximation
- Accurate for small moves

**Quadratic term (Gamma):**
- Second-order correction
- Important for larger moves
- Captures curvature
```

```{admonition} Example: Delta vs. Delta-Gamma
:class: tip

**Given:**
- Option price: $f = \$5.00$
- Delta: $\Delta = 0.60$
- Gamma: $\Gamma = 0.05$
- Stock price change: $\Delta S = \$2.00$

**Delta-only approximation:**
$$\Delta f \approx 0.60 \times 2.00 = \$1.20$$
**New price**: $\$6.20$

**Delta-gamma approximation:**
$$\Delta f \approx 0.60 \times 2.00 + \frac{1}{2} \times 0.05 \times (2.00)^2$$
$$= 1.20 + 0.10 = \$1.30$$
**New price**: $\$6.30$

**Gamma adjustment**: $+\$0.10$ (makes curvature matter)
```

**Physical Meaning**: Delta assumes a straight line; Gamma accounts for the curve. For an option, prices don't change linearly with the stock - they accelerate (for calls when rising, for puts when falling).

---

## Theta ($\Theta$)

```{admonition} Key Concept: Theta
:class: tip

**Theta** measures the rate of change of option price with respect to time:

$$\Theta = \frac{\partial f}{\partial t}$$

**Usually expressed as change per calendar day:**
$$\Theta_{\text{day}} = \frac{\Theta}{365}$$

**For European Options (No Dividends):**

**Call:**
$$\Theta_c = -\frac{S_0 N'(d_1) \sigma}{2\sqrt{T}} - rKe^{-rT}N(d_2)$$

**Put:**
$$\Theta_p = -\frac{S_0 N'(d_1) \sigma}{2\sqrt{T}} + rKe^{-rT}N(-d_2)$$
```

### Properties of Theta

```{note}
**Theta Characteristics:**

**Sign:**
- Usually negative for long options (time decay)
- Options lose value as time passes (all else equal)
- "Theta bleed" or "time decay"

**Magnitude:**
- Largest for at-the-money options
- Accelerates as expiration approaches
- Deep ITM/OTM options have lower theta

**Relation to Other Greeks:**
$$\Theta + rS\Delta + \frac{1}{2}\sigma^2 S^2 \Gamma = r f$$
This is the Black-Scholes PDE rearranged!
```

**Physical Meaning**: Theta measures how much value bleeds away each day due to time decay. It's like ice melting - as expiration nears, the option loses extrinsic value at an accelerating rate.

### Variation of Theta

```{note}
**Theta vs. Stock Price:**
```
Theta
  0 |___    K    ____
    |   ╲      ╱
    |    ╲    ╱
    |     ╲__╱
    |
Neg | Most negative at ATM
```

**Theta vs. Time to Maturity:**
```
|Theta|
    |╲
    | ╲
    |  ╲___
    |      ╲____
    Long T    Short T
```

**Accelerates near expiration**
```

---

## Vega ($\mathcal{V}$)

```{admonition} Key Concept: Vega
:class: tip

**Vega** measures sensitivity to volatility:

$$\mathcal{V} = \frac{\partial f}{\partial \sigma}$$

**For European Options (No Dividends):**

$$\mathcal{V} = S_0 \sqrt{T} N'(d_1)$$

**Same formula for both calls and puts!**

**Usually expressed as change per 1% volatility change.**
```

### Properties of Vega

```{note}
**Vega Characteristics:**

**Sign:**
- Always positive for long options
- Long options benefit from increased volatility
- Short options hurt by increased volatility

**Magnitude:**
- Largest for at-the-money options
- Decreases for ITM and OTM options
- Proportional to $\sqrt{T}$ - longer-dated options have higher vega

**Why Volatility Increases Option Value:**
- More volatility → wider distribution
- Upside unlimited (for calls)
- Downside limited to zero (for stocks) or strike (for options)
- Asymmetric payoff benefits from volatility
```

**Physical Meaning**: Vega measures how much the option benefits from increased uncertainty. Options are "volatility long" - they gain when the future becomes more uncertain, because they capture upside while limiting downside.

---

## Rho ($\rho$)

```{admonition} Key Concept: Rho
:class: tip

**Rho** measures sensitivity to interest rate:

$$\rho = \frac{\partial f}{\partial r}$$

**For European Options (No Dividends):**

**Call:**
$$\rho_c = KT e^{-rT} N(d_2)$$

**Put:**
$$\rho_p = -KT e^{-rT} N(-d_2)$$

**Usually expressed as change per 1% (100 basis points) rate change.**
```

```{note}
**Rho Properties:**

- Calls have **positive rho** (benefit from rate increases)
- Puts have **negative rho** (hurt by rate increases)
- Usually smallest Greek (rates don't change much day-to-day)
- More important for long-dated options
- Interest rate effect on option prices is generally small
```

**Physical Meaning**: Higher interest rates increase call values and decrease put values because the present value of the strike price (paid/received in the future) changes. Rho is usually the least important Greek for short-dated equity options.

---

## Greeks for Dividend-Paying Stocks

```{admonition} Greeks with Continuous Dividend Yield $q$
:class: note

| Greek | Call | Put |
|-------|------|-----|
| **Delta** | $e^{-qT}N(d_1)$ | $-e^{-qT}N(-d_1)$ |
| **Gamma** | $\frac{e^{-qT}N'(d_1)}{S_0\sigma\sqrt{T}}$ | Same as call |
| **Theta** | $-\frac{S_0 e^{-qT} N'(d_1)\sigma}{2\sqrt{T}} - rKe^{-rT}N(d_2) + qS_0 e^{-qT}N(d_1)$ | $-\frac{S_0 e^{-qT} N'(d_1)\sigma}{2\sqrt{T}} + rKe^{-rT}N(-d_2) - qS_0 e^{-qT}N(-d_1)$ |
| **Vega** | $S_0 e^{-qT} \sqrt{T} N'(d_1)$ | Same as call |
| **Rho** | $KTe^{-rT}N(d_2)$ | $-KTe^{-rT}N(-d_2)$ |

**Note:** $d_1$ and $d_2$ are modified to include $q$:

$$d_1 = \frac{\ln(S_0/K) + (r - q + \sigma^2/2)T}{\sigma\sqrt{T}}$$
```

---

## Managing Delta, Gamma, and Vega

```{admonition} Multi-Dimensional Risk Management
:class: important

**Challenge:**

A portfolio may have exposure to multiple Greeks:
- Delta exposure → stock price risk
- Gamma exposure → delta rebalancing risk
- Vega exposure → volatility risk

**Solution:** Use multiple instruments

**To neutralize Delta:**
- Trade the underlying stock

**To neutralize Gamma and Vega:**
- Must trade options or other derivatives
- Need at least as many instruments as Greeks to neutralize
```

### Example: Neutralizing Gamma and Vega

```{admonition} Example Problem: Multi-Greek Hedging
:class: tip

**Portfolio:**
- Delta: $\Delta = 0$ (already delta-neutral)
- Gamma: $\Gamma = -5,000$
- Vega: $\mathcal{V} = -8,000$

**Available Options:**

| Option | Delta | Gamma | Vega |
|--------|-------|-------|------|
| Option 1 | 0.6 | 0.5 | 2.0 |
| Option 2 | 0.5 | 0.8 | 1.2 |

**Question:** How many of each option should be bought to make the portfolio gamma and vega neutral? Then, how to restore delta neutrality?
```

```{dropdown} Solution

**Step 1: Set Up Equations**

Let:
- $w_1$ = Number of Option 1 to buy
- $w_2$ = Number of Option 2 to buy

**Gamma neutrality:**
$$-5,000 + 0.5w_1 + 0.8w_2 = 0$$

**Vega neutrality:**
$$-8,000 + 2.0w_1 + 1.2w_2 = 0$$

**Step 2: Solve System of Equations**

From gamma equation:
$$0.5w_1 + 0.8w_2 = 5,000$$ ... (1)

From vega equation:
$$2.0w_1 + 1.2w_2 = 8,000$$ ... (2)

Multiply equation (1) by 4:
$$2.0w_1 + 3.2w_2 = 20,000$$ ... (3)

Subtract equation (2) from equation (3):
$$2.0w_2 = 12,000$$
$$w_2 = 6,000$$

Substitute back into equation (1):
$$0.5w_1 + 0.8(6,000) = 5,000$$
$$0.5w_1 + 4,800 = 5,000$$
$$w_1 = 400$$

**Step 3: Check Delta Impact**

Adding options changes delta:
$$\Delta_{\text{new}} = 0 + 0.6(400) + 0.5(6,000)$$
$$= 240 + 3,000 = 3,240$$

**Step 4: Restore Delta Neutrality**

To make delta = 0:
- Short 3,240 shares of underlying stock

**Final Answer:**

**Portfolio Construction:**
1. Buy **400 units** of Option 1
2. Buy **6,000 units** of Option 2
3. Short **3,240 shares** of stock

**Verification:**
- Gamma: $-5,000 + 0.5(400) + 0.8(6,000) = -5,000 + 200 + 4,800 = 0$ ✓
- Vega: $-8,000 + 2.0(400) + 1.2(6,000) = -8,000 + 800 + 7,200 = 0$ ✓
- Delta: $0 + 0.6(400) + 0.5(6,000) - 1.0(3,240) = 3,240 - 3,240 = 0$ ✓

**Physical Meaning**: We've created a portfolio that is insensitive to stock price (delta), stock price curvature (gamma), and volatility (vega). It should have minimal P&L fluctuations from these sources.
```

---

## Taylor Series Expansion for Portfolio Value

```{admonition} Complete Taylor Expansion
:class: tip

The change in portfolio value can be approximated:

$$\Delta P = \Delta \cdot \Delta S + \Gamma \cdot \frac{(\Delta S)^2}{2} + \mathcal{V} \cdot \Delta\sigma + \Theta \cdot \Delta t$$

Where:
- $\Delta S$ = Change in stock price
- $\Delta \sigma$ = Change in volatility
- $\Delta t$ = Time elapsed

**Components:**
1. **Delta term**: Linear sensitivity to price
2. **Gamma term**: Quadratic sensitivity to price
3. **Vega term**: Sensitivity to volatility
4. **Theta term**: Time decay

**Higher-order terms** (vanna, volga, etc.) exist but are usually smaller.
```

---

## Relationship Between Greeks: The Black-Scholes PDE

```{important}
**The Black-Scholes PDE Can Be Written:**

$$\Theta + rS\Delta + \frac{1}{2}\sigma^2 S^2 \Gamma = rf$$

**Rearranging:**
$$\Theta + \frac{1}{2}\sigma^2 S^2 \Gamma = r(f - S\Delta)$$

**For Delta-Neutral Portfolio ($\Delta = 0$):**
$$\Theta + \frac{1}{2}\sigma^2 S^2 \Gamma = rf$$

**Interpretation:**

Time decay ($\Theta$) plus convexity profit ($\Gamma$) equals risk-free return on option value.

**Key Insight:** Negative theta (time decay) is compensated by gamma (rebalancing profit) for a delta-neutral portfolio.
```

**Physical Meaning**: In a delta-hedged option position, you lose money to time decay (negative theta) but make it back through rebalancing (gamma). The net effect is earning the risk-free rate, which is what no-arbitrage requires.

---

## Chapter Summary

```{important}
**Key Takeaways:**

1. **Delta ($\Delta$)** measures sensitivity to stock price; range [0,1] for calls, [-1,0] for puts
2. **Delta hedging** requires $\Delta$ shares to offset option
3. **Gamma ($\Gamma$)** measures curvature; same for calls and puts
4. **High gamma** requires frequent rebalancing; largest at-the-money
5. **Theta ($\Theta$)** measures time decay; usually negative for long options
6. **Theta accelerates** as expiration approaches
7. **Vega ($\mathcal{V}$)** measures volatility sensitivity; positive for long options
8. **Vega largest** for ATM options and longer maturities
9. **Rho ($\rho$)** measures interest rate sensitivity; usually least important
10. **Multi-dimensional hedging** requires multiple instruments
11. **Taylor expansion**: $\Delta P \approx \Delta \cdot \Delta S + \frac{1}{2}\Gamma \cdot (\Delta S)^2 + \mathcal{V} \cdot \Delta\sigma + \Theta \cdot \Delta t$
12. **BSM PDE relationship**: $\Theta + \frac{1}{2}\sigma^2 S^2 \Gamma = r(f - S\Delta)$
```

```{seealso}
**Looking Ahead:**

Chapter 10 explores **Volatility and Trading Strategies**, including the volatility smile, implied distributions, and common option strategies used by traders.
```

---

## Practice Problems

```{admonition} Practice Problem 1: Greek Calculations
:class: tip

An at-the-money call option has the following Greeks:
- Delta: 0.55
- Gamma: 0.03
- Theta: -0.05 (per day)
- Vega: 0.20

The stock currently trades at $100.

**Questions:**
1. If the stock rises to $102, estimate the new option price (using delta only, then delta-gamma)
2. If volatility increases by 2%, estimate the change in option price
3. If one day passes with no other changes, estimate the change in option price
4. What is the combined effect of the stock rising $2, volatility increasing 2%, and one day passing?
```

```{dropdown} Solution to Practice Problem 1

**Assume initial option price**: $f = \$5.00$ (ATM call)

**Part 1: Stock Rises to $102 ($\Delta S = 2$)**

**Delta-only:**
$$\Delta f = \Delta \cdot \Delta S = 0.55 \times 2 = \$1.10$$
**New price**: $5.00 + 1.10 = \$6.10$

**Delta-gamma:**
$$\Delta f = \Delta \cdot \Delta S + \frac{1}{2}\Gamma \cdot (\Delta S)^2$$
$$= 0.55 \times 2 + \frac{1}{2} \times 0.03 \times 4$$
$$= 1.10 + 0.06 = \$1.16$$
**New price**: $5.00 + 1.16 = \$6.16$

**Gamma effect**: +$0.06 (curvature increases value)

**Part 2: Volatility Increases 2% ($\Delta\sigma = 0.02$)**

$$\Delta f = \mathcal{V} \cdot \Delta\sigma = 0.20 \times 0.02 = \$0.004$$

Wait, this seems small. Vega is usually quoted per 1% change. If Vega = 0.20 means change per 1% vol change:

$$\Delta f = 0.20 \times 2 = \$0.40$$

**New price**: $5.00 + 0.40 = \$5.40$

**Part 3: One Day Passes ($\Delta t = 1/365$)**

$$\Delta f = \Theta_{\text{day}} \times 1 = -0.05 \times 1 = -\$0.05$$

**New price**: $5.00 - 0.05 = \$4.95$

**Part 4: Combined Effect**

$$\Delta f = \Delta \cdot \Delta S + \frac{1}{2}\Gamma \cdot (\Delta S)^2 + \mathcal{V} \cdot \Delta\sigma + \Theta \cdot \Delta t$$

$$= 1.16 + 0.40 - 0.05$$

$$= \$1.51$$

**New price**: $5.00 + 1.51 = \$6.51$

**Final Answers:**
1. Delta-only: $6.10; Delta-gamma: $6.16
2. Volatility effect: +$0.40
3. Time decay: -$0.05
4. Combined: $6.51

**Breakdown:**
- Stock move: +$1.16
- Volatility increase: +$0.40
- Time decay: -$0.05
- **Net**: +$1.51

**Interpretation**: The stock price increase and volatility increase overwhelm time decay, resulting in significant gain for the option holder.
```

---

**Next Chapter:** [Chapter 10: Volatility and Option Trading Strategies →](chapter10_volatility-and-strategies.md)
