---
title: "Lecture 7: The Continuous-Time Limit of the Random Walk"
author: "Agnès Tourin"
date: "August 12, 2024"
---

# The Continuous-Time Limit of the Random Walk

This chapter discusses the passage to the continuous-time limit of the discrete-time random walk and the binomial tree model, and introduces the Wiener process (Brownian motion) for the first time. Starting in the next chapter, we will move away from discrete-time processes in order to focus more on continuous-time processes.

```{seealso}
**Recommended References:**
- Steven E. Shreve, "Stochastic Calculus for Finance I: The Binomial Asset Pricing Model", 2004, Springer
- Steven E. Shreve, "Stochastic Calculus for Finance II: Continuous-time Finance", 2004, Springer
```

```{note}
**Acknowledgment:**

In this chapter, we draw heavily from Shreve [1] and [2]. Any mistake is the sole responsibility of the author of these slides.
```

## Introduction

The transition from discrete-time to continuous-time models is a fundamental step in quantitative finance. By taking appropriate limits of discrete models, we obtain continuous-time processes that are both mathematically elegant and practically useful for modeling financial markets.

```{admonition} Key Objectives
:class: tip

This lecture will show how:
- The discrete random walk converges to Brownian motion
- The binomial tree model converges to the geometric Brownian motion
- These limiting processes provide realistic models for stock prices
```

## The Symmetric Random Walk

First of all, we recall the definition of the basic memoryless symmetric random walk that was presented earlier.

### Setup

We toss a **fair coin** infinitely many times.

On each toss $i$:
- Probability of getting a **head**: $p = \frac{1}{2}$
- Probability of getting a **tail**: $q = 1 - p = \frac{1}{2}$

### Definition

We denote the **one-step increment** by $Y_i$ and the **random walk** itself by $X_n$:

$$
X_n = \sum_{i=1}^{n} Y_i
$$

where $Y_i$ is:

$$
Y_i = \begin{cases}
+1 & \text{with probability } p \\
-1 & \text{with probability } 1-p
\end{cases}
$$

**Physical Meaning:** At each time step, the process randomly moves up or down by 1. This models random fluctuations in a simple, discrete way.

## Quadratic Variation of the Random Walk

The quadratic variation of the random walk is a quantity of great interest (it makes the Black-Scholes theory work).

```{important}
**Definition: Quadratic Variation**

The **quadratic variation** of the symmetric random walk up to time $k$ is denoted by $[X, X]_k$ and is defined by:

$$
[X, X]_k = \sum_{j=1}^{k} (X_j - X_{j-1})^2
$$
```

### Computation

Then, we can compute the quadratic variation of the random walk along each path, by writing:

$$
[X, X]_k = \sum_{j=1}^{k} (X_j - X_{j-1})^2 = \sum_{j=1}^{k} 1 = k
$$

```{important}
**Key Observation:**

The quadratic variation of the random walk is:
- **Independent of the path** considered
- Equal to $\text{Var}[X_k]$
- Equal to $k$ (the number of steps)
```

**Physical Meaning:** The cumulative squared changes always sum to $k$, regardless of whether the walk went mostly up, mostly down, or oscillated. This deterministic accumulation of variance is crucial for continuous-time limits.

## Scaled Symmetric Random Walk

We apply to the symmetric random walk a well-chosen scaling that will allow us to pass to the continuous-time limit by using the Central Limit Theorem.

### Scaling Parameters

First of all, we denote by $n$ the **number of coin tosses per unit of time**.

We will let $n \to +\infty$ later in this discussion.

Secondly, since the aim is to derive a continuous-time model, we introduce the **continuous time variable** $t$.

### Rescaled Random Walk

```{important}
**Definition: Rescaled Random Walk**

The rescaled random walk is then defined as:

$$
W^{(n)}(t) = \frac{1}{\sqrt{n}} X_{nt}
$$

where $nt$ represents the total number of coin tosses in the time interval $[0, t]$.
```

**Physical Meaning:** We shrink the step size by $\frac{1}{\sqrt{n}}$ while speeding up time by a factor of $n$. This particular scaling preserves the variance structure in the limit.

### Handling Non-Integer Times

Of course, the number $nt$ is not always an integer and, at first, we do not know how to interpret $X_{nt}$ in the case when $nt$ is not an integer. Here is how this small technical issue can be handled in practice:

```{note}
**Linear Interpolation:**

- **If $nt$ is an integer:** $X_{nt}$ is already defined without ambiguity

- **If $nt$ is not an integer:** We define $W^{(n)}(t)$ by **linear interpolation** on the interval $[s, u]$ where:
  - $s$ is the nearest real number on the left of $t$ such that $ns$ is an integer
  - $u$ is the nearest real number to the right of $t$ such that $nu$ is an integer
```

### The Limiting Process

Next, our goal here is to let $n \to +\infty$.

```{note}
**Interpretation of the Limit:**

As $n$ increases:
- We are **accelerating time** (more tosses per unit time)
- We are **reducing the size of the steps** (dividing by $\sqrt{n}$)

At the limit $n \to +\infty$:
- We toss the coin **infinitely fast**
- The size of each step is **infinitesimally small**
```

**Physical Meaning:** In the limit, we obtain a continuous-time process with continuous paths but infinite variation (infinitely many infinitesimal jumps).

The particular choice for the step size ($\frac{1}{\sqrt{n}}$) versus the total number of coin tosses ($nt$) is dictated by the **Central Limit Theorem**.

## Properties of the Scaled Random Walk

### Independent Increments

The increments of the scaled random walk are **independent**.

For a collection of times:

$$
0 = t_0 < t_1 < t_2 < \cdots < t_{m-1} < t_m
$$

such that each $nt_j$ is an integer, the increments:

$$
W^{(n)}(t_1) - W^{(n)}(t_0), \quad W^{(n)}(t_2) - W^{(n)}(t_1), \quad \ldots, \quad W^{(n)}(t_m) - W^{(n)}(t_{m-1})
$$

are **independent random variables**.

**Physical Meaning:** What happens in non-overlapping time intervals are independent events, just as in the original random walk.

### Stationary Increments

The increments of the rescaled random walk are **stationary**.

**Physical Meaning:** The distribution of changes depends only on the time interval length, not on when the interval starts.

### Expectation and Variance

```{important}
**Mean of Increment:**

$$
E[W^{(n)}(t) - W^{(n)}(s)] = 0
$$
```

```{dropdown} Derivation of Variance

The variance of an increment of the scaled random walk is:

$$
\begin{align}
\text{Var}[W^{(n)}(t) - W^{(n)}(s)] &= E\left[\left(\frac{1}{\sqrt{n}} X_{nt} - \frac{1}{\sqrt{n}} X_{ns}\right)^2\right] \\
&= \frac{1}{n} E[(X_{nt} - X_{ns})^2] \\
&= \frac{1}{n}(nt - ns) \\
&= t - s
\end{align}
$$
```

```{important}
**Variance of Increment:**

$$
\text{Var}[W^{(n)}(t) - W^{(n)}(s)] = t - s
$$
```

**Physical Meaning:** Even though we're taking many small steps, the cumulative variance over a time interval $[s, t]$ is $t-s$. The scaling balances step size against number of steps perfectly.

### Martingale Property

The rescaled random walk satisfies the **martingale property** with respect to itself.

Let $0 \leq s \leq t$ such that $nt$ and $ns$ are integers:

$$
E[W^{(n)}(t) \mid \{W^{(n)}(\tau); 0 \leq \tau \leq s\}] = W^{(n)}(s)
$$

**Physical Meaning:** The best prediction of the future value, given all past information, is the current value. This is a "fair game" property.

### Quadratic Variation

We can define the **quadratic variation** of the rescaled random walk by using its natural partition.

Letting $t \geq 0$ be such that $nt$ is an integer, we have:

$$
\begin{align}
[W^{(n)}, W^{(n)}](t) &= \sum_{j=1}^{nt} \left\{W^{(n)}\left(\frac{j}{n}\right) - W^{(n)}\left(\frac{j-1}{n}\right)\right\}^2 \\
&= \sum_{j=1}^{nt} \left\{\frac{1}{\sqrt{n}} Y_j\right\}^2 \\
&= \sum_{j=1}^{nt} \frac{1}{n} \\
&= t
\end{align}
$$

```{important}
**Quadratic Variation Result:**

$$
[W^{(n)}, W^{(n)}](t) = t
$$
```

**Physical Meaning:** The quadratic variation equals time itself. This is a fundamental property that distinguishes Brownian motion from smooth functions (which have zero quadratic variation).

Clearly, when $nt$ is not an integer, one can prove the above properties by using interpolations.

## Central Limit Theorem

As $n \to +\infty$, the distribution of the scaled random walk at time $t$ converges to the **normal distribution** with mean 0 and variance $t$, with density function:

$$
f(x) = \frac{1}{\sqrt{2\pi t}} \exp\left(-\frac{x^2}{2t}\right)
$$

```{dropdown} Justification via Central Limit Theorem

To see this, we can apply the Central Limit Theorem to the random walk:

$$
X_{nt} = \sum_{i=1}^{nt} Y_i
$$

where the variables $Y_i$ have common mean 0 and common variance 1.

Then, by the Central Limit Theorem, we have that:

$$
\frac{X_{nt}}{\sqrt{nt}}
$$

converges in distribution to a standard normal distribution.

Equivalently, $W^{(n)}(t)$ converges to a normal distribution with mean 0 and variance $t$.
```

```{important}
**Convergence to Brownian Motion:**

As $n \to +\infty$:

$$
W^{(n)}(t) \xrightarrow{d} \mathcal{N}(0, t)
$$
```

**Physical Meaning:** No matter what the original step distribution (as long as it has mean 0 and variance 1), the rescaled sum converges to a normal distribution. This is the power of the Central Limit Theorem.

### Different Parameterization

Sometimes, the parameterization will be presented differently in the literature.

Consider a time frame of one year, i.e., $T = 1$.

You may for instance construct a random walk whose step size is $\sqrt{\Delta}$, where $\Delta$ is small.

The relationship between $\Delta$ and $n$ is:

$$
\Delta = \frac{1}{n}
$$

In this situation, the number of coin tosses is $\frac{1}{\Delta}$ on the time interval of length one, or in other words, there is one coin toss every $\Delta$ units of time.

```{warning}
**Existence of Brownian Motion:**

Proving the **existence** of the Brownian motion requires the use of more advanced theorems that won't be presented here.
```

## The Arithmetic Brownian Motion Model

In continuous-time, one can define the **random walk without drift** as:

$$
X(t) = X(0) + \sigma W(t)
$$

where $W(t)$ is a **standard Brownian motion**.

```{note}
**Volatility Parameter:**

We have incorporated a volatility parameter $\sigma > 0$ in the above model.
```

### Discretized Version

A discretized version of the above model is:

$$
X(\Delta) = X(0) + \sigma \sqrt{\Delta} \mathcal{N}(0, 1)
$$

where $\mathcal{N}(0, 1)$ denotes a normal random variable with mean 0 and variance 1, and $\Delta$ is the time step.

The above evolution equation must be coupled with an **initial condition**, such as $X(0) = X_0$, where $X_0$ is a given constant.

### Moments

In addition, we have:

$$
E[X(t)] = X(0), \quad \text{var}[X(t)] = \sigma^2 t
$$

**Physical Meaning:** The process has constant expected value but variance that grows linearly with time. This captures the increasing uncertainty over longer time horizons.

### Arithmetic Brownian Motion with Drift

More generally, we can define the **arithmetic Brownian motion with drift**:

$$
X(t) = X(0) + \mu t + \sigma W(t)
$$

where $\mu$ is the **drift parameter**.

```{note}
**Interpretation of Drift:**

This adds the deterministic trend $\mu t$ to the model.

- If $\mu > 0$: the random walk drifts **upward** over time and $X$ is a **submartingale**
- If $\mu < 0$: the random walk drifts **downward** and $X$ is a **supermartingale**
```

**Physical Meaning:** The drift $\mu$ represents the expected change per unit time. This models trends in addition to random fluctuations.

### Distribution

Clearly, the distribution of $X(t)$ at time $t$ is normal with:
- Mean: $X(0) + \mu t$
- Variance: $\sigma^2 t$

Both the expectation and the variance grow linearly in the time variable $t$.

### Drawback

```{warning}
**Flaw of Arithmetic Brownian Motion:**

$X(t)$ may take **negative values**, even if $\mu$ and $X_0$ are both positive.

This makes it unsuitable for modeling stock prices, which must remain non-negative.
```

**Physical Meaning:** While arithmetic Brownian motion is mathematically convenient, it can produce negative values, which is unrealistic for prices. This motivates the geometric Brownian motion model.

## The Binomial Tree Model: A Geometric Random Walk

In this model, the beginning of the time period is denoted by 0 and the end by 1.

### Initial Setup

At time 0, the asset price per share is denoted by $S_0$, where $S_0$ is a positive number.

A coin is tossed once and falls either on:
- **Head** with probability $p$
- **Tail** with probability $1-p$

We assume that $p$ and $1-p$ are both positive but they are not necessarily equal.

### One-Period Evolution

If a **head** is obtained:

$$
S_1(H) = uS_0 \quad \text{at time 1}
$$

If a **tail** is obtained:

$$
S_1(T) = dS_0
$$

where $u, d$ represent respectively the **up and down factors**.

```{note}
**Visual Representation:**

$$
\begin{array}{ccc}
& & S_1(H) = S_0 u \\
S_0 & \nearrow & \\
& \searrow & \\
& & S_1(T) = S_0 d
\end{array}
$$
```

### Multi-Period Extension

The experiment can be repeated infinitely many times and we can iterate this procedure for determining the next asset price from the previous one.

At each step, the next asset price $S_{n+1}$:
- Goes **up** by a multiplicative factor $u$ if a head is obtained
- Goes **down** by a multiplicative factor $d$ if a tail is obtained

$$
S_{n+1}(H) = uS_n, \quad S_{n+1}(T) = dS_n
$$

In particular, after the toss number 2, the price at time 2 becomes:

$$
\begin{align}
S_2(HH) &= uS_1(H) = u^2 S_0 \\
S_2(HT) &= dS_1(H) = du S_0 \\
S_2(TH) &= uS_1(T) = du S_0 \\
S_2(TT) &= dS_1(T) = d^2 S_0
\end{align}
$$

The third toss has 8 possible outcomes and, given $S_2$, you can compute the asset price $S_3$ for each of these outcomes.

**Physical Meaning:** The multiplicative structure ensures prices remain positive, addressing the main flaw of arithmetic Brownian motion.

## Re-Scaled Binomial Asset Pricing Model

We re-scale the Binomial asset pricing model in order to be able to pass to the continuous-time limit.

At the limit, we obtain the **geometric Brownian motion** asset price model.

### Simplifications and Setup

To simplify, we assume that the probabilities are $p = q = 1/2$ (the coin is fair).

Again, $n$ denotes the **number of coin tosses per unit of time** and we introduce a continuous-time variable $t$.

Hence, there are $nt$ tosses on the interval $[0, t]$.

We denote by $S_n(t)$ the **scaled asset price** at time $t$.

### Up and Down Factors

Next, the **up and down factors** are defined by:

$$
u_n = 1 + \frac{\sigma}{\sqrt{n}}, \quad d_n = 1 - \frac{\sigma}{\sqrt{n}}
$$

where $\sigma > 0$ is the **volatility coefficient**.

**Physical Meaning:** As $n$ increases, the up and down factors get closer to 1, but there are more tosses. The $\frac{1}{\sqrt{n}}$ scaling is crucial for convergence.

### Counting Heads and Tails

If $H_{nt}$ and $T_{nt}$ denote respectively the number of heads and tails in the first $nt$ coin tosses, we have:

$$
nt = H_{nt} + T_{nt}
$$

Next, we use the notation $X_{nt}$ introduced earlier:

$$
X_{nt} = \sum_{i=1}^{nt} Y_i
$$

Furthermore, we notice that we can rewrite it as:

$$
X_{nt} = H_{nt} - T_{nt}
$$

We have the equations:

$$
H_{nt} = \frac{1}{2}(nt + X_{nt}), \quad T_{nt} = \frac{1}{2}(nt - X_{nt})
$$

### Scaled Asset Price Formula

We can now write the scaled asset price as:

$$
\begin{align}
S_n(t) &= S(0) u_n^{H_{nt}} d_n^{T_{nt}} \\
&= S(0) \left(1 + \frac{\sigma}{\sqrt{n}}\right)^{\frac{1}{2}(nt + X_{nt})} \left(1 - \frac{\sigma}{\sqrt{n}}\right)^{\frac{1}{2}(nt - X_{nt})}
\end{align}
$$

**Physical Meaning:** The stock price is the initial price multiplied by the up factor raised to the number of up moves and the down factor raised to the number of down moves.

## Passage to the Limit

One can prove the following theorem by using the Central Limit Theorem and Taylor expansions.

```{important}
**Theorem: Convergence to Geometric Brownian Motion**

As $n \to +\infty$, $S_n(t)$ converges in distribution to the **geometric Brownian motion**:

$$
S(t) = S(0) \exp\left\{\sigma W(t) - \frac{1}{2}\sigma^2 t\right\}
$$

We refer to Shreve [2] for the proof.
```

**Physical Meaning:** The limiting continuous-time model is the exponential of an arithmetic Brownian motion. The $-\frac{1}{2}\sigma^2 t$ term (called the "drift correction") arises from Jensen's inequality and ensures the stock price is a martingale under the risk-neutral measure.

### Log-Normal Distribution

The distribution of $S(t)$ for fixed $t$ is called **log-normal** because $\log(S(t)/S(0))$ is distributed normally with:
- Mean: $-\frac{1}{2}\sigma^2 t$
- Variance: $\sigma^2 t$

```{dropdown} Verification

To see this, we write:

$$
\log\frac{S(t)}{S(0)} = \sigma W(t) - \frac{1}{2}\sigma^2 t
$$

Since $W(t)$ has a normal distribution with mean 0 and variance $t$, then:

$$
\log\frac{S(t)}{S(0)} \sim \mathcal{N}\left(-\frac{1}{2}\sigma^2 t, \sigma^2 t\right)
$$

Equivalently, $\log(S(t))$ has a normal distribution with:
- Mean: $\log(S(0)) - \frac{1}{2}\sigma^2 t$
- Variance: $\sigma^2 t$
```

**Physical Meaning:** Log-normality ensures prices are always positive and can grow without bound, consistent with limited liability for stocks.

## The Geometric Brownian Motion Asset Price Model

```{important}
**Geometric Brownian Motion (without drift):**

$$
S(t) = S(0) e^{-\frac{1}{2}\sigma^2 t + \sigma W(t)}, \quad t \in [0, T]
$$
```

### Advantages

The geometric Brownian motion is commonly used for modeling stock prices because:

1. The process $S(t)$ **stays nonnegative** for every time $t \geq 0$
2. It incorporates into the price a **multiplicative effect** that makes it a better fit for historical financial data over the long term, compared to the arithmetic Brownian motion (with the exception of high-frequency data)

```{note}
**Intraday Data:**

For intraday data, the arithmetic Brownian motion model tends to perform better.
```

**Physical Meaning:** Percentage changes (not absolute changes) are normally distributed, which better matches how we think about stock returns.

### Adding Drift

One can also add a drift term to the above model which then becomes:

$$
S(t) = S(0) e^{(\mu - \frac{1}{2}\sigma^2)t + \sigma W(t)}, \quad t \in [0, T]
$$

where $\mu > 0$ is the **actual instantaneous mean rate of return** of the stock.

In other words, $\mu$ is the return earned per unit of time.

```{note}
**Estimating the Drift:**

The value of $\mu$, which is notoriously hard to estimate, depends on:
- The **risk** of the stock (higher returns should correspond to higher risks)
- The level of **interest rates** in the economy (the higher the interest rates, the higher the expected return)
```

**Physical Meaning:** The drift $\mu$ represents the expected instantaneous return. In equilibrium, riskier stocks should have higher $\mu$ to compensate investors.

### The Volatility Coefficient

The coefficient $\sigma > 0$ is called the **volatility**.

More accurately, it is the **proportional change in the standard deviation** per unit of time.

A proportional change in the standard deviation of the stock price over a time interval of length $\Delta t$ is $\sigma\sqrt{\Delta t}$.

Usually, the time unit is **years**.

```{admonition} Example: Interpreting Volatility
:class: tip

**Setup:** Suppose that $\sigma = 0.3 = 30\%$ per year and the current stock price is 50 dollars.

**Question:** What is the standard deviation of the percentage change in the stock price in 1 week?

**Solution:**

The standard deviation of the percentage change in 1 week is:

$$
\sigma \sqrt{\Delta t} = 30\% \times \sqrt{\frac{1}{52}} = 30\% \times \frac{1}{\sqrt{52}} \approx 4.16\%
$$

**Interpretation:** A one-standard deviation move in the stock price in 1 week is:

$$
50 \times 0.0416 = 2.08 \text{ dollars}
$$
```

**Physical Meaning:** Volatility measures the intensity of random fluctuations. Higher volatility means more uncertain price movements and higher option values.

## Log Price and Log Returns

### Log Price

Taking the log of the left and right hand sides in the definition of the Geometric Brownian motion with drift, we obtain the **log price**:

$$
\log S(t) = \log S(0) + \left(\mu - \frac{1}{2}\sigma^2\right)t + \sigma W(t)
$$

Furthermore, the distribution of the log price $\log S(t)$ is normal with:
- Mean: $\log S(0) + (\mu - \frac{1}{2}\sigma^2)t$
- Variance: $\sigma^2 t$

**Physical Meaning:** The log price follows an arithmetic Brownian motion with drift, which is why we often work with log returns in practice.

### Log Return

Similarly, we can compute the **log return** of the asset price over the time interval $\Delta t$:

$$
r(t, \Delta t) = \log\frac{S(t + \Delta t)}{S(t)} = \left(\mu - \frac{1}{2}\sigma^2\right)\Delta t + \sigma(W(t + \Delta t) - W(t))
$$

It has a normal distribution with:
- Mean: $(\mu - \frac{1}{2}\sigma^2)\Delta t$
- Variance: $\sigma^2 \Delta t$

**Physical Meaning:** Log returns are normally distributed, additive over time, and symmetric (unlike simple returns which are multiplicative and right-skewed).

## Relative Rate of Return

One can alternately compute the **relative rate of return**, which is defined as:

$$
\begin{align}
r(t, \Delta t) &= \frac{S(t + \Delta t) - S(t)}{S(t)} \\
&= \frac{S(t)e^{(\mu - \frac{1}{2}\sigma^2)\Delta t + \sigma(W(t + \Delta t) - W(t))} - S(t)}{S(t)} \\
&= e^{(\mu - \frac{1}{2}\sigma^2)\Delta t + \sigma(W(t + \Delta t) - W(t))} - 1
\end{align}
$$

**Physical Meaning:** This is the actual percentage change in price. It's related to but distinct from the log return.

### Continuously Compounded Rate of Return

A slightly different point of view: we seek the constant continuously compounded rate of return $x$ earned on a stock between time $t$ and time $t + \Delta t$.

By definition, $x$ solves the equation:

$$
S(t + \Delta t) = S(t) e^{x \Delta t}
$$

Then, using the Geometric Brownian motion model for $S$, we compute:

$$
x = \frac{1}{\Delta t} \log\frac{S(t + \Delta t)}{S(t)} = \left(\mu - \frac{1}{2}\sigma^2\right) + \frac{1}{\Delta t}\sigma(W(t + \Delta t) - W(t))
$$

### Distribution of the Compounded Return

The distribution of $x$ is normal with:
- Mean: $\mu - \frac{1}{2}\sigma^2$
- Standard deviation: $\frac{\sigma}{\sqrt{\Delta t}}$

In particular, the **expected compounded rate of return** is:

$$
E[x] = \mu - \frac{1}{2}\sigma^2
$$

```{note}
**Relationship to Log Return:**

One can also relate $x$ to the log return we computed earlier:

$$
x = \frac{r(t, \Delta t)}{\Delta t}
$$
```

**Physical Meaning:** The continuously compounded return is just the log return divided by the time interval. Its expected value is less than $\mu$ by the amount $\frac{1}{2}\sigma^2$, which is the Jensen's inequality correction term.

### The $-\frac{1}{2}\sigma^2$ Term

```{admonition} Where Does the $-\frac{1}{2}\sigma^2$ Term Come From?
:class: tip

Finally, you may wonder: **Where does the $-\frac{1}{2}\sigma^2$ term come from?**

This will be made much clearer later, when we study the **chain rule of Stochastic Calculus** (Itô's Lemma).

**Preview:** It arises from the fact that $(dW)^2 = dt$ in stochastic calculus, leading to second-order terms that don't vanish in the limit.
```

**Physical Meaning:** This term corrects for the difference between the arithmetic mean and the geometric mean. It ensures that the expected stock price at time $t$ under geometric Brownian motion grows at exactly rate $\mu$, not faster.

## A Random Walk with Drift

Consider a time horizon of 1 year and toss a coin $n$ times per year.

We consider time steps of size $\Delta = 1/n$.

The probability of landing on heads is:

$$
p = \frac{1}{2}\left(1 + \mu\sqrt{\Delta}\right)
$$

where $\mu > 0$.

### Construction

We construct the discrete random walk $X_i$ after $i$ coin tosses by setting:

$$
X_0 = 0, \quad X_{i+1} - X_i = \begin{cases}
+\sqrt{\Delta} & \text{if a head is obtained} \\
-\sqrt{\Delta} & \text{if a tail is obtained}
\end{cases}
$$

```{admonition} Problem 1
:class: tip

1. Compute $E[X_{i+1} - X_i]$.
2. Compute $\text{var}[X_{i+1} - X_i]$.
3. What is the limit distribution of $X_n$ as $n \to +\infty$? Justify your answer.
```

```{dropdown} Solution

**Part 1: Expected Increment**

$$
\begin{align}
E[X_{i+1} - X_i] &= p \cdot \sqrt{\Delta} + (1-p) \cdot (-\sqrt{\Delta}) \\
&= \sqrt{\Delta}(2p - 1) \\
&= \sqrt{\Delta} \left(2 \cdot \frac{1}{2}(1 + \mu\sqrt{\Delta}) - 1\right) \\
&= \sqrt{\Delta} \cdot \mu\sqrt{\Delta} \\
&= \mu \Delta
\end{align}
$$

**Part 2: Variance of Increment**

$$
\begin{align}
\text{var}[X_{i+1} - X_i] &= E[(X_{i+1} - X_i)^2] - (E[X_{i+1} - X_i])^2 \\
&= \Delta - (\mu \Delta)^2 \\
&\approx \Delta \quad \text{(for small } \Delta\text{)}
\end{align}
$$

**Part 3: Limit Distribution**

As $n \to +\infty$ (so $\Delta \to 0$):
- $X_n$ has mean $\approx n \cdot \mu \Delta = \mu$ (since $n\Delta = 1$)
- $X_n$ has variance $\approx n \cdot \Delta = 1$

By the Central Limit Theorem:

$$
X_n \xrightarrow{d} \mathcal{N}(\mu, 1)
$$

**Conclusion:** $X_n$ converges to an arithmetic Brownian motion with drift $\mu$ and volatility $\sigma = 1$.
```

**Physical Meaning:** By biasing the coin slightly (making heads more likely), we introduce a drift into the random walk. In the limit, this produces Brownian motion with drift.

## Summary

In this lecture, we covered:

1. **From Discrete to Continuous:**
   - Scaling the random walk appropriately
   - Taking limits using the Central Limit Theorem
   - Convergence to Brownian motion

2. **Quadratic Variation:**
   - Definition and computation
   - The key property $[W, W](t) = t$

3. **Arithmetic Brownian Motion:**
   - Models with and without drift
   - Drawback: can become negative

4. **Geometric Brownian Motion:**
   - Convergence of binomial tree model
   - Log-normal distribution
   - Always positive prices

5. **Key Formulas:**
   - $S(t) = S(0) e^{(\mu - \frac{1}{2}\sigma^2)t + \sigma W(t)}$
   - Log returns are normally distributed
   - The $-\frac{1}{2}\sigma^2$ drift correction

6. **Applications:**
   - Stock price modeling
   - Option pricing foundation
   - Understanding volatility

These continuous-time models form the foundation for modern quantitative finance, including the Black-Scholes-Merton option pricing theory and continuous-time portfolio optimization.

---

## References

1. Steven E. Shreve, "Stochastic Calculus for Finance I: The Binomial Asset Pricing Model", 2004, Springer
2. Steven E. Shreve, "Stochastic Calculus for Finance II: Continuous-time Finance", 2004, Springer
