---
title: "Lecture 6: Introduction to Stochastic Processes"
author: "Agnès Tourin"
date: "October 11, 2024"
---

# Introduction to Stochastic Processes

Stochastic processes are used for modeling the time evolution of financial assets. In this lecture, we present some of the basic mathematical concepts and definitions of the theory of stochastic processes, such as stationarity and independence of increments. These concepts constitute the foundation for conducting empirical studies and building sound mathematical models.

```{seealso}
**Recommended References:**
- Jean Jacod and Philip Protter, "Probability Essentials", Universitext, Second Edition, 2004, Springer
- Paul Wilmott, Sam Howison, and Jeff Dewynne, "Mathematics of Financial Derivatives: A Student Introduction", Cambridge University Press, 1995
- Rama Cont, "Empirical properties of asset returns: stylized facts and statistical issues", Quantitative Finance, 1:223-236, 2001
- Dan Stefanica, "A Linear Algebra Primer for Financial Engineering: Covariance Matrices, Eigenvectors, OLS, and more", Financial Engineering Advanced Background Series, 2014, FE Press New York
```

## Introduction

In this course, we have already encountered some well-known examples of stochastic processes, i.e., random variables that depend on time.

```{note}
**Examples We've Seen:**

- **Sequences of random variables:** Stochastic processes in discrete time
- **Markov chains:** Stochastic processes with a discrete state space that satisfy the Markov property
- **Random walks:** Fundamental discrete-time processes
- **Poisson process:** A continuous-time counting process
```

We illustrate these concepts with an array of elementary examples, as well as examples that constitute the building blocks of many financial models: the random walk, the Poisson process, and the autoregressive model in Econometrics.

We also discuss the features of real financial data that have been discovered through empirical studies. Unfortunately, it is very difficult to come up with a model that possesses the same features as real financial data.

In addition to these notes, we refer for this discussion to the very well written and pedagogical article by Rama Cont [3].

## Preliminary Concepts and Examples

### The Framework

We consider a random experiment $\mathcal{E}$, i.e., an experiment that can be repeated under the same conditions, and whose result cannot be predicted with certainty.

Next, we denote as before, by $\Omega$, the **sample space**, i.e., the set of possible outcomes for the experiment $\mathcal{E}$.

We model the time by using a set $\mathcal{T}$. Generally, we will either have:
- $\mathcal{T} = [0, +\infty)$ for a continuous-time process
- $\mathcal{T} = \{0, 1, 2, 3, \ldots\}$ for a discrete-time process

### Definition of Stochastic Process

```{important}
**Definition: Stochastic Process**

A stochastic process is defined as a function $X$ of the time and of an outcome, $X(t, \omega)$ where $t \in \mathcal{T}$, $\omega \in \Omega$.

- For $\omega$ **fixed**, $\{X(t, \omega); t \in \mathcal{T}\}$ is called a **sample path**
- For $t$ **fixed**, $X(t)$ is a **random variable**
```

**Physical Meaning:** A stochastic process is a family of random variables indexed by time. You can think of it either as:
- A collection of random variables (one for each time $t$), or
- A random function of time (one function for each outcome $\omega$)

```{note}
**Alternative View:**

Roughly, a stochastic process is just a sequence of random variables. However, in continuous-time, we are dealing with a **continuum** of random variables indexed by the continuous time variable $t$.
```

### State Space

Often, the notation $S_X$ is used for the **state space**, which is the set of values that the stochastic process $X$ can take.

```{important}
**Classification by State Space:**

- If $S_X$ is finite or countably infinite, $X$ is said to be a **discrete-state process**
  - Examples: $S_X = \{0, 1, 2, \ldots, N\}$, $S_X = \mathbb{N}$, or $S_X = \mathbb{Z}$

- If $S_X$ is uncountably infinite (for instance $S_X = \mathbb{R}$), $X$ is said to be a **continuous-state process**
```

## Some Elementary Examples

```{admonition} Example 1: Linear Growth
:class: tip

Consider the continuous-time process $X(t, \omega) = tY(\omega)$ where $t \in (0, +\infty)$ and $Y > 0$ is a random variable.

Since $S_X = [0, +\infty)$, it is a **continuous-state process**.

**Physical Meaning:** The process grows linearly in time with a random growth rate $Y$.
```

```{admonition} Example 2: Time-Independent Process
:class: tip

Consider the trivial stochastic process $X(t, \omega) = Y(\omega)$, where $Y$ is a random variable.

Here, the stochastic process is actually entirely time-independent and boils down to a random variable.

**Physical Meaning:** The value is random but doesn't change over time once realized.
```

```{admonition} Example 3: Deterministic Process
:class: tip

Consider the trivial stochastic process $X(t, \omega) = c$, where $c \in \mathbb{R}$ is just a constant.

**Physical Meaning:** No randomness, just a constant value for all times and all outcomes.
```

```{admonition} Example 4: Deterministic Function of Time
:class: tip

Consider another trivial stochastic process $X(t, \omega) = t^2$.

Here $X$ is just a deterministic function of the real variable $t$.

**Physical Meaning:** The process evolves deterministically over time with no randomness.
```

```{admonition} Example 5: Exponential Decay
:class: tip

Consider the process $X(t, \omega) = e^{-t}Y(\omega)$, where $Y$ is a uniformly distributed random variable in the interval $(0, 1)$.

**Physical Meaning:** Random initial value that decays exponentially over time (see Problem 2).
```

## Example of the Symmetric Random Walk

```{admonition} Example: Symmetric Random Walk
:class: tip

Consider the discrete-time and discrete-state process that we have seen in the first lecture: the symmetric random walk.

**Experiment $\mathcal{E}$:** A coin is tossed infinitely many times

**Time set:** $\mathcal{T} = \{0, 1, 2, \ldots\}$

**Sample space:**
$$
\Omega = \{\omega = \omega_1 \omega_2 \ldots \omega_n \mid \omega_n \text{ is the outcome of the } n\text{th coin toss}\}
$$

At each toss, a **head** or a **tail** is obtained with respective probabilities $p$ and $1-p$.
```

### One-Step Increment

The one-step increment is defined as:

$$
Y_i = \begin{cases}
-1 & \text{if } \omega_i = T \\
+1 & \text{if } \omega_i = H
\end{cases}
$$

### Random Walk Definition

The random walk is defined as:

$$
X_0 = 0, \quad X_n = \sum_{i=1}^{n} Y_i \quad \text{for all } n \geq 1
$$

**Physical Meaning:** Starting at 0, the process moves up or down by 1 at each time step, depending on the coin toss. This is the discrete analog of Brownian motion.

## First and Second Moments

Here, we fix the time $t$.

```{important}
**First and Second Moments:**

- **First moment (mean):** $E[X(t)]$

- **Second moment (variance):**
  $$
  \text{Var}[X(t)] = E[(X(t) - E[X(t)])^2]
  $$
```

Some examples were shown in Chapter 1. One can also compute higher moments in a similar way, provided they exist.

**Physical Meaning:** The mean tells us the expected value at time $t$, while the variance measures the spread or uncertainty around that expected value.

## Distribution of a Stochastic Process

A stochastic process can be generally characterized by its distribution.

```{warning}
**Single-Time Distribution is Insufficient:**

If you simply fix the time $t \in \mathcal{T}$ and look at the distribution of the random variable $X(t, \cdot)$ at that fixed time, you **do not capture the time structure** of the stochastic process over time.
```

### Distribution Function of Order $k$

In order to characterize a stochastic process, you must look at the **joint distribution** of the process taken at different times.

```{important}
**Definition: Distribution Function of Order $k$**

Given an arbitrary set of $k$ times $t_1, t_2, \ldots, t_k$, the joint cumulative distribution function of the random vector $(X(t_1), X(t_2), \ldots, X(t_k))$ is given by:

$$
F(x_1, \ldots, x_k; t_1, \ldots, t_k) = P[X(t_1) \leq x_1, \ldots, X(t_k) \leq x_k]
$$
```

**Physical Meaning:** This captures the joint behavior of the process at multiple time points, which is essential for understanding the dynamics.

### Discrete and Continuous Cases

```{note}
**Discrete Case:**

In the discrete case, the distribution of order $k$ can also be described by the **probability mass function**:

$$
P(x_1, \ldots, x_k; n_1, \ldots, n_k) = P[X_{n_1} = x_1, \ldots, X_{n_k} = x_k]
$$
```

```{note}
**Continuous Case:**

In the continuous case, when the joint cumulative distribution function is differentiable $k$ times, the **joint density function** of order $k$ is given for a set of $k$ times, $t_1, t_2, \ldots, t_k$, by:

$$
f(x_1, \ldots, x_k; t_1, \ldots, t_k) = \frac{\partial^k}{\partial x_1 \cdots \partial x_k} F(x_1, \ldots, x_k; t_1, \ldots, t_k)
$$
```

## Independence and Stationarity of Increments

In financial models, we use as building blocks processes with independent and stationary increments, such as the one-step increments of the random walk.

```{important}
**Definition: Independent Increments**

If, for all $0 \leq t_1 < t_2 < t_3 < \cdots < t_n$, the random variables:

$$
X(t_2) - X(t_1), \quad X(t_3) - X(t_2), \quad \ldots, \quad X(t_n) - X(t_{n-1})
$$

are independent, then $X$ is said to be a process with **independent increments**.
```

**Physical Meaning:** What happens in one time interval doesn't affect what happens in a non-overlapping time interval. This is crucial for modeling unpredictable markets.

```{important}
**Definition: Stationary Increments**

If, for all $0 \leq t_1 < t_2$, for all $s \geq 0$, the random variables:

$$
X(t_2) - X(t_1) \quad \text{and} \quad X(t_2+s) - X(t_1+s)
$$

have the same distribution, $X$ is said to be a process with **stationary increments**.
```

**Physical Meaning:** The statistical properties of changes in the process depend only on the length of the time interval, not on when the interval starts. This is time-translation invariance.

## An Example: The Bernoulli Process Revisited

```{admonition} Example: Rolling a Die
:class: tip

**Bernoulli trials:** One rolls a die independently an infinite number of times and defines a **success** as rolling a six.

**Bernoulli process:** A sequence of Bernoulli random variables associated with Bernoulli trials $X_1, X_2, \ldots, X_k$:

$$
X_k = \begin{cases}
1 & \text{if } k\text{th trial is a success} \\
0 & \text{otherwise}
\end{cases}
$$
```

### Distribution and Expectation

The Bernoulli variable $X_k$ has a Bernoulli distribution:

$$
p(x) = p^x (1-p)^{1-x}, \quad \text{for } x = 0, 1
$$

with parameter $p = 1/6$.

In addition, its expectation is given by:

$$
E[X_k] = \text{probability of success} \cdot 1 = \frac{1}{6}
$$

### Cumulative Successes

One may also define the stochastic process $Y_n$ representing the **number of successes after $n$ trials**:

$$
Y_n = \sum_{k=1}^{n} X_k
$$

where $X_k$ are the Bernoulli random variables.

The distribution of $Y_n$ is **Binomial** with parameters $n$ and $p$.

By inverting this formula, we also obtain the relationship:

$$
X_{n+1} = Y_{n+1} - Y_n
$$

The process $X_{n+1} = Y_{n+1} - Y_n$ is called the **one-step increment** of the process $Y_n$.

### Independence and Stationarity

Furthermore, since $X_1, X_2, \ldots, X_n$ are independent random variables, the process $Y_n$ has **independent increments**.

Besides, since $Y_{k+n+1} - Y_{k+n} = X_{k+n+1}$ and $Y_{n+1} - Y_n = X_{n+1}$ have the same distribution, the process $Y_n$ also has **stationary increments**.

**Physical Meaning:** Each trial is independent of previous trials, and the probability structure doesn't change over time.

## Another Important Example: The Symmetric Random Walk

Given a set of integers $0 = k_0 < k_1 < \cdots < k_i < k_{i+1} < \cdots < k_m$, we define the increments of the random walk:

$$
X_{k_{i+1}} - X_{k_i} = \sum_{j=k_i+1}^{k_{i+1}} Y_j
$$

```{important}
**Properties of Random Walk:**

The increments:
$$
X_{k_1} - X_0, \quad X_{k_2} - X_{k_1}, \quad \ldots, \quad X_{k_i+1} - X_{k_i}, \quad \ldots, \quad X_{k_m} - X_{k_{m-1}}
$$

are **independent** random variables. So we can state that the random walk has **independent increments**.

Clearly, the increments of the random walk are also **stationary** since the coin tosses are independent and identical.
```

### Moments of Increments

```{dropdown} Derivation of Mean and Variance

**Mean of increment:**
$$
E[X_{k_{i+1}} - X_{k_i}] = \sum_{j=k_i+1}^{k_{i+1}} E[Y_j] = 0
$$

**Variance of increment:**
$$
\begin{align}
\text{Var}[X_{k_{i+1}} - X_{k_i}] &= E\left[\left(\sum_{j=k_i+1}^{k_{i+1}} Y_j\right)^2\right] \\
&= E\left[\sum_{j=k_i+1}^{k_{i+1}} Y_j^2 + \sum_{j=k_i+1}^{k_{i+1}} \sum_{k \neq j} Y_j Y_k\right] \\
&= \sum_{j=k_i+1}^{k_{i+1}} E[Y_j^2] + \sum_{j=k_i+1}^{k_{i+1}} \sum_{k \neq j} E[Y_j Y_k] \\
&= \sum_{j=k_i+1}^{k_{i+1}} 1 + \sum_{j=k_i+1}^{k_{i+1}} \sum_{k \neq j} 0 \\
&= k_{i+1} - k_i
\end{align}
$$
```

**Physical Meaning:** The variance of the increment over the time interval $[k_i, k_{i+1}]$ is equal to $k_{i+1} - k_i$, the length of the interval. This is characteristic of diffusive processes.

### Overall Mean and Variance

We also deduce the expectation and variance of the random walk from the last two results:

$$
E[X_k \mid X_0 = 0] = E[X_k - X_0 \mid X_0 = 0] = E[X_k - X_0] = 0
$$

$$
\text{Var}[X_k] = \text{Var}[X_k - X_0] = k
$$

**Physical Meaning:** The random walk has zero drift and variance that grows linearly with time, consistent with diffusive behavior.

## Autocovariance and Autocorrelation Functions

```{important}
**Definition: Autocovariance Function**

At the point $(t_1, t_2)$, it is defined by:

$$
C_X(t_1, t_2) = E[X(t_1)X(t_2)] - E[X(t_1)]E[X(t_2)]
$$

and can also be written as:

$$
C_X(t_1, t_2) = E[(X(t_1) - E[X(t_1)])(X(t_2) - E[X(t_2)])]
$$
```

**Physical Meaning:** The autocovariance measures how the process at time $t_1$ is related to the process at time $t_2$. Positive values indicate they tend to move together.

```{important}
**Definition: Autocorrelation Function**

At the point $(t_1, t_2)$, it is given by:

$$
\rho_X(t_1, t_2) = \frac{C_X(t_1, t_2)}{(\text{Var}[X(t_1)] \text{Var}[X(t_2)])^{1/2}}
$$
```

**Physical Meaning:** The autocorrelation is a normalized version of autocovariance, always between -1 and 1, making it easier to interpret the strength of the relationship.

## Example of the AR(1) Process for $a = 1$

We revisit the generalized random walk that was introduced in Chapter 1.

Consider the process $Y_n$ at time $n$, whose evolution is defined as:

$$
Y_{n+1} = Y_n + \epsilon_{n+1}
$$

where the random variables $\epsilon_1, \epsilon_2, \ldots, \epsilon_{n+1}, \ldots$ are independent and identically distributed.

We also assume that the variables $\epsilon_i$ are centered and we denote their common variance by $\sigma^2$.

By using successive iterations, one can also rewrite this model as:

$$
Y_{n+1} = Y_0 + \sum_{i=1}^{n+1} \epsilon_i
$$

where $Y_0$ denotes the initial condition at time $n = 0$.

### Computing the Autocovariance Function

```{dropdown} Derivation of Autocovariance

$$
\begin{align}
E[Y_{n+p} Y_n] &= E\left[\left(Y_0 + \sum_{i=1}^{n+p} \epsilon_i\right)\left(Y_0 + \sum_{i=1}^{n} \epsilon_i\right)\right] \\
&= Y_0^2 + \sum_{i=1}^{n+p} \sum_{j=1}^{n} E[\epsilon_i \epsilon_j] + Y_0 \left(\sum_{i=1}^{n+p} E[\epsilon_i] + \sum_{i=1}^{n} E[\epsilon_i]\right) \\
&= Y_0^2 + \sum_{i=1}^{n} E[\epsilon_i^2] + \sum_{i=1}^{n+p} \sum_{j=1, j \neq i}^{n} E[\epsilon_i]E[\epsilon_j] + 0 \\
&= Y_0^2 + n\sigma^2 + 0 \\
&= Y_0^2 + n\sigma^2
\end{align}
$$

Subtracting the product of the expectations, we find that the autocovariance function is given by:

$$
C_X(n+p, n) = n\sigma^2
$$
```

**Physical Meaning:** The autocovariance depends on the smaller of the two time indices, reflecting the cumulative variance up to that point.

## Strict Sense and Wide Sense Stationarity

We write two definitions of stationarity that are applicable to any process (not just its increments).

```{important}
**Definition: Strict Sense Stationary (SSS)**

$X$ is **strict sense stationary** if for all $s, n, t_1, \ldots, t_n, x_1, \ldots, x_n$:

$$
F(x_1, \ldots, x_n; t_1, \ldots, t_n) = F(x_1, \ldots, x_n; t_1+s, \ldots, t_n+s)
$$
```

**Physical Meaning:** The distribution of the stationary process is independent of a time shift. The statistical properties don't change over time, though the process itself may still vary.

```{important}
**Definition: Wide Sense Stationary (WSS)**

$X$ is **wide sense stationary** if:
1. $E[X(t)]$ is independent of $t$
2. $R_X(t, t+h) = E[X(t)X(t+h)]$ depends only on $h$ and not on $t$
```

**Physical Meaning:** WSS is a weaker condition than SSS, requiring only that the mean is constant and the autocovariance depends only on the time lag, not absolute time.

### Relationship Between SSS and WSS

```{note}
**SSS Implies WSS:**

If the process $X$ is strict stationary, it will also satisfy the wide-sense stationarity definition.

**Proof:**
1. If $X$ is strict stationary, we have that for all $t \geq 0$:
   $$
   E[X(t)] = E[X(0)]
   $$

2. By strict stationarity of $X$:
   $$
   E[X(t)X(t+h)] = E[X(0)X(h)]
   $$
   which only depends on $h$.

3. Finally, if $X$ is strict stationary, its variance does not depend on time:
   $$
   \text{var}(X(t)) = E[X(t)X(t)] - E[X(t)]^2 = E[X(0)^2] - E[X(0)]^2
   $$
```

## Examples of Stationarity

```{admonition} Example 1: Time-Independent Process
:class: tip

Let $X(t) = Y$ for $t \geq 0$ where $Y$ is a random variable.

**Conclusion:** Clearly, $X$ is SSS because its distribution does not depend on the time variable at all.
```

```{admonition} Example 2: Bernoulli Process
:class: tip

The Bernoulli process described earlier (number of successes) is **not WSS** because its expectation is not independent of the time $n$.

Indeed, $E[Y_n] = np$.
```

```{admonition} Example 3: Linear Growth Process
:class: tip

The process $X(t, \cdot) = tY(\cdot)$ where $Y$ is a random variable is **not WSS** since:

$$
E[X(t)] = tE[Y]
$$

is not independent of $t$, except in the special case where $E[Y] = 0$.
```

### Example 4: The Symmetric Random Walk

```{dropdown} Checking WSS for Random Walk

**Mean:**
Firstly, we have seen earlier that, for all $k$, $E[X_k] = 0$. So the random walk $(X_k)_k$ is independent of the time index $k$.

**Autocovariance:**
Next, we need to compute:
$$
\begin{align}
R_X(k, k+j) &= E[X_k X_{k+j}] \\
&= E[X_k(X_{k+j} - X_k) + X_k^2] \\
&= E[X_k]E[X_{k+j} - X_k] + E[X_k^2] \\
&= 0 + E[X_k^2] \\
&= k
\end{align}
$$

**Conclusion:** The symmetric random walk is **not WSS** since $R_X(k, k+j)$ depends on the time variable $k$.
```

**Physical Meaning:** Even though the random walk has constant mean, its autocovariance structure changes with absolute time, making it non-stationary.

## The AR(1) Process

We denote the AR(1) process at time $n$ by $X_n$. We assume that it follows the evolution:

$$
X_{n+1} = aX_n + \epsilon_{n+1}
$$

where the random variables $\epsilon_1, \epsilon_2, \ldots, \epsilon_n, \ldots$ are independent and identically distributed.

We assume that they are centered and denote their common variance by $\sigma^2$.

### Explicit Form

Given an initial condition $X_0$, we can rewrite $X_n$ as:

$$
\begin{align}
X_{n+1} &= aX_n + \epsilon_{n+1} \tag{1} \\
&= a^2 X_{n-1} + \epsilon_{n+1} + a\epsilon_n \tag{2} \\
&= a^{n+1}X_0 + \sum_{i=0}^{n} a^{n+1-i} \epsilon_i \tag{3}
\end{align}
$$

### Expectation

By using the fact that the variables $\epsilon_n$ are centered, we can obtain the expectation of $X_n$:

$$
E[X_{n+1}] = a^{n+1} X_0
$$

```{note}
**WSS Analysis:**

In general, the process is **not WSS** because its expectation depends on $n$, unless $X_0 = 0$.

**Long-run behavior:**
- When $|a| < 1$: $E[X_{n+1}] \to 0$ as $n \to +\infty$
  - 0 is the **long-run mean** of the process
- When $|a| > 1$: the mean explodes and does not converge to a constant
  - Precise behavior depends on the sign of $X_0$ and of $a$
```

**Physical Meaning:** For $|a| < 1$, the process is mean-reverting toward zero. For $|a| > 1$, it's explosive. The case $|a| = 1$ is a random walk (unit root).

### Variance

```{dropdown} Derivation of Variance

$$
\begin{align}
\text{var}[X_{n+1}] &= \sum_{i=0}^{n} a^{2i} \text{var}[\epsilon_i] \\
&= \sigma^2 \sum_{i=0}^{n} a^{2i} \\
&= \sigma^2 \frac{1 - a^{2(n+1)}}{1 - a^2}
\end{align}
$$
```

```{important}
**Long-Run Variance:**

- If $|a| < 1$: $\text{var}[X_{n+1}] \to \frac{\sigma^2}{1-a^2}$ as $n \to +\infty$
  - This result suggests that the AR(1) model is stationary in the long run when $|a| < 1$

- If $|a| > 1$: $\text{var}[X_{n+1}] \to +\infty$
  - The variance of the random walk is explosive in that case
```

**Physical Meaning:** When $|a| < 1$, the process settles into a stationary distribution with finite variance. When $|a| \geq 1$, variance grows without bound.

## The Gaussian Processes

```{admonition} Example: Wiener Process
:class: tip

We will study later the **Wiener process** (also called the Brownian motion), which is a Gaussian process.
```

### Definition

```{important}
**Definition: Gaussian Process**

A stochastic process $X$ is said to be a **Gaussian Process** if the vector:

$$
(X(t_1), X(t_2), \ldots, X(t_n))
$$

has a multi-normal distribution for any $n$ and for all $t_1, t_2, \ldots, t_n$.
```

**Physical Meaning:** At any finite collection of times, the joint distribution is multivariate normal. This makes analysis tractable while still capturing complex dependencies.

### Multi-Normal Distribution

```{important}
**Definition: Multi-Normal Distribution**

A random vector $(X_1, \ldots, X_n)$ has a multi-normal distribution if each random variable $X_k$ can be expressed as a linear combination of $m$ independent standard Gaussian random variables with $m \leq n$:

$$
X_k = \bar{X}_k + \sum_{j=1}^{m} c_{kj} Z_j
$$

where $\bar{X}_k \in \mathbb{R}$ and $Z_j \sim \mathcal{N}(0,1)$.
```

```{note}
**Key Properties:**

An immediate consequence of this definition is that any **affine combination** of multi-normally distributed random vectors has a multi-normal distribution.

Furthermore:
$$
\begin{align}
E[X_k] &= \bar{X}_k \\
\text{Var}[X_k] &= \sum_{j=1}^{m} c_{kj}^2 \\
\text{Cov}[X_i, X_k] &= \sum_{l=1}^{m} c_{il} c_{kl}
\end{align}
$$
```

### Joint Distribution

The joint distribution of the vector $(X_1, X_2, \ldots, X_n)$ is completely determined by the **vector of means** $\boldsymbol{\mu} = (\bar{X}_1, \ldots, \bar{X}_n)$ and the **covariance matrix** $K$.

$$
K = \begin{bmatrix}
\text{Var}[X_1] & \text{Cov}[X_1, X_2] & \cdots & \text{Cov}[X_1, X_n] \\
\text{Cov}[X_1, X_2] & \text{Var}[X_2] & \cdots & \text{Cov}[X_2, X_n] \\
\vdots & \vdots & \ddots & \vdots \\
\text{Cov}[X_1, X_n] & \cdots & \cdots & \text{Var}[X_n]
\end{bmatrix}
$$

Note that since $\text{Cov}[X_i, X_j] = \text{Cov}[X_j, X_i]$, the matrix $K$ is **symmetric**.

### Density Function

If $K$ is nonsingular, the density of $(X_1, X_2, \ldots, X_n)$ exists and can be written as:

$$
f_X(x) = \frac{1}{(2\pi)^{n/2}} \frac{1}{(\det K)^{1/2}} \exp\left\{-\frac{1}{2}(x - \boldsymbol{\mu})^T K^{-1} (x - \boldsymbol{\mu})\right\}
$$

```{warning}
**Singular Covariance Matrix:**

If $K$ is singular, the vector of random variables $(X_1, \ldots, X_n)$ does not even have a density function!
```

### Properties of Covariance Matrix

$K$ is also **nonnegative definite** in the following sense:

$$
\sum_{i=1}^{n} \sum_{j=1}^{n} \lambda_i \lambda_j \text{Cov}[X_i, X_j] \geq 0 \quad \text{for all } \boldsymbol{\lambda} = (\lambda_1, \ldots, \lambda_n) \in \mathbb{R}^n
$$

```{important}
**Independence Condition:**

In the case when $(X_1, X_2, \ldots, X_n)$ has a multi-normal distribution, the random variables $X_1, X_2, \ldots, X_n$ are **independent if and only if** the matrix $K$ is a diagonal matrix.
```

```{warning}
**General Caveat:**

In general, zero linear correlations do not imply independence! The random variables could depend on one another in a nonlinear way.
```

We recommend Jacod and Protter [1] for a review of the multi-normal distribution and Stefanica [4] for a review of linear algebra.

### Gaussian Processes and Stationarity

```{important}
**Theorem: WSS Implies SSS for Gaussian Processes**

If a Gaussian process is weak sense stationary, then it is also strict sense stationary.
```

```{dropdown} Proof

We consider a Gaussian process $X$ and suppose that it is weak sense stationary. Then, we can write that:

$$
R_X(t_1, t_2) = R_X(t_1 - t_2)
$$

and:

$$
m_X(t) = \mu
$$

where $\mu$ is a constant since the expectation of $X$ does not depend on $t$.

Furthermore, we know that the joint distribution of $X$ taken at different times is uniquely characterized by $\boldsymbol{\mu}$ and:

$$
C_X(t_1, t_2) = R_X(t_1 - t_2) - \mu^2
$$

and hence is invariant with respect to any translation in the time variable $t + s$.
```

**Physical Meaning:** For Gaussian processes, second-order properties (mean and covariance) completely determine the distribution, so WSS automatically implies full stationarity.

## Ergodicity

Generally, a process is said to be **ergodic** if any of its characteristics can be obtained from observing a single sample path in the long run.

A stochastic process can be:
- **Mean-ergodic**
- **Distribution-ergodic**
- **Autocorrelation function-ergodic**
- etc.

In this lecture, we focus on **mean-ergodicity**.

### Temporal Mean

First of all, we define the **temporal mean** of the process $X$ as follows:

$$
\langle X \rangle_{\tau} = \frac{1}{\tau} \int_0^{\tau} X(t, \omega) \, dt
$$

Next, we assume that the expectation of the process $X$ is independent of time and we let $m = E[X(t)]$ be the constant mean of $X$.

### Mean-Ergodic Definition

```{important}
**Definition: Mean-Ergodic**

A process $X$ with constant mean $m$ is said to be **mean-ergodic** if:

$$
\lim_{\tau \to +\infty} \text{var}[\langle X \rangle_{\tau}] = 0
$$
```

Since:

$$
E[\langle X \rangle_{\tau}] = \frac{1}{\tau} \int_0^{\tau} E[X(t)] \, dt = m
$$

the above definition is equivalent to the convergence of the temporal mean to $m$ in mean-squares as $\tau \to +\infty$.

```{note}
**Equivalent Definition:**

A process $X$ with constant mean $m$ is said to be mean-ergodic if:

$$
\lim_{\tau \to +\infty} E[(\langle X \rangle_{\tau} - m)^2] = 0
$$
```

**Physical Meaning:** For an ergodic process, you can estimate the ensemble average (expected value over all outcomes) by computing a time average along a single sample path. This is crucial for empirical analysis where we only observe one realization.

## Examples of Ergodicity

```{admonition} Example 1: Time-Independent Process (Not Ergodic)
:class: tip

Let $X(t) = Y$, where $Y$ is a random variable, for all $t$.

$X$ is **not mean-ergodic**.

Indeed:
$$
E[X(t)] = E[Y]
$$

$$
\langle X \rangle_s = \frac{1}{s} \int_0^s X(u) \, du = \frac{1}{s} \int_0^s Y \, du = Y
$$

Consequently:
$$
\text{var}[\langle X \rangle_s] = \text{var}[Y] \neq 0
$$
```

**Physical Meaning:** The time average equals the random variable $Y$ itself, not its expected value. Different sample paths give different time averages.

```{admonition} Example 2: Bernoulli Variables (Ergodic)
:class: tip

The Bernoulli variables introduced in Chapter 1 are a **mean-ergodic process**.

In a discrete-time setting, the integral must be replaced by a discrete sum:

$$
\langle X \rangle_N = \frac{1}{N+1} \sum_{n=0}^{N} X(n, \omega)
$$
```

```{dropdown} Verification of Ergodicity

In the case of the Bernoulli variables:

$$
E[\langle X \rangle_k] = E\left[\frac{1}{k} \sum_{i=1}^{k} X_i\right] = \frac{1}{6} = E[X_i]
$$

and:

$$
\begin{align}
\lim_{k \to +\infty} \text{var}[\langle X \rangle_k] &= \lim_{k \to +\infty} \frac{1}{k^2} \sum_{i=1}^{k} \text{var}[X_i] \\
&= \lim_{k \to +\infty} \frac{1}{k^2} k\left(\frac{1}{6} - \frac{1}{36}\right) \\
&= \lim_{k \to +\infty} \frac{1}{k} \left(\frac{1}{6} - \frac{1}{36}\right) \\
&= 0
\end{align}
$$
```

```{admonition} Example 3: One-Step Increment of Random Walk (Ergodic)
:class: tip

The one-step increment $(k+1, \omega) \mapsto Z_{k+1}(\omega) = X_{k+1}(\omega) - X_k(\omega)$ of the symmetric random walk is a **mean-ergodic process** with mean 0.
```

```{dropdown} Verification for Random Walk Increment

Indeed, computing the temporal mean of $Z$:

$$
\langle Z \rangle_k = \frac{1}{k+1} \sum_{i=0}^{k} (X_{i+1} - X_i) = \frac{1}{k+1}(X_{k+1} - X_0) = \frac{X_{k+1}}{k+1}
$$

Hence:
$$
E[\langle Z \rangle_k] = 0
$$

and, similarly as in the previous example:

$$
\lim_{k \to +\infty} \text{var}[\langle Z \rangle_k] = \lim_{k \to +\infty} \frac{1}{(k+1)^2} (k+1) = 0
$$
```

## The Features of Real Financial Data

This section summarizes some of the findings of the published article by Rama Cont [3].

### Log Returns

What we have in mind here is the study of the characteristics of the evolution of the **log return** of a financial asset, where, if $S(t)$ denotes the price of the asset, the log return over the time interval $[t, t+\Delta t]$ is defined as:

$$
r(t) = \log S(t + \Delta t) - \log S(t)
$$

```{note}
**Time Scale Dependence:**

The properties of the time series $r(t)$ depend on the **time scale** considered, that is, the exact value of $\Delta t$.

In particular, **high-frequency data** reflects the microstructure of financial markets and possesses different characteristics than data at lower frequencies.
```

However, researchers have established some common features shared by a wide range of financial assets across a range of time scales, excluding small intraday time scales.

### Stylized Facts

```{important}
**Stylized Fact 1: Near-Zero Linear Autocorrelations**

The linear autocorrelations are typically **almost zero**.

**Note:** This is no longer true for small intraday time scales (< 20 minutes).

**Important:** The fact that the linear autocorrelation $\rho_X(t, t+\tau)$, where $\tau$ denotes the time lag, is zero does **not** imply the independence of the log returns $r(t)$ and $r(t+\tau)$!
```

**Physical Meaning:** Past returns don't predict future returns in a linear way, consistent with weak-form market efficiency. However, nonlinear dependencies may still exist.

```{important}
**Stylized Fact 2: Fat Tails**

The distribution of returns has **fat tails**, which means that very brutal market events have a non-negligible probability of happening.

The tail behavior is **power-law or Pareto-like**.
```

For instance, the cumulative distribution function $F$ of a Pareto distribution is parametrized by $\alpha$, which is known as the **tail index**, and also by $x_m$, which is the mode:

$$
F(x) = \begin{cases}
1 - \left(\frac{x_m}{x}\right)^\alpha & x \geq x_m \\
0 & x < x_m
\end{cases}
$$

**Physical Meaning:** Extreme events (crashes, spikes) are much more likely than the normal distribution would predict. This has major implications for risk management.

### Tail Index

Generally, the **tail index** $\alpha$ of the distribution, which measures how thick the tail is, is defined as the highest absolute moment which is finite.

```{note}
**Tail Index Values:**

- For both the Gaussian and exponential distributions: $\alpha = +\infty$ (all moments are finite)
- For a power-law distribution: the tail index is the exponent of the distribution
- The tail index can be measured using statistical methods
```

```{important}
**Empirical Evidence:**

In practice, simple studies show that US and French equities as well as exchange rates seem to have a **finite variance**.

Techniques based on extreme values confirm that the index is generally:
- Strictly bigger than two
- Lower or equal to five
- Its value is typically around **three**
```

**Physical Meaning:** With $\alpha \approx 3$, the variance exists but higher moments may not. This is heavier-tailed than normal but not as extreme as Cauchy.

```{important}
**Stylized Fact 3: Up-Down Move Asymmetry**

One observes an **up-down move asymmetry**. Indeed, large drawdowns in stock prices are not compensated by equally large gains.
```

**Physical Meaning:** Markets tend to fall faster than they rise. Losses often occur more suddenly and dramatically than gains.

```{important}
**Stylized Fact 4: Convergence to Normality at Longer Scales**

As the time scale $\Delta t$ increases, the distribution of the log returns looks more and more like a **normal distribution**.

This explains and partly justifies the widespread use of the normal distribution for the log returns.
```

**Physical Meaning:** Over longer time horizons, the Central Limit Theorem kicks in and returns become more normally distributed due to aggregation.

```{important}
**Stylized Fact 5: Intermittency**

Returns are highly variable at every time scale. This phenomenon is often called **intermittency**. The presence of heavy tails supports this statement.
```

**Physical Meaning:** Volatility itself is not constant - periods of calm alternate with periods of turbulence.

```{important}
**Stylized Fact 6: Volatility Clustering**

Researchers found evidence supporting the existence of a phenomenon that they named **volatility clustering**.

Indeed, they observed that measures of volatility have **positive autocorrelations** over several days.

This shows that **high-volatility events are clustered in time**.
```

**Physical Meaning:** "Volatility begets volatility" - if the market is volatile today, it's likely to be volatile tomorrow. This violates the assumption of i.i.d. returns.

```{important}
**Stylized Fact 7: Slow Decay of Nonlinear Autocorrelations**

Unlike the linear autocorrelations of log returns, the autocorrelations of **absolute log returns**, which can be seen as a measure of nonlinear dependence, decay slowly as the time lag increases.

One can also look at the autocorrelation function of the **squared returns** that decays slowly over several days or even weeks.

This shows that the log returns are **not independent** and this contradicts the hypothesis that the increments of the log asset prices follow a random walk.
```

**Physical Meaning:** While returns themselves show little autocorrelation, their absolute values or squares (measures of volatility) show strong persistence. This indicates nonlinear dependence.

```{important}
**Stylized Fact 8: Long-Range Dependence (Controversial)**

Some researchers claim that this proves the existence of **long-range dependence**.

A consequence of this statement is that the **Markov property would not be satisfied** in general.

However, there is **no consensus** on this matter and it is difficult to test whether a time series satisfies the Markov property.
```

**Physical Meaning:** Some believe markets have very long memory in volatility. This is controversial and has implications for model selection.

### Other Empirical Observations

```{note}
**Additional Stylized Facts:**

- The changes in volatility are generally **negatively correlated** with the returns (leverage effect)
- The trading volume is **positively correlated** with volatility
- An estimate of the volatility at a coarse time scale **predicts fairly accurately** the volatility at finer time scales
```

## Statistical Assumptions and Their Limitations

Moreover, in relation with the discussion about the features of financial data, you have to be aware of the various hypotheses that one must make when applying common statistical methods.

One can identify **three main assumptions** that come up in statistical estimation of financial data:

1. **Stationarity**
2. **Ergodicity**
3. **Finite sample properties of estimators**

### Stationarity in Practice

```{note}
**Stationarity Assumptions:**

The log returns are generally assumed to be stationary because this makes the statistical properties invariant in time. In particular, it allows us to estimate moments of the returns.

**Problem:** The data actually fail to be stationary in calendar time because of **seasonality effects**, such as:
- Intraday variability
- Weekend effects
- January effects
- etc.

**Solution:** It is possible to correct this problem by changing the calendar into a **business time**, in which the data appear stationary.
```

**Physical Meaning:** Real markets have patterns related to the calendar (Monday effect, etc.). By using "business time" instead of clock time, we can make the data closer to stationary.

### Ergodicity in Practice

Next, stationarity alone is not sufficient to prove the convergence of the sample mean estimator to the model expectation, and **ergodicity is also required** to ensure that the empirical average does indeed converge toward the mean of the stochastic process.

```{warning}
**Non-Ergodic Models:**

For instance, there are some **multifractal processes** used in the modeling of high-frequency data which are **not ergodic**.
```

### Finite Sample Considerations

Finally, in Finance, sample sizes are typically **small**. Consequently, the error of the estimate of the mean is substantial and it is therefore important to pair the estimate with a **confidence interval**.

```{important}
**Model Trade-offs:**

In this course, we discuss extensively the **random walk model with normal residuals** for the log returns of financial assets.

**Drawback:** This model does not match the data's observed features.

**Merits:** Its tractability. In particular, its properties such as:
- Stationarity and independence of its increments
- Ergodicity
- Finiteness of all its moments

make it possible to apply statistical methods to estimate the moments of its distribution.
```

**Physical Meaning:** We use simplified models (like normal random walks) not because they're perfect, but because they're tractable and "good enough" for many applications. More realistic models are often too complex for practical use.

## Practice Problems

### Problem 1

```{admonition} Problem 1: Indicator Process
:class: tip

Consider the process $\{X(t); t \geq 0\}$ defined by:

$$
X(t) = \begin{cases}
1 & \text{if } t \leq Y \\
0 & \text{if } t > Y
\end{cases}
$$

where $Y$ is a uniformly distributed random variable on the interval $(0, 1)$.

1. Compute, for $t \in [0, 1]$, the first-order probability mass of $X$, $f(t, x)$.
2. What is the first-order probability mass of $X$ for $t > 1$?
3. Give the expectation and the variance of $X$.
4. Compute the autocovariance function of $X$, $C_X(t_1, t_2)$.
5. Is $X$ wide sense stationary? Is $X$ strict sense stationary?
6. What is the distribution of an increment of $X$? Does $X$ have stationary increments?
```

### Problem 2

```{admonition} Problem 2: Exponential Decay Process
:class: tip

Consider the stochastic process:

$$
X(t) = e^{-Yt}, \quad \text{for } t \geq 0
$$

where $Y$ is a random variable with a uniform distribution on the interval $(0, 1)$.

1. Calculate the first-order density function of the process $\{X(t); t \geq 0\}$.
2. Compute $E[X(t)]$ for $t \geq 0$.
3. Compute the auto-covariance function $C_X(t, t+s)$ for $s, t \geq 0$.
```

### Problem 3

```{admonition} Problem 3: Centered Poisson Process
:class: tip

Consider the process $\{X(t); t \geq 0\}$ defined by:

$$
X(t) = N(t) - \lambda t
$$

where $N$ is a Poisson process with rate $\lambda > 0$.

1. Compute, for $t_1, t_2, n_1, n_2 > 0$, the second-order probability mass of $N$, $G(t_1, t_2; n_1, n_2)$.
2. Give the expectation and the variance of $X(t)$.
3. Compute $E[X(t_1)X(t_2)]$ for $0 < t_1, t_2$.
4. Is $X$ wide sense stationary? Is $X$ strict sense stationary?
5. Is $X$ a martingale? Justify your answer.
6. Is $\frac{X(t)}{t}$ mean ergodic?
```

### Problem 4

```{admonition} Problem 4: Linear Growth with Random Rate
:class: tip

Consider the process $\{X(t); t \geq 0\}$ defined by:

$$
X(t) = te^Y
$$

where $Y$ is a random variable with a uniform distribution on $(0, 1)$.

1. Compute, for $t_1, t_2 > 0$ and $x_1 > 0, x_2 > 0$, the second-order cumulative distribution function of $X$, $G(t_1, t_2; x_1, x_2)$.
2. Compute the expectation and the variance of $X$.
3. Compute $E[X(t_1)X(t_2)]$ for $0 < t_1 < t_2$.
4. Is $X$ wide sense stationary? Is $X$ strict sense stationary?
5. What is the distribution of an increment of $X$, $X(t_2) - X(t_1)$, for $0 < t_1 < t_2$ given?
6. Does $X$ have stationary increments? Does $X$ have independent increments?
```

### Problem 5

```{admonition} Problem 5: Linear Process with Random Coefficient
:class: tip

Consider the process $\{X(t); t \geq 0\}$ defined by:

$$
X(t) = 1 + tY
$$

where $Y$ is a continuous random variable with cumulative distribution function $F$, and such that $E[Y] > 0$.

1. Compute, for $t_1, t_2 > 0$, the second-order cumulative distribution function of $X$, $G(t_1, t_2; x_1, x_2)$.
2. Give the expectation and the variance of $X$ in terms of the expectation and variance of $Y$ respectively.
3. Compute $E[X(t_1)X(t_2)]$ for $0 < t_1, t_2$ in terms of the expectation of $Y$ and the expectation of $Y^2$.
4. Is $X$ wide sense stationary? Is $X$ strict sense stationary?
5. What is the distribution of an increment of $X$, $X(t_2) - X(t_1)$, for $0 < t_1 < t_2$ given?
6. Does $X$ have stationary increments? Does $X$ have independent increments?
```

## Summary

In this lecture, we covered:

1. **Basic Concepts:**
   - Definition of stochastic processes
   - Sample paths and state spaces
   - Distribution functions of order $k$

2. **Key Properties:**
   - Independent and stationary increments
   - Autocovariance and autocorrelation functions
   - Stationarity (strict sense and wide sense)
   - Ergodicity

3. **Important Examples:**
   - Symmetric random walk
   - Bernoulli process
   - AR(1) process
   - Gaussian processes

4. **Empirical Stylized Facts:**
   - Near-zero linear autocorrelations
   - Fat tails and power-law behavior
   - Volatility clustering
   - Asymmetry in up/down moves

5. **Statistical Issues:**
   - Stationarity assumptions and seasonality
   - Ergodicity requirements
   - Finite sample considerations

These concepts form the foundation for understanding financial time series and are essential for building and evaluating quantitative models in finance.

---

## References

1. Jean Jacod and Philip Protter, "Probability Essentials", Universitext, Second Edition, 2004, Springer
2. Paul Wilmott, Sam Howison, and Jeff Dewynne, "Mathematics of Financial Derivatives: A Student Introduction", Cambridge University Press, 1995
3. Rama Cont, "Empirical properties of asset returns: stylized facts and statistical issues", Quantitative Finance, 1:223-236, 2001
4. Dan Stefanica, "A Linear Algebra Primer for Financial Engineering: Covariance Matrices, Eigenvectors, OLS, and more", Financial Engineering Advanced Background Series, 2014, FE Press New York
