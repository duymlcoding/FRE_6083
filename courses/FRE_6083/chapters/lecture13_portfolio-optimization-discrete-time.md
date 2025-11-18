---
title: "Lecture 13: Portfolio Optimization in Discrete Time"
author: "Agnès Tourin"
date: "October 31, 2024"
---

# One Period Investment Models and Portfolio Optimization

This lecture introduces portfolio optimization in discrete time using a one-period model. We present the martingale approach for solving portfolio optimization problems and establish the fundamental connection between optimal portfolios, utility functions, and risk-neutral probability measures.

```{seealso}
**Recommended Reference:**
- Stanley R. Pliska, "Introduction to Mathematical Finance, Discrete Time Models", 1997, Blackwell Publishing

**Note:** Most material is drawn from this reference. Any mistakes are the sole responsibility of the author of these notes.
```

## The One-Period Model

### Model Setup

```{important}
**Probability Space:**

We consider an experiment with a finite number of possible outcomes:
$$
\Omega = \{\omega_1, \ldots, \omega_K\}
$$

**Time Structure:**
- $t = 0$: Beginning of the period (investment time)
- $t = 1$: End of the period (terminal time)
```

**Physical Meaning:** This is the simplest possible investment model—you invest your wealth at time 0, observe one of finitely many outcomes, and receive your terminal wealth at time 1.

### Wealth Dynamics

```{note}
**Notation:**

- $w_0 = w$ = initial wealth at time 0
- $w_1$ = terminal wealth at time 1 (random variable)
- **Goal:** Compute the optimal investment strategy
```

### Utility Functions

```{important}
**Definition: Utility Function**

A utility function is $u: \mathbb{R} \to \mathbb{R}$ such that $w \mapsto u(w)$ is:
- **Differentiable**
- **Concave:** $u''(w) \leq 0$
- **Strictly increasing:** $u'(w) > 0$
```

**Physical Meaning:**
- $u(w)$ represents the satisfaction or "utility" derived from wealth $w$
- Concavity captures **risk aversion**: marginal utility decreases with wealth
- Increasing property: more wealth is always better

### Performance Measure

```{important}
**Expected Utility:**

Our measure of portfolio performance is the **expected utility of terminal wealth**:
$$
E[u(w_1)] = \sum_{\omega \in \Omega} P(\omega) u(w_1(\omega))
$$
```

**Physical Meaning:** We evaluate a portfolio not just by its expected return, but by the expected satisfaction it provides, accounting for risk preferences.

## Assets in the Model

### The Bank Account

```{note}
**Risk-Free Asset:**

- $B(0) = 1$ = value at time 0
- $B(1) \geq 1$ = value at time 1 (can be random)

In general, $B = (B(0), B(1))$ is a random variable.
```

**Physical Meaning:** The bank account represents a risk-free (or low-risk) investment option.

### Risky Assets

```{note}
**$N$ Risky Assets:**

- $S_n(t)$ = value of one share of the $n$th risky asset at time $t$
- $n = 1, \ldots, N$
```

### Trading Strategy

```{important}
**Portfolio Representation:**

A trading strategy is denoted by:
$$
(H_0, H_1, \ldots, H_n, \ldots, H_N) \in \mathbb{R}^{N+1}
$$

where:
- $H_n$ = number of shares of the $n$th asset held
- $n = 0$ corresponds to the bank account
```

**Physical Meaning:** The portfolio is a vector specifying how many shares of each asset (including cash) to hold.

## The Optimization Problem

### Basic Formulation

```{important}
**Portfolio Optimization Problem:**

$$
\max_{(H_0, \ldots, H_N) \in \mathbb{R}^{N+1}} E[u(w_1)]
$$

**Subject to:**
$$
w_0 = w \quad \text{(budget constraint)}
$$
```

### The Numeraire

```{note}
**Normalization:**

We make the bank account the **numeraire** (asset of reference) and normalize all prices by dividing by $B(t)$:

$$
\tilde{S}_n(t) = \frac{S_n(t)}{B(t)}
$$
```

**Physical Meaning:** Working with discounted prices simplifies the mathematics and reveals the fundamental economic structure.

### Wealth Expressions

```{important}
**Initial Wealth (Discounted):**

Since $B(0) = 1$:
$$
w_0 = H_0 B(0) + H_1 S_1(0) + \cdots + H_N S_N(0) = H_0 + H_1 \tilde{S}_1(0) + \cdots + H_N \tilde{S}_N(0)
$$

**Terminal Wealth (Discounted):**
$$
w_1 = B(1)\left(H_0 + H_1 \tilde{S}_1(1) + \cdots + H_N \tilde{S}_N(1)\right)
$$
```

### Price Changes

```{note}
**Notation for Price Changes:**

$$
\Delta \tilde{S}_n = \tilde{S}_n(1) - \tilde{S}_n(0)
$$
```

### Eliminating $H_0$

```{dropdown} Derivation of Terminal Wealth Formula

Since initial wealth is given, we can solve for $H_0$:
$$
H_0 = w - H_1 \tilde{S}_1(0) - \cdots - H_N \tilde{S}_N(0)
$$

Substituting into terminal wealth:
$$
\begin{align}
w_1 &= B(1)\left(w - H_1 \tilde{S}_1(0) - \cdots - H_N \tilde{S}_N(0) + H_1 \tilde{S}_1(1) + \cdots + H_N \tilde{S}_N(1)\right) \\
&= B(1)\left\{w + H_1 \Delta\tilde{S}_1 + \cdots + H_N \Delta\tilde{S}_N\right\}
\end{align}
$$
```

```{important}
**Reduced Optimization Problem:**

$$
\max_{(H_1, \ldots, H_N) \in \mathbb{R}^N} E\left[u\left(B(1)\left\{w + H_1 \Delta\tilde{S}_1 + \cdots + H_N \Delta\tilde{S}_N\right\}\right)\right]
$$

**Key Insight:** The problem reduces from $N+1$ variables to $N$ variables.
```

## No Arbitrage and Solution Existence

### Arbitrage Definition

```{important}
**Arbitrage Opportunity:**

An arbitrage opportunity is a strategy $H^a$ such that:
$$
w + \sum_{n=1}^N H_n^a \Delta\tilde{S}_n \geq w
$$

with strict inequality for at least one outcome $\omega$.

**Physical Meaning:** A risk-free profit with no initial investment.
```

### Fundamental Result

```{important}
**No Arbitrage Implies No Solution:**

If there exists an arbitrage opportunity, there **cannot exist** a solution to the optimization problem.
```

```{dropdown} Proof by Contradiction

**Assume:**
- $\hat{H}$ is a solution to the optimization problem
- $H^a$ is an arbitrage opportunity

**Consider the strategy:**
$$
H = \hat{H} + H^a
$$

**Discounted terminal wealth:**
$$
w + \sum_{n=1}^N H_n \Delta\tilde{S}_n = w + \sum_{n=1}^N \hat{H}_n \Delta\tilde{S}_n + \sum_{n=1}^N H_n^a \Delta\tilde{S}_n \geq w + \sum_{n=1}^N \hat{H}_n \Delta\tilde{S}_n
$$

with strict inequality for at least one $\omega$.

**Conclusion:** By concavity and strict increase of $u$, strategy $H$ yields better utility than $\hat{H}$, contradicting optimality of $\hat{H}$.
```

### Consequence

```{important}
**Risk-Neutral Measure Existence:**

If there is a solution to the optimization problem, then:
1. There is **no arbitrage** opportunity
2. There exists a **risk-neutral probability measure**
```

**Physical Meaning:** Optimal portfolios can only exist in arbitrage-free markets, which are characterized by risk-neutral probabilities.

## First-Order Optimality Conditions

### Objective Function

```{note}
**Expanded Objective:**

$$
\sum_{\omega \in \Omega} P(\omega) u\left(B(1, \omega)\left\{w + \sum_{n=1}^N H_n \Delta\tilde{S}_n(\omega)\right\}\right)
$$
```

### Gradient Condition

```{important}
**First-Order Necessary Condition:**

At the optimum, the gradient with respect to $(H_1, \ldots, H_N)$ equals zero.

For all $n = 1, \ldots, N$:
$$
\sum_{\omega \in \Omega} P(\omega) u'\left(B(1, \omega)\left\{w + \sum_{n=1}^N H_n \Delta\tilde{S}_n(\omega)\right\}\right) B(1, \omega) \Delta\tilde{S}_n(\omega) = 0
$$

where $u'$ denotes the first derivative of $u$.
```

### Expectation Form

```{important}
**Expectation Interpretation:**

$$
E[B(1) u'(w_1) \Delta\tilde{S}_n] = 0, \quad n = 1, \ldots, N
$$
```

**Physical Meaning:** At the optimum, the expected marginal change in utility (weighted by the discount factor) from each risky asset must be zero.

## Characterizing the Risk-Neutral Measure

### Martingale Property

```{note}
**Risk-Neutral Measure $\tilde{P}$:**

Under a risk-neutral probability measure $\tilde{P}$, discounted asset prices are martingales:
$$
E^{\tilde{P}}[\Delta\tilde{S}_n] = \sum_{\omega \in \Omega} \tilde{P}(\omega) \Delta\tilde{S}_n(\omega) = 0, \quad n = 1, \ldots, N
$$
```

### Comparison with Optimality

Comparing the martingale property with the first-order condition suggests:

```{important}
**Risk-Neutral Measure Definition:**

$$
\tilde{P}(\omega) = \frac{P(\omega) B(1, \omega) u'(w_1(\omega))}{E[B(1) u'(w_1)]}
$$

**Normalization:** We verify that:
$$
\sum_{k=1}^K \tilde{P}(\omega_k) = 1
$$
```

**Physical Meaning:** The risk-neutral probabilities are the physical probabilities weighted by the marginal utility and discount factor, then normalized.

## The Discounted Wealth Process as a Martingale

### Verification

```{dropdown} Derivation

$$
\begin{align}
E^{\tilde{P}}[w_1 / B(1)] &= \sum_{\omega \in \Omega} \tilde{P}(\omega) \frac{w_1(\omega)}{B(1, \omega)} \\
&= \sum_{\omega \in \Omega} \tilde{P}(\omega) \frac{B(1, \omega)\left(w + \sum_n H_n \Delta\tilde{S}_n(\omega)\right)}{B(1, \omega)} \\
&= w + \sum_n H_n E^{\tilde{P}}[\Delta\tilde{S}_n] \\
&= w = w_0
\end{align}
$$
```

```{important}
**Martingale Property:**

The discounted wealth process is a martingale under the risk-neutral measure:
$$
E^{\tilde{P}}[w_1 / B(1)] = w_0
$$
```

**Physical Meaning:** Under risk-neutral probabilities, discounted wealth has no expected growth—this is the fundamental property of arbitrage-free pricing.

### Does a Solution Always Exist?

```{warning}
**Existence Not Guaranteed:**

The existence of a risk-neutral probability measure does **not** guarantee that the portfolio optimization problem has a solution.

The optimization problem does not always have a solution, even in arbitrage-free markets.
```

## Market Completeness

```{important}
**Definition: Complete Market**

A market model is **complete** if every contingent claim can be replicated by some trading strategy.

Otherwise, the market is **incomplete**.
```

```{important}
**Fundamental Theorem:**

The market model is complete **if and only if** the risk-neutral probability measure is **unique**.
```

**Physical Meaning:**
- In complete markets, any payoff can be synthesized
- In incomplete markets, some risks cannot be hedged

## The Martingale Approach to Portfolio Optimization

### Two-Step Procedure

```{admonition} Solution Technique
:class: tip

Instead of solving the $N$-dimensional nonlinear system directly, we use a two-step approach:

**Step 1:** Compute the optimal terminal value $v_1$

**Step 2:** Compute the trading strategy that generates $v_1$
```

### Step 1: The Subproblem

```{important}
**Subproblem Formulation:**

$$
\max_{v \in V_w} E[u(v)]
$$

where the feasible set is:
$$
V_w = \left\{v \in \mathbb{R}^K : E^{\tilde{P}}[v / B(1)] = w\right\}
$$

**Interpretation:** Find the wealth process with largest expected utility among all martingales (under $\tilde{P}$).
```

**Physical Meaning:** We search over all possible terminal wealths that are consistent with our initial budget (in present value terms).

### Lagrangian Approach

```{important}
**Lagrange Multiplier Method:**

$$
\max_v E[u(v)] - \lambda E^{\tilde{P}}[v / B(1)]
$$

where $\lambda$ is chosen such that the solution satisfies:
$$
E^{\tilde{P}}[v / B(1)] = w
$$
```

```{dropdown} Reformulation

$$
\begin{align}
&E[u(v)] - \lambda E[\tilde{P}/P \cdot v/B(1)] \\
&= E[u(v) - (\tilde{P}/P) v/B(1) \cdot \lambda] \\
&= \sum_\omega P(\omega)[u(v(\omega)) - (\tilde{P}(\omega)/P(\omega)) v(\omega)/B(1,\omega) \cdot \lambda]
\end{align}
$$
```

### First-Order Condition

```{important}
**Optimality Condition:**

For each $\omega \in \Omega$:
$$
u'(v(\omega)) = \frac{\tilde{P}(\omega)}{P(\omega) B(1, \omega)} \lambda
$$

**Solving for $v$:**
$$
v(\omega) = (u')^{-1}\left(\frac{\lambda \tilde{P}(\omega)}{P(\omega) B(1, \omega)}\right)
$$

where $(u')^{-1}$ denotes the inverse function of $u'$.
```

### Determining the Multiplier

Together with the definition of $\tilde{P}$:

```{important}
**Lagrange Multiplier:**

$$
\lambda = E[B(1) u'(w_1)]
$$

where $w_1$ is the optimal solution.
```

### Budget Constraint

```{important}
**Condition on $\lambda$:**

$$
w = E^{\tilde{P}}[w_1 / B(1)] = E^{\tilde{P}}\left[(u')^{-1}\left(\frac{\lambda \tilde{P}}{P B(1)}\right) / B(1)\right]
$$

This equation determines $\lambda$ as a function of initial wealth $w$.
```

**Physical Meaning:** The Lagrange multiplier balances the budget constraint and utility maximization. Higher initial wealth corresponds to lower marginal utility at the optimum.

### Step 2: Replicating Strategy

```{note}
**Implementation:**

Once we determine the optimal terminal wealth $w_1$ from Step 1, Step 2 is straightforward:

**Find the trading strategy $H$ that replicates** the contingent claim $w_1$:
- Price at time 0: $w$
- Payoff at time 1: $w_1$
```

**Physical Meaning:** In a complete market, we can always find a portfolio that produces any desired payoff. In an incomplete market, this step may not be possible for all payoffs.

## Worked Example

```{admonition} Example: Two Assets, Three States
:class: tip

**Parameters:**
- $N = 2$ (two risky assets)
- $K = 3$ (three states)
- $r = 1/9$ (constant interest rate), so $B(1) = 1 + r = 10/9$
- $P(\omega_1) = 1/2$, $P(\omega_2) = 1/4$, $P(\omega_3) = 1/4$
- $u(v) = -\exp(-v)$ (exponential utility)

**Price Evolution:**

| $n$ | $\tilde{S}_n(0)$ | $\tilde{S}_n(1, \omega_1)$ | $\tilde{S}_n(1, \omega_2)$ | $\tilde{S}_n(1, \omega_3)$ |
|-----|------------------|----------------------------|----------------------------|----------------------------|
| 1   | 6                | 6                          | 8                          | 4                          |
| 2   | 10               | 13                         | 9                          | 8                          |
```

### Step 1: Computing the Risk-Neutral Measure

```{dropdown} Solution for $\tilde{P}$

**Martingale conditions:**
$$
E^{\tilde{P}}[\Delta\tilde{S}_n] = \sum_{\omega \in \Omega} \tilde{P}(\omega) \Delta\tilde{S}_n(\omega) = 0, \quad n = 1, 2
$$

**System of equations:**
$$
\begin{cases}
0 \cdot \tilde{P}(\omega_1) + 2\tilde{P}(\omega_2) - 2\tilde{P}(\omega_3) = 0 \\
3\tilde{P}(\omega_1) - 1\tilde{P}(\omega_2) - 2\tilde{P}(\omega_3) = 0 \\
\tilde{P}(\omega_1) + \tilde{P}(\omega_2) + \tilde{P}(\omega_3) = 1
\end{cases}
$$

**Unique solution:**
$$
\tilde{P}(\omega_1) = 1/3, \quad \tilde{P}(\omega_2) = 1/3, \quad \tilde{P}(\omega_3) = 1/3
$$
```

### Radon-Nikodym Derivative

```{note}
**Likelihood Ratio:**

$$
L(\omega) = \frac{\tilde{P}(\omega)}{P(\omega)}
$$

gives:
$$
L(\omega_1) = 2/3, \quad L(\omega_2) = L(\omega_3) = 4/3
$$
```

### Step 2: Optimal Wealth Formula

```{dropdown} Derivation

**Inverse utility function:**
$$
(u')^{-1}(y) = -\ln y
$$

**Optimal wealth:**
$$
w_1(\omega) = -\ln(\lambda L(\omega) / B(1))
$$

**Determining $\lambda$:**
$$
w = E^{\tilde{P}}[-\ln((\tilde{P}/P) / B(1)) / B(1)] = -\ln(\lambda) E^{\tilde{P}}[1/B(1)] - E^{\tilde{P}}[\ln(L/B(1)) / B(1)]
$$

Therefore:
$$
\lambda = \exp\left\{-\frac{w + E^{\tilde{P}}[\ln(L/B(1)) / B(1)]}{E^{\tilde{P}}[1/B(1)]}\right\}
$$

**Simplified formula:**
$$
w_1 = w + \frac{E^{\tilde{P}}[\ln(L/B(1)) / B(1)]}{E^{\tilde{P}}[1/B(1)]} - \ln(L/B(1))
$$
```

### Numerical Results

```{important}
**Computed Values:**

Using $B(1) = 10/9$:
$$
E^{\tilde{P}}[\ln(L/B(1))] = -0.04873
$$

**Optimal wealth:**
- $w_1(\omega_1) = w(10/9) + 0.46209$
- $w_1(\omega_2) = w(10/9) - 0.23105$
- $w_1(\omega_3) = w(10/9) - 0.23105$

**Optimal objective value:**
$$
E[u(w_1)] = -E[L/B(1)] = -E^{\tilde{P}}[1/B(1)] = -9/10
$$
```

### Step 3: Finding the Replicating Strategy

```{important}
**System to Solve:**

$$
w_1 / B(1) = w + H_1 \Delta\tilde{S}_1 + H_2 \Delta\tilde{S}_2
$$

**Equivalent system:**
$$
\begin{cases}
0.41590 = 0 \cdot H_1 + 3H_2 \\
-0.20795 = 2H_1 - H_2 \\
-0.20795 = -2H_1 - 2H_2
\end{cases}
$$

**Unique solution:**
$$
H_1 = -0.03466, \quad H_2 = 0.13863
$$
```

### Computing Cash Position

```{note}
**Budget constraint:**
$$
w = H_0 + 6H_1 + 10H_2
$$

**Solving for $H_0$:**
$$
H_0 = w - 1.17834
$$
```

**Physical Meaning:**
- Hold 0.13863 shares of asset 2 (long position)
- Hold -0.03466 shares of asset 1 (short position)
- Keep $w - 1.17834$ in the bank account

## Summary

In this lecture, we covered:

1. **One-Period Model Foundations:**
   - Finite state space
   - Utility functions and expected utility
   - Bank account and risky assets

2. **Portfolio Optimization:**
   - Basic formulation with budget constraint
   - Connection to no-arbitrage condition
   - Existence and uniqueness issues

3. **Risk-Neutral Measures:**
   - Definition via first-order conditions
   - Martingale property of discounted wealth
   - Radon-Nikodym derivative

4. **The Martingale Approach:**
   - Two-step solution procedure
   - Lagrangian method for Step 1
   - Replication strategy for Step 2

5. **Market Completeness:**
   - Definition and characterization
   - Uniqueness of risk-neutral measure

6. **Worked Example:**
   - Complete solution with exponential utility
   - Numerical computation of optimal portfolio
   - Explicit trading strategy

```{important}
**Key Takeaways:**

- Optimal portfolios exist only in arbitrage-free markets
- The risk-neutral measure encodes both market prices and investor preferences
- The martingale approach transforms a difficult optimization into two simpler steps
- Market completeness ensures all contingent claims can be replicated
```

---

## References

1. Stanley R. Pliska, "Introduction to Mathematical Finance, Discrete Time Models", 1997, Blackwell Publishing
