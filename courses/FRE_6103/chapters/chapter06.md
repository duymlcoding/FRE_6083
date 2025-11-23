---
title: "Chapter 6: Stochastic Processes in Finance"
subtitle: "Random Walks, Mean Reversion, and Geometric Brownian Motion"
author: "David C. Shimko"
date: "2025"
---

# Chapter 6: Stochastic Processes in Finance

## Chapter Overview

In Chapter 5, we learned how to simulate random variables at a single point in time. In Chapter 6, we extend this concept to the dimension of **time**. We are no longer just asking "What is the distribution of the stock price tomorrow?" but rather "What does the entire path of the stock price look like over the next year?"

This chapter introduces the fundamental stochastic processes that underpin modern financial engineering:
1.  **The Arithmetic Random Walk (ARW):** The simplest model, additive and volatile.
2.  **The Ornstein-Uhlenbeck (OU) Process:** A mean-reverting model essential for commodities and interest rates.
3.  **The Geometric Random Walk (GRW):** The multiplicative model that forms the basis of the Black-Scholes option pricing formula.

We will derive the properties of these processes from first principles, analyze their moments (mean and variance) over time, and learn how to simulate their paths using the techniques from Chapter 5.

### Learning Objectives

By the end of this chapter, you will be able to:

1.  **Differentiate** between Arithmetic, Mean Reverting, and Geometric processes and select the appropriate model for a given asset class (stocks vs. commodities vs. cash flows).
2.  **Derive** the expected value and variance of a stochastic process as a function of time $t$.
3.  **Construct** covariance matrices for multi-period simulations of these processes.
4.  **Simulate** sample paths for ARW, OU, and GRW processes in discrete time steps.
5.  **Analyze** the limitations of each model, such as the possibility of negative prices in ARW/OU and the lack of mean reversion in GRW.
6.  **Implement** the "convexity adjustment" required to transition from logarithmic returns to arithmetic expectations in the GRW.

### Prerequisites

```{admonition} Prerequisites
:class: warning

Before studying this chapter, you should be familiar with:
- **Chapter 5:** Simulation techniques, specifically Cholesky decomposition for correlated random variables.
- **Probability:** Normal distribution properties, Expected Value, Variance, Covariance.
- **Calculus:** Basic derivatives and integration (for proving properties of MGFs and limits).
- **Geometric Series:** Summation formulas for $\sum r^k$.
```

---

##  The Arithmetic Random Walk (ARW)

The Random Walk hypothesis, popularized by Louis Bachelier in 1900, posits that asset price changes are random and unpredictable. Even if we don't believe markets are truly random, the **Efficient Market Hypothesis** suggests we cannot systematically outperform them, so modeling prices as random is a rational baseline.

### 1. Definition and Dynamics

The ARW models the **change** in price as a random variable added to the previous price.

**Discrete Time Equation:**

$$

S_{t+1} = S_t + \mu + \sigma Z_t

$$

Where:
* $S_t$: Asset price at time $t$.
* $\mu$: Drift parameter (expected dollar change per period).
* $\sigma$: Volatility parameter (standard deviation of dollar change per period).
* $Z_t \sim N(0,1)$: Standard normal random shock (the "innovation").

**Continuous Time (Arithmetic Brownian Motion):**
As the time step $\Delta t \to dt$:

$$

dS_t = \mu dt + \sigma dZ_t

$$

### 2. Properties over Time

What happens if we look $j$ periods into the future?
We can write $S_{t+j}$ as a collapsing sum of incremental changes:

$$

S_{t+j} = S_t + \sum_{i=1}^j (S_{t+i} - S_{t+i-1})

$$

Substituting the dynamics $S_{k} - S_{k-1} = \mu + \sigma Z_{k-1}$:

$$

S_{t+j} = S_t + \sum_{i=1}^j (\mu + \sigma Z_{t+i-1})

$$

$$

S_{t+j} = S_t + j\mu + \sigma \sum_{i=1}^j Z_{t+i-1}

$$

Since the sum of $j$ independent standard normals is normal with variance $j$:
$\sum_{i=1}^j Z_i \sim N(0, j)$.

**Distribution of Future Price:**

$$

S_{t+j} \sim N(S_t + j\mu, j\sigma^2)

$$

* **Expected Value:** $E[S_{t+j}] = S_t + j\mu$. (Linear growth).
* **Variance:** $\text{Var}(S_{t+j}) = j\sigma^2$. (Variance grows linearly with time).
* **Standard Deviation:** $\sigma \sqrt{j}$. (Risk grows with the square root of time).

### 3. Autocorrelation Structure

In simulation, we often need the covariance between prices at different times, e.g., $S_{t+j}$ and $S_{t+m}$ where $j < m$.

$$

\text{Cov}(S_{t+j}, S_{t+m}) = \text{Cov}\left( S_t + j\mu + \sigma \sum_{i=1}^j Z_i, \quad S_t + m\mu + \sigma \sum_{k=1}^m Z_k \right)

$$

Since $S_t, \mu$ are constants (at time $t$), they drop out of the covariance. We are left with the covariance of the sums of $Z$.
The first $j$ terms of $Z$ are common to both sums. The terms from $j+1$ to $m$ in the second sum are independent of the first sum.

$$

\text{Cov}(S_{t+j}, S_{t+m}) = \sigma^2 \sum_{i=1}^j \text{Var}(Z_i) = \sigma^2 \cdot j

$$

**General Formula:**

$$

\text{Cov}(S_{t+j}, S_{t+m}) = \sigma^2 \min(j, m)

$$

This covariance structure allows us to construct the covariance matrix $\mathbf{A}$ for a vector of prices $(S_{t+1}, S_{t+2}, \dots, S_{t+k})$ and simulate the entire path using the Cholesky decomposition method from Chapter 5.

**Simulation Algorithm:**
1.  Construct the Covariance Matrix $\mathbf{A}$ where $A_{ij} = \sigma^2 \min(i, j)$.
2.  Compute Cholesky $\mathbf{R}$ such that $\mathbf{A} = \mathbf{R}\mathbf{R}^T$.
3.  Generate independent $Z \sim N(0,1)$.
4.  Path $\mathbf{S} = \mathbf{S}_{mean} + \mathbf{Z}\mathbf{R}^T$ (where $\mathbf{Z}$ is a row vector).

    **Note:** For ARW, the Cholesky matrix $\mathbf{R}$ is simply a lower triangular matrix of $\sigma$'s.
    $S_{t+1} = S_t + \mu + \sigma Z_1$
    $S_{t+2} = S_{t+1} + \mu + \sigma Z_2 = S_t + 2\mu + \sigma(Z_1 + Z_2)$
    This confirms the "cumulative sum" structure.

### 4. Critique of ARW

**Pros:**
* Simple to understand and implement.
* Good for short-term approximations.
* Suitable for variables that can be negative (e.g., "Basis" spread between two commodities, or net corporate Cash Flows).

**Cons:**
* **Negative Prices:** For stocks, $S_t$ can drift below zero, which violates limited liability.
* **Unbounded Variance:** Uncertainty grows infinitely ($\sqrt{t}$), which may not fit stable economic variables like interest rates.

---

##  Mean Reversion (Ornstein-Uhlenbeck)

Commodities (oil, copper, wheat) and interest rates do not wander infinitely like stocks.
* **High Prices:** Stimulate supply, reduce demand $\to$ Price falls.
* **Low Prices:** Reduce supply, stimulate demand $\to$ Price rises.
This economic gravity is called **Mean Reversion**.

### 1. Definition and Dynamics

The Ornstein-Uhlenbeck (OU) process pulls the variable back to a long-run mean $\mu$.

**Discrete Time Equation:**

$$

S_{t+1} = S_t + \kappa(\mu - S_t) + \sigma Z_t

$$

Alternatively written as:

$$

S_{t+1} - \mu = (1 - \kappa)(S_t - \mu) + \sigma Z_t

$$

Where:
* $\mu$: Long-run mean level.
* $\kappa$: Speed of mean reversion ($0 \le \kappa \le 1$).
    * $\kappa=0$: Random Walk (no reversion).
    * $\kappa=1$: Instant reversion to mean (no memory).
* $\sigma$: Volatility of the shock.

### 2. Properties over Time

Expanding the recurrence relation for $S_{t+j}$:

$$

S_{t+j} - \mu = (1-\kappa)^j (S_t - \mu) + \sum_{i=0}^{j-1} (1-\kappa)^i \sigma Z_{t+j-i}

$$

**Expected Value:**
The random $Z$ terms average to zero.

$$

E[S_{t+j}] = \mu + (1-\kappa)^j (S_t - \mu)

$$

* As $j \to \infty$, $(1-\kappa)^j \to 0$, so $E[S_{t+j}] \to \mu$. The forecast converges to the long-run mean.

**Variance:**
The variance is the sum of the variances of the independent shock terms.

$$

\text{Var}(S_{t+j}) = \sigma^2 \sum_{i=0}^{j-1} \left[ (1-\kappa)^i \right]^2 = \sigma^2 \sum_{i=0}^{j-1} (1-\kappa)^{2i}

$$

This is a geometric series sum $\sum r^i$ where $r = (1-\kappa)^2$.

$$

\text{Var}(S_{t+j}) = \sigma^2 \frac{1 - (1-\kappa)^{2j}}{1 - (1-\kappa)^2}

$$

Approximating denominator $1 - (1-2\kappa+\kappa^2) \approx 2\kappa$ (for small $\kappa$):

$$

\text{Var}(S_{t+j}) \approx \frac{\sigma^2}{2\kappa} \left( 1 - (1-\kappa)^{2j} \right)

$$

**Limit Behavior:**
* **ARW:** Variance $\to \infty$.
* **OU:** Variance converges to a finite limit $\frac{\sigma^2}{2\kappa}$.
* **"Increases at a decreasing rate":** The uncertainty grows initially but eventually saturates. 

### 3. Autocorrelation Structure

The covariance between $S_{t+j}$ and $S_{t+m}$ (where $j < m$) involves the overlap of shocks.

$$

\text{Cov}(S_{t+i}, S_{t+j}) = \sigma^2 (1-\kappa)^{|i-j|} \frac{1 - (1-\kappa)^{2 \min(i,j)}}{1 - (1-\kappa)^2}

$$



### 4. Critique of OU

**Pros:**
* Captures economic reality of supply/demand equilibrium.
* Bounded variance makes long-term modeling more stable.
* Ideal for **Commodities** and **Interest Rates**.

**Cons:**
* Still allows negative values (since shocks are Normal additive).
* Not suitable for assets that grow exponentially (stocks).

---

##  The Geometric Random Walk (GRW)

To model stock prices while respecting limited liability ($S \ge 0$) and exponential growth, we use the Geometric Random Walk. This is the engine behind the Black-Scholes model.

### 1. The Log-Normal Transformation

Instead of modeling price changes $S_{t+1} - S_t$, we model **returns** (log-price changes).

Let $\Sigma_t = \ln(S_t)$. We model $\Sigma_t$ as an **Arithmetic** Random Walk.

$$

\ln(S_{t+1}) - \ln(S_t) = \nu + \sigma Z_t

$$

$$

\ln\left( \frac{S_{t+1}}{S_t} \right) \sim N(\nu, \sigma^2)

$$

Where $\nu$ is the expected *log-return*.

**Dynamics:**

$$

S_{t+1} = S_t e^{\nu + \sigma Z_t}

$$

Since $e^x$ is always positive, $S_{t+1}$ can never be negative. The price follows a **Log-Normal Distribution**.

### 2. The Convexity Adjustment (Drift)

There is a subtle but critical distinction between the **Expected Log Return** ($E[\ln(S_{t+1}/S_t)]$) and the **Log of Expected Return** ($\ln(E[S_{t+1}/S_t])$).

If $Y = e^X$ where $X \sim N(\mu, \sigma^2)$, then:

$$ E[Y] = e^{\mu + \frac{1}{2}\sigma^2} $$

We usually define the drift $\mu$ in terms of the *expected rate of return* of the stock:

$$ E[S_{t+1}] = S_t e^{\mu} $$

(using continuous compounding notation).

Matching the expectations:

$$ E[S_{t+1}] = S_t E[e^{\nu + \sigma Z}] = S_t e^{\nu + \frac{1}{2}\sigma^2} $$

Set this equal to the target drift $S_t e^{\mu}$:

$$ e^{\nu + \frac{1}{2}\sigma^2} = e^{\mu} $$

$$ \nu = \mu - \frac{1}{2}\sigma^2 $$

**The GRW Generator Equation:**
To simulate a stock with expected return $\mu$ and volatility $\sigma$:

$$

S_{t+1} = S_t \exp\left( (\mu - \frac{1}{2}\sigma^2) + \sigma Z_t \right)

$$

The term $-\frac{1}{2}\sigma^2$ is the **Drift Adjustment** or **Convexity Adjustment**. It accounts for the fact that volatility drags down the compounded geometric return relative to the arithmetic average. 

### 3. Properties over Time

**Log Price:**
$\ln(S_{t+j}) \sim N(\ln(S_t) + j(\mu - 0.5\sigma^2), j\sigma^2)$.

**Price Level:**
* **Expected Value:** $E[S_{t+j}] = S_t e^{j\mu}$.
* **Variance:** $\text{Var}(S_{t+j}) = S_t^2 e^{2j\mu} (e^{j\sigma^2} - 1)$.

### 4. Critique of GRW

**Pros:**
* Prevents negative prices ($S \ge 0$).
* Consistent with compounding interest.
* Standard model for **Stocks** and **Indices**.

**Cons:**
* Assumes constant volatility (markets have stochastic vol).
* Does not allow for default (stock price 0 is asymptotic, never hit).
* Fails to capture "Fat Tails" (extreme events are more common in reality than Normal distribution predicts).

---

##  Worked Examples

```{admonition} Example 1: Simulating an ARW
:class: tip

**Problem:** Simulate 3 periods of a stock price using ARW.
$S_0 = 20, \mu = 0, \sigma = 5$.
Random draws $Z_1 = 0.5, Z_2 = -1.2, Z_3 = 0.8$.

**Step 1: $t=1$**
$S_1 = S_0 + \mu + \sigma Z_1 = 20 + 0 + 5(0.5) = 22.5$.

**Step 2: $t=2$**
$S_2 = S_1 + \mu + \sigma Z_2 = 22.5 + 0 + 5(-1.2) = 22.5 - 6 = 16.5$.

**Step 3: $t=3$**
$S_3 = S_2 + \mu + \sigma Z_3 = 16.5 + 0 + 5(0.8) = 16.5 + 4 = 20.5$.

**Path:** 20 $\to$ 22.5 $\to$ 16.5 $\to$ 20.5.

```

```{admonition} Example 2: OU Expected Value
:class: tip

**Problem:** Corn price $S_0 = 5$. Long run mean $\mu = 4$. Mean reversion $\kappa = 0.20$. Volatility $\sigma = 0.75$. Calculate expected price at $t=5$.

**Formula:**
$E[S_t] = \mu + (1-\kappa)^t (S_0 - \mu)$.

**Calculation:**

$$ E[S_5] = 4 + (1 - 0.20)^5 (5 - 4) $$

$$ E[S_5] = 4 + (0.8)^5 (1) $$

$$ E[S_5] = 4 + 0.32768 = 4.33 $$

**Interpretation:**
The price started high (5) relative to the mean (4). Over 5 years, it is expected to drift down towards 4, reaching 4.33.

```

```{admonition} Example 3: GRW Convexity Adjustment
:class: tip

**Problem:** A stock has an expected annual return of 10% ($\mu=0.10$) and volatility of 20% ($\sigma=0.20$). What is the mean of the *log-returns* ($\nu$)?

**Formula:**
$\nu = \mu - \frac{1}{2}\sigma^2$.

**Calculation:**

$$ \nu = 0.10 - 0.5(0.20)^2 $$

$$ \nu = 0.10 - 0.5(0.04) $$

$$ \nu = 0.10 - 0.02 = 0.08 $$

**Result:**
Even though the arithmetic expected return is 10%, the most likely path (geometric drift) grows at 8%. This 2% drag is the "volatility tax."

```

---

##  Practice Problems

```{admonition} Practice Problem 1: ARW Variance
:class: tip

**Problem:** An ARW process has $\sigma = 2$. What is the standard deviation of the price at $t=16$?

<details>
<summary><strong>Click for Solution</strong></summary>

Variance $\text{Var}(S_t) = t \sigma^2$.
$\text{Var}(S_{16}) = 16 \times 2^2 = 16 \times 4 = 64$.
Standard Deviation $= \sqrt{64} = 8$.
Alternatively: $\text{StdDev} = \sigma \sqrt{t} = 2 \sqrt{16} = 2 \times 4 = 8$.

</details>
```

```{admonition} Practice Problem 2: OU Limit
:class: tip

**Problem:** For an OU process with $\sigma = 10$ and $\kappa = 0.5$, what is the maximum long-term variance?

<details>
<summary><strong>Click for Solution</strong></summary>

The variance of an OU process converges to:

$$ \lim_{t \to \infty} \text{Var}(S_t) = \frac{\sigma^2}{1 - (1-\kappa)^2} \approx \frac{\sigma^2}{2\kappa} $$

Using the approximate formula:

$$ \text{Var} \approx \frac{100}{2(0.5)} = \frac{100}{1} = 100 $$

Using exact formula:
Denominator $= 1 - (0.5)^2 = 1 - 0.25 = 0.75$.
$\text{Var} = 100 / 0.75 = 133.33$.

</details>
```

```{admonition} Practice Problem 3: GRW Simulation
:class: tip

**Problem:** Simulate one step of a GRW. $S_0 = 100, \mu = 0.05, \sigma = 0.10, Z = -1$.

<details>
<summary><strong>Click for Solution</strong></summary>

Formula: $S_1 = S_0 \exp(\mu - 0.5\sigma^2 + \sigma Z)$.

$$ S_1 = 100 \exp(0.05 - 0.5(0.01) + 0.1(-1)) $$

$$ S_1 = 100 \exp(0.05 - 0.005 - 0.1) $$

$$ S_1 = 100 \exp(-0.055) $$

$$ S_1 = 100 (0.9465) = 94.65 $$

</details>
```

---

##  Chapter Summary

```{important}
**Key Concepts Recap**

**1. The Trio of Processes:**
* **ARW:** Additive noise. Good for spreads/cash flows. Risk of negative prices.
* **OU:** Mean reverting. Good for commodities/rates. Bounded variance.
* **GRW:** Multiplicative noise. Good for stocks. Convexity adjustment required.

**2. Volatility and Time:**
* In Random Walks (ARW/GRW), risk grows with time ($\sigma \sqrt{t}$). The future is infinitely uncertain.
* In Mean Reversion (OU), risk is bounded. The economic forces of supply and demand limit how far prices can drift.

**3. The Convexity Adjustment:**
When moving from Normal shocks to Lognormal prices, we must subtract $\frac{1}{2}\sigma^2$ from the drift. This ensures that $E[S_t]$ matches the arithmetic return $\mu$, counteracting the mathematical fact that $E[e^X] > e^{E[X]}$.
```

### Formula Cheat Sheet

| Model | Dynamics Equation | Expected Value $E[S_t]$ | Variance $\text{Var}(S_t)$ |
| :--- | :--- | :--- | :--- |
| **ARW** | $S_{t+1} = S_t + \mu + \sigma Z$ | $S_0 + t\mu$ | $t\sigma^2$ |
| **OU** | $S_{t+1} = S_t + \kappa(\mu-S_t) + \sigma Z$ | $\mu + (1-\kappa)^t(S_0-\mu)$ | $\approx \frac{\sigma^2}{2\kappa} (1 - (1-\kappa)^{2t})$ |
| **GRW** | $S_{t+1} = S_t e^{(\mu - 0.5\sigma^2) + \sigma Z}$ | $S_0 e^{t\mu}$ | $S_0^2 e^{2t\mu}(e^{t\sigma^2}-1)$ |

