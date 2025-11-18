---
title: "Chapter 8: The Black-Scholes-Merton Model"
author: "Based on John C. Hull"
date: "2025"
---

# The Black-Scholes-Merton Model

This chapter develops the Black-Scholes-Merton option pricing model, one of the most important breakthroughs in financial economics. We'll derive the famous formula and explore its interpretation through risk-neutral valuation.

## Introduction

```{admonition} Historical Context
:class: note

**1973: A Revolution in Finance**

Fischer Black, Myron Scholes, and Robert Merton independently derived a closed-form solution for European option prices.

**Impact:**
- Enabled rapid growth of options markets
- Led to 1997 Nobel Prize in Economics (Merton & Scholes)
- Foundation of modern derivatives pricing
- One of the most influential formulas in finance

**Key Insight:** Options can be hedged using the underlying asset, allowing pricing without knowing the stock's expected return.
```

---

## The Concepts Underlying Black-Scholes-Merton

The BSM model rests on three fundamental ideas:

```{admonition} Key Concept: Three Pillars of BSM
:class: tip

**1. Common Source of Uncertainty**
- Option price and stock price driven by same random shocks
- Both depend on future stock price movements

**2. Riskless Portfolio Construction**
- Can form portfolio of stock + option that eliminates randomness
- Portfolio contains specific number of shares + options

**3. No-Arbitrage Condition**
- Riskless portfolio must earn risk-free rate
- Otherwise, arbitrage opportunity exists
- This condition determines option price
```

**Physical Meaning**: Imagine two boats (stock and option) in the same sea. The waves (randomness) affect both. By tying them together in the right proportion, you can create a stable raft that doesn't rock with the waves. This stable raft must earn the safe return, or free money exists.

---

## Setting Up the Model

```{admonition} Model Assumptions
:class: important

**Stock Price Process:**

$$dS = \mu S \, dt + \sigma S \, dz$$

**Option Value:**
- $f = f(S, t)$ depends on stock price $S$ and time $t$
- Follows some stochastic process (to be determined)

**By Itô's Lemma:**

$$df = \left(\frac{\partial f}{\partial S}\mu S + \frac{\partial f}{\partial t} + \frac{1}{2}\frac{\partial^2 f}{\partial S^2}\sigma^2 S^2\right)dt + \frac{\partial f}{\partial S}\sigma S \, dz$$

```

---

## Constructing the Riskless Portfolio

```{admonition} The Delta-Hedged Portfolio
:class: tip

**Portfolio Composition:**
- **Long** $\Delta$ shares of stock
- **Short** 1 option

Where $\Delta = \frac{\partial f}{\partial S}$ (we'll see why shortly)

**Portfolio Value:**

$$\Pi = \Delta S - f$$

**Change in Portfolio Value:**

$$d\Pi = \Delta \, dS - df$$

```

### Eliminating Randomness

```{note}
**Substituting the stochastic processes:**

$$d\Pi = \Delta(\mu S \, dt + \sigma S \, dz) - \left[\left(\frac{\partial f}{\partial S}\mu S + \frac{\partial f}{\partial t} + \frac{1}{2}\frac{\partial^2 f}{\partial S^2}\sigma^2 S^2\right)dt + \frac{\partial f}{\partial S}\sigma S \, dz\right]$$

**The $dz$ terms:**

$$\Delta \sigma S \, dz - \frac{\partial f}{\partial S}\sigma S \, dz$$

**Choose $\Delta = \frac{\partial f}{\partial S}$ to eliminate randomness!**

The $dz$ terms cancel, leaving only $dt$ terms.
```

**Physical Meaning**: By holding exactly $\frac{\partial f}{\partial S}$ shares per option, the random component cancels out. When the stock goes up by $dS$, the gain on shares exactly offsets the loss on the short option (over infinitesimal time).

---

## The Black-Scholes-Merton Differential Equation

After setting $\Delta = \frac{\partial f}{\partial S}$, the portfolio change becomes:

$$d\Pi = \left(-\frac{\partial f}{\partial t} - \frac{1}{2}\frac{\partial^2 f}{\partial S^2}\sigma^2 S^2\right)dt$$

This is riskless! Therefore, it must earn the risk-free rate:

$$d\Pi = r\Pi \, dt$$

Where $\Pi = \frac{\partial f}{\partial S} S - f$

```{admonition} Key Result: The Black-Scholes-Merton Differential Equation
:class: important

$$\frac{\partial f}{\partial t} + rS\frac{\partial f}{\partial S} + \frac{1}{2}\sigma^2 S^2 \frac{\partial^2 f}{\partial S^2} = rf$$

**This partial differential equation must be satisfied by any derivative on a non-dividend-paying stock.**

**Boundary Conditions:**
- For European call: $f(S,T) = \max(S-K, 0)$
- For European put: $f(S,T) = \max(K-S, 0)$
```

### Key Observation

```{important}
**The Stock's Expected Return ($\mu$) Does Not Appear!**

The BSM differential equation is **independent of** $\mu$.

**Why?**
- The option is priced relative to the stock
- Both respond to the same shocks
- The hedge eliminates exposure to expected return
- Only volatility $\sigma$ matters

**Implication:** Risk preferences don't affect option prices!
```

**Physical Meaning**: Whether the stock is expected to return 5%, 10%, or 15% doesn't matter for option pricing. The option moves with the stock, so their relative pricing depends only on the magnitude of fluctuations (volatility), not the direction of drift.

---

## The Black-Scholes-Merton Formulas

Solving the BSM differential equation with appropriate boundary conditions yields:

```{admonition} The Black-Scholes-Merton Formulas
:class: tip

**European Call:**

$$c = S_0 N(d_1) - Ke^{-rT}N(d_2)$$

**European Put:**

$$p = Ke^{-rT}N(-d_2) - S_0 N(-d_1)$$

Where:

$$d_1 = \frac{\ln(S_0/K) + (r + \sigma^2/2)T}{\sigma\sqrt{T}}$$

$$d_2 = d_1 - \sigma\sqrt{T} = \frac{\ln(S_0/K) + (r - \sigma^2/2)T}{\sigma\sqrt{T}}$$

And:
- $S_0$ = Current stock price
- $K$ = Strike price
- $r$ = Risk-free rate (continuously compounded)
- $T$ = Time to expiration (years)
- $\sigma$ = Volatility (annualized)
- $N(x)$ = Cumulative standard normal distribution function
```

---

## Understanding the Black-Scholes Formula

The formula has an elegant interpretation:

```{admonition} Interpretation of the Call Formula
:class: tip

$$c = S_0 N(d_1) - Ke^{-rT}N(d_2)$$

**$S_0 N(d_1)$:**
- Expected stock price at expiration (in risk-neutral world)
- IF the option is exercised
- Weighted by probability of exercise

**$Ke^{-rT}N(d_2)$:**
- Present value of strike price
- Weighted by probability of exercise

**$N(d_2)$:**
- Risk-neutral probability of exercise
- $P(\text{Stock Price} > K \text{ at expiration})$

**$N(d_1)$:**
- Adjustment factor for conditional expectation
- Accounts for distribution of stock price
```

### Alternative Interpretation

$$c = e^{-rT}[S_0 e^{rT} N(d_1) - K N(d_2)]$$

```{note}
**Expected Payoff Interpretation:**

**$S_0 e^{rT} N(d_1)$:**
- Expected stock price at expiration (if exercised)
- In risk-neutral world

**$K N(d_2)$:**
- Strike price paid (if exercised)

**$N(d_2)$:**
- Risk-neutral probability of exercise

**$e^{-rT}[\cdots]$:**
- Present value factor
```

**Physical Meaning**: The call is worth the expected payoff (stock minus strike) in a risk-neutral world, discounted back at the risk-free rate, considering only scenarios where exercise occurs.

---

## Example: Calculating Option Prices

```{admonition} Example Problem: BSM Calculation
:class: tip

**Problem Statement:**
Calculate the price of a European call option with the following parameters:

- Current stock price: $S_0 = \$50$
- Strike price: $K = \$48$
- Time to expiration: $T = 6$ months $= 0.5$ years
- Risk-free rate: $r = 5\%$ per annum
- Volatility: $\sigma = 30\%$ per annum

**Questions:**
1. Calculate $d_1$ and $d_2$
2. Find $N(d_1)$ and $N(d_2)$
3. Calculate the call option price
4. Calculate the put option price (using put-call parity)
```

```{dropdown} Solution

**Step 1: Calculate $d_1$**

$$d_1 = \frac{\ln(S_0/K) + (r + \sigma^2/2)T}{\sigma\sqrt{T}}$$

$$= \frac{\ln(50/48) + (0.05 + 0.30^2/2) \times 0.5}{0.30\sqrt{0.5}}$$

$$= \frac{\ln(1.0417) + (0.05 + 0.045) \times 0.5}{0.30 \times 0.7071}$$

$$= \frac{0.04082 + 0.0475}{0.2121}$$

$$= \frac{0.08832}{0.2121} = 0.4164$$

**Step 2: Calculate $d_2$**

$$d_2 = d_1 - \sigma\sqrt{T}$$

$$= 0.4164 - 0.30 \times 0.7071$$

$$= 0.4164 - 0.2121 = 0.2043$$

**Step 3: Find $N(d_1)$ and $N(d_2)$**

Using standard normal tables or calculator:

$$N(0.4164) = 0.6615$$

$$N(0.2043) = 0.5809$$

**Step 4: Calculate Call Price**

$$c = S_0 N(d_1) - Ke^{-rT}N(d_2)$$

$$= 50 \times 0.6615 - 48 \times e^{-0.05 \times 0.5} \times 0.5809$$

$$= 33.075 - 48 \times 0.9753 \times 0.5809$$

$$= 33.075 - 27.189$$

$$= \$5.89$$

**Step 5: Calculate Put Price Using Put-Call Parity**

$$p = c - S_0 + Ke^{-rT}$$

$$= 5.89 - 50 + 48 \times 0.9753$$

$$= 5.89 - 50 + 46.814$$

$$= \$2.70$$

**Alternative: Direct Put Formula**

$$p = Ke^{-rT}N(-d_2) - S_0 N(-d_1)$$

Where:
- $N(-d_2) = 1 - N(d_2) = 1 - 0.5809 = 0.4191$
- $N(-d_1) = 1 - N(d_1) = 1 - 0.6615 = 0.3385$

$$p = 48 \times 0.9753 \times 0.4191 - 50 \times 0.3385$$

$$= 19.621 - 16.925 = \$2.70$$

**Final Answers:**
1. $d_1 = 0.4164$, $d_2 = 0.2043$
2. $N(d_1) = 0.6615$, $N(d_2) = 0.5809$
3. Call price: \$5.89
4. Put price: \$2.70

**Interpretation:**
- The call is in-the-money (stock > strike) and has significant value
- The put is out-of-the-money but has time value
- $N(d_2) = 0.5809$ means ~58% risk-neutral probability of call ending in-the-money
```

---

## Risk-Neutral Valuation

An alternative derivation provides deep insight:

```{admonition} Key Principle: Risk-Neutral Valuation
:class: important

**To price any derivative:**

1. **Assume** the expected return on the underlying asset equals the risk-free rate
2. **Calculate** the expected payoff of the derivative
3. **Discount** this expected payoff at the risk-free rate

**Why This Works:**

The BSM differential equation is independent of $\mu$. Its solution is therefore the same in:
- The real world (with actual expected return $\mu$)
- A hypothetical "risk-neutral world" (where expected return is $r$)

Since we get the same answer, we might as well use the simpler risk-neutral world!
```

**Physical Meaning**: It's like converting temperature between Fahrenheit and Celsius. The actual temperature doesn't change, but Celsius might be more convenient for calculations. Similarly, risk-neutral valuation is a convenient "unit" for pricing - it gives the right answer more easily.

---

## Deriving BSM Using Risk-Neutral Valuation

```{admonition} Alternative Derivation
:class: note

**Step 1: In Risk-Neutral World**

Stock price at time $T$ is lognormally distributed:

$$\ln S_T \sim N\left(\ln S_0 + \left(r - \frac{\sigma^2}{2}\right)T, \sigma^2 T\right)$$

**Step 2: Expected Call Payoff**

$$c = e^{-rT} E[\max(S_T - K, 0)]$$

$$= e^{-rT} \int_K^{\infty} (S_T - K) g(S_T) \, dS_T$$

Where $g(S_T)$ is the risk-neutral probability density function of $S_T$.

**Step 3: Change of Variables**

Let $Q = \frac{\ln(S_T/S_0) - (r - \sigma^2/2)T}{\sigma\sqrt{T}}$

Then $Q \sim N(0,1)$ and $S_T = S_0 e^{(r-\sigma^2/2)T + \sigma\sqrt{T}Q}$

**Step 4: Evaluate the Integral**

After considerable algebra (involving properties of lognormal distributions):

$$c = S_0 N(d_1) - Ke^{-rT}N(d_2)$$

**This is the Black-Scholes formula!**
```

### Intuitive Risk-Neutral Formula

```{note}
**Simplified Intuition:**

$$c = e^{-rT}[E^Q[S_T | S_T > K] \cdot P^Q(S_T > K) - K \cdot P^Q(S_T > K)]$$

Where $E^Q$ and $P^Q$ denote expectation and probability in risk-neutral measure.

**Components:**
- $P^Q(S_T > K) = N(d_2)$: Probability of exercise
- $E^Q[S_T | S_T > K] = S_0 e^{rT} \frac{N(d_1)}{N(d_2)}$: Conditional expected stock price
```

---

## Why BSM Works: The Deep Insight

```{important}
**The Fundamental Theorem of Asset Pricing**

**Key Insight:**

Any derivative whose payoff depends only on the price of a traded asset can be replicated by dynamically trading that asset.

**Implications:**

1. **Replication means no arbitrage**: The derivative price must equal replication cost
2. **Replication doesn't depend on expected return**: Only on volatility
3. **Equivalent to risk-neutral pricing**: Expecting risk-free return is mathematically equivalent to perfect replication

**In one sentence:** Because we can hedge perfectly (in the continuous-time limit), the option price is determined by no-arbitrage, not by risk preferences.
```

**Physical Meaning**: If you can perfectly replicate an asset using other assets, then its price must equal the cost of replication - otherwise you could buy the cheap one and sell the expensive one for free money. BSM shows options can be replicated, so their prices are determined.

---

## Properties of the Black-Scholes Formula

```{note}
**Key Properties:**

**1. Homogeneity:**
- If you double $S_0$ and $K$, you double the option price
- Scaling property

**2. Put-Call Parity:**
- $c - p = S_0 - Ke^{-rT}$
- Put and call prices linked

**3. Limiting Cases:**
- As $\sigma \to 0$: $c \to \max(S_0 - Ke^{-rT}, 0)$ (intrinsic value)
- As $\sigma \to \infty$: $c \to S_0$ (option becomes stock)
- As $T \to 0$: $c \to \max(S_0 - K, 0)$ (immediate payoff)

**4. Monotonicity:**
- Call price increases with $S_0$, $T$, $\sigma$, $r$
- Call price decreases with $K$
```

---

## Implied Volatility

```{admonition} Key Concept: Implied Volatility
:class: tip

**Implied volatility** is the volatility that makes the BSM price equal to the observed market price.

**Process:**
1. Observe market price of option
2. Solve BSM formula for $\sigma$ (numerically)
3. This $\sigma$ is the implied volatility

**Interpretation:**
- Market's consensus forecast of future volatility
- Forward-looking (historical volatility is backward-looking)
- Used to quote options in practice
```

**Physical Meaning**: Instead of quoting options in dollars, traders quote them in "vol." For example, "That call is trading at 25 vol" means the implied volatility is 25%. This is more informative because it abstracts from strike, maturity, and stock price level.

---

## Extensions of Black-Scholes

```{note}
**BSM with Dividends:**

For stock paying continuous dividend yield $q$:

$$c = S_0 e^{-qT} N(d_1) - Ke^{-rT}N(d_2)$$

Where:

$$d_1 = \frac{\ln(S_0/K) + (r - q + \sigma^2/2)T}{\sigma\sqrt{T}}$$

$$d_2 = d_1 - \sigma\sqrt{T}$$

**Other Extensions:**
- Currency options: Replace $q$ with foreign interest rate $r_f$
- Commodity options: Include convenience yield
- Futures options: Different formulas (Black's model)
```

---

## Limitations of Black-Scholes

```{warning}
**Model Limitations:**

**Assumptions that may not hold:**

1. **Constant volatility**: Real volatility changes over time (stochastic volatility)
2. **Lognormal returns**: Real returns have fatter tails (jumps, crashes)
3. **Continuous trading**: Markets close; large moves happen
4. **No transaction costs**: Reality has bid-ask spreads
5. **Known volatility**: Must estimate, introduces error
6. **Constant risk-free rate**: Rates change over time

**Practical Implications:**
- BSM gives starting point, not final answer
- Traders adjust for model deficiencies
- More sophisticated models address some issues
- Implied volatility smile indicates model mis specification
```

---

## Chapter Summary

```{important}
**Key Takeaways:**

1. **BSM model** prices European options using no-arbitrage principle
2. **Three key ideas**: Common uncertainty source, riskless hedging, no-arbitrage
3. **BSM differential equation**: $\frac{\partial f}{\partial t} + rS\frac{\partial f}{\partial S} + \frac{1}{2}\sigma^2 S^2 \frac{\partial^2 f}{\partial S^2} = rf$
4. **Independence of $\mu$**: Expected return doesn't affect option prices
5. **Call formula**: $c = S_0 N(d_1) - Ke^{-rT}N(d_2)$
6. **Put formula**: $p = Ke^{-rT}N(-d_2) - S_0 N(-d_1)$
7. **$N(d_2)$** is risk-neutral probability of exercise
8. **Risk-neutral valuation**: Price as expected payoff discounting at $r$
9. **Volatility is crucial**: Only parameter requiring estimation
10. **Implied volatility**: Market's forecast extracted from option prices
11. **Practical tool**: Foundation for modern options trading
12. **Has limitations**: Real markets violate some assumptions
```

```{seealso}
**Looking Ahead:**

Chapter 9 explores **The Greeks**, which measure how option prices change with various parameters, essential for risk management and trading.
```

---

## Practice Problems

```{admonition} Practice Problem 1: Computing Option Prices
:class: tip

A stock trades at \$75. A 3-month European call option has a strike of \$72. The risk-free rate is 4% per annum and volatility is 35% per annum.

**Questions:**
1. Calculate the call option price
2. Calculate the put option price
3. What is the probability (in the risk-neutral world) that the call will be exercised?
4. If the call trades at $6.50 in the market, what is the implied volatility?
```

```{dropdown} Solution to Practice Problem 1

**Given:**
- $S_0 = 75$
- $K = 72$
- $T = 0.25$ years
- $r = 0.04$
- $\sigma = 0.35$

**Part 1: Calculate Call Price**

**Step 1: Calculate $d_1$**

$$d_1 = \frac{\ln(75/72) + (0.04 + 0.35^2/2) \times 0.25}{0.35\sqrt{0.25}}$$

$$= \frac{\ln(1.0417) + (0.04 + 0.06125) \times 0.25}{0.35 \times 0.5}$$

$$= \frac{0.04082 + 0.02531}{0.175}$$

$$= \frac{0.06613}{0.175} = 0.3779$$

**Step 2: Calculate $d_2$**

$$d_2 = 0.3779 - 0.175 = 0.2029$$

**Step 3: Find $N(d_1)$ and $N(d_2)$**

$$N(0.3779) = 0.6473$$

$$N(0.2029) = 0.5804$$

**Step 4: Calculate Call Price**

$$c = 75 \times 0.6473 - 72 \times e^{-0.04 \times 0.25} \times 0.5804$$

$$= 48.548 - 72 \times 0.9900 \times 0.5804$$

$$= 48.548 - 41.365$$

$$= \$7.18$$

**Part 2: Calculate Put Price**

$$p = c - S_0 + Ke^{-rT}$$

$$= 7.18 - 75 + 72 \times 0.9900$$

$$= 7.18 - 75 + 71.28$$

$$= \$3.46$$

**Verification using put formula:**

$$p = 72 \times 0.9900 \times (1-0.5804) - 75 \times (1-0.6473)$$

$$= 71.28 \times 0.4196 - 75 \times 0.3527$$

$$= 29.901 - 26.453 = \$3.45$$ (small rounding difference)

**Part 3: Probability of Exercise**

$$P(\text{Exercise}) = N(d_2) = 0.5804 = 58.04\%$$

**Part 4: Implied Volatility (if market price is \$6.50)**

If market price is \$6.50 instead of theoretical \$7.18, we need to find $\sigma_{implied}$ such that BSM formula gives \$6.50.

Since market price (\$6.50) < theoretical price at 35% vol (\$7.18), implied volatility must be lower than 35%.

**Trial and error (or numerical solver):**

Try $\sigma = 0.30$ (30%):
- $d_1 = 0.4593$, $d_2 = 0.3093$
- $N(d_1) = 0.6770$, $N(d_2) = 0.6215$
- $c = 75 \times 0.6770 - 71.28 \times 0.6215 = 50.775 - 44.291 = \$6.48$

**Final Answers:**
1. Call price: \$7.18 (at 35% vol)
2. Put price: \$3.46
3. Probability of exercise: **58.04%**
4. Implied volatility: **≈30%** (if market price is \$6.50)

**Interpretation**: The call is in-the-money (\$75 > \$72) and has significant value. There's a 58% chance (in risk-neutral world) it ends in-the-money. If the market prices it at \$6.50, the implied volatility is about 30%, suggesting the market expects lower volatility than the 35% assumption.
```

---
