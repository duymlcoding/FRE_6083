---
title: "Chapter 7: Stochastic Processes and Brownian Motion"
author: "Based on John C. Hull"
date: "2025"
---

# Stochastic Processes and Brownian Motion

This chapter develops the continuous-time mathematics underlying modern option pricing theory. We'll explore Markov processes, Wiener processes (Brownian motion), Itô's lemma, and the geometric Brownian motion model for stock prices.

## Markov Processes

```{admonition} Key Concept: Markov Process
:class: tip

A **Markov process** is a stochastic process where only the current value of a variable is relevant for predicting the future - the history doesn't matter.

**Formally:**

$$P(X_{t+s} | X_t, X_{t-1}, \ldots, X_0) = P(X_{t+s} | X_t)$$

**Key Property:** The future is independent of the past, given the present.
```

```{note}
**Assumption in Finance:**

**Stock prices are assumed to follow a Markov process.**

**Implications:**
- Past price history doesn't help predict future changes (beyond current price)
- Supports weak-form market efficiency
- Simplifies mathematical modeling
- Only need to track current price, not full history
```

**Physical Meaning**: Markov property says that "the stock price knows everything about where it's been." All relevant information from the past is embedded in today's price, so the path taken to reach today doesn't matter for predicting tomorrow.

---

## A Simple Markov Example

```{admonition} Example Problem: Understanding Variance Additivity
:class: tip

Consider a variable $x$ where:
- Change in $x$ over 1 year follows $N(0, 1)$ (normal with mean 0, variance 1)
- Changes in successive periods are independent

**Questions:**
1. What is the distribution of the change in $x$ over 2 years?
2. What about over 1/2 year?
3. What about over $\Delta t$ years?
```

```{dropdown} Solution

**Part 1: Change Over 2 Years**

Let $\Delta x_1$ = change in year 1, $\Delta x_2$ = change in year 2

- $\Delta x_1 \sim N(0, 1)$
- $\Delta x_2 \sim N(0, 1)$
- Independent

Total change: $\Delta x_{total} = \Delta x_1 + \Delta x_2$

**Mean:** $E[\Delta x_{total}] = 0 + 0 = 0$

**Variance (KEY INSIGHT - variances add for independent variables):**

$$\text{Var}[\Delta x_{total}] = \text{Var}[\Delta x_1] + \text{Var}[\Delta x_2] = 1 + 1 = 2$$

**Distribution:** $\Delta x_{total} \sim N(0, 2)$

**Part 2: Change Over 1/2 Year**

Think backward: Two half-year periods make one year.

If each half-year has variance $v$, then:

$$v + v = 1$$

$$v = 0.5$$

**Distribution:** $\Delta x_{1/2\text{-year}} \sim N(0, 0.5)$

**Part 3: Change Over $\Delta t$ Years**

By the same logic:

$$\text{Var}[\Delta x(\Delta t)] = \Delta t$$

**Distribution:** $\Delta x(\Delta t) \sim N(0, \Delta t)$

**Final Answer:**
1. 2 years: $N(0, 2)$
2. 1/2 year: $N(0, 0.5)$
3. $\Delta t$ years: $N(0, \Delta t)$

**Key Insight:** **Standard deviation grows with the square root of time**: $\sigma(\Delta t) = \sqrt{\Delta t}$
```

### Variance vs. Standard Deviation

```{important}
**Critical Distinction:**

**Variances are additive:**

$$\text{Var}(X + Y) = \text{Var}(X) + \text{Var}(Y)$$ (if independent)

**Standard deviations are NOT additive:**

$$\sigma(X + Y) \neq \sigma(X) + \sigma(Y)$$

**Instead:**

$$\sigma(X + Y) = \sqrt{\sigma^2(X) + \sigma^2(Y)}$$

**For time scaling:**
- Variance over time $T$: $\sigma^2 T$
- Standard deviation over time $T$: $\sigma\sqrt{T}$
```

**Physical Meaning**: Imagine flipping coins. After 100 flips, you expect to be about $\sqrt{100} = 10$ flips away from 50-50, not 100 flips away. Randomness accumulates with the square root of time, not linearly.

---

## Wiener Process (Brownian Motion)

The Wiener process is the continuous-time limit of a random walk.

```{admonition} Key Concept: Wiener Process
:class: tip

A **Wiener process** (or **Brownian motion**) $z(t)$ is a Markov process with:

1. **Mean rate of change**: Zero
2. **Variance rate**: 1 per unit time
3. **Independent increments**: Non-overlapping periods are independent
4. **Continuous paths**: $z(t)$ is continuous (though not differentiable)

**Notation:** Changes denoted $dz$
```

### Properties of a Wiener Process

```{important}
**Key Properties:**

**Over small time interval $\Delta t$:**

$$\Delta z = \epsilon \sqrt{\Delta t}$$

Where $\epsilon \sim N(0, 1)$ (standard normal random variable)

**Equivalently:**

$$\Delta z \sim N(0, \Delta t)$$

**Over finite time $T$:**

$$z(T) - z(0) \sim N(0, T)$$

**Mean:** $E[z(T) - z(0)] = 0$
**Variance:** $\text{Var}[z(T) - z(0)] = T$
**Standard Deviation:** $\sigma[z(T) - z(0)] = \sqrt{T}$
```

```{admonition} Example: Simulating Wiener Process
:class: tip

Simulate a Wiener process over 1 year using monthly steps ($\Delta t = 1/12$).

**Process:**
1. Start at $z(0) = 0$
2. Each month, add $\epsilon \sqrt{1/12}$ where $\epsilon \sim N(0,1)$
3. Continue for 12 months
```

```{dropdown} Example Simulation

| Month | $\epsilon$ | $\Delta z = \epsilon\sqrt{1/12}$ | $z(t)$ |
|-------|-----------|----------------------------------|--------|
| 0 | - | - | 0.000 |
| 1 | 0.5 | 0.144 | 0.144 |
| 2 | -0.8 | -0.231 | -0.087 |
| 3 | 1.2 | 0.346 | 0.259 |
| 4 | -0.3 | -0.087 | 0.172 |
| 5 | 0.7 | 0.202 | 0.374 |
| 6 | -1.1 | -0.318 | 0.056 |
| 7 | 0.4 | 0.115 | 0.171 |
| 8 | -0.6 | -0.173 | -0.002 |
| 9 | 0.9 | 0.260 | 0.258 |
| 10 | -0.2 | -0.058 | 0.200 |
| 11 | 0.5 | 0.144 | 0.344 |
| 12 | 0.8 | 0.231 | 0.575 |

**Final value:** $z(1) = 0.575$

**Note:** This is one realization. If repeated, would get different path. The distribution of $z(1)$ is $N(0, 1)$.
```

**Physical Meaning**: Brownian motion describes the erratic movement of a particle suspended in fluid, bombarded by molecules. In finance, it models the random "shocks" that hit asset prices.

---

## Generalized Wiener Process

Real-world variables have non-zero drift and scaling.

```{admonition} Key Concept: Generalized Wiener Process
:class: tip

A **generalized Wiener process** for variable $x$ has the form:

$$dx = a \, dt + b \, dz$$

Where:
- $a$ = Drift rate (expected change per unit time)
- $b$ = Volatility (standard deviation of change per unit time)
- $dz$ = Standard Wiener process

**Discrete time equivalent:**

$$\Delta x = a \Delta t + b \epsilon \sqrt{\Delta t}$$

Where $\epsilon \sim N(0, 1)$
```

### Properties of Generalized Wiener Process

```{note}
**Over time interval $\Delta t$:**

$$\Delta x \sim N(a \Delta t, b^2 \Delta t)$$

**Mean:** $E[\Delta x] = a \Delta t$
**Variance:** $\text{Var}[\Delta x] = b^2 \Delta t$
**Standard Deviation:** $\sigma[\Delta x] = b\sqrt{\Delta t}$

**Over longer time $T$:**

$$x(T) - x(0) \sim N(aT, b^2T)$$

```

```{admonition} Example Problem: Generalized Wiener Process
:class: tip

A cash balance $x$ changes according to:

$$dx = 5 \, dt + 2 \, dz$$

Where time is measured in years and $x$ is in thousands of dollars.

**Questions:**
1. What is the expected change in the cash balance over 1 year?
2. What is the standard deviation of the change over 1 year?
3. What is the distribution of the change over 6 months?
```

```{dropdown} Solution

**Given:**
- Drift: $a = 5$ (thousand dollars per year)
- Volatility: $b = 2$ (thousand dollars per year)

**Part 1: Expected Change Over 1 Year**

$$E[\Delta x(1)] = a \times 1 = 5 \text{ thousand dollars}$$

**Part 2: Standard Deviation Over 1 Year**

$$\sigma[\Delta x(1)] = b \times \sqrt{1} = 2 \text{ thousand dollars}$$

**Part 3: Distribution Over 6 Months**

$$\Delta x(0.5) \sim N(a \times 0.5, b^2 \times 0.5)$$

$$\Delta x(0.5) \sim N(2.5, 2.0)$$

Mean: $2.5$ thousand dollars
Variance: $2.0$ (thousand dollars)²
Standard Deviation: $\sqrt{2.0} = 1.414$ thousand dollars

**Final Answers:**
1. Expected change: \$5,000
2. Standard deviation: \$2,000
3. Distribution over 6 months: **$N(2500, 1414)$** (in dollars)

**Physical Meaning**: The cash balance drifts upward at $5,000 per year on average, but with random fluctuations having standard deviation $2,000 per year.
```

---

## Itô Process

The most general form allows drift and volatility to vary with time and the variable itself.

```{admonition} Key Concept: Itô Process
:class: tip

An **Itô process** has the form:

$$dx = a(x,t) \, dt + b(x,t) \, dz$$

Where:
- $a(x,t)$ = Drift rate (function of $x$ and time $t$)
- $b(x,t)$ = Volatility (function of $x$ and time $t$)

**Key Difference from Generalized Wiener:**
- Drift and volatility can change over time
- Can depend on current value of $x$
- Much more flexible
```

**Physical Meaning**: In a generalized Wiener process, drift and volatility are constants. In an Itô process, they can vary - like a car whose acceleration and turbulence change based on speed and road conditions.

---

## Geometric Brownian Motion: The Stock Price Model

```{admonition} Key Concept: Stock Price Process
:class: tip

Stock prices are modeled as:

$$dS = \mu S \, dt + \sigma S \, dz$$

Where:
- $S$ = Stock price
- $\mu$ = Expected return (drift) per unit time
- $\sigma$ = Volatility per unit time
- $dz$ = Wiener process

**Discrete approximation:**

$$\Delta S = \mu S \Delta t + \sigma S \epsilon \sqrt{\Delta t}$$

**In percentage terms:**

$$\frac{\Delta S}{S} = \mu \Delta t + \sigma \epsilon \sqrt{\Delta t}$$

```

### Why This Model?

```{note}
**Desirable Properties:**

1. **Proportional changes**: Returns (not price changes) are normally distributed
2. **Positive prices**: Process never goes negative
3. **Limited liability**: Price can't fall below zero
4. **Constant volatility**: Percentage volatility $\sigma$ is constant
5. **Realistic**: Matches observed behavior reasonably well
```

**Physical Meaning**: The model says that **percentage changes** (returns) are normally distributed with constant volatility. If the stock is at \$100, a typical daily move might be ±2%. If at \$50, a typical move is ±1$ (still ±2%).

---

## Itô's Lemma

Itô's lemma is the stochastic calculus chain rule - essential for derivatives pricing.

```{admonition} Key Concept: Itô's Lemma
:class: tip

If $x$ follows the Itô process:

$$dx = a(x,t) \, dt + b(x,t) \, dz$$

And $G$ is a function of $x$ and $t$: $G = G(x,t)$

Then $G$ follows:

$$dG = \left(\frac{\partial G}{\partial x} a + \frac{\partial G}{\partial t} + \frac{1}{2} \frac{\partial^2 G}{\partial x^2} b^2\right) dt + \frac{\partial G}{\partial x} b \, dz$$

**Short form:**

$$dG = \left(G_x a + G_t + \frac{1}{2} G_{xx} b^2\right) dt + G_x b \, dz$$

```

### Why Itô's Lemma is Different

```{important}
**Key Difference from Ordinary Calculus:**

In ordinary calculus, Taylor expansion:

$$dG = \frac{\partial G}{\partial x} dx + \frac{\partial G}{\partial t} dt + \text{higher order terms}$$

In stochastic calculus:

$$dG = \frac{\partial G}{\partial x} dx + \frac{\partial G}{\partial t} dt + \frac{1}{2} \frac{\partial^2 G}{\partial x^2} (dx)^2 + \ldots$$

**The $(dx)^2$ term doesn't vanish!**

**Why?** Because:
- $(dz)^2 = dt$ (not zero!)
- $(dt)^2 = 0$ (as usual)
- $dz \cdot dt = 0$ (cross terms vanish)
```

### Intuition: Why $(dz)^2 = dt$?

```{note}
**Heuristic Argument:**

$$dz = \epsilon \sqrt{dt}$$ where $\epsilon \sim N(0,1)$

$$(dz)^2 = \epsilon^2 dt$$

$$E[\epsilon^2] = 1$$

So $(dz)^2 \approx dt$ in expectation.

**More rigorously:** In the limit as $dt \to 0$, $(dz)^2$ converges to $dt$ in mean square.
```

---

## Deriving Itô's Lemma

```{admonition} Derivation Outline
:class: note

**Step 1: Taylor Expansion**

$$dG = \frac{\partial G}{\partial x}dx + \frac{\partial G}{\partial t}dt + \frac{1}{2}\frac{\partial^2 G}{\partial x^2}(dx)^2 + \frac{1}{2}\frac{\partial^2 G}{\partial t^2}(dt)^2 + \frac{\partial^2 G}{\partial x \partial t}dx \, dt + \ldots$$

**Step 2: Substitute $dx = a \, dt + b \, dz$**

$$(dx)^2 = (a \, dt + b \, dz)^2 = a^2(dt)^2 + 2ab \, dt \, dz + b^2(dz)^2$$

**Step 3: Apply Stochastic Calculus Rules**

- $(dt)^2 = 0$
- $dt \, dz = 0$
- $(dz)^2 = dt$

Therefore: $(dx)^2 = b^2 \, dt$

**Step 4: Substitute Back**

$$dG = \frac{\partial G}{\partial x}(a \, dt + b \, dz) + \frac{\partial G}{\partial t}dt + \frac{1}{2}\frac{\partial^2 G}{\partial x^2}b^2 dt$$

**Step 5: Collect Terms**

$$dG = \left(\frac{\partial G}{\partial x}a + \frac{\partial G}{\partial t} + \frac{1}{2}\frac{\partial^2 G}{\partial x^2}b^2\right)dt + \frac{\partial G}{\partial x}b \, dz$$

**This is Itô's Lemma!**
```

---

## Application: The Lognormal Property

```{admonition} Example Problem: What Process Does $\ln S$ Follow?
:class: tip

Given that stock price follows:

$$dS = \mu S \, dt + \sigma S \, dz$$

**Question:** What process does $G = \ln S$ follow?

**Use Itô's Lemma to find $d(\ln S)$**
```

```{dropdown} Solution

**Step 1: Identify Components**

- $x = S$
- $G(S) = \ln S$
- $a = \mu S$
- $b = \sigma S$

**Step 2: Calculate Partial Derivatives**

$$\frac{\partial G}{\partial S} = \frac{1}{S}$$

$$\frac{\partial^2 G}{\partial S^2} = -\frac{1}{S^2}$$

$$\frac{\partial G}{\partial t} = 0$$ (no explicit time dependence)

**Step 3: Apply Itô's Lemma**

$$d(\ln S) = \left(\frac{1}{S} \cdot \mu S + 0 + \frac{1}{2} \cdot \left(-\frac{1}{S^2}\right) \cdot (\sigma S)^2\right)dt + \frac{1}{S} \cdot \sigma S \, dz$$

$$= \left(\mu - \frac{1}{2}\sigma^2\right)dt + \sigma \, dz$$

**Step 4: Integrate Over Time $T$**

$$\ln S_T - \ln S_0 = \left(\mu - \frac{1}{2}\sigma^2\right)T + \sigma \sqrt{T} \epsilon$$

Where $\epsilon \sim N(0,1)$

$$\ln S_T \sim N\left(\ln S_0 + \left(\mu - \frac{1}{2}\sigma^2\right)T, \sigma^2 T\right)$$

**Final Answer:**

$$d(\ln S) = \left(\mu - \frac{\sigma^2}{2}\right)dt + \sigma \, dz$$

**Physical Meaning**: The logarithm of the stock price follows a generalized Wiener process with:
- Drift: $\mu - \frac{\sigma^2}{2}$
- Volatility: $\sigma$

**The $-\frac{\sigma^2}{2}$ term is the "Itô correction" or "volatility drag"** - it appears because of the second derivative term in Itô's lemma.
```

---

## The Lognormal Distribution

```{admonition} Key Result: Lognormal Property
:class: important

If $\ln S_T$ is normally distributed, then $S_T$ is **lognormally distributed**.

**Distribution of $S_T$:**

$$\ln\left(\frac{S_T}{S_0}\right) \sim N\left(\left(\mu - \frac{\sigma^2}{2}\right)T, \sigma^2 T\right)$$

**Expected value:**

$$E[S_T] = S_0 e^{\mu T}$$

**Variance:**

$$\text{Var}[S_T] = S_0^2 e^{2\mu T}(e^{\sigma^2 T} - 1)$$

```

### Understanding the Lognormal

```{note}
**Properties of Lognormal Distribution:**

1. **Always positive**: $S_T > 0$ (unlike normal)
2. **Right-skewed**: Long right tail, bounded at zero on left
3. **Median vs. Mean**: Median < Mean
4. **Multiplicative returns**: Returns compound multiplicatively

**Median:**

$$\text{Median}[S_T] = S_0 e^{(\mu - \sigma^2/2)T}$$

**Mean:**

$$E[S_T] = S_0 e^{\mu T}$$

**Note:** Mean > Median due to right skew.
```

```{admonition} Example Problem: Lognormal Calculations
:class: tip

**Problem:**
A stock trades at $100. Annual expected return is 12%, annual volatility is 25%. What is the distribution of the stock price in 1 year?

**Given:**
- $S_0 = 100$
- $\mu = 0.12$
- $\sigma = 0.25$
- $T = 1$
```

```{dropdown} Solution

**Step 1: Distribution of $\ln S_1$**

$$\ln S_1 \sim N\left(\ln 100 + \left(0.12 - \frac{0.25^2}{2}\right) \times 1, 0.25^2 \times 1\right)$$

$$= N\left(4.605 + (0.12 - 0.03125), 0.0625\right)$$

$$= N(4.694, 0.0625)$$

**Mean of log:** $4.694$
**Standard deviation of log:** $\sqrt{0.0625} = 0.25$

**Step 2: Expected Value of $S_1$**

$$E[S_1] = 100 \times e^{0.12 \times 1} = 100 \times e^{0.12} = 100 \times 1.1275 = \$112.75$$

**Step 3: Median of $S_1$**

$$\text{Median}[S_1] = 100 \times e^{(0.12 - 0.25^2/2) \times 1}$$

$$= 100 \times e^{0.08875} = 100 \times 1.0928 = \$109.28$$

**Step 4: Volatility of $S_1$**

$$\text{Var}[S_1] = 100^2 \times e^{2 \times 0.12}(e^{0.0625} - 1)$$

$$= 10000 \times 1.2712 \times 0.0645 = \$820$$

$$\text{Std Dev}[S_1] = \sqrt{820} = \$28.64$$

**Step 5: Approximate 95% Confidence Interval**

Using log-space (more accurate):

95% interval for $\ln S_1$: $4.694 \pm 1.96 \times 0.25 = [4.204, 5.184]$

Converting back: $[e^{4.204}, e^{5.184}] = [\$66.78, \$178.54]$

**Final Answer:**
- Expected price: \$112.75
- Median price: \$109.28
- Standard deviation: \$28.64
- 95% confidence interval: **[\$66.78, \$178.54]**

**Physical Meaning**: The stock is expected to reach $112.75, but there's substantial uncertainty. There's a 2.5% chance it falls below $67 and a 2.5% chance it rises above $179.
```

---

## The Volatility Drag

```{important}
**Why Does $\mu - \frac{\sigma^2}{2}$ Appear?**

This is the **volatility drag** or **Jensen's inequality effect**.

**Intuition:**

Consider two paths:
- **Path A**: Up 20%, down 20% → Final: $1.20 \times 0.80 = 0.96$ (loss!)
- **Path B**: No change → Final: $1.00$

Even though average return is 0%, volatility causes loss due to compounding.

**The $-\frac{\sigma^2}{2}$ term corrects for this:**
- Expected **log return**: $\mu - \frac{\sigma^2}{2}$
- Expected **actual return**: $\mu$

**Higher volatility** → **Larger drag** on geometric returns
```

---

## Chapter Summary

```{important}
**Key Takeaways:**

1. **Markov process**: Future independent of past, given present
2. **Stock prices assumed Markovian**: Only current price matters
3. **Variance is additive** for independent changes; standard deviation grows as $\sqrt{T}$
4. **Wiener process**: $dz$ with mean 0, variance rate 1
5. **Generalized Wiener**: $dx = a \, dt + b \, dz$ adds drift and scaling
6. **Itô process**: $dx = a(x,t) \, dt + b(x,t) \, dz$ allows time and state dependence
7. **Geometric Brownian motion**: $dS = \mu S \, dt + \sigma S \, dz$ models stock prices
8. **Itô's lemma**: Stochastic chain rule with extra $\frac{1}{2}b^2 G_{xx}$ term
9. **Key rule**: $(dz)^2 = dt$ in stochastic calculus
10. **Lognormal property**: $\ln S_T$ is normal, so $S_T$ is lognormal
11. **Volatility drag**: Expected log return = $\mu - \frac{\sigma^2}{2}$
12. **Expected price**: $E[S_T] = S_0 e^{\mu T}$
```

```{seealso}
**Looking Ahead:**

Chapter 8 uses these stochastic process tools to derive the **Black-Scholes-Merton model**, the most famous formula in finance.
```

---

## Practice Problems

```{admonition} Practice Problem 1: Stock Price Simulation
:class: tip

A stock trades at $50 with annual volatility of 30% and expected return of 10%. Model its price over 3 months using monthly time steps.

**Given:**
- $S_0 = \$50$
- $\mu = 0.10$
- $\sigma = 0.30$
- $\Delta t = 1/12$ year (monthly)

**Questions:**
1. What is the expected price after 3 months?
2. What is the standard deviation of percentage returns over 3 months?
3. Simulate one possible price path.
```

```{dropdown} Solution to Practice Problem 1

**Part 1: Expected Price After 3 Months**

$$E[S_{0.25}] = S_0 e^{\mu T} = 50 \times e^{0.10 \times 0.25}$$

$$= 50 \times e^{0.025} = 50 \times 1.0253 = \$51.26$$

**Part 2: Standard Deviation of Returns**

Over 3 months ($T = 0.25$):

$$\text{Std Dev}[\ln(S_T/S_0)] = \sigma\sqrt{T} = 0.30 \times \sqrt{0.25} = 0.30 \times 0.5 = 0.15 = 15\%$$

**Part 3: Simulated Price Path**

Using monthly steps:

$$\Delta S = \mu S \Delta t + \sigma S \epsilon \sqrt{\Delta t}$$

$$\Delta t = 1/12, \quad \sqrt{\Delta t} = 0.2887$$

| Month | $S$ (start) | $\epsilon$ | $\Delta S$ | $S$ (end) |
|-------|-------------|-----------|-----------|-----------|
| 0 | $50.00 | - | - | $50.00 |
| 1 | $50.00 | 0.8 | $0.42 + 3.46 = 3.88$ | $53.88 |
| 2 | $53.88 | -0.5 | $0.45 - 2.33 = -1.88$ | $52.00 |
| 3 | $52.00 | 0.3 | $0.43 + 1.35 = 1.78$ | $53.78 |

**Calculations for Month 1:**
- Drift: $0.10 \times 50 \times (1/12) = 0.42$
- Diffusion: $0.30 \times 50 \times 0.8 \times 0.2887 = 3.46$
- Total: $\Delta S = 0.42 + 3.46 = 3.88$

**Final Answers:**
1. Expected price: \$51.26
2. Std dev of returns: **15%**
3. Simulated path: \$50 → \$53.88 → \$52.00 → \$53.78

**Note**: Each simulation would produce different results. The distribution of final prices centers around $51.26 with 15% volatility.
```

---
