---
title: "Lecture 2: Convergence, Law of Large Numbers, and Central Limit Theorem"
author: "Agnès Tourin"
date: "July 31, 2024"
---

# Convergence Concepts, Law of Large Numbers, Central Limit Theorem, Markov Sequences, and the Martingale Property

This lecture reviews several concepts of convergence that apply to sequences of random variables, the strong law of large numbers, and the Central Limit Theorem. We also present examples of applications in Finance, including Markov sequences and the martingale property.

```{seealso}
**Recommended References:**
- Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
- Jean Jacod and Philip Protter, "Probability Essentials", Universitext, Second Edition, 2004, Springer
- Timothy Falcon Crack, "Heard on the street: Quantitative Questions from Wall Street Job Interviews", revised 20th Edition, 2019
- Hull, J., "Options, Futures and Other Derivatives", 9th edition, 2009, Pearson/Prentice Hall
```

## Convergence of Random Variables

### Pointwise Convergence

```{note}
**Definition: Pointwise Convergence**

The sequence $X_n$ converges to the limit $X$ as $n \to +\infty$ if and only if:

$$
\text{For all } \omega \in \Omega, \quad X_n(\omega) \to X(\omega) \text{ as } n \to +\infty
$$
```

```{warning}
**Why Pointwise Convergence is Rarely Used:**

Convergence for all $\omega$ is **almost never used in probability** because, in most situations, this type of convergence simply does not work. It leads to a limit that does not provide much insight into the behavior of the sequence.

Consequently, it needs to be replaced by **weaker concepts of convergence**, such as convergence for almost all $\omega$.
```

### Example: Infinite Coin Toss

```{admonition} Example: Limiting Frequency of Heads
:class: tip

**Experiment:** Infinite coin toss with probability $p$ of falling on heads.

**Random Variable:**
$$
X_n = \begin{cases}
1 & \text{if a head is obtained at the } n\text{th toss} \\
0 & \text{if a tail is obtained at the } n\text{th toss}
\end{cases}
$$

**Study the Limit:**
$$
\lim_{n \to +\infty} \frac{X_1(\omega) + X_2(\omega) + \cdots + X_n(\omega)}{n}
$$
```

**Observations:**
- When the outcome is $\omega = (T, T, \ldots, T)$ (all tails), the limit equals 0.
- When $\omega = (H, H, \ldots, H)$ (all heads), the limit equals 1.
- As we will see with the **strong law of large numbers**, it converges for **almost all** $\omega$ to the intuitive limit $p$.

**Physical Meaning:** The fraction of heads in a long sequence of coin tosses approaches the probability $p$ of getting heads on any single toss.

## Almost Sure Convergence

```{important}
**Definition: Almost Sure Convergence**

$X_n \to X$ as $n \to +\infty$ **almost surely** if and only if:

$$
P\left\{\omega: \lim_{n \to +\infty} X_n(\omega) = X(\omega)\right\} = 1
$$

**Equivalent Formulation:**

$X_n \to X$ as $n \to +\infty$ almost surely if and only if the set:

$$
\mathcal{N} = \left\{\omega: \lim_{n \to +\infty} X_n(\omega) \neq X(\omega)\right\}
$$

has probability 0.
```

**Physical Meaning:** The sequence converges to $X$ for "almost all" outcomes, except possibly on a set of outcomes that has probability zero. This is the strongest useful notion of convergence in probability theory.

## Other Notions of Convergence

### Convergence in Probability

```{important}
**Definition: Convergence in Probability (i.p.)**

A sequence of random variables $X_n$ converges in probability to $X$ as $n \to +\infty$ if and only if:

$$
\lim_{n \to +\infty} P\{\omega: |X_n(\omega) - X(\omega)| > \epsilon\} = 0, \quad \text{for every } \epsilon > 0
$$
```

**Physical Meaning:** For any tolerance level $\epsilon > 0$, the probability that $X_n$ differs from $X$ by more than $\epsilon$ goes to zero as $n$ increases. The values of $X_n$ cluster around $X$ with high probability for large $n$.

### Convergence in Mean Squares

```{important}
**Definition: Convergence in Mean Squares (m.s.)**

A sequence of random variables $X_n$ converges in mean squares to $X$ as $n \to +\infty$ if and only if:

1. $E[|X_n|^2] < +\infty$ for all $n$
2. $E[|X|^2] < +\infty$
3. $\lim_{n \to +\infty} E[|X_n - X|^2] = 0$
```

**Physical Meaning:** The expected squared distance between $X_n$ and $X$ goes to zero. This is a stronger condition than convergence in probability and requires second moments to exist.

## Convergence in Distribution

```{important}
**Definition: Convergence in Distribution**

This notion of convergence is the **weakest** of all.

Roughly speaking, it is not the sequence of random variables $X_n$ that converges here but rather the sequence of its cumulative distribution functions $F_n$.

Let $F$ denote the distribution function obtained at the limit. The sequence of random variables $X_n$ converges in distribution to $X$ as $n \to +\infty$ if and only if:

$$
\lim_{n \to +\infty} F_n(x) = F(x) \quad \text{at each point } x \text{ of continuity of } F
$$
```

```{note}
**Subtle Concept:**

In reality, this concept of convergence is more subtle than described here. For a precise definition, see Jean Jacod and Philip Protter, "Probability Essentials".
```

**Physical Meaning:** The distributions of $X_n$ approach the distribution of $X$, even though the random variables themselves might not be getting close to each other on any particular outcome.

## Relations Between Different Notions of Convergence

```{important}
**Hierarchy of Convergence:**

The following diagram summarizes how these notions of convergence relate to each other:

$$
\begin{array}{ccc}
\text{Almost Sure (a.s.)} & & \text{Mean Squares (m.s.)} \\
\downarrow & & \downarrow \\
& \text{In Probability (i.p.)} & \\
& \downarrow & \\
& \text{In Distribution (in dis.)} &
\end{array}
$$

**Key Relationships:**
- Almost sure convergence $\Rightarrow$ Convergence in probability
- Mean squares convergence $\Rightarrow$ Convergence in probability
- Convergence in probability $\Rightarrow$ Convergence in distribution
```

```{warning}
**Important Note:**

None of the arrows above can be reversed in general, without adding more assumptions. See Jean Jacod and Philip Protter, "Probability Essentials" for more details.
```

## Law of Large Numbers and Central Limit Theorem

These are fundamental and very useful results with many applications in Quantitative Finance.

```{admonition} Key Insight: Why the Normal Distribution is Everywhere
:class: tip
The Central Limit Theorem explains the **prevalence of the normal distribution** in many practical applications. When you sum many independent random variables, the result tends toward a normal distribution, regardless of the original distributions!
```

### Setup and Assumptions

Let $X_1, X_2, \ldots$ be an infinite sequence of independent and identically distributed random variables (i.i.d. r.v.s).

Let $S_n = X_1 + X_2 + \cdots + X_n$.

**Assumptions:**
- $\mu = E[X_i] < +\infty$ (finite mean)
- $\sigma^2 = \text{var}[X_i] < +\infty$ (finite variance)

### The Theorems

```{important}
**Strong Law of Large Numbers (SLLN):**

$$
\lim_{n \to +\infty} \frac{S_n}{n} = \mu \quad \text{almost surely and in mean squares}
$$

**Physical Meaning:** The sample average of many i.i.d. random variables converges to their expected value.
```

```{important}
**Central Limit Theorem (CLT):**

If in addition $\sigma^2 > 0$, then as $n \to +\infty$:

$$
\frac{S_n - n\mu}{\sigma\sqrt{n}} \quad \text{converges in distribution to a standard normal distribution}
$$

Equivalently:
$$
\frac{S_n - n\mu}{\sigma\sqrt{n}} \xrightarrow{d} \mathcal{N}(0, 1)
$$

**Physical Meaning:** The normalized sum of many i.i.d. random variables becomes approximately normally distributed, regardless of the original distribution of the $X_i$.
```

## Examples of the Theorems

### Example 1: Coin Toss Revisited

```{admonition} Example: Law of Large Numbers for Coin Tosses
:class: tip

**Setup:** Going back to the earlier infinite coin toss example.

**Result:** By the strong law of large numbers:

$$
\lim_{n \to +\infty} \frac{X_1(\omega) + X_2(\omega) + \cdots + X_n(\omega)}{n}
$$

converges to $p$ **almost surely** (and in mean squares).

**Interpretation:** The long-run frequency of heads equals the probability of heads.
```

### Example 2: Central Limit Theorem for Bernoulli Trials

```{admonition} Example: CLT Applied to Binomial Distribution
:class: tip

**Context:** Bernoulli trials with sequence of Bernoulli random variables $X_k$ and number of successes after $n$ trials: $Y_n = \sum_{k=1}^{n} X_k$.

**Parameters:**
- Common expectation: $\mu = p$
- Common variance: $\text{var}[X_k] = E[X_k^2] - (E[X_k])^2 = p - p^2 = p(1-p)$

**Central Limit Theorem Result:**

The distribution of the rescaled number of successes:

$$
\frac{Y_n - np}{\sqrt{np(1-p)}}
$$

converges to the standard normal distribution $\mathcal{N}(0, 1)$ as $n \to +\infty$.

**Recall:** $Y_n$ has a Binomial distribution with parameters $n$ and $p$.
```

**Physical Meaning:** For large $n$, the binomial distribution can be approximated by a normal distribution. This is why we often use the normal distribution to approximate binomial probabilities.

## Application to Statistics: Consistent and Unbiased Estimators

### The Sample Mean as an Estimator

Let $X_1, \ldots, X_n$ be $n$ i.i.d. random variables. Consider the following estimator of their common mean $\mu$:

$$
\hat{\mu}_n = \frac{X_1 + X_2 + \cdots + X_n}{n}
$$

```{important}
**Properties of the Sample Mean:**

1. **Consistency:** By the strong law of large numbers, the estimator $\hat{\mu}_n$ is **consistent**, i.e.,
   $$
   \hat{\mu}_n \to \mu \quad \text{almost surely as } n \to +\infty
   $$

2. **Unbiasedness:** The estimator is **unbiased**, that is,
   $$
   E[\hat{\mu}_n] = \mu
   $$
```

**Physical Meaning:**
- **Unbiased:** On average, the estimator equals the true value.
- **Consistent:** As the sample size grows, the estimator converges to the true value.

## A Game Theory Application

Adapted from Timothy Falcon Crack, "Heard on the Street".

```{admonition} Example Problem: Two Games
:class: tip

**Problem Statement:**

You are offered two games:

**Game 1:** Roll a die once and you are paid 1 million dollars times the number you obtain on the upturned face of the die.

**Game 2:** Roll a die one million times and for each roll, you are paid 1 dollar times the number of dots on the upturned face of the die.

You are **risk averse**. Which game do you prefer?
```

```{dropdown} Solution

**Step 1: Calculate Expected Gain for Game 1**

Denote by $X$ the gain in dollars for the first game:

$$
E[X] = 10^6 \cdot 1 \cdot \frac{1}{6} + 10^6 \cdot 2 \cdot \frac{1}{6} + \cdots + 10^6 \cdot 6 \cdot \frac{1}{6}
$$

$$
E[X] = 10^6 \cdot \frac{1 + 2 + 3 + 4 + 5 + 6}{6} = 10^6 \cdot \frac{21}{6} = 3.5 \text{ Million dollars}
$$

**Step 2: Calculate Expected Gain for Game 2**

Denote by $Y$ the gain in dollars for the second game:

$$
E[Y] = 10^6 \left(1 \cdot \frac{1}{6} + 2 \cdot \frac{1}{6} + \cdots + 6 \cdot \frac{1}{6}\right) = 3.5 \text{ Million dollars}
$$

**Step 3: Apply Law of Large Numbers**

The expectation of the gain for each game is **3.5 million dollars**.

However, the law of large numbers tells you that, with the **second game**, your actual payoff will be **much closer to the expected payoff** than in the first game.

**Step 4: Compare Variances**

Another way of looking at it: Since you are **risk averse**, you prefer the game with the **lowest variance**.

It turns out that the variance of the first game is **1,000,000 times bigger** than the variance of the second game.

**Final Answer:** **Choose Game 2** if you are risk averse.

**Key Insight:** Game 2 provides the same expected return with dramatically lower risk due to diversification across one million independent trials.
```

```{note}
**Further Exploration:**

See Exercises 1 to 4 and 6 at the end of the chapter for more examples.
```

## Application to Non-Parametric Historical Estimations

### Setup

Consider an infinite sequence $X_1, X_2, \ldots, X_i, \ldots$ of i.i.d. random variables with a finite and positive variance.

Denote by $F$ their common cumulative distribution function.

### Empirical Distribution Function

Define:

$$
Y_i(x) = \mathbb{I}_{\{X_i \leq x\}}
$$

where $\mathbb{I}_{\{X_i \leq x\}}$ is the indicator function of the set $\{X_i \leq x\}$:

$$
\mathbb{I}_{\{X_i \leq x\}}(\omega) = \begin{cases}
1 & \text{if } X_i(\omega) \leq x \\
0 & \text{otherwise}
\end{cases}
$$

### Properties

```{important}
**Properties of $Y_i(x)$:**

1. The variables $Y_i(x)$ are **i.i.d.**

2. The common mean of $Y_i(x)$ is $F(x)$:
   $$
   E[Y_i(x)] = P[X_i \leq x] = F(x)
   $$

3. The **empirical distribution function**:
   $$
   F_n(x) = \frac{1}{n} \sum_{i=1}^{n} Y_i(x)
   $$
   satisfies:
   $$
   \lim_{n \to +\infty} F_n(x) = F(x) \quad \text{a.s., } \forall x
   $$

4. The common variance of $Y_i(x)$ is:
   $$
   \text{var}[Y_i(x)] = F(x)(1 - F(x))
   $$

5. The distribution of the error for the approximation of $F$ by $F_n$ as $n \to +\infty$ is **normal and centered**. The rate of convergence is:
   $$
   \frac{\sqrt{F(x)(1 - F(x))}}{\sqrt{n}}
   $$
```

**Physical Meaning:** We can estimate an unknown distribution function $F$ by counting the fraction of observations that fall below each value $x$. This empirical distribution converges to the true distribution.

### Glivenko-Cantelli Theorem

```{important}
**Glivenko-Cantelli Theorem:**

The theorem gives an even stronger result. It tells us that the convergence is **uniform** in the variable $x$:

$$
\sup_x |F_n(x) - F(x)| \to 0 \quad \text{a.s. as } n \to +\infty
$$
```

**Physical Meaning:** The empirical distribution function converges to the true distribution function uniformly over all values of $x$, not just pointwise. This is a remarkably strong result!

```{seealso}
See Exercise 5 for more details.
```

## Application to Monte Carlo Simulations

### Problem Setup

Consider the integral:

$$
a = \int_0^1 f(x) \, dx
$$

This can be interpreted as the following expectation:

$$
a = E[f(U)]
$$

where $U$ is a random variable that is uniformly distributed on the interval $(0, 1)$.

### Monte Carlo Method

Consider a sequence $U_1, U_2, \ldots, U_n$ of independent and uniformly distributed random variables in the interval $(0, 1)$.

```{important}
**Monte Carlo Approximation:**

By the strong law of large numbers:

$$
\lim_{n \to +\infty} \frac{1}{n} \sum_{i=1}^{n} f(U_i) = a, \quad \text{almost surely}
$$

**Interpretation:** We can approximate the integral by averaging function values at random points.
```

### Error Distribution

One can also determine the distribution of the error:

$$
\frac{1}{n} \sum_{i=1}^{n} f(U_i) - a
$$

by applying the Central Limit Theorem.

```{important}
**Error Distribution (CLT):**

By the Central Limit Theorem, the error is **normally distributed** with:
- Mean: 0
- Variance: $\frac{\sigma^2}{n}$

where:
$$
\sigma^2 = \int_0^1 (f(x) - a)^2 \, dx
$$
```

### Variance Estimation

The coefficient $\sigma^2$ is not known in general but it can be estimated in practice using the samples $U_i$ drawn from the uniform distribution.

```{note}
**Unbiased Statistical Estimate for $\sigma^2$:**

$$
\hat{\sigma}^2 = \frac{1}{n-1} \sum_{i=1}^{n} |f(U_i) - \hat{a}_n|^2
$$

where:
$$
\hat{a}_n = \frac{1}{n} \sum_{i=1}^{n} f(U_i)
$$
```

### When to Use Monte Carlo

```{note}
**Comparison with Traditional Methods:**

In principle, one can approximate a single integral using Monte Carlo simulations. However, approximating a single integral using the **Trapezoidal rule** would be more precise than the Monte Carlo simulations technique.

The Monte Carlo simulations method becomes **competitive as the number of dimensions increases** and it is often used in practice for the approximation of **multiple integrals in a high number of dimensions**.
```

**Physical Meaning:** For 1D integrals, deterministic quadrature rules are better. But for high-dimensional integrals (common in finance for pricing complex derivatives), Monte Carlo becomes superior because its convergence rate doesn't deteriorate with dimension.

## Markov Sequences

### Intuition: Sequences with "No Memory"

```{admonition} Key Concept: Markov Property
:class: tip
Some random sequences are said to have **no memory**.

Roughly speaking, this means that the **future distribution depends only on the current state** and not on the whole history.
```

### Example: Elementary Arithmetic Random Walk

```{admonition} Example: Random Walk is Markov
:class: tip

The symmetric random walk seen in the previous lecture does not have a memory since at each coin toss, you restart from scratch (each coin toss is independent from the previous one).

**Key Insight:**
- The **future** depends only on the **present**, not the **past**.
- The future value of the random walk is only determined by its present value and the outcomes of the next coin tosses.
- It does **not** depend on the whole path that the random walk took, starting at $X_0$.
```

**Physical Meaning:** Knowing where you are now is sufficient to predict the future distribution. How you got to the current position doesn't matter.

### Formal Definition

```{important}
**Definition: Markov Sequence**

More generally, we suppose that part of the history of a random sequence is known (i.e., has been observed).

We consider the future distribution conditionally to this past history.

A random sequence $(X_n)_{n \in \mathbb{N}}$ is said to be **Markovian** if for all $m < n$, for all $x$ in the state space:

$$
P[X_n \leq x \mid \{X_k, k \leq m\}] = P[X_n \leq x \mid X_m]
$$

**Interpretation:** The future distribution depends exclusively on the most recent observed value in the history.
```

### Example: Random Walk with Short Memory

```{admonition} Example: Non-Markov Process
:class: tip

**Setup:** At each round, one tosses a coin and obtains either:
- Head with probability $p$
- Tail with probability $1-p$

**Rules:**
- If a **head** is obtained: the random walk keeps going in the **same direction** as at the previous step
  - If it went up (+1) at the previous step, it goes up (+1) again
  - If it went down (-1) at the previous step, it goes down (-1) again

- If a **tail** is obtained: the random walk **reverses its direction**
  - If it went up, it now goes down
  - If it went down, it now goes up

**Conclusion:** The process $(Y_n)_n$ is **not Markovian** since it depends on two of its own lags (current position and position at the previous step).

We say that $(Y_n)_n$ is a process with **short memory**.
```

**Physical Meaning:** To predict the next move, you need to know both where you are and which direction you were moving. The current position alone is insufficient.

### Financial Application

```{admonition} Application: Stock Prices
:class: tip

**Context:** Consider a sequence of end-of-trading day stock prices.

**Markov Assumption:** Assuming that this sequence is Markov means that the stock price at the end of the $n$th trading day depends on the previous end-of-day prices **only through the price at the end of day $m$**.

**Implication:** All relevant information about past prices is summarized in the current price. This is related to the Efficient Market Hypothesis.
```

## The Discrete-Time Martingale Property

### Example: Symmetric Random Walk

The symmetric random walk we defined last week satisfies:

$$
E[X_n \mid X_0 = 0] = 0
$$

This leads to the general definition of a martingale.

### Definition: Martingale with Respect to Itself

```{important}
**Definition: Discrete-Time Martingale**

A sequence of random variables is a **discrete-time martingale with respect to itself** if for all integers $k, n \geq 0$:

$$
E[X_{k+n} \mid \{X_m, m = 0, \ldots, k\}] = X_k
$$

**Interpretation:** A martingale is expected to perform consistently on average. It does not have a tendency to rise, nor to fall.
```

**Physical Meaning:** The best prediction of future value, given all past information, is the current value. There's no systematic drift upward or downward. This is the mathematical formalization of a "fair game."

### More General Definition

```{important}
**Martingale with Respect to Another Process:**

If:
$$
E[X_{k+n} \mid \{Y_m, m = 0, \ldots, k\}] = X_k
$$

then $(X_n)_n$ is said to be a **discrete-time martingale with respect to the process** $(Y_n)_n$.
```

### Example: Random Walk as Martingale

The symmetric random walk defined in Lecture 1 is also a martingale with respect to the sequence of step functions $(Y_n)$ which were defined as:

$$
Y_n = \begin{cases}
+1 & \text{if a Head is obtained at toss number } n \\
-1 & \text{if a Tail is obtained at toss number } n
\end{cases}
$$

```{seealso}
We refer to Exercise 7 for another example of a martingale with respect to another process.
```

## The Asymmetric Random Walk

### Setup

Consider an elementary random walk which is **not necessarily symmetric**.

```{note}
**Parameters:**

- Probability of getting a Head: $p \in (0, 1)$
- Probability of getting a Tail: $q = 1 - p$

This corresponds to flipping a **biased coin**.
```

### Expectation Analysis

**Expected One-Step Increment:**

$$
E[Y_i] = p \cdot 1 + (1-p) \cdot (-1) = 2p - 1
$$

**Expected Position (starting at $X_0 = 0$):**

$$
E[X_n \mid X_0 = 0] = \sum_{i=1}^{n} E[Y_i] = n(2p - 1)
$$

### Martingale Classification

```{important}
**When is the Random Walk a Martingale?**

$p = 0.5$ is the **only value** of $p$ for which the random walk is a martingale.

**Three Cases:**

1. **$p = 0.5$:** The random walk is a **martingale** (fair game)
   $$
   E[X_n \mid X_0 = 0] = 0
   $$

2. **$p < 0.5$:** The random walk tends to **fall** and is called a **discrete-time supermartingale**
   $$
   E[X_n \mid X_0 = 0] = n(2p - 1) < 0
   $$

3. **$p > 0.5$:** The random walk tends to **rise** and is called a **discrete-time submartingale**
   $$
   E[X_n \mid X_0 = 0] = n(2p - 1) > 0
   $$
```

### Formal Definitions

```{important}
**Submartingale:**

A sequence of random variables is a **discrete-time submartingale** with respect to itself if for all integers $k, n \geq 0$:

$$
E[X_{k+n} \mid \{X_m, m = 0, \ldots, k\}] \geq X_k
$$

**Physical Meaning:** The process has a tendency to **increase** over time.
```

```{important}
**Supermartingale:**

A sequence of random variables is a **discrete-time supermartingale** with respect to itself if for all integers $k, n \geq 0$:

$$
E[X_{k+n} \mid \{X_m, m = 0, \ldots, k\}] \leq X_k
$$

**Physical Meaning:** The process has a tendency to **decrease** over time.
```

```{note}
**Generalization:**

It is straightforward to generalize these definitions to the cases of a submartingale or supermartingale $(X_n)$ with respect to another process $(Y_n)$.
```

## Financial Interpretation

```{admonition} Application to Finance
:class: tip

**Martingales in Finance:**

- **Fair Game:** A martingale represents a "fair game" where expected future value equals current value.
- **Efficient Markets:** Under the risk-neutral measure, discounted stock prices are martingales (fundamental to option pricing).
- **No Arbitrage:** The martingale property is closely related to the absence of arbitrage opportunities.

**Submartingales and Supermartingales:**

- **Submartingale:** Stock prices under the physical measure (with positive expected return/drift).
- **Supermartingale:** Discounted wealth in an unfavorable game or investment.
```

## Summary

In this lecture, we covered:

1. **Convergence Concepts:**
   - Almost sure convergence
   - Convergence in probability
   - Convergence in mean squares
   - Convergence in distribution

2. **Fundamental Limit Theorems:**
   - Strong Law of Large Numbers
   - Central Limit Theorem

3. **Applications:**
   - Statistical estimation
   - Monte Carlo simulations
   - Risk analysis in games

4. **Markov Property:**
   - Sequences with no memory
   - Applications to finance

5. **Martingale Property:**
   - Fair games
   - Submartingales and supermartingales
   - Financial applications

These concepts form the foundation for understanding stochastic processes in finance and are essential for derivative pricing, risk management, and statistical modeling.

---

## References

1. Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
2. Jean Jacod and Philip Protter, "Probability Essentials", Universitext, Second Edition, 2004, Springer
3. Timothy Falcon Crack, "Heard on the street: Quantitative Questions from Wall Street Job Interviews", revised 20th Edition, 2019
4. Hull, J., "Options, Futures and Other Derivatives", 9th edition, 2009, Pearson/Prentice Hall
