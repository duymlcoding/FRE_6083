---
title: "Lecture 1: Sequences and Sums of Random Variables"
author: "Agnès Tourin"
date: "July 30, 2024"
---

# Sequences and Sums of Random Variables

This lecture reviews fundamental concepts of sequences of random variables and sums of random variables in probability theory. Understanding this material is essential for comprehending financial and insurance models presented later in this course.

```{seealso}
**Recommended References:**
- Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
- Jean Jacod and Philip Protter, "Probability Essentials", Universitext, Second Edition, 2004, Springer
- Dan Stefanica, "A Primer for the Mathematics of Financial Engineering", second Edition, 2011, FE Press New York
```

## Sequence of Random Variables

### Probability Space Foundation

We begin with a probability space $(\Omega, \mathcal{A}, P)$, where:

```{note}
**Key Components of Probability Space:**

- **$\Omega$** = state space (set of all possible outcomes)
- **$\mathcal{A}$** = space of events (a σ-algebra)
- **$P$** = probability measure
```

```{admonition} Key Concept: Random Variable
:class: tip
A random variable is a deterministic function of an outcome $\omega \in \Omega$:

$$
X: \omega \in \Omega \to X(\omega) \in \mathbb{R}
$$

The randomness comes from the underlying outcome $\omega$, not from the function $X$ itself.
```

### Sequences of Random Variables

We consider a sequence $(X_n)_{n \in \mathbb{N}}$ of random variables, where the random variable depends on the index $n$. Typically, $n$ represents time.

**Physical Meaning:** As time progresses (increasing $n$), we observe different random outcomes. This framework allows us to model dynamic processes like stock prices, insurance claims, or weather patterns over time.

## First Example: The Bernoulli Distribution

### Bernoulli Trials

```{admonition} Example: Rolling a Die
:class: tip

**Experiment:** Roll a die infinitely many times on the probability space $(\Omega, \mathcal{P})$.

**Success Definition:** Rolling a six

**Key Property:** The outcomes of these trials are mutually independent.
```

### Bernoulli Random Variable

To each Bernoulli trial, we associate a Bernoulli random variable $X_k$ defined by:

$$
X_k = \begin{cases}
1 & \text{if } k\text{th trial is a success} \\
0 & \text{otherwise}
\end{cases}
$$

```{important}
**Probability Mass Function (Bernoulli Distribution):**

$$
p(x) = p^x(1-p)^{1-x}, \quad \text{for } x \in \{0,1\}
$$

where:
- $p$ = probability of success
- For rolling a six: $p = 1/6$
- $1-p$ = probability of failure
```

### Expectation of a Bernoulli Variable

```{note}
**Definition: Expectation of a Random Variable $X$**

$$
E[X] = \int_\Omega X(\omega) \, dP(\omega)
$$

In a discrete probability model, this simplifies to:

$$
E[X] = \sum_{\omega \in \Omega} X(\omega) P(\omega)
$$
```

For the Bernoulli variable defined above:

$$
E[X_k] = 0 \cdot (1-p) + 1 \cdot p = p
$$

**Physical Meaning:** The expected value of a Bernoulli trial equals the probability of success. If you roll a die many times, on average, you'll get a six with frequency $p = 1/6$.

## Sums of Random Variables

### The Binomial Distribution

We can define the sum:

$$
Y_n = \sum_{k=1}^{n} X_k
$$

where $X_k$ is the Bernoulli random variable defined earlier.

```{admonition} Key Concept: Partial Sums
:class: tip
The partial sum $(Y_n)_{n \in \mathbb{N}}$ is itself a sequence of random variables. It describes the **number of successes after $n$ trials**.
```

The distribution of $Y_n$ is Binomial with parameters $n$ and $p$:

```{important}
**Binomial Probability Mass Function:**

$$
p(x) = \binom{n}{x} p^x (1-p)^{n-x}, \quad \text{for } x \in \{0, 1, 2, 3, \ldots, n\}
$$

where:
- $n$ = number of trials
- $x$ = number of successes
- $p$ = probability of success on each trial
- $\binom{n}{x} = \frac{n!}{x!(n-x)!}$ = binomial coefficient
```

## Expectation of a Sum of Random Variables

```{important}
**Linearity of Expectation:**

For a sum $Y_n = \sum_{k=1}^{n} X_k$ of random variables:

$$
E[Y_n] = \sum_{k=1}^{n} E[X_k]
$$

This holds **regardless of whether the variables are independent or not**.
```

For the Bernoulli trials:

$$
E[Y_n] = \sum_{k=1}^{n} E[X_k] = \sum_{k=1}^{n} p = np
$$

```{note}
**General Linearity Property:**

For all real numbers $a, b$ and all random variables $X, Y$:

$$
E[aX + bY] = aE[X] + bE[Y]
$$
```

**Physical Meaning:** If you roll a die $n$ times with success probability $p = 1/6$, you expect to see $np = n/6$ sixes on average.

## Covariance of Random Variables

### Definition and Properties

```{important}
**Covariance Definition:**

For two random variables $X$ and $Y$:

$$
\text{cov}(X, Y) = E[(X - EX)(Y - EY)]
$$

This can also be rewritten as:

$$
\text{cov}(X, Y) = E[XY] - E[X]E[Y]
$$
```

```{note}
**Covariance Properties:**

1. **Linearity:** For three random variables $X$, $Y$, $Z$:
   $$
   \text{cov}(X, Y+Z) = \text{cov}(X, Y) + \text{cov}(X, Z)
   $$

2. **General Sum Formula:** For sums of $n$ and $m$ random variables:
   $$
   \text{cov}\left(\sum_{i=1}^{n} X_i, \sum_{j=1}^{m} Y_j\right) = \sum_{i=1}^{n} \sum_{j=1}^{m} \text{cov}(X_i, Y_j)
   $$
```

**Physical Meaning:** Covariance measures how two random variables move together. Positive covariance means they tend to increase together; negative covariance means when one increases, the other tends to decrease.

## Variance of a Sum of Random Variables

### General Formula

The variance of a random variable $X$ can be defined as:

$$
\text{var}[X] = \text{cov}(X, X) = E[(X - EX)^2]
$$

```{important}
**Variance of a Sum (General Case):**

$$
\text{var}\left(\sum_{i=1}^{n} X_i\right) = \sum_{i=1}^{n} \text{var}(X_i) + 2\sum_{i=1}^{n} \sum_{j<i} \text{cov}(X_i, X_j)
$$
```

### Special Case: Independent Variables

```{important}
**Variance of a Sum (Independent Variables):**

If $X_1, X_2, \ldots, X_n$ are pairwise independent random variables, then:

$$
\text{var}\left(\sum_{i=1}^{n} X_i\right) = \sum_{i=1}^{n} \text{var}(X_i)
$$

The cross terms vanish because $\text{cov}(X_i, X_j) = 0$ for independent variables.
```

### Application to Binomial Variable

For the Binomial variable $Y_n = \sum_{k=1}^{n} X_k$ where $X_k$ are Bernoulli variables:

First, compute the variance of a single Bernoulli variable:

$$
\text{var}(X_k) = E[X_k^2] - (E[X_k])^2 = p - p^2 = p(1-p)
$$

Since the Bernoulli variables are independent:

$$
\text{var}(Y_n) = \sum_{k=1}^{n} \text{var}(X_k) = np(1-p)
$$

```{warning}
**Important Note:**

Independence does not always hold in financial models. Sometimes we must use the more general formula that includes covariance terms. For example, in portfolio theory, asset returns are often correlated.
```

## Properties of Variance and Covariance

### Fundamental Properties

```{note}
**Key Properties:**

1. **Deterministic Variables:** $\text{var}[X] = 0$ if and only if $X$ is deterministic (constant).

2. **Linear Combination:** For all $(a, b) \in \mathbb{R}^2$ and random variables $(X, Y)$:
   $$
   \text{var}[aX + bY] = a^2\text{var}[X] + b^2\text{var}[Y] + 2ab\,\text{cov}(X, Y)
   $$

3. **Cauchy-Schwarz Inequality:** For all random variables $X$, $Y$:
   $$
   |\text{cov}(X, Y)|^2 \leq \text{var}[X]\,\text{var}[Y]
   $$

   Equivalently:
   $$
   |E[XY]|^2 \leq E[X^2]E[Y^2]
   $$
```

### Consequences and Special Cases

```{note}
**Important Consequences:**

1. If either $X$ or $Y$ is deterministic (constant), then $\text{cov}(X, Y) = 0$.

2. The Cauchy-Schwarz inequality is an equality if and only if $X$ is a multiple of $Y$ or $Y$ is a multiple of $X$.

3. If $X$ and $Y$ are independent, then $\text{cov}(X, Y) = 0$.
```

```{warning}
**Common Misconception:**

The converse of property 3 is **not true**. $X$ and $Y$ can be dependent in a nonlinear way but still have zero covariance.
```

### Counterexample: Zero Covariance Does Not Imply Independence

```{admonition} Example: Dependent Variables with Zero Covariance
:class: tip

**Setup:** Consider a discrete random variable $X$ taking values in $\{-1, 0, 1\}$ with probabilities:

$$
P(X = -1) = 0.25, \quad P(X = 0) = 0.5, \quad P(X = 1) = 0.25
$$

Define $Y = X^2$.

**Observation:** $Y$ is clearly dependent on $X$ (it's a function of $X$), but one can verify that $\text{cov}(X, Y) = 0$ because the relationship is nonlinear.
```

## Correlation Coefficient

```{important}
**Correlation Coefficient Definition:**

The correlation coefficient measures the **linear dependence** of two random variables:

$$
\rho_{X,Y} = \frac{\text{cov}(X, Y)}{\sqrt{\text{var}[X]\,\text{var}[Y]}}
$$
```

### Properties of Correlation

```{note}
**Correlation Properties:**

1. **Bounded:** By Cauchy-Schwarz, $-1 \leq \rho_{X,Y} \leq 1$.

2. **Zero Correlation:** $\rho_{X,Y} = 0$ if and only if $\text{cov}(X, Y) = 0$. We say that $X$ and $Y$ are **uncorrelated**.

   **Note:** Again, this does not imply independence!

3. **Perfect Correlation:** $\rho_{X,Y} = \pm 1$ if and only if $X$ and $Y$ are multiples of one another (perfectly linearly related).
```

**Physical Meaning:**
- $\rho = 1$: Perfect positive linear relationship
- $\rho = -1$: Perfect negative linear relationship
- $\rho = 0$: No linear relationship (but could have nonlinear relationship)
- $0 < |\rho| < 1$: Partial linear relationship

## Financial Application: Portfolio Returns and Variance

This section demonstrates how expectation and variance apply to financial portfolios.

### Portfolio Setup

Consider a portfolio of $N$ assets over a time period $[0, 1]$.

```{note}
**Notation:**

- $S_i(0)$ = price per share of the $i$th asset at time 0
- $S_i(1)$ = price per share of the $i$th asset at time 1
- $n_i$ = number of shares of $i$th asset held in the portfolio
- $\omega_i$ = fraction of wealth invested in the $i$th asset
```

### Asset Returns

The relative returns over the time period are denoted by $X_1, X_2, \ldots, X_N$:

$$
X_i = \frac{S_i(1) - S_i(0)}{S_i(0)}
$$

**Physical Meaning:** $X_i$ represents the percentage gain (or loss) on asset $i$ over the period.

### Portfolio Wealth

The total wealth at time 0:

$$
W_0 = \sum_{i=1}^{N} n_i S_i(0)
$$

The total wealth at time 1:

$$
W_1 = \sum_{i=1}^{N} n_i S_i(1)
$$

The fraction of wealth invested in the $i$th asset:

$$
\omega_i = \frac{n_i S_i(0)}{\sum_{i=1}^{N} n_i S_i(0)} = \frac{n_i S_i(0)}{W_0}
$$

Note that $\sum_{i=1}^{N} \omega_i = 1$ (portfolio weights sum to 1).

### Portfolio Return Calculation

```{dropdown} Derivation of Portfolio Return

The total relative return of the portfolio is:

$$
\begin{align}
R &= \frac{\sum_{i=1}^{N} n_i S_i(1) - \sum_{i=1}^{N} n_i S_i(0)}{\sum_{i=1}^{N} n_i S_i(0)} \\
&= \frac{\sum_{i=1}^{N} n_i (S_i(1) - S_i(0))}{\sum_{i=1}^{N} n_i S_i(0)} \\
&= \frac{\sum_{i=1}^{N} n_i X_i S_i(0)}{\sum_{i=1}^{N} n_i S_i(0)} \\
&= \sum_{i=1}^{N} X_i \frac{n_i S_i(0)}{\sum_{i=1}^{N} n_i S_i(0)} \\
&= \sum_{i=1}^{N} \omega_i X_i \\
&= \omega_1 X_1 + \omega_2 X_2 + \cdots + \omega_N X_N
\end{align}
$$
```

```{important}
**Portfolio Return Formula:**

$$
R = \sum_{i=1}^{N} \omega_i X_i
$$

**Key Insight:** The total return of the portfolio is a linear combination of the individual asset returns, weighted by the portfolio weights.
```

### Expected Portfolio Return

Using the linearity of expectation:

```{important}
**Expected Portfolio Return:**

$$
E[R] = \sum_{i=1}^{N} \omega_i E[X_i]
$$

The expected return is the weighted average of expected asset returns.
```

### Portfolio Variance

Using the variance formula for linear combinations:

```{important}
**Portfolio Variance:**

$$
\begin{align}
\text{var}[R] &= \text{var}\left[\sum_{i=1}^{N} \omega_i X_i\right] \\
&= \sum_{i=1}^{N} \omega_i^2 \text{var}[X_i] + \sum_{i=1}^{N} \sum_{j \neq i} \omega_i \omega_j \text{cov}(X_i, X_j) \\
&= \sum_{i=1}^{N} \omega_i^2 \text{var}[X_i] + \sum_{i=1}^{N} \sum_{j \neq i} \omega_i \omega_j \rho_{X_i,X_j} \sqrt{\text{var}[X_i]\text{var}[X_j]}
\end{align}
$$

where $\rho_{X_i,X_j}$ is the correlation coefficient between assets $i$ and $j$.
```

**Physical Meaning:** Portfolio variance depends on:
1. Individual asset variances (weighted by squared portfolio weights)
2. Pairwise correlations between assets (weighted by products of portfolio weights)

```{admonition} Key Takeaway: Diversification
:class: tip
The presence of covariance/correlation terms shows why diversification works. If assets are not perfectly correlated, the portfolio variance can be less than the weighted sum of individual variances. Negative correlations provide even better risk reduction.
```

## Distribution of a Sum of Random Variables

It is not always easy to determine the distribution of a sum of independent random variables in closed form, even when the distribution of each variable is known explicitly.

### Two Independent Variables

Let $X$ and $Y$ be two independent random variables.

```{note}
**Notation:**

- $F_{X+Y}$ = cumulative distribution function of $X+Y$
- $F_X$, $F_Y$ = cumulative distribution functions of $X$ and $Y$
- $f_Y$ = density of $Y$
```

### Convolution Formula

```{dropdown} Derivation of Convolution

By definition:

$$
\begin{align}
F_{X+Y}(z) &= P[X + Y \leq z] \\
&= P[X \leq z - Y] \\
&= \int_{-\infty}^{+\infty} \int_{-\infty}^{z-y} f_X(x) \, dx \, f_Y(y) \, dy \\
&= \int_{-\infty}^{+\infty} F_X(z-y) f_Y(y) \, dy
\end{align}
$$
```

```{important}
**Distribution of Sum (Convolution):**

$$
F_{X+Y}(z) = \int_{-\infty}^{+\infty} F_X(z-y) f_Y(y) \, dy
$$

The distribution of $X+Y$ is the **convolution** of the distributions $F_X$ and $F_Y$.
```

### Generalization to $n$ Variables

This result can be generalized by induction to compute the distribution of the sum of $n$ independent and identically distributed random variables.

If we denote by $F$ the common cumulative distribution function of each variable, the cumulative distribution function of the sum is the **$n$-fold convolution** of $F$ with itself.

Let $F_{n-1}$, $f_{n-1}$ be the cumulative distribution function and density function of $X_1 + \cdots + X_{n-1}$. Then:

```{important}
**$n$-fold Convolution Formulas:**

**CDF:**
$$
F_n(x) = \int_{-\infty}^{+\infty} F(x-y) f_{n-1}(y) \, dy
$$

**PDF (by differentiation):**
$$
f_n(x) = \int_{-\infty}^{+\infty} f(x-y) f_{n-1}(y) \, dy
$$
```

### Example Problem

```{admonition} Example: Sum of Uniform Variables
:class: tip

**Problem:** Let $X_1, \ldots, X_n$ be i.i.d. random variables uniformly distributed on the interval $[0, 1]$. Compute $F_n(1) = P\left[\sum_{i=1}^{n} X_i \leq 1\right]$.

**Hint:** Find a recursive relationship on $F_n(x)$ for $x \in [0, 1]$, and show that $F_n(x) = \frac{x^n}{n!}$.
```

```{note}
**Key Observation:**

As seen in the above example, one can sometimes characterize the distribution of a sum of independent random variables with a known common distribution. However, this is not always possible in closed form.
```

## The Sample Mean

### Definition

```{important}
**Sample Mean:**

Let $X_1, X_2, \ldots, X_n$ be independent and identically distributed random variables. Then:

$$
\overline{Y}_n = \frac{1}{n} \sum_{i=1}^{n} X_i
$$

is called the **sample mean**.
```

**Physical Meaning:** The sample mean is the average of $n$ observations. It's an estimator of the true population mean $\mu$.

### Expectation of Sample Mean

Denoting the common mean by $\mu$ and the common variance by $\sigma^2$:

$$
E[\overline{Y}_n] = \frac{1}{n} \sum_{i=1}^{n} E[X_i] = \frac{1}{n} \cdot n\mu = \mu
$$

```{admonition} Key Concept: Unbiased Estimator
:class: tip
The sample mean is an **unbiased estimator** of the population mean, because $E[\overline{Y}_n] = \mu$.
```

### Variance of Sample Mean

$$
\begin{align}
\text{var}[\overline{Y}_n] &= \frac{1}{n^2} \text{var}\left(\sum_{i=1}^{n} X_i\right) \\
&= \frac{1}{n^2} \sum_{i=1}^{n} \text{var}[X_i] \\
&= \frac{1}{n^2} \cdot n\sigma^2 \\
&= \frac{\sigma^2}{n}
\end{align}
$$

```{important}
**Variance of Sample Mean:**

$$
\text{var}[\overline{Y}_n] = \frac{\sigma^2}{n}
$$

**Key Insight:** The variance of the sample mean decreases as $n$ increases. This is why larger samples give more precise estimates.
```

### Covariance Between Sample Mean and Deviation

For $i = 1, \ldots, n$:

```{dropdown} Derivation

$$
\begin{align}
\text{cov}(\overline{Y}_n, X_i - \overline{Y}_n) &= \text{cov}(\overline{Y}_n, X_i) - \text{cov}(\overline{Y}_n, \overline{Y}_n) \\
&= \frac{1}{n}\text{cov}\left(X_i + \sum_{j \neq i} X_j, X_i\right) - \text{var}(\overline{Y}_n) \\
&= \frac{1}{n}\text{cov}(X_i, X_i) + \frac{1}{n}\sum_{j \neq i}\text{cov}(X_j, X_i) - \frac{\sigma^2}{n} \\
&= \frac{\sigma^2}{n} + 0 - \frac{\sigma^2}{n} \\
&= 0
\end{align}
$$
```

**Physical Meaning:** The sample mean is uncorrelated with the deviation of any individual observation from the sample mean.

## The Sample Variance

### Definition

```{important}
**Sample Variance:**

Let $X_1, \ldots, X_n$ be $n$ independent and identically distributed random variables with common mean $\mu$ and common variance $\sigma^2$. The **sample variance** is:

$$
S_n^2 = \frac{1}{n} \sum_{i=1}^{n} (X_i - \overline{Y}_n)^2
$$
```

### Expectation of Sample Variance

```{important}
**Expected Value of Sample Variance:**

$$
E[S_n^2] = \frac{n-1}{n}\sigma^2
$$
```

```{note}
**Bias Correction:**

Since $E[S_n^2] = \frac{n-1}{n}\sigma^2 \neq \sigma^2$, the sample variance $S_n^2$ is a **biased estimator** of $\sigma^2$.

The **unbiased sample variance** is:

$$
\tilde{S}_n^2 = \frac{1}{n-1} \sum_{i=1}^{n} (X_i - \overline{Y}_n)^2 = \frac{n}{n-1} S_n^2
$$

which satisfies $E[\tilde{S}_n^2] = \sigma^2$.
```

## Distribution of Sample Mean and Variance in the Normal Case

### Assumptions

We now assume that $X_1, \ldots, X_n$ are independent and have a normal distribution with common mean $\mu$ and common variance $\sigma^2$:

$$
X_i \sim \mathcal{N}(\mu, \sigma^2), \quad i = 1, \ldots, n
$$

### Important Results

```{important}
**Properties Under Normality:**

1. **Sample Mean Distribution:** $\overline{Y}_n$ is also distributed normally, with mean $\mu$ and variance $\frac{\sigma^2}{n}$:
   $$
   \overline{Y}_n \sim \mathcal{N}\left(\mu, \frac{\sigma^2}{n}\right)
   $$

2. **Independence:** $\overline{Y}_n$ is independent of $S_n^2$.

3. **Sample Variance Distribution:** $S_n^2$ has a chi-square distribution with $n-1$ degrees of freedom (after appropriate scaling):
   $$
   \frac{(n-1)S_n^2}{\sigma^2} \sim \chi^2_{n-1}
   $$
```

```{seealso}
For proofs of these results, see Sheldon Ross, "Introduction to Probability Models", Chapter 5.
```

## The Poisson Paradigm

### Modified Bernoulli Trials

We revisit Bernoulli trials, but this time with a variable success probability.

```{admonition} Setup: Poisson Paradigm
:class: tip

**Modified Assumptions:**
- The probability of success at the $k$th trial is $p_k$ (depends on trial number)
- We assume $p_k$ is **small** for all $k$
- Consider the number of successes $Y_n = \sum_{k=1}^{n} X_k$
```

### Moment Generating Function Approach

The moment generating function of $X_k$ is:

$$
\psi(t) = E[e^{tX_k}] = p_k e^t + (1-p_k) = 1 + p_k(e^t - 1)
$$

Since $p_k$ is small, $p_k(e^t - 1)$ is also small, and we can use the linear approximation $e^x \approx 1 + x$:

$$
\psi(t) \approx \exp(p_k(e^t - 1))
$$

### Poisson Approximation

```{dropdown} Derivation

The moment generating function of $Y_n$:

$$
\begin{align}
E[e^{tY_n}] &= E\left[e^{t\sum_{k=1}^{n} X_k}\right] \\
&= E\left[\prod_{k=1}^{n} e^{tX_k}\right] \\
&= \prod_{k=1}^{n} E[e^{tX_k}] \\
&\approx \prod_{k=1}^{n} \exp(p_k(e^t - 1)) \\
&= \exp\left(\sum_{k=1}^{n} p_k(e^t - 1)\right)
\end{align}
$$
```

```{important}
**Poisson Approximation:**

When $p_k$ is small, $Y_n$ is approximately Poisson distributed with parameter:

$$
\lambda = \sum_{k=1}^{n} p_k
$$

**Recall:** The moment generating function of a Poisson distribution is:
$$
E[e^{tX}] = e^{\lambda(e^t - 1)}
$$
```

**Physical Meaning:** When dealing with many trials, each with a small probability of success, the total number of successes follows approximately a Poisson distribution. This is why the Poisson distribution models rare events (insurance claims, equipment failures, etc.).

## The Elementary Arithmetic Random Walk

### Setup

```{admonition} Experiment: Coin Toss
:class: tip

**Experiment:** Toss a coin infinitely many times.

**Outcomes:**
- Head with probability $p$
- Tail with probability $1-p$

**Fair Coin:** $p = 1-p = 0.5$

**Key Property:** The tosses are independent.
```

### Random Walk Definition

Define the sequence of independent random variables:

$$
X_k = \begin{cases}
+1 & \text{if a head is obtained at the } k\text{th trial} \\
-1 & \text{if a tail is obtained at the } k\text{th trial}
\end{cases}
$$

The random walk $Y_n$ is defined by:

$$
Y_0 = 0, \quad Y_n = \sum_{k=1}^{n} X_k
$$

**Physical Meaning:** $Y_n$ represents the net position after $n$ steps. Each step moves up (+1) or down (-1). This models random movement and is fundamental in finance (stock prices), physics (Brownian motion), and many other fields.

### Properties of the Random Walk

```{important}
**Random Walk Properties:**

1. **Expected Step:**
   $$
   E[X_k] = p - (1-p) = 2p - 1
   $$
   For a fair coin ($p = 0.5$): $E[X_k] = 0$

2. **Expected Position:**
   $$
   E[Y_n | Y_0 = 0] = \sum_{k=1}^{n} E[X_k] = n(2p-1)
   $$
   For a fair coin: $E[Y_n] = 0$ (no drift)

3. **Variance of Step:**
   $$
   \text{var}[X_k] = E[X_k^2] - (E[X_k])^2 = 1 - (2p-1)^2 = 4p(1-p)
   $$

4. **Variance of Position:**
   $$
   \text{var}[Y_n] = \sum_{k=1}^{n} \text{var}[X_k] = 4pn(1-p)
   $$
   For a fair coin: $\text{var}[Y_n] = n$ (variance grows linearly with time)
```

```{note}
**Significance for Finance:**

This is one of the most important examples for financial applications. We will return to random walks many times throughout this course, as they form the basis for modeling stock prices and other financial quantities.
```

## Generalization of Random Walks

### General Autoregressive Model

One can generalize the previous example by allowing different distributions for the increments:

```{important}
**Generalized Random Walk (AR(1) Model):**

$$
Y_{n+1} = Y_n + \epsilon_{n+1}
$$

where the random variables $\epsilon_1, \epsilon_2, \ldots, \epsilon_{n+1}, \ldots$ are independent and identically distributed.

**Note:** The noise term is evaluated at time $n+1$.
```

By successive iterations:

$$
Y_{n+1} = Y_0 + \sum_{i=1}^{n+1} \epsilon_i
$$

where $Y_0$ denotes the initial condition at time $n=0$.

```{note}
**Connection to Econometrics:**

This model constitutes a particular case of the well-known **Autoregressive model** (abbreviated AR) in Econometrics.
```

### Example 1: Bernoulli Increments

The elementary example of the previous section corresponds to:

$$
\epsilon_{n+1} = \begin{cases}
-1 & \text{with probability } 1-p \\
+1 & \text{with probability } p
\end{cases}
$$

Given initial condition $Y_0$, the variable $Y_{n+1}$ has a binomial distribution with parameters $n+1$ and $p$ (shifted by $Y_0$).

### Example 2: Normal Increments

```{important}
**Normal Random Walk:**

Assume the residual is normally distributed:

$$
\epsilon_{n+1} \sim \mathcal{N}(0, \sigma^2)
$$

where $\sigma$ is a positive constant.

Given $Y_0$, the distribution of $Y_{n+1}$ is:

$$
Y_{n+1} \sim \mathcal{N}(Y_0, (n+1)\sigma^2)
$$

**Note:** The variance depends on time $n$ and increases linearly with $n$.
```

**Physical Meaning:** In a normal random walk, the position spreads out over time. The standard deviation grows as $\sqrt{n}$, meaning uncertainty increases with time. This is used in finance to model stock price movements.

### Issue: Thin Tails of Normal Distribution

```{warning}
**Drawback of Normal Distribution in Finance:**

A disadvantage of using the normal distribution in financial applications is the **thinness of its tails**, which makes extreme events appear very unlikely.

In risk management, we care about extreme events and want them to be adequately represented in models. For this purpose, distributions with **fatter tails** may be preferred.
```

### Example 3: Heavy-Tailed Random Walk (Pareto)

```{important}
**Heavy-Tailed Random Walk (Pareto Distribution):**

Consider residuals following the Pareto distribution with density function:

$$
f(x) = \begin{cases}
\frac{\alpha}{2} \frac{1}{|x|^{\alpha+1}} & \text{for } |x| \geq 1 \\
0 & \text{otherwise}
\end{cases}
$$

with $0 < \alpha < 2$.

**Key Property:** The normal distribution has exponentially fast decreasing tails, whereas the Pareto distribution has tails that decrease with a **power law**.
```

**Physical Meaning:** Power-law tails mean extreme events are much more likely than in the normal distribution. This better captures the reality of financial markets, where "Black Swan" events occur more frequently than normal distributions would predict.

### Example 4: Cauchy Random Walk

```{important}
**Cauchy Distribution:**

Another density that decreases at the same rate as Pareto when $\alpha = 1$ is the **Cauchy density function**:

$$
g(x) = \frac{1}{\pi} \frac{1}{1 + x^2}, \quad \text{for } x \in \mathbb{R}
$$
```

```{warning}
**Drawback of Heavy Tails:**

The downside of distributions with thick tails is the **lack of well-defined moments**.

In particular, the **Cauchy distribution does not have a well-defined mean and variance**.
```

### Example 5: Student's t-Distribution

The Cauchy distribution can be generalized to the **Student's t-distribution**:

```{important}
**Student's t-Distribution:**

$$
g(x) = \frac{\Gamma\left(\frac{\nu+1}{2}\right)}{\sqrt{\nu\pi} \, \Gamma\left(\frac{\nu}{2}\right)} \left(1 + \frac{x^2}{\nu}\right)^{-\frac{\nu+1}{2}}, \quad \text{for } x \in \mathbb{R}
$$

where:
- $\nu > 0$ represents the **degrees of freedom**
- $\Gamma(\cdot)$ is the gamma function

**Properties:**
- Median and mode are 0
- Mean is defined (and equal to 0) only when $\nu > 1$
- Variance is defined only when $\nu > 2$
- The case $\nu = 1$ corresponds to the Cauchy distribution
```

## Application to Equities

### Stock Log Returns

```{note}
**Notation:**

- $X_t$ = stock price per share at time $t$
- $Y_t = \log X_{t+1} - \log X_t$ = log return
```

### Model

We model the evolution of the stock log return over time as:

$$
Y_{t+1} = Y_t + \epsilon_{t+1}
$$

where the random variables $\epsilon_{t+1}$ are i.i.d.

**Interpretation:** Suppose one observes the stock price as time passes, and at time $t$, $Y_t$ is known. The above equation attempts to predict the log return at time $t+1$. The noise term is not known yet and remains uncertain until time $t+1$.

### Remarks on Distribution Choice

```{note}
**Choosing the Right Distribution:**

1. **Normal Distribution:**
   - If we assume the noise term is normally distributed, the likelihood of extreme price swings will be **underestimated**.
   - A distribution with fatter tails can capture these unlikely events better.

2. **Frequency Matters:**
   - At **low frequency** (daily, weekly, monthly data), the normal distribution may be appropriate as stock data looks more normal as frequency decreases.
   - At **high frequency** (intraday data), data typically has fatter tails.

3. **Empirical Evidence:**
   - The tails of the distribution of S&P 500 index futures log returns, sampled at 5-minute frequency, do not decrease exponentially.
   - They behave more like a power law.
   - **Important:** Tails are notoriously hard to estimate accurately.
```

## Characteristic Function of Sums

### Definition

```{important}
**Characteristic Function:**

For a real-valued random variable $X$:

$$
\varphi_X(u) = E[e^{iuX}], \quad \text{for all } u \in \mathbb{R}
$$

where $i = \sqrt{-1}$ is the imaginary unit.
```

```{note}
**Advantages of Characteristic Function:**

- The characteristic function **always exists**, in contrast to the moment generating function.
- Can be rewritten as:
  $$
  \varphi_X(u) = \int e^{iux} \, dF_X(x)
  $$
  where $F_X$ denotes the cumulative distribution function of $X$.
- When $X$ has a density function $f_X$:
  $$
  \varphi_X(u) = \int e^{iux} f_X(x) \, dx
  $$
```

### Sum of Independent Variables

```{important}
**Characteristic Function of Sum:**

Let $X, Y$ be independent real-valued random variables. Then:

$$
\varphi_{X+Y}(u) = \varphi_X(u) \varphi_Y(u)
$$

**Key Insight:** The characteristic function of a sum of independent variables is the **product** of individual characteristic functions. This is much simpler than the convolution formula for densities!
```

## Insurance Application: Aggregate Loss Model

### Model Setup

We present a simplified aggregate loss model in insurance.

```{note}
**Assumptions:**

- $N$ = total number of insurance claims (assumed constant)
- $X_n$ = insurer's loss amount for the $n$th claim (random)
- The variables $X_n$ are independent and identically distributed
- Common mean: $\mu$
- Common standard deviation: $\sigma$
```

### Total Loss

```{important}
**Aggregate Loss:**

$$
S_N = \sum_{n=1}^{N} X_n
$$
```

### Expected Loss

$$
E[S_N] = E\left[\sum_{n=1}^{N} X_n\right] = \sum_{n=1}^{N} E[X_n] = N\mu
$$

**Physical Meaning:** If we expect $N$ claims with average loss $\mu$ each, the total expected loss is $N\mu$.

### Variance of Loss

```{dropdown} Derivation

$$
\begin{align}
\text{var}[S_N] &= E\left[\left(\sum_{n=1}^{N} X_n\right)^2\right] - (E[S_N])^2 \\
&= E\left[\sum_{n=1}^{N} X_n^2 + \sum_{i} \sum_{j \neq i} X_i X_j\right] - N^2\mu^2 \\
&= \sum_{n=1}^{N} E[X_n^2] + N(N-1)\mu^2 - N^2\mu^2 \\
&= N(\mu^2 + \sigma^2) + N(N-1)\mu^2 - N^2\mu^2 \\
&= N\mu^2 + N\sigma^2 + N^2\mu^2 - N\mu^2 - N^2\mu^2 \\
&= N\sigma^2
\end{align}
$$
```

```{important}
**Variance of Aggregate Loss:**

$$
\text{var}[S_N] = N\sigma^2
$$

**Interpretation:** The variance of total loss scales linearly with the number of claims.
```

## Exercises

### Problem 1: Value at Risk with Different Distributions

```{admonition} Problem 1: Reflecting on Normal Distribution in Risk Management
:class: tip

**Context:** We consider a continuous random variable $X$ representing the profit and loss of a portfolio.

**Definition - Value at Risk (VaR):**
$$
\text{VaR}_q(X) = x_q
$$
where $x_q$ denotes the $q$-quantile of the distribution of $X$.

**Quantile Definition:** Denoting by $F$ the cumulative distribution function of the loss:
$$
x_q = F^{-1}(q)
$$
where $F^{-1}$ denotes the inverse function of $F$.

**Interpretation:** There is only a $q\%$ probability of incurring a loss of at least $\text{VaR}_q$ during the time period.

**Questions:**

1. Assume the distribution of $X$ is standard normal and take $q = 5\%$. Compute $\text{VaR}_q$ under these assumptions.

2. Assume that $X$ is Cauchy distributed and take $q = 5\%$. Compute $\text{VaR}_q$ under these assumptions.

   **Hint:** Compute and invert the Cauchy cumulative distribution function before computing VaR.

3. Compare the above results and conclude.
```

```{dropdown} Answers

1. **Standard Normal:** $\text{VaR}_{0.05} = -1.6449$ (approximately)

2. **Cauchy:** $\text{VaR}_{0.05} = -6.314$ (approximately)

3. **Conclusion:** The Cauchy distribution (with heavier tails) gives a much larger VaR, indicating higher risk. This demonstrates why the choice of distribution matters significantly in risk management. The normal distribution may underestimate extreme losses.
```

### Problem 2: Correlated Loan Portfolio

```{admonition} Problem 2: Portfolio of Correlated Loans
:class: tip

**Setup:** A portfolio of $n$ loans is modeled using correlated Bernoulli variables.

For $i = 1, \ldots, n$, define:

$$
X_i = \sqrt{\rho} Y + \sqrt{1-\rho} \epsilon_i
$$

where:
- $Y \sim \mathcal{N}(0,1)$ is a common factor to all loans
- $\rho \in (0,1)$ is the correlation coefficient between two loans
- $\epsilon_i \sim \mathcal{N}(0,1)$ are independent random variables
- $\epsilon_i$ is independent of $Y$ for all $i$

**Interpretation:** $X_i$ represents the value of the $i$th borrower's assets.

Define the Bernoulli variable:

$$
Y_i = \mathbb{I}_{\{X_i < x\}}
$$

where $\mathbb{I}$ is the indicator function and $x$ is the level below which loan $i$ defaults. In other words, $Y_i = 1$ if loan $i$ defaults and $Y_i = 0$ otherwise.

**Questions:**

1. Is the distribution of $X_i$ normal? Justify your answer.

2. Compute $E[X_i]$.

3. Compute $\text{var}[X_i]$.

4. Verify that $\text{cov}(X_i, X_j) = \rho$ for all $i \neq j$.

5. Write the probability $p_i$ of default of the $i$th loan in terms of the standard normal cumulative distribution function $\Phi$ and give $E[Y_i]$. Does $p_i$ depend on $i$?

6. Compute $\text{var}[Y_i]$.

7. The random variable $L$ represents the number of defaults in the portfolio. Write it in terms of the Bernoulli variables $Y_i$, for $i = 1, \ldots, n$.

8. Compute the expected loss.

9. Discuss the flaws of this model.
```

```{dropdown} Hints for Solutions

1. **Normality:** $X_i$ is a linear combination of independent normal variables, so it's normal.

2. **Mean:** Use linearity of expectation: $E[X_i] = \sqrt{\rho} E[Y] + \sqrt{1-\rho} E[\epsilon_i] = 0$.

3. **Variance:** Use independence: $\text{var}[X_i] = \rho \text{var}[Y] + (1-\rho) \text{var}[\epsilon_i] = 1$.

4. **Covariance:** $\text{cov}(X_i, X_j) = \text{cov}(\sqrt{\rho}Y, \sqrt{\rho}Y) = \rho$.

5. **Default Probability:** $p_i = P[X_i < x] = \Phi(x)$ (doesn't depend on $i$).

6. **Variance of Bernoulli:** $\text{var}[Y_i] = p_i(1-p_i)$.

7. **Total Defaults:** $L = \sum_{i=1}^{n} Y_i$.

8. **Expected Defaults:** $E[L] = \sum_{i=1}^{n} E[Y_i] = np$.

9. **Model Flaws:** This model assumes symmetric correlation structure, constant default threshold, Gaussian dependence (may miss tail dependence), etc.
```

---

## References

1. Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
2. Jean Jacod and Philip Protter, "Probability Essentials", Universitext, Second Edition, 2004, Springer
3. Dan Stefanica, "A Primer for the Mathematics of Financial Engineering", second Edition, 2011, FE Press New York
