---
title: "Lecture 10: A Basic Introduction to Stochastic Calculus"
author: "Agnès Tourin"
date: "November 18, 2024"
---

# A Basic Introduction to Stochastic Calculus and Its Application to the Modeling of Dynamic Asset Prices

This lecture introduces in an elementary manner the most basic concepts of stochastic calculus and their application to the modeling of dynamic asset prices. We develop the Ito integral, Ito's formula, and their applications to financial modeling, including volatility estimation and interest rate models.

```{seealso}
**Recommended References:**
- Bernt Oksendal, "Stochastic Differential Equations: An introduction with applications", Universitext, 6th Edition, 2007, Springer
- Steven E. Shreve, "Stochastic Calculus for Finance II: Continuous-time finance", 2004, Springer
```

```{important}
**Disclaimer:**

These notes draw heavily from the references above. Any mistake is the sole responsibility of the author of these notes.
```

## Introduction

One of our primary goals is to be able to describe rigorously the dynamic evolution of stochastic processes in continuous time.

### Motivation: Stochastic Differential Equations

What we have in mind is the **linear differential equation**:

$$
dS(t) = \mu(t)S(t)dt, \quad S(0) = S_0
$$

with

$$
\mu(t) = r(t) + \epsilon(t)
$$

where:
- $r(t)$ is a known deterministic function of $t$
- $\epsilon(t)$ represents some random noise

**Physical Meaning:** We want to model asset prices with both a deterministic trend $r(t)$ and random fluctuations $\epsilon(t)$.

### General Form

In general, we are interested in the slightly more general equation:

$$
dS(t) = b(t, S(t))dt + \sigma(t, S(t))\epsilon(t)
$$

where:
- $b(t, S(t))$ is the drift coefficient
- $\sigma(t, S(t))$ is the diffusion coefficient
- $\epsilon(t)$ is the random noise term

### The Challenge

We would like $\epsilon(t)$ to have:
- Continuous sample paths
- Stationarity
- Unit variance
- Independence: for all $0 \leq t_1 < t_2$, $\epsilon(t_1)$ and $\epsilon(t_2)$ are independent

```{warning}
**Impossibility Result:**

Unfortunately, there does not exist any process satisfying all the above requirements simultaneously.
```

Consequently, we need to find a reasonable interpretation of the stochastic differential equation.

### The Solution: Integral Form

We rewrite the differential equation in **integral form**:

$$
S(t) = S(0) + \int_0^t b(u, S(u)) du + \int_0^t \sigma(u, S(u)) dW(u)
$$

where $W$ is a **standard Brownian motion**.

```{important}
**Key Challenge:**

The second integral, which is **stochastic**, requires careful definition. This integral could be interpreted as:
- A **Stratonovich integral**, or
- An **Ito integral**

In these notes, we present the **Ito integral**, which is used in the Black-Scholes-Merton option pricing framework.
```

**Physical Meaning:** Since $dW(t)$ does not exist at any time $t$ (Brownian motion is not differentiable), defining the Ito stochastic integral is a way to give meaning to the stochastic differential equation.

## The Ito Integral

We start with a fixed time horizon $T > 0$.

### Goal

The goal is to define the **Ito integral**, which is a stochastic integral of the form:

$$
\int_0^t \Delta(u) dW(u)
$$

where:
- $W(t)$ is a standard Brownian motion
- $\Delta(u)$ is a stochastic process
- $t \in [0, T]$

### Information Structure

```{note}
**Key Assumption:**

We assume that the information available at time $t$ is sufficient to know $\Delta$ with certainty up to time $t$, for each $t \in [0, T]$.

This means that the **standard Brownian motion is the only source of uncertainty**, and there is no additional source of uncertainty introduced through $\Delta(u)$.
```

**Physical Meaning:** We can only use information available up to time $t$ when computing $\Delta(t)$. This is called the **non-anticipating** or **adapted** property.

## Construction of the Ito Integral

### Step 1: Piecewise Constant Integrands

First, we define the integral for **piecewise constant integrands**, then pass to the limit to extend it to general integrands.

Consider a partition of $[0, T]$:

$$
0 = t_0 < t_1 < t_2 < \cdots < t_n = T
$$

Assume that the integrand $\Delta$ is constant on each subinterval $[t_j, t_{j+1})$:

$$
\Delta(t) = \Delta(t_j) \quad \text{for all } t \in [t_j, t_{j+1})
$$

### Successive Definition on Intervals

We define the Ito integral $I(t) = \int_0^t \Delta(u) dW(u)$ successively:

**On $[0, t_1)$:**
$$
I(t) = \Delta(t_0)[W(t) - W(t_0)] = \Delta(0)W(t)
$$

**On $[t_1, t_2)$:**
$$
I(t) = \Delta(0)W(t_1) + \Delta(t_1)[W(t) - W(t_1)]
$$

**On $[t_2, t_3)$:**
$$
I(t) = \Delta(0)W(t_1) + \Delta(t_1)[W(t_2) - W(t_1)] + \Delta(t_2)[W(t) - W(t_2)]
$$

### General Formula

```{important}
**Ito Integral for Piecewise Constant Integrand:**

For $t \in [t_k, t_{k+1}]$:

$$
I(t) = \sum_{j=0}^{k-1} \Delta(t_j)[W(t_{j+1}) - W(t_j)] + \Delta(t_k)[W(t) - W(t_k)]
$$
```

**Physical Meaning:** The integral is a weighted sum of Brownian motion increments, where weights $\Delta(t_j)$ are determined at the left endpoint of each interval.

## A Financial Interpretation of Ito's Integral

This interpretation provides intuition for the Ito integral construction.

```{admonition} Financial Trading Strategy
:class: tip

**Setup:**
- $W(t)$ represents the **price per share** of an asset at time $t$
- The partition $0 = t_0 < t_1 < \cdots < t_n$ represents **trading dates**
- $\Delta(t_0), \Delta(t_1), \ldots, \Delta(t_n)$ represent the **positions** (number of shares) invested in the asset at each trading date
- The position is held until the next trading date
- The position is **rebalanced** at every trading date

**Gain/Loss:**

$I(t)$ is the **accumulated gain/loss from trading** up to time $t$.

**Example:**
- At time $t_0$, buy $\Delta(t_0)$ shares at price $W(t_0)$
- At time $t_1$, the position is worth $\Delta(t_0)W(t_1)$
- Gain/loss from first period: $\Delta(t_0)[W(t_1) - W(t_0)]$
```

**Physical Meaning:** The Ito integral represents cumulative trading profits when following a dynamic trading strategy $\Delta(t)$ in an asset with price $W(t)$.

## General Construction of the Ito Integral

### Extension to General Integrands

We now consider more general integrands and summarize the theory.

```{important}
**Assumptions on the Integrand $\Delta(t)$:**

1. **Adapted:** If the path of $W$ has been observed up to time $t$, then $\Delta$ is also known up to time $t$

2. **Square Integrability:**
   $$
   E\left[\int_0^T \Delta(u)^2 du\right] < +\infty
   $$
```

### Approximation by Piecewise Constant Functions

Define a sequence $\Delta_n(t)$ of piecewise constant processes which converges to $\Delta(t)$ as $n \to +\infty$:

$$
\lim_{n \to +\infty} E\left[\int_0^T |\Delta_n(t) - \Delta(t)|^2 dt\right] = 0
$$

### Definition by Limit

```{important}
**Definition: Ito Integral (General Case)**

$$
\int_0^t \Delta(u) dW(u) = \lim_{n \to \infty} \int_0^t \Delta_n(u) dW(u)
$$
```

The limit is meant in $L^2(P)$, that is, for all $t \in [0, T]$:

$$
\int_\Omega \left|\int_0^t \Delta(u) dW(u) - \int_0^t \Delta_n(u) dW(u)\right|^2 dP(\omega) \to 0 \quad \text{as } n \to +\infty
$$

**Physical Meaning:** We can approximate any reasonable integrand by simpler piecewise constant ones, and the Ito integral is defined as the limit of these simpler integrals.

```{note}
**Extension to General Intervals:**

We chose to construct the Ito integral on any interval of the form $[0, t]$ where $t \in [0, T]$. However, we could extend this construction to any interval $[s, t]$ where $0 \leq s \leq t \leq T$.
```

## Properties of the Ito Integral

```{important}
**Key Properties:**

1. **Continuity:** $I(t)$ is continuous in $t$

2. **Adapted:** If one knows the path of the Brownian motion up to time $t$, then one also knows $I$ with certainty up to time $t$, for each $t \in [0, T]$

3. **Linearity:** For all real numbers $c_1, c_2$ and integrands $\Delta_1, \Delta_2$:
   $$
   \int_0^t [c_1\Delta_1(s) + c_2\Delta_2(s)]dW(s) = c_1\int_0^t \Delta_1(s)dW(s) + c_2\int_0^t \Delta_2(s)dW(s)
   $$

4. **Martingale Property:** $I(t)$ is a martingale

5. **Zero Expectation:** $E[I(t)] = 0$ for all $t \in [0, T]$

6. **Ito's Isometry:**
   $$
   E[I^2(t)] = E\left[\int_0^t \Delta^2(u) du\right]
   $$

7. **Quadratic Variation:**
   $$
   [I, I](t) = \int_0^t \Delta^2(u) du
   $$
```

**Physical Meaning:** The Ito integral of an adapted process is a martingale with zero expectation. Its variance grows according to the integrated squared integrand.

## Deterministic Integrand: Special Case

When the integrand is **deterministic** (not random), we have a special result.

```{important}
**Ito Integral with Deterministic Integrand:**

Let:
$$
I(t) = \int_0^t \delta(s) dW(s)
$$

where $\delta(s)$ is a **deterministic function** of time.

Then $I(t)$ is **normally distributed** with:
- Mean: $0$
- Variance: $\int_0^t \delta^2(s) ds$

Furthermore, $I$ is a **Gaussian process**.
```

**Physical Meaning:** When we integrate a deterministic function against Brownian motion, we get a normally distributed random variable. This is a generalization of the fact that $\int_0^t dW(s) = W(t) \sim \mathcal{N}(0, t)$.

## Some Well-Known Facts of Stochastic Calculus

These "multiplication rules" are fundamental for Ito calculus.

```{important}
**Differential Rules:**

1. **Quadratic variation of Brownian motion:**
   $$
   dW(t) \cdot dW(t) = dt
   $$

2. **Deterministic time has zero quadratic variation:**
   $$
   dt \cdot dt = 0
   $$

3. **Cross-variation of Brownian motion with time is zero:**
   $$
   dW(t) \cdot dt = 0
   $$
```

**Physical Meaning:** The Brownian motion's infinitesimal increments squared equal infinitesimal time. This is the key difference from ordinary calculus where $(dt)^2 = 0$.

## The Chain Rule of Stochastic Calculus: Ito's Formula

In ordinary calculus, the chain rule is:

$$
\frac{d}{dt}f(W(t)) = f'(W(t))W'(t)
$$

or equivalently, in differential notation:

$$
df(W(t)) = f'(W(t))dW(t)
$$

```{warning}
**This is NOT correct for Brownian motion!**

The ordinary chain rule does not apply because the quadratic variation of the Brownian motion is not zero.
```

### Ito's Formula for Functions of Brownian Motion

```{important}
**Ito's Formula (One Variable):**

For a twice-differentiable function $f$:

$$
df(W(t)) = f'(W(t))dW(t) + \frac{1}{2}f''(W(t))dt
$$

**Integral Form:**

$$
f(W(t)) = f(0) + \int_0^t f'(W(s))dW(s) + \int_0^t \frac{1}{2}f''(W(s))ds
$$
```

**Physical Meaning:** There's an extra term $\frac{1}{2}f''(W(t))dt$ that doesn't appear in ordinary calculus. This comes from the non-zero quadratic variation of Brownian motion.

### Ito's Formula for Time-Dependent Functions

```{important}
**Ito's Formula (Two Variables):**

For a function $f(t, x)$ that depends on both time and space:

$$
df(t, W(t)) = f_t(t, W(t))dt + f_x(t, W(t))dW(t) + \frac{1}{2}f_{xx}(t, W(t))dt
$$

This can be rewritten as:

$$
df(t, W(t)) = \left[f_t(t, W(t)) + \frac{1}{2}f_{xx}(t, W(t))\right]dt + f_x(t, W(t))dW(t)
$$
```

**Physical Meaning:** When a function depends on both time $t$ and the Brownian motion $W(t)$, we get contributions from time evolution ($f_t dt$), spatial movement ($f_x dW$), and the second-order correction ($\frac{1}{2}f_{xx} dt$).

## Ito Processes

An **Ito process** generalizes the Brownian motion to include drift and diffusion coefficients.

```{important}
**Definition: Ito Process**

An Ito process is a process of the form:

$$
X(t) = X(0) + \int_0^t \mu(s) ds + \int_0^t \sigma(s) dW(s)
$$

where $\mu$ and $\sigma$ are stochastic processes that are known with certainty up to time $t$ if the standard Brownian motion is known up to time $t$, for each $t \in [0, T]$.

**Differential Form:**
$$
dX(t) = \mu(t)dt + \sigma(t)dW(t)
$$
```

**Physical Meaning:** An Ito process has both a deterministic trend $\mu(t)$ and random fluctuations driven by $\sigma(t)dW(t)$.

### Ito's Formula for Ito Processes

```{important}
**Ito's Formula for General Ito Process:**

For a function $f(t, x)$ and an Ito process $X(t)$:

$$
df(t, X(t)) = f_t(t, X(t))dt + f_x(t, X(t))dX(t) + \frac{1}{2}f_{xx}(t, X(t))dX(t)dX(t)
$$

where:

$$
dX(t)dX(t) = \sigma^2(t)dW(t)dW(t) = \sigma^2(t)dt
$$
```

**Integral Form:**

$$
\begin{align}
f(t, X(t)) = f(0, X(0)) &+ \int_0^t f_t(s, X(s))ds + \int_0^t f_x(s, X(s))dX(s) \\
&+ \int_0^t \frac{1}{2}f_{xx}(s, X(s))\sigma^2(s)ds
\end{align}
$$

where:

$$
\int_0^t f_x(s, X(s))dX(s) = \int_0^t f_x(s, X(s))\mu(s)ds + \int_0^t f_x(s, X(s))\sigma(s)dW(s)
$$

## Ito's Formula in 2 Dimensions

For systems with multiple sources of randomness, we need multidimensional Ito's formula.

```{important}
**Two Ito Processes:**

Define two Ito processes $X, Y$ driven by independent standard Brownian motions $W_1, W_2$:

$$
\begin{align}
X(t) &= X(0) + \int_0^t \mu_1(s)ds + \int_0^t \sigma_{11}(s)dW_1(s) + \int_0^t \sigma_{12}(s)dW_2(s) \\
Y(t) &= Y(0) + \int_0^t \mu_2(s)ds + \int_0^t \sigma_{21}(s)dW_1(s) + \int_0^t \sigma_{22}(s)dW_2(s)
\end{align}
$$
```

### Multidimensional Ito's Formula

```{important}
**Ito's Formula (2D):**

$$
\begin{align}
df(t, X(t), Y(t)) &= f_t(t, X(t), Y(t))dt \\
&+ f_x(t, X(t), Y(t))dX(t) + f_y(t, X(t), Y(t))dY(t) \\
&+ \frac{1}{2}f_{xx}(t, X(t), Y(t))dX(t)dX(t) \\
&+ \frac{1}{2}f_{yy}(t, X(t), Y(t))dY(t)dY(t) \\
&+ f_{xy}(t, X(t), Y(t))dX(t)dY(t)
\end{align}
$$

where:

$$
\begin{align}
dX(t)dX(t) &= (\sigma_{11}^2 + \sigma_{12}^2)dt \\
dY(t)dY(t) &= (\sigma_{21}^2 + \sigma_{22}^2)dt \\
dX(t)dY(t) &= (\sigma_{11}\sigma_{21} + \sigma_{12}\sigma_{22})dt
\end{align}
$$
```

### The Product Rule

```{important}
**Product Rule (Ito Calculus):**

$$
d(X(t)Y(t)) = X(t)dY(t) + Y(t)dX(t) + dX(t)dY(t)
$$

**Note:** The extra term $dX(t)dY(t)$ does not appear in ordinary calculus.
```

**Physical Meaning:** When differentiating a product in stochastic calculus, we must include the quadratic covariation term.

## Example: The Geometric Brownian Motion

This is the most important example for finance.

### Closed Form Formula

The geometric Brownian motion has the closed-form solution:

$$
S(t) = S(0)e^{\mu t - \frac{1}{2}\sigma^2 t + \sigma W(t)}, \quad t \in [0, T]
$$

### Deriving the SDE

We can derive rigorously the **stochastic differential equation** that $S(t)$ satisfies by using Ito's formula.

```{dropdown} Derivation Using Ito's Formula

**Step 1:** Consider the function $f(t, x) = S(0)e^x$ and the process:

$$
X(t) = \mu t - \frac{1}{2}\sigma^2 t + \sigma W(t)
$$

**Step 2:** Compute the derivatives of $f$:

$$
\begin{align}
f_t(t, x) &= 0 \\
f_x(t, x) &= S(0)e^x \\
f_{xx}(t, x) &= S(0)e^x
\end{align}
$$

**Step 3:** Apply Ito's formula:

$$
\begin{align}
dS(t) &= df(t, X(t)) \\
&= 0 \cdot dt + S(0)e^{X(t)}dX(t) + \frac{1}{2}S(0)e^{X(t)}dX(t)dX(t) \\
&= S(t)\left[\left(\mu - \frac{1}{2}\sigma^2\right)dt + \sigma dW(t)\right] + \frac{1}{2}S(t)\sigma^2 dt \\
&= S(t)\mu dt + S(t)\sigma dW(t)
\end{align}
$$
```

```{important}
**SDE for Geometric Brownian Motion:**

$$
dS(t) = \mu S(t)dt + \sigma S(t)dW(t)
$$

where:
- $\mu$ is the drift (expected return)
- $\sigma$ is the volatility (diffusion coefficient)
```

**Physical Meaning:** The percentage change in $S$ has a deterministic component $\mu dt$ and a random component $\sigma dW(t)$. This is the standard model for stock prices.

## Application: Estimating Volatility from Market Data

A good estimate for **historical volatility** is provided by the following procedure, which relies on stochastic calculus.

### The Method

Recall the well-known differential rules:

$$
dW(t)dW(t) = dt, \quad dt \cdot dt = 0, \quad dt \cdot dW(t) = 0
$$

**Setup:**
- Pick a partition of $[0, T]$ into $n$ subintervals of equal length
- $0 = t_0 \leq t_1 \leq t_2 \leq \cdots \leq t_j \leq t_{j+1} \leq \cdots \leq t_n = T$
- $t_j = jT/n$
- Define $\Delta t = T/n$
- Observe stock price and collect data: $S_0, S_1, \ldots, S_j, \ldots, S_n$
- $S_j$ is the stock price in interval $[t_j, t_{j+1})$

### Log Returns

Using the geometric Brownian motion model:

$$
\log\frac{S_{j+1}}{S_j} = \sigma[W(t_{j+1}) - W(t_j)] + \left(\mu - \frac{1}{2}\sigma^2\right)\Delta t
$$

### Derivation

```{dropdown} Detailed Derivation

**Step 1:** Square both sides:

$$
\left(\log\frac{S_{j+1}}{S_j}\right)^2 = \left[\sigma(W(t_{j+1}) - W(t_j)) + \left(\mu - \frac{1}{2}\sigma^2\right)\Delta t\right]^2
$$

**Step 2:** Sum over all indices:

$$
\sum_{j=0}^{n-1} \left(\log\frac{S_{j+1}}{S_j}\right)^2 = \sum_{j=0}^{n-1} \left[\sigma(W(t_{j+1}) - W(t_j)) + \left(\mu - \frac{1}{2}\sigma^2\right)\Delta t\right]^2
$$

**Step 3:** Expand the right-hand side:

$$
\begin{align}
\sum_{j=0}^{n-1} \left(\log\frac{S_{j+1}}{S_j}\right)^2 &= \sum_{j=0}^{n-1} \left[\sigma^2(W(t_{j+1}) - W(t_j))^2 \right. \\
&\quad + 2\sigma\left(\mu - \frac{1}{2}\sigma^2\right)\Delta t(W(t_{j+1}) - W(t_j)) \\
&\left. \quad + \left(\mu - \frac{1}{2}\sigma^2\right)^2(\Delta t)^2\right]
\end{align}
$$

**Step 4:** Use the quadratic variation and the properties $dt \cdot dt = 0$, $dW(t) \cdot dt = 0$:

$$
\sum_{j=0}^{n-1} (W(t_{j+1}) - W(t_j))^2 \approx T
$$

as $n \to \infty$ (by quadratic variation).

The cross terms vanish, so:

$$
\sum_{j=0}^{n-1} \left(\log\frac{S_{j+1}}{S_j}\right)^2 \approx \sigma^2 T
$$
```

```{important}
**Volatility Estimator:**

$$
\sigma^2 \approx \frac{1}{T}\sum_{j=0}^{n-1} \left(\log\frac{S_{j+1}}{S_j}\right)^2
$$

**Key Advantage:** This estimate does not require a prior estimation of the parameter $\mu$.
```

**Physical Meaning:** We can estimate volatility from observed price data by summing squared log returns. This works because the quadratic variation of log prices equals $\sigma^2 t$.

## Example: The Vasicek Interest Rate Model

The Vasicek model is a mean-reverting model used for interest rates and other financial quantities.

### The Model

```{important}
**Vasicek SDE:**

$$
dR(t) = \kappa(\theta - R(t))dt + \sigma dW(t)
$$

where $\kappa, \theta, \sigma > 0$ are positive constants.
```

**Physical Meaning:**
- $\theta$ is the long-run mean level
- $\kappa$ is the speed of mean reversion
- When $R(t) > \theta$, the drift is negative (pulls $R$ down toward $\theta$)
- When $R(t) < \theta$, the drift is positive (pushes $R$ up toward $\theta$)

### Applications

```{note}
**Where is Vasicek Used?**

1. **Interest rates:** The short rate (overnight rate)
2. **Commodities:** Gold, coffee, oil, gas, electricity prices
3. **Pairs trading:** The spread of two co-integrated assets
```

### Closed-Form Solution

```{important}
**Explicit Solution:**

$$
R(t) = e^{-\kappa t}R(0) + \theta(1 - e^{-\kappa t}) + \sigma e^{-\kappa t}\int_0^t e^{\kappa s}dW(s)
$$
```

### Verification Using Ito's Formula

```{dropdown} Proof that This is the Solution

Define:
$$
X(t) = \int_0^t e^{\kappa s}dW(s)
$$

and:
$$
f(t, x) = e^{-\kappa t}R(0) + \theta(1 - e^{-\kappa t}) + \sigma e^{-\kappa t}x
$$

**Step 1:** Compute partial derivatives:

$$
\begin{align}
f_x(t, x) &= \sigma e^{-\kappa t} \\
f_{xx}(t, x) &= 0 \\
f_t(t, x) &= -\kappa e^{-\kappa t}R(0) + \kappa\theta e^{-\kappa t} - \kappa\sigma e^{-\kappa t}x \\
&= \kappa\theta - \kappa f(t, x)
\end{align}
$$

**Step 2:** Apply Ito's formula:

$$
\begin{align}
dR(t) &= df(t, X(t)) \\
&= f_t(t, X(t))dt + f_x(t, X(t))dX(t) + \frac{1}{2}f_{xx}(t, X(t))dX(t)dX(t) \\
&= (\kappa\theta - \kappa f(t, X(t)))dt + \sigma e^{-\kappa t}dX(t) \\
&= \kappa(\theta - R(t))dt + \sigma dW(t)
\end{align}
$$

This confirms the solution.
```

### Distribution of R(t)

The integral:
$$
\int_0^t e^{\kappa s}dW(s)
$$

is an Ito integral with a **deterministic integrand**, so it is normally distributed with mean 0 and variance:

$$
\int_0^t e^{2\kappa s}ds = \frac{1}{2\kappa}(e^{2\kappa t} - 1)
$$

```{important}
**Distribution of Vasicek Process:**

$R(t)$ is normally distributed with:

**Mean:**
$$
\mu_R(t) = e^{-\kappa t}R(0) + \theta(1 - e^{-\kappa t})
$$

**Variance:**
$$
\sigma_R^2(t) = \frac{\sigma^2}{2\kappa}(1 - e^{-2\kappa t})
$$
```

**Physical Meaning:**
- As $t \to \infty$, the mean approaches $\theta$ (mean reversion)
- As $t \to \infty$, the variance approaches $\sigma^2/(2\kappa)$ (stationary variance)

### Mean Reversion

```{note}
**Properties of Mean Reversion:**

- For $t$ large, the mean of $R(t)$ tends to $\theta/\kappa \cdot \kappa = \theta$
- When $R(t) = \theta$, the drift term becomes 0
- If $R(0) = \theta$, then $E[R(t)] = \theta$ for all times
- When $R(t) > \theta$, the drift is negative (pulls back toward $\theta$)
- When $R(t) < \theta$, the drift is positive (pushes up toward $\theta$)
```

### Issue: Negative Interest Rates

```{warning}
**Drawback of Vasicek Model:**

Even when $R(0)$ is strictly positive, $R(t)$ may wander into negative territory at times.

If one does not want negative interest rates, one remedy is the **Cox-Ingersoll-Ross (CIR) model**:

$$
dR(t) = \kappa(\theta - R(t))dt + \sigma\sqrt{R(t)}dW(t)
$$

where $\kappa, \theta, \sigma > 0$ are positive constants.
```

**Physical Meaning (CIR):** When $R(t)$ reaches 0, the volatility term becomes zero, and the evolution is only dictated by the drift which pushes $R(t)$ back into positive territory.

```{note}
**Limitation:**

Unlike the Vasicek model, the CIR stochastic differential equation does not have an analytical solution and must be approximated numerically.
```

## The Euler Scheme

When we cannot solve an SDE in closed form, we must approximate its solution numerically.

### Arithmetic Brownian Motion

Consider the **arithmetic Brownian motion with drift**:

$$
dX(t) = \mu dt + \sigma dW(t)
$$

```{important}
**Euler Discretization:**

$$
X(t + \Delta t) = X(t) + \mu \Delta t + \sigma\sqrt{\Delta t} \, N(0, 1)
$$

where:
- $N(0, 1)$ is a sample drawn from the standard normal distribution
- $\Delta t > 0$ is the time step

**Truncation Error:** The Euler scheme has truncation error of order $\sqrt{\Delta t}$.
```

**Physical Meaning:** We approximate the continuous SDE by discrete updates. At each time step, we add the deterministic drift $\mu \Delta t$ and a random shock $\sigma\sqrt{\Delta t} N(0,1)$.

### Geometric Brownian Motion

Consider the **geometric Brownian motion with drift**:

$$
dS(t) = \mu S(t)dt + \sigma S(t)dW(t)
$$

```{important}
**Euler Discretization for GBM:**

$$
\frac{S(t + \Delta t) - S(t)}{S(t)} \approx \mu \Delta t + \sigma\sqrt{\Delta t} \, N(0, 1)
$$

which gives:

$$
S(t + \Delta t) = S(t)[1 + \mu \Delta t + \sigma\sqrt{\Delta t} \, N(0, 1)]
$$

where:
- $N(0, 1)$ denotes a standard normal random variable
- $\Delta t > 0$ is the time step
```

**Physical Meaning:** The percentage change in stock price is approximated by a normal random variable with mean $\mu \Delta t$ and standard deviation $\sigma\sqrt{\Delta t}$.

---

## References

1. Bernt Oksendal, "Stochastic Differential Equations: An introduction with applications", Universitext, 6th Edition, 2007, Springer
2. Steven E. Shreve, "Stochastic Calculus for Finance II: Continuous-time finance", 2004, Springer
