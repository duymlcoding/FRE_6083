---
title: "Lecture 9: The Brownian Motion"
author: "Agnès Tourin"
date: "October 17, 2024"
---

# The Brownian Motion

This lecture introduces the Brownian motion as the continuous-time limit of the rescaled symmetric random walk. The Brownian motion is a fundamental stochastic process in continuous time with a continuous state space, essential for modeling asset prices and derivative securities in finance.

```{seealso}
**Recommended Reference:**
- Steven E. Shreve, "Stochastic Calculus for Finance II: Continuous-time finance", 2004, Springer
```

```{important}
**Disclaimer:**

These notes draw heavily from the reference above. However, any mistake is the sole responsibility of the author of these notes.
```

## Introduction

The Brownian motion is introduced as the continuous-time limit of the rescaled symmetric random walk that we studied in earlier lectures.

```{note}
**Key Properties:**

- The Brownian motion is a **stochastic process in continuous time** with a **continuous state space**
- The set of outcomes $\Omega$ can be seen as the result of an infinite number of coin tosses, but the coin is being tossed infinitely fast in the continuous-time limit
- An experiment is the set of all coin tosses, and the outcome is $\omega$
- For fixed $\omega$, $t \mapsto W(t;\omega)$ is a **sample path** of the Brownian motion
```

**Physical Meaning:** While a random walk moves in discrete jumps at discrete times, Brownian motion evolves continuously. However, these paths are highly irregular and non-smooth, reflecting the continuous randomness.

### Fundamental Property

We recall that the Brownian motion increment:

$$
W(t) - W(0)
$$

is normally distributed with mean 0 and variance $t$.

**Physical Meaning:** Over time interval $t$, the Brownian motion's displacement has standard deviation $\sqrt{t}$. Uncertainty grows with the square root of time.

## Definition of a Brownian Motion

```{important}
**Definition: Standard Brownian Motion**

We consider a process $\{W(t); t \geq 0\}$ satisfying $W(0) = 0$.

The process $\{W(t); t \geq 0\}$ is said to be a **Brownian motion** (or **Wiener process**) if:

1. **Continuity:** $W$ is continuous in the variable $t$

2. **Independent Increments:** For all $0 = t_0 < t_1 < t_2 < \cdots < t_n$, the increments
   $$
   W(t_1) - W(t_0), \quad W(t_2) - W(t_1), \quad \ldots, \quad W(t_n) - W(t_{n-1})
   $$
   are independent

3. **Stationary Increments:** For all $j = 0, \ldots, n-1$, the increment $W(t_{j+1}) - W(t_j)$ is normally distributed with mean 0 and variance $t_{j+1} - t_j$
```

**Physical Meaning:**
- **Continuity:** Paths don't jump; they evolve smoothly in space (though not differentiably)
- **Independent increments:** What happens in one time interval doesn't affect what happens in another
- **Stationary increments:** The distribution of changes depends only on the length of time, not when it occurs

## The Brownian Motion as a Gaussian Process

We saw the definition of a Gaussian process in earlier chapters. It turns out that the Brownian motion is indeed a Gaussian process.

### Joint Distribution

For all $0 = t_0 < t_1 < t_2 < \cdots < t_n$, the random variables $W(t_1), W(t_2), \ldots, W(t_n)$ are **jointly normally distributed**.

Their joint distribution is characterized by:
1. The vector of its means
2. Its covariance matrix

### Mean Vector

Since the mean of each $W(t_j)$ is 0:

$$
E[W(t_j)] = 0
$$

the $n$-dimensional vector of means is:

$$
\begin{bmatrix}
0 \\
0 \\
\vdots \\
0
\end{bmatrix}
$$

### Covariance Matrix

The covariance matrix is defined as:

$$
\begin{bmatrix}
E[W^2(t_1)] & E[W(t_1)W(t_2)] & \cdots & E[W(t_1)W(t_n)] \\
E[W(t_2)W(t_1)] & E[W^2(t_2)] & \cdots & E[W(t_2)W(t_n)] \\
\vdots & \vdots & \ddots & \vdots \\
E[W(t_n)W(t_1)] & \cdots & \cdots & E[W^2(t_n)]
\end{bmatrix}
$$

We take into account the fact that all expectations are equal to 0.

**Diagonal Elements (Variances):**

$$
E[W^2(t_j)] = t_j
$$

**Off-Diagonal Elements (Covariances):**

```{dropdown} Derivation of Covariance

For all $s, t \geq 0$ such that $s \leq t$:

$$
\begin{align}
E[W(s)W(t)] &= E[W(s)(W(t) - W(s)) + W^2(s)] \\
&= E[W(s)]E[W(t) - W(s)] + E[W^2(s)] \\
&= 0 + s \\
&= \min(s, t)
\end{align}
$$

The second equality uses the independence of $W(s)$ and $W(t) - W(s)$.
```

```{important}
**Covariance Matrix of Brownian Motion:**

$$
\text{Cov}(W(s), W(t)) = \min(s, t)
$$

The complete covariance matrix is:

$$
\begin{bmatrix}
t_1 & t_1 & \cdots & t_1 \\
t_1 & t_2 & \cdots & t_2 \\
\vdots & \vdots & \ddots & \vdots \\
t_1 & t_2 & \cdots & t_n
\end{bmatrix}
$$
```

**Physical Meaning:** The covariance between values at times $s$ and $t$ equals the minimum of the two times. Values close in time are highly correlated.

## Markov Property

```{important}
**Definition: Markov Property for Brownian Motion**

The Brownian motion satisfies the **Markov property** if for all $0 \leq s \leq t$:

$$
P[W(t) \leq x \mid \{W(u); 0 \leq u \leq s\}] = P[W(t) \leq x \mid W(s)]
$$
```

**Physical Meaning:** When you look at the future distribution of the Brownian motion, conditionally on its past realizations, the only relevant data is the most recent observation. The past path doesn't matter, only where you are now.

## Martingale Property

```{important}
**Definition: Martingale Property**

The Brownian motion satisfies the **martingale property** if for all $0 \leq s \leq t$:

$$
E[W(t) \mid \{W(u); 0 \leq u \leq s\}] = W(s)
$$

Taking into account the Markov property, we can rewrite this as:

$$
E[W(t) \mid W(s)] = W(s), \quad \forall \, 0 \leq s < t
$$
```

**Physical Meaning:** The best prediction of future position, given all past information, is the current position. The Brownian motion is a "fair game" with no drift.

```{dropdown} Proof of the Martingale Property

$$
\begin{align}
E[W(t) \mid \{W(u); 0 \leq u \leq s\}] &= E[W(t) - W(s) + W(s) \mid W(s)] \\
&= E[W(t) - W(s) \mid W(s)] + E[W(s) \mid W(s)] \\
&= E[W(t) - W(s)] + W(s) \\
&= 0 + W(s) \\
&= W(s)
\end{align}
$$

**Key steps:**
- **Linearity of expectation**
- $W(s)$ can be taken out of the conditional expectation since it's known
- The increment $W(t) - W(s)$ is independent of $W(s)$ when $s < t$
- The expectation of a Brownian motion increment is 0
```

## Transition Density for the Brownian Motion

Since the Brownian motion is a Markovian process, it can be characterized alternately by its initial condition $W(0) = 0$ together with its **transition density**.

```{important}
**Transition Density:**

For $x, y \in \mathbb{R}$ and $s \leq t$:

$$
p(y, x, t, s) = \frac{1}{\sqrt{2\pi(t-s)}} \exp\left(-\frac{(y-x)^2}{2(t-s)}\right)
$$

This is the **conditional probability density** in the variable $y$ for the random variable $W(t)$, conditioned on the event $W(s) = x$.
```

**Physical Meaning:** This is the density of where the Brownian motion will be at time $t$, given it's at position $x$ at time $s$. It's a normal distribution centered at $x$ with variance $(t-s)$.

```{note}
**Analogy to Discrete Time:**

The transition density is the analogue of the **transition probability matrix** for Markov chains in discrete time.
```

## On the Regularity of the Brownian Motion

The Brownian motion has remarkable and counterintuitive regularity properties.

```{important}
**Continuity vs. Differentiability:**

- Each sample path of the Brownian motion $W(t, \omega)$ is a **continuous function** of time (almost surely)
- However, the sample paths **cannot be differentiated** with respect to time at any point!
```

**Physical Meaning:** Brownian paths are continuous but extremely jagged. They have "kinks" everywhere, making them non-differentiable at every point.

### Comparison with Absolute Value Function

Consider the absolute value function $f(t) = |t|$ centered at 0:
- This function is **not differentiable at $t = 0$** (it has a kink there)
- At all other points, it **is differentiable**

```{warning}
**Brownian Motion is Worse:**

The paths of the Brownian motion look even worse than the absolute value function. A Brownian motion is not even **Lipschitz continuous**, unlike the absolute value function.

If it were Lipschitz continuous, it would be differentiable almost everywhere, which is not the case.
```

```{admonition} Definition: Lipschitz Continuous Function
:class: note

A continuous function $f$ defined on the real line is said to be **Lipschitz continuous** if there exists a constant $C$ such that for all $x, y \in \mathbb{R}$:

$$
|f(x) - f(y)| \leq C|x - y|
$$
```

## Quadratic Variation for the Brownian Motion

The quadratic variation is a key concept that distinguishes the Brownian motion from smooth functions.

```{important}
**Theorem: Quadratic Variation of Brownian Motion**

For all $T \geq 0$:

$$
[W, W](T) = T \quad \text{almost surely}
$$
```

### Definition of Quadratic Variation

Consider an arbitrary partition of the time interval $[0, T]$:

$$
0 = t_0 < t_1 < \cdots < t_j < t_{j+1} < \cdots < t_n = T
$$

where $n$ is a positive integer.

Denote by $h$ the size of the largest subinterval:

$$
h = \max_{i=1,\ldots,n} |t_j - t_{j-1}|
$$

```{important}
**Definition: Quadratic Variation**

The **quadratic variation** of any function $f$ of the variable $t$ is defined as:

$$
[f, f](T) = \lim_{\substack{h \to 0 \\ n \to +\infty}} \sum_{i=1}^{n} (f(t_j) - f(t_{j-1}))^2
$$
```

**Physical Meaning:** This measures the accumulated squared changes along a path. For smooth functions, this sum approaches zero as we refine the partition. For Brownian motion, it approaches $T$.

```{note}
**Key Properties:**

1. The quadratic variation of a stochastic process is computed **pathwise** (for any given fixed outcome $\omega$), hence the quadratic variation is also a stochastic process

2. Any **differentiable function** has quadratic variation equal to 0

3. The non-zero quadratic variation of the Brownian motion comes from the fact that it is **not differentiable**

4. The quadratic variation of the Brownian motion is **deterministic** (does not depend on the particular outcome $\omega$) and equals the **variance** of the Brownian motion
```

## Hitting Time

We now study the **first time** the Brownian motion hits a given level.

```{important}
**Definition: First Hitting Time**

For $a > 0$, the **first hitting time** of level $a$ is defined by:

$$
\tau_a = \inf\{t \geq 0; W(t) \geq a\}
$$

**Goal:** Compute the distribution of $\tau_a$, i.e., $P[\tau_a \leq t]$
```

**Physical Meaning:** This is the first time a particle undergoing Brownian motion reaches position $a$. In finance, this models the first time a stock price reaches a barrier.

## Distribution of the Hitting Time

```{dropdown} Derivation of Hitting Time Distribution

**Step 1:** Write the total probability:

$$
P[W(t) \geq a] = P[W(t) \geq a \mid \tau_a \leq t]P[\tau_a \leq t] + P[W(t) \geq a \mid \tau_a > t]P[\tau_a > t]
$$

**Step 2:** The second term equals 0 because the Brownian motion cannot be above $a$ if it has not hit $a$ yet by time $t$ (i.e., $\tau_a > t$).

This leaves us with:

$$
P[W(t) \geq a] = P[W(t) \geq a \mid \tau_a \leq t]P[\tau_a \leq t]
$$

**Step 3:** Apply the reflection principle (stated next).
```

### Reflection Principle

```{important}
**Reflection Principle:**

$$
P[W(t) \geq a \mid \tau_a \leq t] = \frac{1}{2}
$$
```

**Physical Meaning:** Knowing that the Brownian motion has hit $a$ sometime before time $t$, the Brownian motion is equally likely to be above $a$ as below $a$ at time $t$. This is due to the symmetry of the Brownian motion.

### Computing the Distribution

Using the reflection principle:

```{dropdown} Full Derivation

$$
\begin{align}
P[\tau_a \leq t] &= 2P[W(t) \geq a] \\
&= 2 \cdot \frac{1}{\sqrt{2\pi t}} \int_a^{+\infty} e^{-x^2/(2t)} dx \\
&= 2 \cdot \frac{1}{\sqrt{2\pi}} \int_{a/\sqrt{t}}^{+\infty} e^{-y^2/2} dy \\
&= 2\left(1 - \Phi\left(\frac{a}{\sqrt{t}}\right)\right)
\end{align}
$$

where $\Phi$ is the standard normal cumulative distribution function.
```

```{important}
**Distribution of First Hitting Time:**

For $a > 0$:

$$
P[\tau_a \leq t] = 2\left(1 - \Phi\left(\frac{a}{\sqrt{t}}\right)\right)
$$

By symmetry, for $a < 0$:

$$
P[\tau_a \leq t] = 2\left(1 - \Phi\left(\frac{|a|}{\sqrt{t}}\right)\right)
$$

**General form:**

$$
P[\tau_a \leq t] = 2\left(1 - \Phi\left(\frac{|a|}{\sqrt{t}}\right)\right)
$$
```

### Density Function

If needed, we can compute the **density function** of the first hitting time by differentiating:

$$
f_{\tau_a}(t) = |a| \phi\left(\frac{|a|}{\sqrt{t}}\right) t^{-3/2}
$$

where $\phi$ is the standard normal density function.

## Application: Gambler's Ruin Model in Continuous Time

This is a continuous-time version of the gambler's ruin problem, with applications to credit risk.

```{admonition} Example: Credit Risk Model
:class: tip

**Setup:** The wealth of a gambler (or firm) is modeled using the **arithmetic Brownian motion without drift**:

$$
X(t) = X(0) + \sigma W(t)
$$

where:
- $X(0) > 0$ is the initial capital
- $\sigma > 0$ is a volatility coefficient
- $W(t)$ is a standard Brownian motion

**Time of Ruin:** Define the hitting time of 0:

$$
\tau_0 = \inf\{t \geq 0; X(t) \leq 0\} = \inf\left\{t \geq 0; W(t) \leq -\frac{X(0)}{\sigma}\right\}
$$
```

```{dropdown} Solution

Using the hitting time distribution:

$$
\begin{align}
P[\tau_0 \leq t] &= \frac{2}{\sqrt{2\pi}} \int_{|X(0)|/(\sigma\sqrt{t})}^{+\infty} e^{-y^2/2} dy \\
&= 2\left(1 - \Phi\left(\frac{|X(0)|}{\sigma\sqrt{t}}\right)\right)
\end{align}
$$

where $\Phi$ is the standard normal cumulative distribution function.
```

**Physical Meaning:** The probability of ruin decreases as initial capital $X(0)$ increases and increases as volatility $\sigma$ increases. For large $t$, the probability approaches a limit that depends on the ratio $X(0)/\sigma$.

## Financial Applications of Reflection Principle

```{note}
**Applications in Finance:**

1. **Option Pricing:** The reflection principle is used for pricing **Barrier options** (e.g., up-and-out calls where the option becomes worthless when the stock price rises above a prescribed barrier $B > K$)

2. **Maximum Distribution:** The payout of barrier options depends on the distribution of the maximum to date:
   $$
   M(t) = \max_{0 \leq s \leq t} W(s)
   $$
   which is also determined using the reflection principle

3. **Credit Risk:** Merton and Black-Cox developed models for pricing equity and bonds with default risk. Defaulting occurs when the value of assets $A(t)$, modeled as a geometric Brownian motion, falls below a prescribed barrier
```

```{warning}
**Advanced Topic:**

The case of the **geometric Brownian motion** is more complicated than the arithmetic Brownian motion and requires advanced techniques beyond the scope of this chapter.
```

## The Geometric Brownian Motion

We introduced the geometric Brownian motion earlier as the limit of the rescaled multi-period binomial tree model. Now we show how to compute its expectation.

### Definition

Consider the **arithmetic Brownian motion with drift**:

$$
Y(t) = \left(\mu - \frac{1}{2}\sigma^2\right)t + \sigma W(t)
$$

where $W(t)$ is a standard Brownian motion.

Define the **geometric Brownian motion** as:

$$
X(t) = e^{Y(t)}
$$

### Computing the Expectation

```{dropdown} Detailed Computation

**Step 1:** Compute the expectation:

$$
\begin{align}
E[X(t)] &= E\left[e^{(\mu - \frac{1}{2}\sigma^2)t + \sigma W(t)}\right] \\
&= e^{(\mu - \frac{1}{2}\sigma^2)t} E[e^{\sigma W(t)}] \\
&= e^{(\mu - \frac{1}{2}\sigma^2)t} E[e^{\sigma\sqrt{t}Y}]
\end{align}
$$

where $Y$ is a standard normal random variable.

**Step 2:** Calculate the expectation of the exponential:

$$
\begin{align}
e^{(\mu - \frac{1}{2}\sigma^2)t} E[e^{\sigma\sqrt{t}Y}] &= e^{(\mu - \frac{1}{2}\sigma^2)t} \int_{-\infty}^{+\infty} \frac{1}{\sqrt{2\pi}} e^{\sigma\sqrt{t}x} e^{-x^2/2} dx \\
&= e^{(\mu - \frac{1}{2}\sigma^2)t} \int_{-\infty}^{+\infty} \frac{1}{\sqrt{2\pi}} e^{-\frac{1}{2}(x - \sigma\sqrt{t})^2} e^{\frac{1}{2}\sigma^2 t} dx \\
&= e^{\mu t} \int_{-\infty}^{+\infty} \frac{1}{\sqrt{2\pi}} e^{-\frac{1}{2}(x - \sigma\sqrt{t})^2} dx \\
&= e^{\mu t}
\end{align}
$$
```

```{important}
**Expected Value of Geometric Brownian Motion:**

$$
E[X(t)] = e^{\mu t}
$$
```

**Physical Meaning:** The geometric Brownian motion has exponential growth (or decay) on average at rate $\mu$. This is why it's used to model stock prices with a constant expected return.

### Generalization

We can generalize further by defining the asset price:

$$
S(t) = S(\tau) e^{Y(t) - Y(\tau)}
$$

for every $\tau, t$ with $\tau \leq t$.

The **conditional expectation** is:

$$
E[S(t) \mid \{S(u); 0 \leq u \leq \tau\}] = S(\tau) e^{\mu(t-\tau)}
$$

**Physical Meaning:** Given current price $S(\tau)$, the expected future price grows exponentially at rate $\mu$.

## Exercises

### Question 1

```{admonition} Exercise 1: Conditional Distribution
:class: tip

Consider the process $X(t) = \mu t + \sigma W(t)$, where $W$ is a standard Brownian motion.

**Question:** What is the conditional distribution of $X(t)$ given that $X(s) = c$ when $s < t$ ($c$ is a given constant)?
```

### Question 2

```{admonition} Exercise 2: Stock Price with Stopping Rule
:class: tip

Consider an investor who is holding one share of a stock whose price per share is given by:

$$
S(u) = S(0) + \sigma W(u), \quad u \geq 0
$$

where $\sigma > 0$ is constant and $W$ is a standard Brownian motion.

This investor purchased the stock at price $S(0) > 0$ at time 0 and decides to sell the stock whenever it falls below the price $S(0)(1-\alpha)$ for the first time, where $0 < \alpha < 1$ is a constant.

**Questions:**

1. What is the distribution of $S(u)$? Give its mean and variance.

2. Is the process $S$ a martingale? Justify your answer.

3. What is the cumulative distribution function of the hitting time $\tau_{S(0)(1-\alpha)}$ of the process $S$?

4. Give also the density function of the distribution of the hitting time $\tau_{S(0)(1-\alpha)}$ of the process $S$.
```

### Question 3

```{admonition} Exercise 3: Transformations of Brownian Motion
:class: tip

We consider a standard Brownian motion $W$.

**Questions:**

1. Is the process $t \in [0, +\infty) \mapsto W(ct^2)$, where $c$ is a positive constant, a standard Brownian motion? Justify your answer.

2. Is $t \in [0, +\infty) \mapsto \sqrt{t}W(1)$ a standard Brownian motion? Justify your answer.

3. Compute the mean and autocovariance function of the process:
   $$
   X(t) = \int_0^t W(s) ds
   $$

4. Consider the process $S(t) = \mu t + \sigma W(t)$ for $t \in [0, T]$, where $\mu, \sigma > 0$ are both positive constants. Compute $P[S(T) < 0]$.
```

### Question 4

```{admonition} Exercise 4: Maximum and Moving Average
:class: tip

Consider a standard Brownian motion $W$ and its maximum to date:

$$
M(t) = \max_{0 \leq s \leq t} W(s)
$$

**Questions:**

1. Show that:
   $$
   P\left[\max_{0 \leq s \leq t} W(s) \geq m\right] = P[\tau_m \leq t]
   $$
   where $\tau_m$ denotes the first time $W$ hits the level $m$.

2. Deduce the cumulative distribution and density functions of $M(t)$.

3. Consider the partition of the time interval $[0, t]$:
   $$
   0, \frac{t}{n}, \frac{2t}{n}, \ldots, \frac{jt}{n}, \ldots, \frac{nt}{n} = t
   $$
   where $n > 1$, and define the moving average process:
   $$
   X_n = \frac{\sum_{j=n-k}^{n} W(jt/n)}{k+1}
   $$
   for some $n \geq k$.

   Compute the expectation and variance of $X_n$.
```

### Question 5

```{admonition} Exercise 5: Martingales and Transformations
:class: tip

**Questions:**

1. Let $Y$ be a standard normal random variable. For all $t \geq 0$, let $X(t) = \sqrt{t}Y$. Is $X$ a standard Brownian motion? Justify.

2. Let $W$ be a standard Brownian motion. Show that $W^2(t) - t$ is a martingale.

3. Consider a standard Brownian motion $W$. Show that the following process is a standard Brownian motion:
   $$
   B(t) = cW(t/c^2) \quad \text{for all } t \geq 0
   $$

4. Consider a standard Brownian motion $W$, and the process:
   $$
   B(0) = 0, \quad B(t) = tW(1/t) \quad \text{for all } t > 0
   $$
   Show that $B$ is a standard Brownian motion by using the definition.
```

---

## References

1. Steven E. Shreve, "Stochastic Calculus for Finance II: Continuous-time finance", 2004, Springer
