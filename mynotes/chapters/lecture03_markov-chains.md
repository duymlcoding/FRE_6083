---
title: "Lecture 3: Markov Chains"
author: "Agnès Tourin"
date: "August 6, 2024"
---

# Markov Chains

This lecture introduces discrete-time Markov chains with a discrete state space, fundamental tools for modeling stochastic systems with the Markov property. These processes have numerous applications in insurance and finance, from modeling credit rating transitions to regime-switching volatility models.

```{seealso}
**Recommended References:**
- Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
- Rick Durrett, "Probability: Theory and Examples", 4th ed., Cambridge University Press, Cambridge, 2010
- Hull, J., "Options, Futures and Other Derivatives", 9th edition, 2009, Pearson/Prentice Hall
- Charles Tapiero, "Applied Stochastic Models and Control for Finance and Insurance", 1998, Kluwer Academic Publisher
```

## Introduction to Markov Chains

```{admonition} Key Applications in Finance and Insurance
:class: tip

Markov chains are particularly useful for:
- **Regime-switching models:** Modeling volatility that switches between low and high levels
- **Credit risk:** Modeling the migration of bond credit ratings over time
- **Default probability:** Estimating the probability of firm default (gambler's ruin problem)
- **Insurance claims:** Modeling claim frequency and severity patterns
```

### Basic Properties

A Markov chain is a stochastic process with a discrete state space. In this course, we focus on discrete-time Markov chains.

```{note}
**Notation:**

- The Markov chain is denoted by $\{X_n; n = 0, 1, \ldots\}$
- The state space is either $\mathbb{N}$ (non-negative integers) or $\mathbb{Z}$ (all integers)
- In general definitions, we assume the state space is $\mathbb{Z}$
```

## Definition of a Markov Chain

```{important}
**Definition: Discrete-Time Markov Chain**

A discrete-time Markov chain $(X_n)$ is a discrete-time and discrete-state process satisfying the **Markov property**:

$$
P[X_{n+1} = j \mid X_n = i, X_{n-1} = i_{n-1}, \ldots, X_0 = i_0] = P[X_{n+1} = j \mid X_n = i]
$$

**Physical Meaning:** The future state depends only on the current state, not on the entire history of how we arrived at the current state.
```

### Examples of Markov Chains

```{admonition} Example: Random Walk
:class: tip

The symmetric random walk introduced in Lecture 1 is a Markov chain:
- At each step, the process moves up or down by 1
- The next position depends only on the current position and the coin toss
- The path taken to reach the current position is irrelevant

**Transition probabilities:**
$$
\begin{cases}
j = i+1 & \text{with probability } p \\
j = i & \text{with probability } r \\
j = i-1 & \text{with probability } q
\end{cases}
$$
where $p + q + r = 1$.
```

```{warning}
**Non-Markov Example:**

The random walk with short memory from Lecture 2 is **not** a Markov chain because it does not satisfy the Markov property. The next step depends on both the current position and the direction of the previous move.
```

## Time-Homogeneity

```{important}
**Definition: Time-Homogeneous Markov Chain**

A Markov chain $X_n$ is **time-homogeneous** if its transition probabilities are independent of time:

$$
P[X_{n+1} = j \mid X_n = i] = p_{i,j} \quad \text{for all } n = 0, 1, \ldots
$$

where $p_{i,j}$ is independent of $n$.
```

**Physical Meaning:** In a time-homogeneous chain, the probability of moving from state $i$ to state $j$ is the same whether we make this transition at time 0, time 100, or any other time. The system's dynamics don't change over time.

```{note}
**Connection to Previous Definition:**

Under the time-homogeneity assumption, this chapter's definition of the Markov property is equivalent to the definition presented in Lecture 2.
```

## The Transition Probability Matrix

```{important}
**Definition: One-Step Transition Probability Matrix**

The one-step transition probability matrix $P$ of a time-homogeneous Markov chain is:

$$
P = \begin{bmatrix}
p_{0,0} & p_{0,1} & p_{0,2} & \cdots \\
p_{1,0} & p_{1,1} & p_{1,2} & \cdots \\
p_{2,0} & p_{2,1} & p_{2,2} & \cdots \\
\vdots & \vdots & \vdots & \ddots
\end{bmatrix}
$$

**Required Properties:**
1. **Non-negativity:** $p_{i,j} \geq 0$ for all $i, j$
2. **Row sums to 1:** $\sum_{j=0}^{\infty} p_{i,j} = 1$ for all $i$
```

**Physical Meaning:**
- The first constraint ensures probabilities are non-negative
- The second constraint models the fact that the process must be in exactly one state at any given time

### Example: Random Walk Transition Matrix

For a random walk starting from $X_0 = 0$:

$$
P = \begin{bmatrix}
\ddots & \vdots & \vdots & \vdots & \vdots \\
\cdots & q & r & p & 0 \\
\cdots & 0 & q & r & p \\
\vdots & \vdots & \vdots & \vdots & \ddots
\end{bmatrix}
$$

where $p + q + r = 1$.

```{note}
**Finite vs. Infinite State Space:**

In this example, the matrix $P$ has infinite dimension. However, we can restrict the random walk to a finite state space $\{0, \ldots, N-1\}$ by imposing boundary conditions at the edges 0 and $N-1$.
```

## $n$-Step Transition Probabilities

```{important}
**Definition: $n$-Step Transition Probability**

The matrix $P^{(n)} = (p_{i,j}^{(n)})_{i,j}$ of transition probabilities in $n$ steps is defined by:

$$
p_{i,j}^{(n)} = P[X_{m+n} = j \mid X_m = i]
$$

This matrix has the same dimensions as the one-step transition matrix $P$.
```

### Chapman-Kolmogorov Equations

The Chapman-Kolmogorov equations provide the main general tool for analyzing Markov chains.

```{important}
**Chapman-Kolmogorov Equations**

**Scalar Form:**
$$
p_{i,j}^{(m+n)} = \sum_{k=0}^{\infty} p_{i,k}^{(m)} p_{k,j}^{(n)}, \quad \text{for all } m, n, i, j \geq 0
$$

**Matrix Form:**
$$
P^{(m+n)} = P^{(m)} P^{(n)}
$$

**Corollary:**
$$
P^{(n)} = \underbrace{P^{(1)} \cdots P^{(1)}}_{n \text{ times}}
$$
```

**Physical Meaning:** To go from state $i$ to state $j$ in $m+n$ steps, we must pass through some intermediate state $k$ at step $m$. We sum over all possible intermediate states, weighted by the probabilities of the two-part journey.

```{dropdown} Proof of Chapman-Kolmogorov Equations

Starting from the definition:

$$
\begin{align}
p_{i,j}^{(m+n)} &= P[X_{m+n} = j \mid X_0 = i] \\
&= \sum_{k=0}^{\infty} P[X_{m+n} = j, X_m = k \mid X_0 = i] \\
&= \sum_{k=0}^{\infty} P[X_{m+n} = j \mid X_m = k, X_0 = i] P[X_m = k \mid X_0 = i] \\
&= \sum_{k=0}^{\infty} p_{k,j}^{(n)} p_{i,k}^{(m)} \\
&= \sum_{k=0}^{\infty} p_{i,k}^{(m)} p_{k,j}^{(n)}
\end{align}
$$

By the definition of matrix multiplication, we have $P^{(m+n)} = P^{(m)} P^{(n)}$.
```

## First Passage and Return Probabilities

### First Time Probability

```{important}
**Definition: First Passage Probability**

The probability that the chain will move to state $j$ from $X_0 = i$ for the first time at time $n$ is:

$$
f_{i,j}^{(n)} = P[X_n = j, X_{n-1} \neq j, \ldots, X_1 \neq j \mid X_0 = i]
$$

for all $n \geq 0$ and all states $i, j$.
```

### Probability of First Return

```{important}
**Definition: First Return Probability**

This is a special case of first passage probability where $i = j$:

$$
f_{i,i}^{(n)} = P[X_n = i, X_{n-1} \neq i, \ldots, X_1 \neq i \mid X_0 = i]
$$

for all $n \geq 0$ and for each state $i$.
```

**Physical Meaning:** This measures the probability of returning to the starting state for the first time after exactly $n$ steps, without having visited it in the interim.

### Relationship Between Transition and First Passage Probabilities

```{important}
**Key Relationship:**

Using a total probability argument:

$$
p_{i,j}^{(n)} = \sum_{k=0}^{n} f_{i,j}^{(k)} p_{j,j}^{(n-k)}
$$

**Application:** Assuming the transition probabilities $p_{i,j}^{(n)}$ are known, we can compute recursively the first time probabilities $f_{i,j}^{(n)}$ from this relationship.
```

**Physical Meaning:** To be in state $j$ at time $n$ starting from state $i$, we must first reach $j$ at some time $k \leq n$, then stay or return to $j$ for the remaining $n-k$ steps.

## Classification of States

### Accessibility and Communication

```{important}
**Definitions: State Relations**

- **Accessible:** State $j$ is **accessible** from state $i$ if there exists $n \geq 0$ such that $p_{i,j}^{(n)} > 0$

- **Communicate:** States $i$ and $j$ **communicate** if $i$ is accessible from $j$ and $j$ is accessible from $i$

- **Irreducible:** A Markov chain is **irreducible** if all states communicate
```

**Physical Meaning:**
- Accessibility means you can eventually reach state $j$ starting from state $i$
- Communication is a two-way street: you can go from $i$ to $j$ and back
- Irreducibility means all states are reachable from each other

### Periodicity

```{important}
**Definition: Aperiodic Markov Chain**

A Markov chain is **aperiodic** if for every state $i$, the greatest common divisor of $\{n \mid p_{i,i}^{(n)} > 0\}$ equals 1.
```

**Physical Meaning:** An aperiodic chain doesn't have a rigid cyclic structure. It can return to states at various times, not just at regular intervals.

## Ergodic Markov Chains

```{important}
**Definition: Ergodic Markov Chain**

An irreducible Markov chain is **ergodic** if the limit:

$$
\pi_j = \lim_{n \to +\infty} p_{i,j}^{(n)}
$$

exists, is independent of $i$, and satisfies $\sum_{j=0}^{\infty} \pi_j = 1$.

**Theorem:** A finite-state Markov chain that is irreducible and aperiodic is ergodic.
```

**Physical Meaning:** In the long run, an ergodic chain "forgets" its initial state, and the probability of being in any particular state $j$ converges to a limit $\pi_j$ that doesn't depend on where you started.

### Computing the Ergodic Limit

```{important}
**Ergodic Distribution Equations**

When $\pi_j$ exists, it can be obtained by solving:

$$
\begin{cases}
\boldsymbol{\pi} = \boldsymbol{\pi} P \\
\sum_{j=0}^{\infty} \pi_j = 1
\end{cases}
$$

where $\boldsymbol{\pi} = (\pi_0, \pi_1, \ldots)$ is a row vector.
```

```{dropdown} Derivation of Ergodic Equations

Starting from the Chapman-Kolmogorov equations with $m = 1$:

$$
P^{n+1} = P^n P
$$

This is equivalent to:

$$
p_{i,j}^{n+1} = \sum_{k=0}^{\infty} p_{i,k}^n p_{k,j}, \quad \text{for all states } i, j
$$

Letting $n \to +\infty$ in the above formula:

$$
\pi_j = \sum_{k=0}^{\infty} \pi_k p_{k,j}
$$

which is equivalent to $\boldsymbol{\pi} = \boldsymbol{\pi} P$ in vector form.
```

### Interpretation as Long-Run Fraction of Time

```{note}
**Time-Average Interpretation:**

$\pi_j$ can be interpreted as the fraction of time spent in state $j$ in the long run.

If $t_j(N)$ denotes the amount of time spent in state $j$ during periods $1, \ldots, N$:

$$
\frac{t_j(N)}{N} \to \pi_j \quad \text{as } N \to +\infty \quad \text{(almost surely)}
$$

where:
$$
t_j(N) = \sum_{k \leq N} \mathbb{I}_{\{X_k = j\}}
$$
```

**Physical Meaning:** If you run the Markov chain for a very long time, approximately $100 \times \pi_j$ percent of the time will be spent in state $j$.

## Initial Distribution and Marginal Probabilities

### Initial Distribution

In some applications:
- The initial position is **deterministic** and given as a constant
- In other applications, we provide an **initial distribution** $\boldsymbol{\pi}^{(0)} = (\pi_0^{(0)}, \pi_1^{(0)}, \ldots)$ where:

$$
\pi_i^{(0)} = P[X_0 = i], \quad \text{for every state } i
$$

and $\sum_i \pi_i^{(0)} = 1$.

### Marginal Probabilities

```{important}
**Computing Marginal Probabilities**

To compute marginal probabilities at time $n$, condition on the initial state:

$$
P[X_n = j] = \sum_{i=0}^{\infty} P[X_n = j \mid X_0 = i] P[X_0 = i] = \sum_{i=0}^{\infty} p_{i,j}^{(n)} P[X_0 = i]
$$

**Matrix Form:**
$$
\boldsymbol{\pi}^{(n)} = \boldsymbol{\pi}^{(0)} P^n
$$

where $\boldsymbol{\pi}^{(n)} = (\pi_1^{(n)}, \pi_2^{(n)}, \ldots, \pi_i^{(n)})$ represents the distribution at time $n$.
```

```{note}
**Complete Specification:**

A discrete-time Markov chain is fully determined by:
1. Its initial distribution $\boldsymbol{\pi}^{(0)}$
2. Its transition probability matrix $P$
```

### Stationary Distribution

```{important}
**Stationary Distribution Property**

The long-run distribution $\boldsymbol{\pi}$ of an ergodic chain forms a **stationary distribution**:

If $P[X_0 = j] = \pi_j$ for all $j \geq 0$, then:

$$
P[X_n = j] = \pi_j \quad \text{for all } n, j \geq 0
$$

**Proof by induction:** Use $\boldsymbol{\pi}^{(n)} = \boldsymbol{\pi}^{(0)} P^n = \boldsymbol{\pi} P^n = \boldsymbol{\pi}$.
```

**Physical Meaning:** If the chain starts with its ergodic distribution, it maintains that distribution forever. The system is in statistical equilibrium.

### Expected Value of the Markov Chain

```{important}
**Conditional Expectation Formula**

$$
E[X_n \mid X_0 = i] = \sum_{j=1}^{\infty} j \cdot P[X_n = j \mid X_0 = i] = \sum_{j=1}^{\infty} j \cdot p_{i,j}^{(n)}
$$
```

## The Two-State Markov Chain

Consider a two-state Markov chain with states $\{0, 1\}$.

```{admonition} Application: Insurance Claims
:class: tip

**Setup:** Each year, an insured is in one of two states:
- **State 0:** No claim is made
- **State 1:** A claim is made

**Transition Probabilities:**
$$
P[X_{n+1} = 1 \mid X_n = 0] = \alpha, \quad P[X_{n+1} = 0 \mid X_n = 1] = \beta
$$

where $\alpha, \beta \in (0, 1)$ are given parameters.
```

### Transition Matrix

$$
P = \begin{bmatrix}
1-\alpha & \alpha \\
\beta & 1-\beta
\end{bmatrix}
$$

### Computing Powers of P

```{dropdown} Derivation of $P^{(n)}$

One can show by induction that for all $n \geq 1$:

$$
P^{(n)} = \frac{1}{\alpha + \beta} \begin{bmatrix}
\beta & \alpha \\
\beta & \alpha
\end{bmatrix} + \frac{(1-\alpha-\beta)^n}{\alpha + \beta} \begin{bmatrix}
\alpha & -\alpha \\
-\beta & \beta
\end{bmatrix}
$$
```

### Ergodic Limit

As $n \to +\infty$, when $\alpha, \beta \in (0,1)$:

$$
P^{(n)} \to P^{\infty} = \frac{1}{\alpha + \beta} \begin{bmatrix}
\beta & \alpha \\
\beta & \alpha
\end{bmatrix}
$$

Therefore, the ergodic limit is:

$$
\boldsymbol{\pi} = \left[\frac{\beta}{\alpha + \beta}, \frac{\alpha}{\alpha + \beta}\right]
$$

**Physical Meaning:** In the long run, the fraction of time with no claims is $\frac{\beta}{\alpha+\beta}$ and the fraction with claims is $\frac{\alpha}{\alpha+\beta}$.

### Non-Ergodic Case

```{warning}
**Special Case: $\alpha = \beta = 1$**

When $\alpha = \beta = 1$:

$$
P = \begin{bmatrix}
0 & 1 \\
1 & 0
\end{bmatrix}
$$

We have:
$$
P^{2k} = \begin{bmatrix}
1 & 0 \\
0 & 1
\end{bmatrix}, \quad P^{2k+1} = \begin{bmatrix}
0 & 1 \\
1 & 0
\end{bmatrix}
$$

The sequence $P^n$ does not converge. This chain is **periodic** with period 2, hence not ergodic.
```

## Application: Airline Market Share

This example demonstrates how to study ergodicity numerically.

```{admonition} Example: Two Competing Airlines
:class: tip

**Setup:**
- **Airline 1:** Initial customers = 500,000
- **Airline 2:** Initial customers = 200,000 (implements price reduction)
- **Total market:** 700,000 customers (constant)

**Goal:** Study how customer distribution evolves over time (monthly).

**Markov Chain Model:**
- **State 0:** Customer flies with Airline 1
- **State 1:** Customer flies with Airline 2
- Time unit: 1 month
```

### Transition Probabilities

$$
\begin{align}
p_{0,0} &= 1/6 & p_{0,1} &= 5/6 \\
p_{1,0} &= 1/3 & p_{1,1} &= 2/3
\end{align}
$$

**Interpretation:**
- 1/6 of customers currently using Airline 1 stay loyal
- 5/6 of customers currently using Airline 1 switch to Airline 2

$$
P = \begin{bmatrix}
1/6 & 5/6 \\
1/3 & 2/3
\end{bmatrix}
$$

### Evolution Equations

Let $N_0^n, N_1^n$ denote the number of customers for each airline at month $n$.

$$
\begin{bmatrix}
N_0^{n+1} \\
N_1^{n+1}
\end{bmatrix} = \begin{bmatrix}
1/6 & 1/3 \\
5/6 & 2/3
\end{bmatrix} \begin{bmatrix}
N_0^n \\
N_1^n
\end{bmatrix}
$$

Note: We use $P^T$ (transpose) because we're tracking absolute numbers, not probabilities.

After $n$ months:

$$
\begin{bmatrix}
N_0^{n+1} \\
N_1^{n+1}
\end{bmatrix} = (P^T)^{n+1} \begin{bmatrix}
N_0^0 \\
N_1^0
\end{bmatrix}
$$

### Numerical Results

| Month | Airline 1 | Airline 2 |
|-------|-----------|-----------|
| 0 | 500,000 | 200,000 |
| 1 | 150,000 | 550,000 |
| 2 | 208,000 | 492,000 |
| 3 | 199,000 | 501,000 |
| 4 | 200,000 | 500,000 |

**Conclusion:** The market share stabilizes at approximately 200,000 customers for Airline 1 and 500,000 for Airline 2.

## Example: Three-State Non-Ergodic Chain

```{admonition} Example: Non-Ergodic Chain
:class: tip

Consider a Markov chain with state space $\{0, 1, 2\}$ and transition matrix:

$$
P = \begin{bmatrix}
1 & 0 & 0 \\
0 & 1 & 0 \\
1/2 & 1/2 & 0
\end{bmatrix}
$$
```

We compute successive powers:

$$
P^n = \begin{bmatrix}
1 & 0 & 0 \\
0 & 1 & 0 \\
1/2 & 1/2 & 0
\end{bmatrix} = P
$$

Since the rows of $P$ are not identical, this chain is **non-ergodic**.

**Physical Meaning:** States 0 and 1 are **absorbing states** (once entered, never left). State 2 eventually leads to one of the absorbing states. There's no unique long-run distribution independent of initial conditions.

## The Gambler's Ruin Problem

This classic problem is a building block of structural credit risk models.

```{admonition} Problem Setup: Gambling with Limited Capital
:class: tip

**Scenario:**
- A player repeatedly plays a game
- Each round: win $1 with probability $p$ or lose $1 with probability $q = 1-p$
- Initial capital: $i$ dollars
- Game continues until either:
  - Bankruptcy: capital reaches $0$
  - Target reached: capital reaches $k$ dollars

**Question:** What is the probability of eventual ruin?

**State Space:** $S_X = \{0, 1, 2, \ldots, k\}$

**Process:** $X_n$ = player's capital at time $n$, with $X_0 = i$
```

### Absorbing Boundary Conditions

The states 0 and $k$ are **absorbing states**:

$$
p_{0,0} = p_{k,k} = 1
$$

For all other states $i = 1, \ldots, k-1$:

$$
p_{i,i+1} = p = 1 - p_{i,i-1}
$$

### Transition Matrix

The $(k+1) \times (k+1)$ matrix $P$ is:

$$
P = \begin{bmatrix}
1 & 0 & & & & \\
q & 0 & p & & & \\
& \ddots & \ddots & \ddots & & \\
& & q & 0 & p & \\
& & & \ddots & \ddots & \ddots \\
& & & & q & 0 & p \\
& & & & & 0 & 1
\end{bmatrix}
$$

### Probability of Ruin

```{important}
**Definition: Probability of Ruin in $n$ Steps**

$$
r_i^{(n)} = P[X_n = 0 \mid X_0 = i] = p_{i,0}^{(n)}
$$

**Note:** This is the probability of being bankrupt by step $n$, not necessarily at exactly step $n$.

**Eventual Ruin:**
$$
r_i = \lim_{n \to \infty} r_i^{(n)}
$$
```

**Physical Meaning:** Once bankrupt ($X_n = 0$), the player stays bankrupt forever. So $r_i^{(n)}$ is non-decreasing in $n$.

### Computing the Probability of Ruin

```{important}
**Boundary Conditions and Recursion**

**Boundary conditions:**
$$
r_0 = 1, \quad r_k = 0
$$

**Chapman-Kolmogorov approach:**

Letting $n \to +\infty$ in the Chapman-Kolmogorov equations yields:

$$
r_i = \sum_{l=0}^{+\infty} p_{i,l}^{(1)} r_l
$$

This leads to the system:
$$
\begin{cases}
r_1 = p r_2 + q \\
r_i = q r_{i-1} + p r_{i+1} & \text{for } i = 2, \ldots, k-2 \\
r_{k-1} = q r_{k-2}
\end{cases}
$$
```

```{dropdown} Solution for Fair Game ($p = q = 1/2$)

Rewriting the general equation:
$$
(p+q)r_i = qr_{i-1} + pr_{i+1}
$$

Iterating:
$$
r_{i+1} - r_i = \frac{q}{p}(r_i - r_{i-1}) = \left(\frac{q}{p}\right)^i (r_1 - 1)
$$

For $p = q = 1/2$:
$$
r_j = 1 + j(r_1 - 1)
$$

Using the boundary condition $r_{k-1} = \frac{1}{2}r_{k-2}$ with $j = k-1$:
$$
r_1 = 1 - \frac{1}{k}
$$

Therefore:
$$
r_j = 1 - \frac{j}{k} = \frac{k-j}{k}
$$

**Physical Meaning:** For a fair game, the probability of ruin starting with $i$ dollars is simply the ratio of how far you are from the goal.
```

```{dropdown} Solution for Unfair Game ($p \neq q$)

For $p \neq q$:

$$
r_j - r_1 = (r_1 - 1) \frac{q}{p} \frac{1 - (q/p)^{j-1}}{1 - q/p}
$$

Using boundary conditions and solving:

$$
r_j = \frac{1 - (q/p)^j}{1 - (q/p)^k}
$$

when $p \neq q$.

**Physical Meaning:**
- If $p < q$ (unfavorable game), $(q/p) > 1$ and $r_j$ increases faster than linearly
- If $p > q$ (favorable game), $(q/p) < 1$ and $r_j$ is smaller than in the fair case
```

```{important}
**Summary: Probability of Ruin**

Starting with capital $i$ dollars:

**Fair game ($p = 1/2$):**
$$
r_i = \frac{k-i}{k}
$$

**Unfair game ($p \neq 1/2$):**
$$
r_i = \frac{1 - (q/p)^i}{1 - (q/p)^k}
$$
```

## Summary

In this lecture, we covered:

1. **Markov Chain Fundamentals:**
   - Markov property: future depends only on present, not past
   - Time-homogeneity: transition probabilities don't change over time
   - Transition matrices and Chapman-Kolmogorov equations

2. **Classification of States:**
   - Accessibility, communication, and irreducibility
   - Periodicity and aperiodicity
   - Ergodicity and stationary distributions

3. **Applications:**
   - Insurance claims modeling
   - Market share dynamics
   - Gambler's ruin and credit risk

4. **Key Results:**
   - Ergodic distributions solve $\boldsymbol{\pi} = \boldsymbol{\pi} P$
   - Long-run behavior of finite, irreducible, aperiodic chains
   - Explicit solutions for two-state chains and gambler's ruin

These concepts form the foundation for understanding more complex stochastic models in finance and insurance, including regime-switching models, credit migration matrices, and structural credit risk models.

---

## References

1. Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
2. Rick Durrett, "Probability: Theory and Examples", 4th ed., Cambridge University Press, Cambridge, 2010
3. Hull, J., "Options, Futures and Other Derivatives", 9th edition, 2009, Pearson/Prentice Hall
4. Charles Tapiero, "Applied Stochastic Models and Control for Finance and Insurance", 1998, Kluwer Academic Publisher
