---
title: "Chapter 5: Simulation"
subtitle: "Monte Carlo Methods, Variance Reduction, and Multivariate Modeling"
author: "David C. Shimko"
date: "2025"
---

# Chapter 5: Simulation

## Chapter Overview

In the previous chapters, we relied on "closed-form" solutions—formulas like the GVE or annuity equations that give a precise answer based on deterministic inputs. However, the real world is rarely so cooperative. Financial engineers often face problems where the random variables are too complex, too numerous, or too interdependent for a single equation to solve.

This chapter introduces **Simulation** (often called Monte Carlo Simulation). While it is computationally the "slowest and least accurate" method compared to analytic formulas, it is the "most flexible". It allows us to model complex phenomena like:
* Stochastic interest rates and exchange rates.
* Path-dependent commodity prices.
* Event risks (defaults, accidents) with non-standard distributions.

We will move from generating simple random numbers to building sophisticated engines that can simulate correlated default times for a bond portfolio using Cholesky decompositions and Copulas.

### Learning Objectives

By the end of this chapter, you will be able to:

1.  **Apply** the Inverse Transform Method to generate random numbers from any probability distribution (Normal, Exponential, Geometric).
2.  **Execute** the core simulation loop: Generate $\to$ Calculate $\to$ Aggregate $\to$ Analyze Error.
3.  **Implement** Variance Reduction techniques (Moment Matching, Antithetic Sampling) to improve simulation precision without simply increasing sample size.
4.  **Derive** the Cholesky Decomposition of a covariance matrix to simulate correlated random variables.
5.  **Prove** the properties of Linear Combinations of Normal variables using Moment Generating Functions (MGFs) and "Completing the Square."
6.  **Construct** Gaussian Copulas to correlate non-normal random variables (e.g., discrete bond default times).
7.  **Optimize** business decisions under uncertainty using simulation with Common Random Numbers (CRN).

### Prerequisites

```{admonition} Prerequisites
:class: warning

Before studying this chapter, you should be familiar with:
- **Probability Theory:** CDFs, PDFs, Expected Value, Variance, Covariance.
- **Matrix Algebra:** Matrix multiplication, transposes, and triangular matrices.
- **Calculus:** Integration techniques (substitution) for deriving MGFs.
- **Excel/Python:** Basic familiarity with `RAND()`, `NORMSINV()`, or `numpy.random`.
```

---

##  Foundations of Random Number Generation

At the heart of every simulation is the **Random Number Generator (RNG)**. Most systems provide a way to generate a **Uniform** random number $U \sim [0, 1]$. The challenge is converting this uniform noise into specific distributions (Normal, Exponential, etc.) that represent financial variables.

### 1. The Uniform Distribution

$U \sim U[a, b]$ means any value between $a$ and $b$ is equally likely.
For simulation, we use the standard uniform $U[0, 1]$.

* **PDF:** $u(x) = 1$ for $x \in [0, 1]$.
* **CDF:** $U(x) = x$ for $x \in [0, 1]$. 

### 2. The Inverse Transform Theorem

This is the fundamental theorem for simulation. If we have a uniform random number $u$, we can transform it into *any* random variable $X$ if we know the inverse of $X$'s Cumulative Distribution Function (CDF), $F^{-1}(u)$.

**Theorem:**
If $U \sim U[0,1]$ and $X = F^{-1}(U)$, then $X$ has the CDF $F(x)$.

**Proof Logic:**
Since $F(x)$ is a monotonic increasing function:

$$

P(X \le x) = P(F^{-1}(U) \le x)

$$

Apply $F$ to both sides of the inequality inside the probability:

$$

P(X \le x) = P(U \le F(x))

$$

Since $P(U \le k) = k$ for a uniform distribution:

$$

P(X \le x) = F(x)

$$

Thus, $X$ follows the distribution $F$. 


### 3. Generating Specific Distributions

#### The Normal Distribution
For a standard normal $Z \sim N(0, 1)$, the CDF is denoted $N(z)$.
We generate $z$ using the inverse CDF:

$$

z = N^{-1}(u)

$$

In Excel: `=NORMSINV(RAND())`
In Python: `numpy.random.normal()` 

#### The Exponential Distribution
Used for "time until arrival" models.
PDF: $f(x) = \lambda e^{-\lambda x}$ for $x \ge 0$.
CDF: $F(x) = 1 - e^{-\lambda x}$. 

To simulate, set $u = F(x)$ and solve for $x$:

$$

u = 1 - e^{-\lambda x}

$$

$$

e^{-\lambda x} = 1 - u

$$

$$

-\lambda x = \ln(1 - u)

$$

$$

x = -\frac{\ln(1 - u)}{\lambda}

$$

Since $(1-u)$ is distributed identically to $u$ (both uniform on [0,1]), we often simplify to:

$$

x = -\frac{\ln(u)}{\lambda}

$$



#### The Geometric Distribution (Discrete)
Used for discrete time-to-event models (e.g., bond defaults in Chapter 4).
PDF: $f(i) = (1-\pi)^{i-1}\pi$.
CDF: $F(i) = 1 - (1-\pi)^i$.

To simulate, we solve for $i$ and round up to the nearest integer:

$$

i = \text{roundup} \left( \frac{\ln(1-u)}{\ln(1-\pi)} \right)

$$



---

##  The Simulation Core Logic

Simulation is an experimental process. Instead of solving an integral analytically, we estimate it statistically.

### 1. The Process

1.  **Generate** $N$ random outcomes ($z_1, z_2, \dots, z_N$).
2.  **Calculate** the target function $f(z_i)$ for each outcome (e.g., the payoff of an option).
3.  **Aggregate** to find the sample mean $\bar{x}$. This is our estimate of the Expected Value $E[f(Z)]$. 

$$

\bar{x} = \frac{1}{N} \sum_{i=1}^N f(z_i)

$$

### 2. Measuring Error

Because simulation relies on random sampling, the answer is never exact. We must quantify the uncertainty.

* **Sample Variance ($s^2$):**

$$
s^2 = \frac{1}{N-1} \sum (x_i - \bar{x})^2
$$

* **Standard Error (SE):** The standard deviation of the *mean itself*.

$$
SE = \frac{s}{\sqrt{N}}
$$ 

**Confidence Intervals:**
According to the Central Limit Theorem, the sample mean $\bar{x}$ is normally distributed for large $N$.

$$

\text{Confidence Interval} = \bar{x} \pm m \left( \frac{s}{\sqrt{N}} \right)

$$

Where $m$ determines the confidence level:
* $m=1$: 68% confidence
* $m=2$: 95% confidence
* $m=3$: 99.7% confidence 

**The Law of Precision:**
To reduce the error by a factor of $k$, you must increase the sample size $N$ by a factor of $k^2$. Simulation is computationally expensive! 

---

##  Variance Reduction Techniques

Since increasing $N$ is costly, we use mathematical tricks to reduce the variance $s^2$ without generating more samples.

### 1. Moment Matching

Random samples rarely have a mean of exactly 0 and standard deviation of exactly 1, even if drawn from $N(0,1)$. **Moment Matching** forces this property.

**Algorithm:**
1.  Generate raw samples $z$.
2.  Calculate sample mean $\bar{z}$ and sample standard deviation $s_z$.
3.  Transform each $z_i$ into a standardized $\hat{z}_i$:

$$

\hat{z}_i = \frac{z_i - \bar{z}}{s_z}

$$

Now, the sample mean of $\hat{z}$ is exactly 0 and the variance is exactly 1. This eliminates "noise" in the first two moments. 

### 2. Antithetic Sampling

This technique exploits negative correlation. For every random number $u$, we also generate its "mirror" $1-u$.

* Generate $z_i = F^{-1}(u_i)$.
* Generate $w_i = F^{-1}(1 - u_i)$. For symmetric distributions (like Normal), $w_i = -z_i$.

**Why it works:**
The estimator becomes $\bar{x} = \frac{z + w}{2}$.
If $z$ and $w$ are negatively correlated, the variance of their sum is lower than the sum of their variances.

$$\text{Var}(z+w) = \text{Var}(z) + \text{Var}(w) + 2\text{Cov}(z,w)$$

Since $\text{Cov}(z, -z)$ is negative, the total variance decreases. 

---

##  Multivariate Simulation (Correlated Variables)

In finance, assets are correlated. A stock portfolio or a basket of bonds requires us to simulate multiple random variables that move together.

### 1. Linear Combinations of Normals

We can build correlated normals from independent normals.
If $Z_1, Z_3 \sim N(0,1)$ are independent, we can construct $Z_2$:

$$

Z_2 = \rho Z_1 + \sqrt{1-\rho^2} Z_3

$$

Properties of $Z_2$:
* Mean: 0
* Variance: $\rho^2(1) + (1-\rho^2)(1) = 1$
* Correlation with $Z_1$: $\rho$ 

### 2. The Cholesky Decomposition

For $k > 2$ variables, we generalize using matrices. We need to transform a vector of independent normals $\mathbf{Z}$ into correlated normals $\mathbf{X}$ with covariance matrix $\mathbf{A}$.

**Goal:** Find a matrix $\mathbf{R}$ such that if we multiply independent $\mathbf{Z}$ by $\mathbf{R}^T$, the resulting covariance is $\mathbf{A}$.

$$

\text{Var}(\mathbf{Z}\mathbf{R}^T) = \mathbf{R} \text{Var}(\mathbf{Z}) \mathbf{R}^T = \mathbf{R} \mathbf{I} \mathbf{R}^T = \mathbf{R}\mathbf{R}^T

$$

So we need $\mathbf{A} = \mathbf{R}\mathbf{R}^T$.
This is called the **Cholesky Decomposition**. $\mathbf{R}$ is a lower triangular matrix. 

**Algorithm for 2x2 Matrix:**
Given $\mathbf{A} = \begin{pmatrix} a_{11} & a_{12} \\ a_{21} & a_{22} \end{pmatrix}$ and $\mathbf{R} = \begin{pmatrix} r_{11} & 0 \\ r_{21} & r_{22} \end{pmatrix}$.

1.  $r_{11}^2 = a_{11} \implies r_{11} = \sqrt{a_{11}}$
2.  $r_{21} r_{11} = a_{21} \implies r_{21} = a_{21} / r_{11}$
3.  $r_{21}^2 + r_{22}^2 = a_{22} \implies r_{22} = \sqrt{a_{22} - r_{21}^2}$ 

**Simulation Step:**
1.  Generate independent $\mathbf{Z}$ (vector of $N(0,1)$).
2.  Calculate $\mathbf{X} = \boldsymbol{\mu} + \mathbf{Z} \mathbf{R}^T$. 

---

##  Advanced Derivations (MGFs and Completing the Square)

To prove that linear combinations of normals are indeed normal, we look at the **Moment Generating Function (MGF)**. This section provides the mathematical depth required to understand *why* the Cholesky method works.

### 1. "Completing the Square" Technique

This algebraic trick is essential for Gaussian integrals.
Given a quadratic $p(x) = -ax^2 + bx + c$, we can rewrite it as:

$$

p(x) = -a(x - h)^2 + k

$$

Where $h = \frac{b}{2a}$ and $k = c + \frac{b^2}{4a}$. 

### 2. MGF of a Normal Distribution

The MGF is defined as $M_X(t) = E[e^{tX}]$. For a Normal $X \sim N(\mu, \sigma^2)$:

$$

M_X(t) = \int_{-\infty}^{\infty} e^{tx} \frac{1}{\sigma\sqrt{2\pi}} e^{-\frac{(x-\mu)^2}{2\sigma^2}} dx

$$

The exponent is quadratic in $x$. By "completing the square" in the exponent, we can isolate the $x$ terms into a Gaussian integral (which sums to 1) and separate the $t$ terms.

**Result:**

$$

M_X(t) = e^{\mu t + \frac{1}{2}\sigma^2 t^2}

$$



### 3. Proof for Linear Combinations

Let $Y = aX_1 + bX_2$.
Since $X_1, X_2$ are independent:

$$

M_Y(t) = E[e^{t(aX_1 + bX_2)}] = E[e^{atX_1}] E[e^{btX_2}]

$$

Substitute the Normal MGF formula:

$$

M_Y(t) = e^{\mu_1 (at) + \frac{1}{2}\sigma_1^2 (at)^2} \cdot e^{\mu_2 (bt) + \frac{1}{2}\sigma_2^2 (bt)^2}

$$

$$

M_Y(t) = e^{(\mu_1 a + \mu_2 b)t + \frac{1}{2}(a^2\sigma_1^2 + b^2\sigma_2^2)t^2}

$$

This is the MGF of a Normal distribution with mean $a\mu_1 + b\mu_2$ and variance $a^2\sigma_1^2 + b^2\sigma_2^2$. Thus, linear combinations of normals are normal. 

---

##  Copulas and Non-Normal Correlation

The Cholesky method only works for Normal distributions. What if we need to correlate **Bond Default Times**, which follow a Geometric distribution? We use a **Copula**.

### The Gaussian Copula Method

**Concept:** Use the Normal distribution as a "bridge" to induce correlation, then map back to the target distribution.

**Algorithm:**
1.  **Correlation:** Generate correlated standard normals $z_1, z_2$ using Cholesky (correlation $\rho$).
2.  **Uniform Mapping:** Convert $z$ values to uniform $u$ values using the Normal CDF.

$$
u_1 = N(z_1), \quad u_2 = N(z_2)
$$

Now $u_1, u_2$ are correlated uniform variables.
3.  **Target Mapping:** Convert $u$ values to the target distribution using the Inverse Transform.
    For Geometric (bond default):

$$
x_1 = \text{Geometric}^{-1}(u_1), \quad x_2 = \text{Geometric}^{-1}(u_2)
$$



**Physical Interpretation:**
We are correlating the "percentile rankings" of the variables. If Bond A is in the "bad" tail of the normal distribution (low $z$, low $u$), Bond B is likely also in the bad tail (due to correlation), leading to simultaneous early defaults.


---

##  Worked Examples

```{admonition} Example 1: Integrating $\max(Z, c)$
:class: tip

**Problem:** Estimate $E[\max(Z, 0.5)]$ where $Z \sim N(0,1)$. Compare with exact theory.

**Exact Theory:**

$$E[\max(Z, c)] = c N(c) + n(c)$$

For $c=0.5$:
$N(0.5) = 0.69146$
$n(0.5) = \frac{1}{\sqrt{2\pi}} e^{-0.5^2/2} = 0.352$
$E = 0.5(0.69146) + 0.352 = 0.6978$. 

**Simulation:**
1.  Generate 1000 $z$ values.
2.  Compute $x_i = \max(z_i, 0.5)$.
3.  Average $\bar{x}$.
    * *Standard Simulation:* might yield $0.6974 \pm 0.0250$.
    * *Moment Matching:* reduces error significantly.
    * *Antithetic:* further refinement.

```

```{admonition} Example 2: Cholesky Decomposition
:class: tip

**Problem:** Find the Cholesky matrix $\mathbf{R}$ for Covariance Matrix $\mathbf{A} = \begin{pmatrix} 100 & 80 \\ 80 & 144 \end{pmatrix}$.

**Step 1: $r_{11}$**

$$r_{11} = \sqrt{a_{11}} = \sqrt{100} = 10$$

**Step 2: $r_{21}$**

$$r_{21} = a_{21} / r_{11} = 80 / 10 = 8$$

**Step 3: $r_{22}$**

$$r_{22} = \sqrt{a_{22} - r_{21}^2} = \sqrt{144 - 8^2} = \sqrt{144 - 64} = \sqrt{80} \approx 8.94$$

**Result:**

$$\mathbf{R} = \begin{pmatrix} 10 & 0 \\ 8 & 8.94 \end{pmatrix}$$

```

```{admonition} Example 3: Inventory Optimization (Common Random Numbers)
:class: tip

**Context:** Maximize profit where Demand $D \sim \text{Geometric}(\pi=0.1)$.
Profit = $5 \min(s, D) - 3 \max(s-D, 0) - 7 \max(D-s, 0)$.

**Problem:** Find optimal stock $s$.

**Method:**
1.  Generate a fixed set of random demands $D_1, \dots, D_N$ (e.g., 1000 scenarios).
2.  For each stocking level $s = 8, 9, \dots, 15$:
    Calculate average profit using the *same* $D$ vectors.
3.  Compare results.

**Why Common Random Numbers?**
If we used different random numbers for $s=10$ and $s=11$, the noise might mask the small difference in profitability. By using the same random inputs, we isolate the effect of changing $s$. This produces a smooth optimization curve rather than a jagged one. 

```

---

##  Practice Problems

```{admonition} Practice Problem 1: Exponential Inverse
:class: tip

**Problem:** Find the formula to generate random numbers for an Exponential distribution with mean 10.

**Solution:**
Mean $\mu = 1/\lambda = 10 \implies \lambda = 0.1$.
Inverse CDF formula:

$$x = -\frac{\ln(u)}{0.1} = -10 \ln(u)$$

Generate $u \sim U[0,1]$, apply formula.

```

```{admonition} Practice Problem 2: Correlated Simulation
:class: tip

**Problem:** You have two independent standard normals $z_1 = 0.5, z_3 = -1.2$. You want to create $z_2$ such that $\text{corr}(z_1, z_2) = 0.6$.

**Solution:**
Formula: $z_2 = \rho z_1 + \sqrt{1-\rho^2} z_3$.
$\rho = 0.6$.
$\sqrt{1 - 0.6^2} = \sqrt{0.64} = 0.8$.

$$z_2 = 0.6(0.5) + 0.8(-1.2)$$

$$z_2 = 0.3 - 0.96 = -0.66$$

```

```{admonition} Practice Problem 3: Confidence Interval
:class: tip

**Problem:** Simulation of 10,000 trials yields mean $\bar{x} = 100$ and sample std dev $s = 20$. Calculate the 95% confidence interval ($m=2$).

**Solution:**
Standard Error $SE = 20 / \sqrt{10000} = 20 / 100 = 0.2$.
Interval = $100 \pm 2(0.2)$.
Range: $[99.6, 100.4]$.

```

---

##  Chapter Summary

```{important}
**Key Concepts Recap**

**1. The Inverse Transform:**
The universal key to simulation. By mapping uniform random numbers through the inverse CDF ($F^{-1}(u)$), we can replicate any statistical distribution.

**2. The Cost of Precision:**
Simulation error decreases with the square root of $N$. To double precision, we must quadruple the workload. This makes **Variance Reduction** techniques (like Moment Matching and Antithetic Sampling) critical for efficiency.

**3. Correlation via Cholesky:**
To model the real world, variables must move together. We achieve this by decomposing the Covariance Matrix ($\Sigma = RR^T$) and mixing independent noise ($\mu + Z R^T$).

**4. Copulas for the Non-Normal:**
Real risks (like defaults) are often not normal. Gaussian Copulas allow us to maintain the correlation structure of the Normal distribution while enforcing the marginal distributions (like Geometric) of the underlying assets.

**5. Simulation as Optimization:**
Beyond pricing, simulation helps make decisions (like inventory levels). Using **Common Random Numbers** ensures that comparisons between choices are fair and not driven by random noise.
```

### Formula Cheat Sheet

| Concept | Formula |
| :--- | :--- |
| **Exponential Inverse** | $x = -\ln(u)/\lambda$ |
| **Standard Error** | $SE = s / \sqrt{N}$ |
| **Confidence Interval** | $\bar{x} \pm m (s/\sqrt{N})$ |
| **Moment Matching** | $\hat{z} = (z - \bar{z})/s_z$ |
| **Correlated Normal** | $Z_2 = \rho Z_1 + \sqrt{1-\rho^2} Z_3$ |
| **Cholesky (Vector)** | $\mathbf{X} = \boldsymbol{\mu} + \mathbf{Z} \mathbf{R}^T$ |
| **Cholesky (2x2)** | $r_{11}=\sqrt{a_{11}}, r_{21}=a_{21}/r_{11}, r_{22}=\sqrt{a_{22}-r_{21}^2}$ |

