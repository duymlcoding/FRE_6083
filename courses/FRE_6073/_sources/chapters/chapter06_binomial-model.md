---
title: "Chapter 6: The Binomial Model"
author: "Based on John C. Hull"
date: "2025"
---

# The Binomial Model

This chapter introduces the binomial asset pricing model, a fundamental framework for understanding derivative valuation. We'll explore how to price options using a discrete-time tree model and discover the powerful concept of risk-neutral valuation.

## Introduction to the Binomial Model

```{admonition} Key Concept: Binomial Model
:class: tip

The **binomial model** assumes that in each time step, an asset price can move to one of two possible values:
- **Up** by a factor $u$ (with probability $p$)
- **Down** by a factor $d$ (with probability $1-p$)

**Foundation:**
- Asset follows a random walk
- In the limit (small time steps), leads to lognormal distribution
- Basis for Black-Scholes-Merton model
```

**Why the Binomial Model Matters:**

```{note}
**Importance:**

1. **Conceptual clarity**: Easy to understand arbitrage pricing
2. **Risk-neutral valuation**: Reveals fundamental pricing principle
3. **Practical tool**: Used for American options and complex derivatives
4. **Theoretical foundation**: Converges to Black-Scholes as $\Delta t \to 0$
5. **Pedagogical value**: Teaches core derivatives concepts
```

**Physical Meaning**: Think of the binomial model as a simplified version of reality where stock prices can only move up or down at discrete points in time. While unrealistic, this simplification reveals deep truths about option pricing.

---

## A Simple Binomial Model

Let's start with the simplest possible model: one time step.

```{admonition} One-Step Binomial Tree Setup
:class: tip

**Today (t=0):**
- Stock price: $S_0$
- Option price: $f$ (unknown)

**At expiration (t=T):**
- Stock goes up to $S_0u$ with probability $p$
  - Option value: $f_u$
- Stock goes down to $S_0d$ with probability $1-p$
  - Option value: $f_d$

Where:
- $u$ = Up factor (e.g., 1.10 for 10% increase)
- $d$ = Down factor (e.g., 0.90 for 10% decrease)
```

### Tree Diagram

```
              S₀u
             / f_u
        S₀
         f
             \ S₀d
              f_d

    t=0     t=T
```

---

## The Replicating Portfolio Approach

The key insight: We can replicate the option payoff using a portfolio of stock and bonds.

```{admonition} Key Concept: Replication
:class: tip

**Construct a portfolio:**
- Long $\Delta$ shares of stock
- Short 1 option

**Goal:** Make the portfolio riskless (same value in both states)

**Riskless condition:**

$$S_0u\Delta - f_u = S_0d\Delta - f_d$$

```

### Solving for Delta

```{important}
**Delta ($\Delta$) Formula:**

$$\Delta = \frac{f_u - f_d}{S_0u - S_0d}$$

**Interpretation:**
- $\Delta$ = Number of shares needed to replicate the option
- Also called the **hedge ratio**
- Measures option's sensitivity to stock price
```

**Physical Meaning**: Delta tells you how many shares perfectly hedge one option. If $\Delta = 0.5$, then holding 0.5 shares and shorting 1 call creates a riskless position.

---

## Deriving the Option Price

```{admonition} Valuation Steps
:class: note

**Step 1:** Portfolio value at maturity = $S_0u\Delta - f_u$

**Step 2:** Portfolio value today = $(S_0u\Delta - f_u)e^{-rT}$

**Step 3:** Alternative expression for portfolio value today = $S_0\Delta - f$

**Step 4:** Equate the two expressions:

$$S_0\Delta - f = (S_0u\Delta - f_u)e^{-rT}$$

**Step 5:** Solve for $f$:

$$f = S_0\Delta - (S_0u\Delta - f_u)e^{-rT}$$

```

### Risk-Neutral Probability

Substituting $\Delta = \frac{f_u - f_d}{S_0u - S_0d}$ and simplifying yields:

```{admonition} Key Formula: Option Price
:class: tip

$$f = [pf_u + (1-p)f_d]e^{-rT}$$

Where:

$$p = \frac{e^{rT} - d}{u - d}$$

**Key Insight:** $p$ is NOT the real probability of up/down movements! It's a mathematical construct called the **risk-neutral probability**.
```

---

## Risk-Neutral Valuation

```{admonition} Key Concept: Risk-Neutral Probability
:class: tip

The quantity $p = \frac{e^{rT} - d}{u - d}$ can be interpreted as a probability such that:

**The stock price earns the risk-free rate:**

$$S_0e^{rT} = pS_0u + (1-p)S_0d$$

**Proof:**

$$pS_0u + (1-p)S_0d = \frac{e^{rT} - d}{u - d} \cdot S_0u + \frac{u - e^{rT}}{u - d} \cdot S_0d$$

$$= \frac{S_0(ue^{rT} - ud + ud - de^{rT})}{u - d} = \frac{S_0e^{rT}(u - d)}{u - d} = S_0e^{rT}$$ ✓

```

```{important}
**The Risk-Neutral Valuation Principle:**

To value a derivative:
1. **Assume** expected return on underlying = risk-free rate
2. **Calculate** expected payoff of derivative
3. **Discount** at risk-free rate

**Powerful Insight:** The option value is independent of the stock's expected return! Only volatility matters.
```

**Physical Meaning**: In a "risk-neutral world," investors don't demand extra return for risk - all assets earn the risk-free rate. Options are priced as if we live in this hypothetical world, even though we don't. This works because the option and stock can be combined to create a riskless portfolio.

---

## Complete Example: Call Option Pricing

```{admonition} Example Problem: One-Step Binomial
:class: tip

**Problem Statement:**
A stock currently trades at $20. In 3 months, it will either:
- Increase to $22 (up move)
- Decrease to $18 (down move)

A 3-month call option has a strike price of $21. The risk-free rate is 4% per annum (continuously compounded).

**Questions:**
1. What is the option price?
2. What is the delta (hedge ratio)?
3. Verify the replicating portfolio.
```

```{dropdown} Solution

**Given:**
- $S_0 = \$20$
- $u = 1.10$ (since $22/20 = 1.10$)
- $d = 0.90$ (since $18/20 = 0.90$)
- $K = \$21$
- $r = 0.04$
- $T = 0.25$ years

**Step 1: Calculate Payoffs**

**If stock goes up to \$22:**

$$f_u = \max(22 - 21, 0) = \$1$$

**If stock goes down to \$18:**

$$f_d = \max(18 - 21, 0) = \$0$$

**Step 2: Calculate Delta**

$$\Delta = \frac{f_u - f_d}{S_0u - S_0d} = \frac{1 - 0}{22 - 18} = \frac{1}{4} = 0.25$$

**Step 3: Calculate Risk-Neutral Probability**

$$p = \frac{e^{rT} - d}{u - d} = \frac{e^{0.04 \times 0.25} - 0.90}{1.10 - 0.90}$$

$$= \frac{e^{0.01} - 0.90}{0.20} = \frac{1.0101 - 0.90}{0.20} = \frac{0.1101}{0.20} = 0.5503$$

**Step 4: Calculate Option Price**

$$f = [pf_u + (1-p)f_d]e^{-rT}$$

$$= [0.5503 \times 1 + 0.4497 \times 0]e^{-0.04 \times 0.25}$$

$$= 0.5503 \times e^{-0.01}$$

$$= 0.5503 \times 0.9900$$

$$= \$0.545$$

**Step 5: Verify Replicating Portfolio**

**Portfolio:** Long $\Delta = 0.25$ shares, short 1 call

**Value today:**

$$0.25 \times 20 - 0.545 = 5.00 - 0.545 = \$4.455$$

**Value if stock goes up:**

$$0.25 \times 22 - 1 = 5.50 - 1.00 = \$4.50$$

**Value if stock goes down:**

$$0.25 \times 18 - 0 = 4.50 - 0 = \$4.50$$

**Present value of \$4.50:**

$$4.50 \times e^{-0.01} = 4.50 \times 0.9900 = \$4.455$$ ✓

**Final Answers:**
1. Option price: \$0.545
2. Delta: **0.25**
3. Replicating portfolio: Long 0.25 shares, short 1 call, has riskless value of $4.50 at maturity

**Physical Meaning**: To hedge this call option, you need to hold 0.25 shares per option. The option is worth $0.545 because that's the cost (when combined with 0.25 shares) that creates a riskless position earning the risk-free rate.
```

---

## Alternative Valuation Using Replication

We can also value the option directly from the replicating portfolio:

```{admonition} Alternative Method
:class: note

**Riskless portfolio value at maturity:** $4.50

**Present value:** $4.50e^{-0.01} = \$4.455$

**Portfolio composition:** $0.25 \times 20 - f = 4.455$

**Solve for option price:**

$$5.00 - f = 4.455$$

$$f = \$0.545$$ ✓

**Same answer!**
```

---

## Irrelevance of Real Probabilities

A surprising and important result:

```{important}
**Real Probabilities Don't Matter!**

The option price does NOT depend on:
- The actual probability of up/down moves
- The stock's expected return
- Investors' risk preferences

**Only these matter:**
- Current stock price
- Possible future prices (volatility)
- Risk-free rate
- Time to expiration

**Why?** Because we're valuing the option in terms of the stock price, and they share the same source of uncertainty.
```

```{admonition} Example: Different Real Probabilities
:class: tip

Suppose the real probability of the stock going up is:
- Case A: 60%
- Case B: 50%
- Case C: 40%

**Question:** Does the option price change?

**Answer:** No! In all three cases, the option price is $0.545.

The real probability affects the stock's expected return, but the option price depends only on the range of possible outcomes (volatility), not the likelihood of each outcome.
```

**Physical Meaning**: This is like insurance pricing. Your home insurance premium doesn't depend on YOUR personal belief about fire probability - it depends on the insurance company's ability to hedge across many policies and the cost of that hedging.

---

## Multi-Period Binomial Model

The one-step model extends naturally to multiple periods.

```{admonition} Two-Step Binomial Tree
:class: tip

**Structure:**

```
                    S₀u²
                   /
              S₀u
             /     \ S₀ud
        S₀
             \     / S₀ud
              S₀d
                   \ S₀d²

    t=0    t=Δt   t=2Δt
```

**Valuation:**
1. Calculate payoffs at final nodes
2. Work backward, applying risk-neutral valuation at each node
3. Value at each node = $[p \times \text{up value} + (1-p) \times \text{down value}]e^{-r\Delta t}$
```

---

## Choosing the Parameters: The CRR Model

Cox, Ross, and Rubinstein (1979) proposed a method to match volatility:

```{admonition} Key Formula: CRR Binomial Parameters
:class: tip

To match volatility $\sigma$:

$$u = e^{\sigma\sqrt{\Delta t}}$$

$$d = e^{-\sigma\sqrt{\Delta t}} = \frac{1}{u}$$

Where:
- $\sigma$ = Annual volatility of stock
- $\Delta t$ = Length of time step

**Risk-neutral probability:**

$$p = \frac{e^{r\Delta t} - d}{u - d}$$

```

```{admonition} Example: CRR Parameters
:class: tip

**Given:**
- Stock volatility: $\sigma = 30\%$ per annum
- Time step: $\Delta t = 1$ month $= 1/12$ year
- Risk-free rate: $r = 5\%$ per annum

**Calculate binomial parameters:**
```

```{dropdown} Solution

**Step 1: Calculate Up Factor**

$$u = e^{\sigma\sqrt{\Delta t}} = e^{0.30 \times \sqrt{1/12}}$$

$$= e^{0.30 \times 0.2887} = e^{0.08660}$$

$$= 1.0905$$

**Step 2: Calculate Down Factor**

$$d = \frac{1}{u} = \frac{1}{1.0905} = 0.9170$$

**Step 3: Calculate Risk-Neutral Probability**

$$p = \frac{e^{r\Delta t} - d}{u - d}$$

$$= \frac{e^{0.05 \times 1/12} - 0.9170}{1.0905 - 0.9170}$$

$$= \frac{e^{0.004167} - 0.9170}{0.1735}$$

$$= \frac{1.0042 - 0.9170}{0.1735} = \frac{0.0872}{0.1735}$$

$$= 0.5026$$

**Final Answer:**
- Up factor: **1.0905** (9.05% increase)
- Down factor: **0.9170** (8.30% decrease)
- Risk-neutral probability: **0.5026**

**Interpretation**: With 30% annual volatility, in one month the stock can increase by ~9% or decrease by ~8%, with the risk-neutral probability of increase being about 50%.
```

---

## Delta and Hedging

The hedge ratio changes as we move through the tree.

```{admonition} Key Concept: Dynamic Delta
:class: tip

**Delta at each node:**

$$\Delta = \frac{f_u - f_d}{S_u - S_d}$$

Where $f_u$, $f_d$ are option values at up and down nodes from current position.

**Key Insight:** Delta changes over time and with stock price. The portfolio must be **rebalanced** at each time step to remain risk-neutral.
```

**Physical Meaning**: Delta hedging isn't "set it and forget it." As the stock price and time change, the hedge ratio changes. A trader must continuously adjust their position - buying shares when the stock rises, selling when it falls.

---

## Girsanov's Theorem

A deep theoretical result underlies risk-neutral valuation:

```{admonition} Key Concept: Girsanov's Theorem
:class: important

**Key Insight:**

**Volatility is the same in the real world and the risk-neutral world.**

**Implications:**
1. We can measure volatility from historical data (real world)
2. Use that volatility in risk-neutral pricing (risk-neutral world)
3. This "change of measure" is valid

**Why it works:**
- Volatility is about the magnitude of randomness
- Risk preference affects expected return (drift)
- But risk preference doesn't change magnitude of fluctuations
```

**Physical Meaning**: Think of volatility like the size of ocean waves. Whether you're risk-averse or risk-seeking doesn't change how big the waves are - it only changes whether you're willing to ride them.

---

## American Options and the Binomial Model

```{important}
**Why Binomial Model is Practical:**

For **American options** (can exercise early):
- No closed-form formula exists (unlike European options)
- Binomial model handles early exercise naturally
- At each node, compare:
  - **Hold value**: Continue with risk-neutral valuation
  - **Exercise value**: Immediate payoff from exercising
  - Take the maximum

**Algorithm:**
1. Work backward from expiration
2. At each node: $f = \max(\text{Exercise value}, \text{Hold value})$
3. If exercise value > hold value, early exercise is optimal
```

---

## Convergence to Black-Scholes

```{note}
**As time steps become smaller ($\Delta t \to 0$):**

- Binomial model converges to Black-Scholes-Merton model
- Discrete random walk → Continuous geometric Brownian motion
- Risk-neutral valuation principle remains the same

**Practical Usage:**
- Typically use 30-100 time steps for accuracy
- More steps = more accurate but slower
- Trade-off between speed and precision
```

---

## Chapter Summary

```{important}
**Key Takeaways:**

1. **Binomial model** assumes asset prices follow discrete up/down movements
2. **Replicating portfolio** of stock and bonds can hedge derivative
3. **Delta** ($\Delta$) is the hedge ratio: $\Delta = \frac{f_u - f_d}{S_0u - S_0d}$
4. **Risk-neutral valuation**: Price derivatives as if expected returns equal risk-free rate
5. **Risk-neutral probability** $p = \frac{e^{rT} - d}{u - d}$ makes stock earn risk-free rate
6. **Real probabilities are irrelevant** - only volatility matters
7. **CRR parameters**: $u = e^{\sigma\sqrt{\Delta t}}$, $d = 1/u$ match volatility
8. **Delta changes** over time - requires dynamic hedging
9. **Girsanov's theorem**: Volatility same in real and risk-neutral worlds
10. **Multi-step trees** value complex derivatives including American options
11. **Convergence**: Binomial → Black-Scholes as $\Delta t \to 0$
```

```{seealso}
**Looking Ahead:**

Chapter 7 explores **stochastic processes**, providing the continuous-time foundation for option pricing models like Black-Scholes-Merton.
```

---

## Practice Problems

```{admonition} Practice Problem 1: Put Option Pricing
:class: tip

A stock currently trades at $50. Over the next 6 months, it will either:
- Increase to $60
- Decrease to $40

A 6-month European put option has a strike price of $48. The risk-free rate is 5% per annum (continuously compounded).

**Questions:**
1. Calculate the put option's delta
2. Calculate the put option's price
3. Describe the replicating portfolio
4. Verify that risk-neutral probability makes the stock earn the risk-free rate
```

```{dropdown} Solution to Practice Problem 1

**Given:**
- $S_0 = \$50$
- $S_u = \$60$, $u = 1.20$
- $S_d = \$40$, $d = 0.80$
- $K = \$48$
- $r = 0.05$
- $T = 0.5$ years

**Part 1: Calculate Put Payoffs**

**If stock goes up to \$60:**

$$f_u = \max(48 - 60, 0) = \$0$$

**If stock goes down to \$40:**

$$f_d = \max(48 - 40, 0) = \$8$$

**Part 2: Calculate Delta**

$$\Delta = \frac{f_u - f_d}{S_u - S_d} = \frac{0 - 8}{60 - 40} = \frac{-8}{20} = -0.40$$

**Interpretation**: Negative delta for put (as expected - puts gain when stock falls)

**Part 3: Calculate Risk-Neutral Probability**

$$p = \frac{e^{rT} - d}{u - d} = \frac{e^{0.05 \times 0.5} - 0.80}{1.20 - 0.80}$$

$$= \frac{e^{0.025} - 0.80}{0.40} = \frac{1.0253 - 0.80}{0.40} = \frac{0.2253}{0.40} = 0.5633$$

**Part 4: Calculate Put Price**

$$f = [pf_u + (1-p)f_d]e^{-rT}$$

$$= [0.5633 \times 0 + 0.4367 \times 8]e^{-0.025}$$

$$= 3.494 \times 0.9753$$

$$= \$3.41$$

**Part 5: Replicating Portfolio**

**Portfolio:** Long $\Delta = -0.40$ shares (i.e., short 0.40 shares), short 1 put

**Value today:**

$$-0.40 \times 50 - 3.41 = -20.00 - 3.41 = -\$23.41$$

Or: Short 0.40 shares, long 1 put:

$$0.40 \times 50 - 3.41 = 20.00 - 3.41 = \$16.59$$

**Value if stock goes up:**

$$0.40 \times 60 - 0 = \$24.00$$

**Value if stock goes down:**

$$0.40 \times 40 - 8 = 16.00 - 8 = \$24.00$$

Wait, let me recalculate. For a put, the replicating portfolio should be:

Actually, let's verify: Portfolio is long $\Delta$ shares, short 1 put.
With $\Delta = -0.40$, we're short 0.40 shares, short 1 put.

Up state: $-0.40 \times 60 - 0 = -24$
Down state: $-0.40 \times 40 - 8 = -16 - 8 = -24$ ✓

PV: $-24 \times e^{-0.025} = -24 \times 0.9753 = -\$23.41$
Today: $-0.40 \times 50 - p = -20 - p = -23.41$
Therefore: $p = \$3.41$ ✓

**Part 6: Verify Risk-Neutral Valuation**

Expected stock price in risk-neutral world:

$$E[S_T] = p \times 60 + (1-p) \times 40$$

$$= 0.5633 \times 60 + 0.4367 \times 40$$

$$= 33.80 + 17.47 = \$51.27$$

Under risk-free growth:

$$S_0 e^{rT} = 50 \times e^{0.025} = 50 \times 1.0253 = \$51.27$$ ✓

**Final Answers:**
1. Delta: **-0.40** (negative for put)
2. Put price: \$3.41
3. Replicating portfolio: **Short 0.40 shares and short 1 put** (or equivalently, long 0.40 shares and long 1 put creates opposite position)
4. Risk-neutral probability (0.5633) makes expected stock price equal $S_0e^{rT}$ ✓
```

---
