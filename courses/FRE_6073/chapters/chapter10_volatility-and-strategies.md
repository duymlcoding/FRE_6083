---
title: "Chapter 10: Volatility Smiles and Option Trading Strategies"
author: "Based on John C. Hull"
date: "2025"
---

# Volatility Smiles and Option Trading Strategies

This chapter explores the volatility smile phenomenon - evidence that Black-Scholes assumptions don't perfectly match reality - and examines practical option trading strategies used by market participants.

## Part I: Volatility Smiles and Implied Distributions

### What is a Volatility Smile?

```{admonition} Key Concept: Volatility Smile
:class: tip

A **volatility smile** is the relationship between implied volatility and strike price for options with the same maturity.

**Definition:**
- Plot implied volatility (y-axis) vs. strike price or moneyness (x-axis)
- For options on the same underlying with same expiration
- Reveals how market prices deviate from Black-Scholes

**If Black-Scholes were perfect:**
- All options would have the same implied volatility
- Flat line (no smile)

**In reality:**
- Implied volatility varies with strike
- Pattern depends on underlying asset class
```

**Physical Meaning**: The volatility smile shows that traders are willing to pay more (in vol terms) for some strikes than others, suggesting they believe the true distribution of returns differs from lognormal.

---

## The Volatility Smile for Foreign Currency Options

```{admonition} FX Volatility Smile Pattern
:class: note

**Shape:** Symmetric "smile" - U-shaped

```
Implied
Vol (%)
    |    ╱      ╲
    |   ╱        ╲
    |  ╱          ╲
    | ╱____________╲
    |_______|_______
          ATM
     OTM  K/S₀  OTM
```

**Characteristics:**
- Minimum volatility at-the-money
- Increases for both deep ITM and deep OTM options
- Relatively symmetric around ATM
- Called a "smile" (not smirk or skew)
```

### Implied Distribution for FX Options

```{note}
**Properties of FX Implied Distribution:**

Compared to lognormal distribution:

1. **Heavier tails**: Both left and right tails fatter
2. **More peaked**: Higher probability near the mean
3. **Leptokurtic**: Positive excess kurtosis

**Interpretation:**
- More frequent small moves (peaked center)
- More frequent extreme moves (fat tails)
- Fewer moderate moves (relative to lognormal)
```

```{admonition} Visual Comparison
:class: note

```
Probability
Density
    |     /\
    |    /  \      - - Implied
    |   /    \     ___ Lognormal
    |  / /‾‾\ \
    | /_/    \_\___
    |_____________
       Exchange Rate
```

**Implied distribution** (solid):
- Higher peak
- Thicker tails on both sides
```

### Why Does the FX Smile Exist?

```{admonition} Possible Causes
:class: important

**1. Jumps in Exchange Rates**
- Exchange rates don't move continuously
- Central bank interventions cause sudden jumps
- News announcements create discontinuities
- Violates continuous Brownian motion assumption

**2. Stochastic Volatility**
- Volatility itself is random (not constant)
- Volatility clusters - high vol periods follow high vol
- Creates fat tails in return distribution

**Both effects contribute to observed smile**
```

**Physical Meaning**: Currency markets experience sudden shocks (jumps) and periods of varying turbulence (stochastic volatility). The Black-Scholes model assumes smooth, constant-volatility changes, so traders adjust by using different implied vols for different strikes.

---

## Historical Analysis: Evidence of Fat Tails

```{admonition} Empirical Evidence
:class: note

**Historical FX Rate Changes vs. Normal Model:**

| Event | Real World (%) | Normal Model (%) |
|-------|----------------|------------------|
| >1 SD | 23.32 | 31.73 |
| >2 SD | 4.67 | 4.55 |
| >3 SD | 1.30 | 0.27 |
| >4 SD | 0.49 | 0.01 |
| >5 SD | 0.24 | 0.00 |
| >6 SD | 0.13 | 0.00 |

**Key Observations:**
- Fewer 1-2 SD moves than normal model predicts
- **Much more** extreme moves (>3 SD) than normal predicts
- >4 SD events occur ~50× more than normal model suggests
```

**Physical Meaning**: Real markets have "Black Swan" events far more frequently than the bell curve predicts. This is why out-of-the-money options are more expensive than Black-Scholes suggests.

---

## The Volatility Smile for Equity Options

```{admonition} Equity Volatility Smile Pattern
:class: note

**Shape:** Asymmetric "smirk" or "skew" - downward sloping

```
Implied
Vol (%)
    |╲
    | ╲
    |  ╲___________
    |
    |_______|_______
          ATM
     OTM        OTM
    (puts)    (calls)
     K/S₀
```

**Characteristics:**
- Downward sloping from left to right
- High implied vol for low strikes (OTM puts)
- Low implied vol for high strikes (OTM calls)
- Called "skew" or "smirk," not "smile"
- Particularly pronounced since 1987 crash
```

### Implied Distribution for Equity Options

```{note}
**Properties of Equity Implied Distribution:**

Compared to lognormal:

1. **Left tail heavier**: More crash risk
2. **Right tail thinner**: Large upside moves less likely
3. **Negative skewness**: Left tail extends further

```
Probability
Density
    |       /|
    |      / |     - - Implied
    |   __/  |     ___ Lognormal
    |  /     |\
    | /      | \__
    |/       |
    |________|____
            Stock Price
```

**Implied** (solid):
- Fat left tail (crash risk)
- Thin right tail
- Skewed left
```

### Why Does the Equity Skew Exist?

```{admonition} Possible Explanations
:class: important

**1. Leverage Effect**
- Stock price falls → Firm's debt/equity ratio increases
- Higher leverage → Higher risk → Higher volatility
- Creates negative correlation between price and volatility

**2. Volatility Feedback**
- Volatility increases → Required return increases
- Higher required return → Lower stock price
- Also creates negative correlation

**3. Flight to Quality**
- Market stress → Investors flee to safe assets
- Selling pressure → Price falls
- Uncertainty → Volatility rises
- Reinforcing cycle

**Net Effect:** When prices fall, volatility tends to rise, making further falls more likely
```

**Physical Meaning**: Stock markets have an asymmetric fear - crashes happen faster and more violently than rallies. The 1987 crash, Long-Term Capital Management crisis, and 2008 financial crisis reinforced this pattern in trader psychology and option pricing.

---

## Other Possible Smile Patterns

```{note}
**Reverse Skew** (rare):
- Light left tail, heavy right tail
- Would occur if crashes were less likely than explosive rallies
- Seen in some commodity markets during shortages

**Flat Smile** (theoretical):
- No smile - all strikes same implied vol
- Would occur if Black-Scholes assumptions held perfectly
- Never observed in practice for any significant period
```

---

## Characterizing Volatility Smiles

Traders use several methods to describe smiles:

```{admonition} Methods to Plot Volatility Smile
:class: tip

**1. Strike vs. Spot ($K/S_0$)**
$$\text{Implied Vol vs. } K/S_0$$

**2. Strike vs. Forward ($K/F_0$)**
$$\text{Implied Vol vs. } K/F_0$$
- More common in practice
- Accounts for carry costs

**3. Delta**
$$\text{Implied Vol vs. Delta}$$
- Very common among traders
- "25-delta call," "10-delta put," etc.

**4. Moneyness (Log)**
$$\text{Implied Vol vs. } \ln(K/S_0)$$
- Symmetric around zero
```

```{note}
**At-The-Money (ATM) Definitions:**

**Traders often use different ATM definitions:**

1. **$K = S_0$** (spot)
2. **$K = F_0$** (forward price) - **Most common**
3. **50-delta option** - call with $\Delta = 0.5$ or put with $\Delta = -0.5$

**Forward ATM most common** because it accounts for carry (dividends, interest).
```

---

## Volatility Term Structure

```{admonition} Key Concept: Volatility Term Structure
:class: tip

The **volatility term structure** shows how implied volatility varies with time to maturity (for a fixed strike or moneyness).

**Typical Patterns:**

**When volatility is high:**
```
Implied
Vol
    |╲
    | ╲_________
    |
    |___________
      Time to Maturity
```
- Downward sloping
- Market expects mean reversion
- Short-term vol > long-term vol

**When volatility is low:**
```
Implied
Vol
    |      ____
    |    /
    |   /
    |__/________
      Time to Maturity
```
- Upward sloping
- Market expects vol to rise
- Long-term vol > short-term vol
```

**Physical Meaning**: Volatility mean reverts. When it's unusually high, traders expect it to fall back to normal. When it's low, they expect it to rise. This creates term structure slopes.

---

## Volatility Surface

```{admonition} Key Concept: Volatility Surface
:class: tip

The **volatility surface** is implied volatility as a function of BOTH strike and maturity:

$$\sigma_{implied} = f(K, T)$$

Or equivalently: $f(K/S_0, T)$ or $f(\Delta, T)$

**3D Surface:**
- x-axis: Strike (or moneyness)
- y-axis: Time to maturity
- z-axis: Implied volatility

**Combines:**
- Volatility smile (strike dimension)
- Volatility term structure (time dimension)
```

### Example Volatility Surface

```{admonition} Sample Volatility Surface Data
:class: note

| Maturity | K/S₀ = 0.90 | K/S₀ = 0.95 | K/S₀ = 1.00 | K/S₀ = 1.05 | K/S₀ = 1.10 |
|----------|-------------|-------------|-------------|-------------|-------------|
| 1 month  | 14.2% | 13.0% | 12.0% | 13.1% | 14.5% |
| 3 months | 14.0% | 13.0% | 12.0% | 13.1% | 14.2% |
| 6 months | 14.1% | 13.3% | 12.5% | 13.4% | 14.3% |
| 1 year   | 14.7% | 14.0% | 13.5% | 14.0% | 14.8% |
| 2 years  | 15.0% | 14.4% | 14.0% | 14.5% | 15.1% |
| 5 years  | 14.8% | 14.6% | 14.4% | 14.7% | 15.0% |

**Observations:**
- Smile present at all maturities (lowest vol near ATM)
- Smile flattens as maturity increases
- Short-term ATM vol (12.0%) < long-term ATM vol (14.4%)
- Term structure upward sloping (relatively low current vol)
```

**Physical Meaning**: The volatility surface is the market's complete view of risk across all strikes and maturities. It encodes beliefs about both the shape of the return distribution (smile) and how that distribution evolves over time (term structure).

---

## Minimum Variance Delta

```{admonition} Practitioner Delta Adjustment
:class: important

When a volatility smile exists, the optimal hedge ratio differs from Black-Scholes delta:

$$\Delta_{MV} = \Delta_{BS} + \mathcal{V} \frac{\partial \sigma_{imp}(S)}{\partial S}$$

Where:
- $\Delta_{MV}$ = Minimum variance delta
- $\Delta_{BS}$ = Black-Scholes delta
- $\mathcal{V}$ = Vega
- $\frac{\partial \sigma_{imp}}{\partial S}$ = Slope of implied vol vs. stock price

**Why the adjustment?**

If stock price increases and option moves up the smile (to lower implied vol):
- Option gains from delta effect
- Option loses from vega effect (vol decrease)
- Net delta is less than Black-Scholes suggests
```

**Physical Meaning**: If the volatility smile is sticky (moves with the stock), then hedging requires adjusting for how implied vol changes as you move along the smile. This is especially important for exotic options.

---

## Determining the Implied Distribution

```{admonition} Extracting the Implied Distribution
:class: tip

The risk-neutral probability density can be extracted from option prices:

$$g(K) = e^{rT} \frac{\partial^2 c}{\partial K^2}$$

Where:
- $g(K)$ = Risk-neutral probability density at strike $K$
- $c$ = Call price as a function of strike

**Practical Method:**

Given call prices $c_1$, $c_2$, $c_3$ at strikes $K_1 < K_2 < K_3$ equally spaced by $\Delta K$:

$$g(K_2) \approx e^{rT} \frac{c_1 - 2c_2 + c_3}{(\Delta K)^2}$$

**Why it works:** The second derivative of call price with respect to strike gives the probability density.
```

---

## Part II: Option Trading Strategies

### Principal Protected Notes

```{admonition} Key Product: Principal Protected Note
:class: tip

**Structure:**
A security that guarantees principal while providing upside participation.

**Example:**
- Initial investment: $1,000
- 3-year maturity
- **Guarantee**: Get back at least $1,000
- **Upside**: Participate in stock index gains

**Construction:**
1. Buy 3-year zero-coupon bond with face value $1,000
2. Use remaining funds to buy call options on index
```

```{admonition} Example Problem: Designing a Principal Protected Note
:class: tip

**Given:**
- Investment amount: $1,000
- Maturity: 3 years
- Risk-free rate: 6% (continuously compounded)
- Stock index: 1,000
- Index dividend yield: 1.5%
- 3-year ATM call option on index costs: $164 per $1,000 notional

**Question:** Design a principal protected note. What participation rate can you offer?
```

```{dropdown} Solution

**Step 1: Cost of Principal Protection**

Buy 3-year zero-coupon bond paying $1,000 at maturity:

$$\text{Cost} = 1,000 \times e^{-0.06 \times 3} = 1,000 \times e^{-0.18}$$
$$= 1,000 \times 0.8353 = \$835.27$$

**Step 2: Funds Available for Options**

$$\text{Available} = 1,000 - 835.27 = \$164.73$$

**Step 3: Call Options Purchasable**

Call option cost: $164 per $1,000 of index exposure

$$\text{Number of options} = \frac{164.73}{164} = 1.0045$$

**Step 4: Structure**

**Principal Protected Note:**
- Guaranteed return: $1,000 (100% principal protection)
- Plus: 100% of index gains above 1,000

**If index rises to 1,200:**
- Bond pays: $1,000
- Options pay: $200
- Total: $1,200 (full participation!)

**If index falls to 800:**
- Bond pays: $1,000
- Options expire worthless
- Total: $1,000 (principal protected!)

**Final Answer:** Can offer **100% participation** in index gains with **full principal protection**.

**Viability depends on:**
- Interest rates (higher → more attractive)
- Option prices / volatility (lower → more attractive)
- Dividend yield (lower → cheaper options)
```

### Variations

```{note}
**Principal Protected Note Variations:**

**1. Cap on Returns:**
- Reduce cost by capping maximum gain
- Use bull call spread instead of naked call
- Example: Participate up to 50% gain

**2. Out-of-the-Money Strike:**
- Strike above current price
- Cheaper options → higher participation or longer maturity
- Example: Participate in gains above 10%

**3. Knock-Out Features:**
- Options knock out if barrier hit
- Much cheaper → higher participation
- Risk: Might not participate if barrier touched

**4. Asian/Average:**
- Payoff based on average price
- Cheaper than European
- Reduces extreme payoff volatility
```

---

## Basic Option Positions

```{admonition} Four Fundamental Positions
:class: note

```
(a) Long Stock        (b) Short Stock
Profit|                Profit|
      |      /                |╲
      |     /                 | ╲
      |    /                  |  ╲
   ___|___/_____          _____|__╲_____
      |  /    ST               |   ╲   ST
      | /                      |    ╲

(c) Long Call         (d) Long Put
Profit|                Profit|╲
      |      /                | ╲
      |     /                 |  ╲_____
   ___|____/_____         ____|________
      |K   /    ST             |K       ST
      |   /                    |
```

**Key Points:**
- Stock: Linear payoff, unlimited risk (for short)
- Call: Limited downside, unlimited upside
- Put: Limited downside (to $K$), limited upside (to $K$)
```

---

## Spread Strategies

### Bull Spread Using Calls

```{admonition} Bull Call Spread
:class: tip

**Position:**
- **Buy** call with strike $K_1$ (low)
- **Sell** call with strike $K_2$ (high)
- Where $K_1 < K_2$

**Payoff:**
```
Profit
    |        _____K₂
    |       /
    |      /
 ___|_____/_______
    |K₁          ST
    |
Max Loss
```

**Maximum Profit:** $K_2 - K_1 - \text{Net Premium}$

**Maximum Loss:** Net premium paid

**Breakeven:** $S_T = K_1 + \text{Net Premium}$

**When to Use:**
- Moderately bullish outlook
- Want to reduce cost vs. naked call
- Willing to cap upside
```

### Bull Spread Using Puts

```{note}
**Alternative: Bull Put Spread**

- **Sell** put with strike $K_2$ (high)
- **Buy** put with strike $K_1$ (low)

**Same payoff profile as bull call spread**

**Difference:**
- Receive net premium (vs. pay for call spread)
- Maximum profit = Net premium received
- Maximum loss = $K_2 - K_1 - \text{Net Premium}$
```

### Bear Spread

```{admonition} Bear Put Spread
:class: tip

**Position:**
- **Buy** put with strike $K_2$ (high)
- **Sell** put with strike $K_1$ (low)

**Payoff:**
```
Profit
    |╲_____K₂
    | ╲
    |  ╲
 ___|___╲_______
    |K₁  ╲    ST
    |     ╲
Max Loss
```

**When to Use:**
- Moderately bearish
- Reduce cost vs. naked put
- Cap maximum profit
```

### Butterfly Spread

```{admonition} Butterfly Spread
:class: tip

**Position (using calls):**
- **Buy** 1 call at $K_1$ (low)
- **Sell** 2 calls at $K_2$ (middle)
- **Buy** 1 call at $K_3$ (high)

Where $K_2 - K_1 = K_3 - K_2$ (equal spacing)

**Payoff:**
```
Profit
    |      /\
    |     /  \
    |    /    \
 ___|___/______\___
    |K₁  K₂   K₃  ST
    |
```

**Maximum Profit:** At $S_T = K_2$

**Maximum Loss:** Net premium paid (at extremes)

**When to Use:**
- Expect little movement (low volatility)
- Profit from stock staying near $K_2$
- Limited risk strategy
```

**Physical Meaning**: A butterfly is a bet on low volatility. If the stock stays near the middle strike, you profit. If it moves far in either direction, you lose only the small premium paid.

---

## Calendar Spreads

```{admonition} Calendar Spread (Time Spread)
:class: tip

**Position:**
- **Sell** near-term option (expiring soon)
- **Buy** longer-term option (same strike)

**Can use calls or puts**

**Payoff at near-term expiration:**
```
Profit
    |      /‾\
    |     /   \
    |    /     \
 ___|___/___K__\___
    |          ST
    |
```

**Maximum Profit:** Near $K$ (at-the-money)

**Risk:** Large moves in either direction

**When to Use:**
- Expect low volatility short-term
- Profit from time decay differential
- Long vega position (benefits if vol rises)

**Note:** Complex strategy - profit depends on vol surface changes
```

**Physical Meaning**: Near-term options decay faster (higher theta). You sell expensive theta and buy cheaper theta. Profits if stock stays near strike and/or volatility rises.

---

## Combination Strategies

### Straddle

```{admonition} Long Straddle
:class: tip

**Position:**
- **Buy** call at strike $K$
- **Buy** put at strike $K$
- (Same strike, same expiration)

**Payoff:**
```
Profit
    |    /         \
    |   /           \
    |  /             \
 ___|_/______________\__
    |K               ST
    |
Max Loss
```

**Profit if:** Large move in either direction

**Loss if:** Stock stays near $K$

**Breakeven:**
- $S_T = K + \text{Total Premium}$
- $S_T = K - \text{Total Premium}$

**When to Use:**
- Expect large move but unsure of direction
- Earnings announcements
- Major events with unknown outcome
- Long volatility position
```

### Strip and Strap

```{note}
**Strip:** 1 call + 2 puts
- More bearish bias
- Profits more from downside

**Strap:** 2 calls + 1 put
- More bullish bias
- Profits more from upside

Both are volatility plays with directional tilt.
```

### Strangle

```{admonition} Long Strangle
:class: tip

**Position:**
- **Buy** call at strike $K_2$ (high)
- **Buy** put at strike $K_1$ (low)
- Where $K_1 < K_2$

**Payoff:**
```
Profit
    |  /             \
    | /               \
    |/                 \
 ___|__________________\__
    |K₁              K₂  ST
    |
```

**Cheaper than straddle** (OTM options cost less)

**Requires larger move** to profit

**When to Use:**
- Expect large move (less certain than straddle)
- Want to reduce cost vs. straddle
- Willing to need larger move to profit
```

**Physical Meaning**: A strangle is a cheaper straddle - you give up profit on moderate moves in exchange for lower upfront cost. Good when you expect extreme moves but want to limit downside.

---

## Other Combinations

### Box Spread

```{note}
**Box Spread:**
- Bull call spread + Bear put spread (same strikes)
- Payoff: $K_2 - K_1$ (always, regardless of $S_T$)

**For European options:**
- Worth $e^{-rT}(K_2 - K_1)$
- Risk-free bond!

**For American options:**
- Early exercise complicates
- Not necessarily riskless
```

---

## Creating Any Payoff

```{important}
**Building Block Principle:**

With butterfly spreads of all strikes (closely spaced), you can create ANY payoff pattern!

**Intuition:**
- Butterfly = small "spike" at one strike
- Combine many butterflies → any shape
- In theory, can replicate any derivative

**Practical Limitations:**
- Transaction costs
- Discrete strikes
- Liquidity
- Model risk
```

**Physical Meaning**: Options are incredibly flexible. By combining them cleverly, traders can create almost any exposure pattern imaginable - bets on volatility, skewness, specific price ranges, etc.

---

## Chapter Summary

```{important}
**Key Takeaways:**

**Part I: Volatility:**

1. **Volatility smile**: Implied vol varies with strike, violating Black-Scholes
2. **FX smile**: Symmetric U-shape; fat tails on both sides
3. **Equity skew**: Downward sloping; heavy left tail (crash risk)
4. **Fat tails**: Real distributions have more extreme events than lognormal
5. **Causes**: Jumps, stochastic volatility, leverage effect
6. **Term structure**: Implied vol varies with maturity; mean-reverting
7. **Volatility surface**: 2D surface of vol(K, T)
8. **Minimum variance delta**: Adjusts for smile effects

**Part II: Strategies:**

9. **Principal protected notes**: Zero-coupon bond + call options
10. **Bull/bear spreads**: Directional bets with limited risk/reward
11. **Butterfly**: Profit from low volatility, small moves
12. **Calendar spread**: Profit from time decay differential
13. **Straddle**: Profit from large move, any direction (long vol)
14. **Strangle**: Cheaper straddle, requires bigger move
15. **Flexibility**: Can create almost any payoff with options
```

```{seealso}
**Course Complete!**

You've now covered the fundamental concepts of derivatives:
- Forward and futures contracts
- Pricing and valuation principles
- Interest rate markets
- Bond mathematics
- Binomial model and risk-neutral valuation
- Stochastic processes
- Black-Scholes-Merton model
- The Greeks and risk management
- Volatility smiles and trading strategies

**Next Steps:**
- Practice problems and case studies
- Advanced topics (exotic options, credit derivatives)
- Real-world trading and risk management
```

---

## Practice Problems

```{admonition} Practice Problem 1: Bull Call Spread
:class: tip

**Given:**
- Stock price: $100
- Call option (Strike $100): $6
- Call option (Strike $110): $2

**Questions:**
1. What is the cost to establish a bull call spread?
2. What is the maximum profit?
3. What is the maximum loss?
4. What are the breakeven points?
5. What is the payoff if the stock ends at $95? $105? $115?
```

```{dropdown} Solution to Practice Problem 1

**Bull Call Spread Structure:**
- **Buy** call at $K_1 = \$100$ for $\$6$
- **Sell** call at $K_2 = \$110$ for $\$2$

**Part 1: Cost (Net Premium)**

$$\text{Cost} = 6 - 2 = \$4$$

**Part 2: Maximum Profit**

Occurs when $S_T \geq 110$:

At $S_T = 110$ or higher:
- Long call payoff: $S_T - 100$
- Short call payoff: $-(S_T - 110)$
- Net: $(S_T - 100) - (S_T - 110) = 10$

$$\text{Max Profit} = 10 - 4 = \$6$$

**Part 3: Maximum Loss**

Occurs when $S_T \leq 100$:

Both calls expire worthless:
$$\text{Max Loss} = \$4$$ (net premium paid)

**Part 4: Breakeven**

At breakeven, profit = 0:

$$S_T - 100 - 4 = 0$$
$$S_T = \$104$$

**Part 5: Payoffs**

**At $S_T = \$95$:**
- Long call: $0$
- Short call: $0$
- Profit: $0 - 4 = -\$4$ (max loss)

**At $S_T = \$105$:**
- Long call: $105 - 100 = 5$
- Short call: $0$
- Profit: $5 - 4 = \$1$

**At $S_T = \$115$:**
- Long call: $115 - 100 = 15$
- Short call: $-(115 - 110) = -5$
- Net payoff: $15 - 5 = 10$
- Profit: $10 - 4 = \$6$ (max profit)

**Final Answers:**
1. Cost: **$4**
2. Maximum profit: **$6** (at $S_T \geq 110$)
3. Maximum loss: **$4** (at $S_T \leq 100$)
4. Breakeven: **$104**
5. Payoffs: **$95 → -$4; $105 → +$1; $115 → +$6**

**Interpretation**: The bull call spread reduces the cost of a bullish position from $6 to $4, but caps the maximum profit at $6. It's appropriate for moderate bullish views where you're willing to cap upside to reduce cost.
```

---

**Course Complete!** You have successfully completed all 10 chapters of Introduction to Derivatives.

---

**Recommended Next Steps:**
1. Review all practice problems
2. Work through additional examples
3. Explore real market data for volatility smiles
4. Practice constructing and analyzing option strategies
5. Study advanced topics like exotic options and credit derivatives
