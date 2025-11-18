---
title: "Lecture 4: The Poisson Process"
author: "Agnès Tourin"
date: "August 7, 2024"
---

# The Poisson Process

This chapter presents an example of a Markov process in continuous-time: the Poisson process. The Poisson process is fundamental in modeling rare events in finance and insurance, such as insurance claims, defaults, and extreme market events.

```{seealso}
**Recommended References:**
- Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
- Rick Durrett, "Probability: Theory and Examples", 4th ed., Cambridge University Press, Cambridge, 2010
```

## Introduction

The Poisson process is a continuous-time Markov process that serves as a cornerstone model for counting random events that occur over time. Unlike discrete-time Markov chains, the Poisson process evolves continuously.

```{note}
**Key Applications:**
- Insurance: Number of claims filed by time $t$
- Credit risk: Number of defaults in a portfolio
- Market microstructure: Number of trades in a time interval
- Operations: Number of customer arrivals
```

## Counting Processes

Since the Poisson process is a counting process, we first recall the definition of a counting process.

```{important}
**Definition: Counting Process**

A stochastic process $\{N(t); t \geq 0\}$ is said to be a **counting process** if $N(t)$ represents the total number of events that occur by time $t$.
```

**Physical Meaning:** $N(t)$ counts how many events (insurance claims, defaults, arrivals) have occurred from time 0 up to time $t$.

### Properties of Counting Processes

A counting process enjoys a number of properties:

```{note}
**Properties of Counting Processes:**

1. **Non-negativity:** $N(t) \geq 0$ for all $t \geq 0$

2. **Integer-valued:** $N(t)$ takes integer values

3. **Non-decreasing:** If $s < t$, then $N(s) \leq N(t)$ (i.e., $N$ is non-decreasing in time)

4. **Increments:** For $s < t$, $N(t) - N(s)$ equals the number of events that occur in the interval $(s, t]$
```

## Definition of the Poisson Process

```{important}
**Definition: Poisson Process**

A counting process $N$ is said to be a **Poisson process with rate** $\lambda > 0$ if:

1. **Initial condition:** $N(0) = 0$

2. **Independent increments:** The process has independent increments

3. **Poisson distributed increments:** The increment $N(t+s) - N(s)$ is Poisson distributed with mean $\lambda t$, i.e.,
   $$
   P[N(t+s) - N(s) = n] = e^{-\lambda t} \frac{(\lambda t)^n}{n!}, \quad \text{for all } n = 0, 1, 2, \ldots
   $$
```

**Physical Meaning:** The Poisson process is completely characterized by a single parameter $\lambda$ (the rate). Events occur randomly over time, with the number of events in any interval depending only on the length of that interval, not on when it starts.

### Key Properties

```{note}
**Immediate Consequences:**

1. **Stationary increments:** $N$ has stationary increments (the distribution of $N(t+s) - N(s)$ depends only on $t$, not on $s$)

2. **Expected number of events:**
   $$
   E[N(t)] = E[N(t) - N(0)] = \lambda t
   $$

3. **Variance:**
   $$
   \text{var}[N(t)] = \text{var}[N(t) - N(0)] = \lambda t
   $$
```

**Physical Meaning:** The parameter $\lambda$ can be seen as the **average rate of jumps per unit of time**. In other words, the average number of jumps in the interval $[0, t]$ is equal to $\lambda t$.

## Inter-Arrival and Waiting Time Distribution

We denote by $T_1$ the time of the first event (jump), by $T_2$ the waiting time between the first and second event, and generally, by $T_n$ the time between the $(n-1)$th and the $n$th event.

```{important}
**Definition: Inter-Arrival Times**

The sequence $T_1, T_2, \ldots, T_n$ is called the sequence of **inter-arrival times**.
```

```{important}
**Distribution of Inter-Arrival Times**

It is easy to show (see Ross [1]) that $T_1, T_2, \ldots, T_n$ are i.i.d. exponential random variables with mean $\frac{1}{\lambda}$:

$$
f_{T_i}(t) = \lambda e^{-\lambda t}, \quad t \geq 0
$$
```

**Physical Meaning:** The time between successive events follows an exponential distribution. This is a memoryless distribution: the probability of the next event in the next $\Delta t$ time units doesn't depend on how long you've already waited.

## Memorylessness Property

```{important}
**Memorylessness Property**

The Poisson process possesses the **Markov property**. Consequently, the inter-arrival times satisfy the **memorylessness property**:

$$
P[T_i > T + t \mid T_i > t] = P[T_i > T]
$$
```

**Physical Meaning:** If you've already waited $t$ time units for the next event, the probability of waiting an additional $T$ time units is the same as if you'd just started waiting. The process has "no memory" of how long you've been waiting.

```{note}
**Unique Property:**

The exponential distribution is actually the **only continuous distribution** that satisfies the memorylessness property.

**Implication:** For all Markov chains in continuous time, the time spent in a given state is always exponentially distributed. This is an important restriction to keep in mind when choosing a model.
```

## The Arrival Times

Next, we can define the sequence of arrival times $S_1, S_2, \ldots, S_n$ where $S_n$ denotes the arrival time of the $n$th jump by setting:

$$
S_n = \sum_{i=1}^{n} T_i, \quad n \geq 1
$$

```{important}
**Distribution of Arrival Times**

It turns out that $S_n$ has a **gamma distribution** with parameters $n$ and $\lambda$ (we refer to Ross [1] for the proof, the key point being that $\{S_n > t\} = \{N(t) \leq n-1\}$):

$$
f_{S_n}(t) = e^{-\lambda t} \frac{(\lambda t)^{n-1}}{(n-1)!}, \quad t \geq 0
$$
```

**Physical Meaning:** The time until the $n$th event follows a gamma distribution, which is the sum of $n$ independent exponential random variables.

### Constructive Definition

We can finally redefine the Poisson process in a way that's more constructive than the earlier definition, by using the arrival times:

$$
N(t) = \begin{cases}
0 & \text{for } 0 \leq t < S_1 \\
1 & \text{for } S_1 \leq t < S_2 \\
2 & \text{for } S_2 \leq t < S_3 \\
\vdots
\end{cases}
$$

**Physical Meaning:** The counting process stays at each level until the next jump occurs. This provides a way to construct sample paths of the Poisson process.

## A Simple Example

```{admonition} Example: Insurance Claims
:class: tip

**Setup:** Let $N(t)$ be the number of insurance claims filed in the interval $[0, t]$ where $t$ is in weeks. We assume that $N$ is a Poisson process with rate $\lambda = 1$ per week.
```

```{dropdown} Question 1: Probability of at least 1 claim in a given week

**Question:** Compute the probability that at least 1 claim will be made during a given week.

**Solution:**

$$
\begin{align}
P[N(t+1) - N(t) \geq 1] &= 1 - P[N(1) - N(0) = 0] \\
&= 1 - e^{-1} \frac{1^0}{0!} \\
&= 1 - e^{-1} \\
&\approx 0.632
\end{align}
$$
```

```{dropdown} Question 2: Probability of no claims in 2 consecutive weeks

**Question:** Calculate the probability that no insurance claim is made during 2 given consecutive weeks.

**Solution:**

$$
\begin{align}
P[N(t+2) - N(t) = 0] &= P[N(2) - N(0) = 0] \\
&= e^{-2} \frac{2^0}{0!} \\
&= e^{-2} \\
&\approx 0.135
\end{align}
$$
```

```{dropdown} Question 3: Conditional probability

**Question:** Compute the probability that exactly 2 claims will be made during a given week, knowing that there were exactly 2 claims in the previous week.

**Solution:**

By the **independent increments** property:

$$
\begin{align}
P[N(t+1) - N(t) = 2 \mid N(t) - N(t-1) = 2] &= P[N(1) - N(0) = 2] \\
&= e^{-1} \frac{1^2}{2!} \\
&= \frac{e^{-1}}{2} \\
&\approx 0.184
\end{align}
$$

**Key Insight:** The knowledge of past claims does not affect future probabilities due to independent increments.
```

```{dropdown} Question 4: Expected waiting time between claims

**Question:** Compute the expected waiting time between two consecutive claims.

**Solution:**

Since all the inter-arrival times are i.i.d. and exponentially distributed with parameter $\lambda = 1$:

$$
\begin{align}
E[T_i] &= \int_0^{+\infty} t \lambda e^{-\lambda t} \, dt \\
&= \left[-t e^{-\lambda t}\right]_0^{+\infty} + \int_0^{+\infty} e^{-\lambda t} \, dt \\
&= 0 + \frac{1}{\lambda} \\
&= 1 \text{ week}
\end{align}
$$
```

## An Aggregate Loss Model in Insurance

We revisit the insurance model that was introduced in Chapter 1 to make it more realistic.

```{note}
**Model Setup:**

- Number of insurance claims at time $t$: modeled by a Poisson process $N(t)$ with parameter $\lambda > 0$
- Loss $X_n$ associated with the $n$th claim: random variable
- Arrival time of the $n$th claim: $S_n$
- Discount factor: $r$
```

### Total Discounted Accumulated Loss

The total discounted accumulated loss at time $t$ is given by:

$$
L(t) = \sum_{n=1}^{N(t)} e^{-rS_n} X_n
$$

where:
- The variables $X_n$ are independent and identically distributed
- $S_n$ is the arrival time of the $n$th claim
- $r$ is a discount factor

**Physical Meaning:** We sum up all losses that occurred by time $t$, discounting each loss back to time 0 based on when it occurred.

### Model Assumptions

To simplify, we assume that:

1. The claim amounts $X_n$ are independent of $N(t)$ for all $t$ and all $n$
2. The claim amounts are independent of the claim arrival times $S_n$ for every $n$

```{important}
**Key Fact: Conditional Distribution of Arrival Times**

Conditionally on $N(t) = n$, the variables $S_1, S_2, \ldots, S_n$ are distributed as the ordered values of $n$ independent uniform random variables in $(0, t)$ (see Ross [1], p. 334-335).
```

**Physical Meaning:** If we know exactly $n$ events occurred in $[0, t]$, their arrival times are distributed like $n$ random points uniformly scattered in that interval, then sorted in order.

### Computation of the Expected Loss

In other words, $S_1, S_2, \ldots, S_n$ can be interpreted as a random permutation of the uniformly distributed over the interval $(0, t)$ random variables $t_1, t_2, \ldots, t_n$, so that:

$$
\sum_{n=1}^{N(t)} e^{-rS_n} = \sum_{n=1}^{N(t)} e^{-rt_n}
$$

```{dropdown} Derivation of Expected Loss

Let $\mu$ denote the common mean of the variables $X_i$.

$$
\begin{align}
E[L(t)] &= \sum_{k=0}^{\infty} E[L(t) \mid N(t) = k] P[N(t) = k] \\
&= \sum_{k=0}^{\infty} E[L(t) \mid N(t) = k] \exp(-\lambda t) \frac{(\lambda t)^k}{k!} \\
&= \sum_{k=0}^{\infty} E\left[\sum_{i=1}^{N(t)} e^{-rS_i} X_i \mid N(t) = k\right] \exp(-\lambda t) \frac{(\lambda t)^k}{k!} \\
&= \sum_{k=0}^{\infty} E\left[\sum_{i=1}^{k} e^{-rS_i} X_i\right] \exp(-\lambda t) \frac{(\lambda t)^k}{k!} \\
&= \sum_{k=0}^{\infty} \sum_{i=1}^{k} E[e^{-rS_i} X_i] \exp(-\lambda t) \frac{(\lambda t)^k}{k!} \\
&= \sum_{k=0}^{\infty} \sum_{i=1}^{k} E[e^{-rS_i}] E[X_i] \exp(-\lambda t) \frac{(\lambda t)^k}{k!} \\
&= \sum_{k=0}^{\infty} \sum_{i=1}^{k} E[e^{-rt_i}] \mu \exp(-\lambda t) \frac{(\lambda t)^k}{k!}
\end{align}
$$

Since $t_i$ is uniformly distributed on $(0, t)$:

$$
E[e^{-rt_i}] = \int_0^t e^{-rx} \frac{1}{t} \, dx = \frac{1}{rt}(1 - e^{-rt})
$$

Therefore:

$$
\begin{align}
E[L(t)] &= \sum_{k=0}^{\infty} k \frac{(1 - e^{-rt})}{rt} \mu e^{-\lambda t} \frac{(\lambda t)^k}{k!} \\
&= \frac{\mu(1 - e^{-rt})}{rt} \sum_{k=0}^{\infty} k e^{-\lambda t} \frac{(\lambda t)^k}{k!} \\
&= \frac{\mu(1 - e^{-rt})}{rt} E[N(t)] \\
&= \frac{\mu(1 - e^{-rt})}{rt} \lambda t \\
&= \frac{\mu \lambda (1 - e^{-rt})}{r}
\end{align}
$$

because the mean of a Poisson distribution with parameter $\lambda t$ is $E[N(t)] = \lambda t$.
```

```{important}
**Expected Discounted Loss:**

$$
E[L(t)] = \frac{\mu \lambda (1 - e^{-rt})}{r}
$$

where:
- $\mu$ = expected claim amount
- $\lambda$ = arrival rate of claims
- $r$ = discount rate
- $t$ = time horizon
```

**Physical Meaning:** The expected total discounted loss increases with time, the claim rate, and the average claim size, but is reduced by discounting (higher $r$ means future losses are worth less today).

## An Arithmetic Random Walk Driven by a Poisson Process

We consider a Poisson process $N$ with rate $\lambda > 0$. We define the **Poisson random walk**:

$$
Y_{t+1} = Y_t + \delta \epsilon_{t+1}
$$

where:

$$
\epsilon_{t+1} = N(t+1) - N(t)
$$

and $\delta$ is a positive constant.

```{note}
**Properties:**

By the definition of the Poisson process, the variables $\epsilon_{t+1}$ are:
- i.i.d.
- Have a Poisson distribution with mean $\lambda$ and variance $\lambda$
```

### Explicit Form

Overall, given the initial condition $Y_0$, we have:

$$
Y_{t+1} = Y_0 + \delta \sum_{i=1}^{t+1} \epsilon_i
$$

which can also simply be rewritten as:

$$
Y_{t+1} = Y_0 + \delta(N(t+1) - N(0))
$$

since the sum of residuals is a telescopic series.

**Physical Meaning:** This models a process that jumps by amount $\delta$ each time the Poisson process has an event. Unlike the continuous-time Poisson process, this is evaluated at discrete time points.

## Simulation Techniques

```{important}
**One Simulation Technique:**

**Step 1:** Simulate the jump inter-arrival times explicitly, by drawing independent samples from the exponential distribution with mean $1/\lambda$.

**Step 2:** Compute the corresponding jump times, and at each jump time, add 1 to the Poisson process (see Ross [1]).

**Note:** There are several other methods for simulating Poisson processes.
```

## Practice Problems

### Problem 1

```{admonition} Problem 1: Conditional Variance
:class: tip

Consider a continuous nonnegative random variable $T$ with mean $\mu$ and variance $\sigma^2$, and a Poisson process with rate $\lambda > 0$.

1. Compute $\text{var}(N(T))$.
2. Compute $\text{cov}(\lambda T, N(T))$.

**Hint:** Use the law of total variance and the tower property of conditional expectation.
```

### Problem 2

```{admonition} Problem 2: Asset Price Process (from Ross [1])
:class: tip

Consider the sequence $Y_1, Y_2, \ldots$ of independent random variables with common mean $\mu$, common variance $\sigma^2$, and a Poisson process with rate $\lambda > 0$.

We also assume that all the $Y_i$ random variables are independent of $N(t)$ for all $t$. We define the asset price process:

$$
X(t) = x_0 \prod_{i=1}^{N(t)} Y_i
$$

where $x_0$ is a deterministic initial condition.

1. Compute $E[X(t)]$.
2. Compute $\text{var}[X(t)]$.
3. Is $X(t)$ a martingale with respect to the information generated by observing it?
4. Is there a value of $\mu$ that makes $X$ a martingale?
```

### Problem 3

```{admonition} Problem 3: Covariance with Sum
:class: tip

We consider a Poisson process with rate $\lambda > 0$ and we recall that $E[N(t)] = \text{var}(N(t)) = \lambda t$.

We also consider a sequence $X_1, X_2, X_3, \ldots$ of i.i.d. random variables with common mean $\mu$ and common variance $\sigma^2$, that are also independent of $N(t)$.

1. Compute:
   $$
   \text{cov}\left(N(t), \sum_{i=1}^{N(t)} X_i\right)
   $$
```

### Problem 4

```{admonition} Problem 4: Sum of Poisson Processes
:class: tip

Consider three independent Poisson processes $M_1(t), M_2(t), M_3(t)$ with respective rates $\lambda_1, \lambda_2, \lambda_3 > 0$.

We also define:

$$
N_1(t) = M_1(t) + M_2(t), \quad N_2(t) = M_2(t) + M_3(t)
$$

1. Write the joint probability mass $P[N_1(t) = n, N_2(t) = m]$ as a sum. **Note:** Do not attempt to compute the sum.

2. Compute $\text{cov}(N_1(t), N_2(t))$.
```

### Problem 5

```{admonition} Problem 5: Conditional Poisson Process
:class: tip

We consider the following **conditional Poisson process**.

First of all, let $\Lambda$ be a continuous random variable and let $f$ be its density function, defined on $(0, +\infty)$.

Next, let $N$ be a counting process.

Finally, conditional on $\Lambda = \lambda > 0$, $N$ is a Poisson process with rate $\lambda$.

1. Write the probability mass $P[N(t+s) - N(s) = n]$ as an integral over the interval $(0, +\infty)$.

2. Does $N$ have stationary increments? Justify your answer by using the formula derived in the first question.

3. Does $N$ have independent increments? Justify your answer in plain English.
```

## Summary

In this lecture, we covered:

1. **Counting Processes:**
   - Definition and properties
   - Non-decreasing, integer-valued processes

2. **Poisson Process:**
   - Definition via independent and stationary increments
   - Rate parameter $\lambda$ and its interpretation
   - Exponential inter-arrival times
   - Gamma-distributed arrival times

3. **Key Properties:**
   - Memorylessness of exponential distribution
   - Connection to Markov property
   - Independent and stationary increments

4. **Applications:**
   - Insurance claims modeling
   - Aggregate loss with discounting
   - Poisson-driven random walks

5. **Simulation:**
   - Methods for generating Poisson process sample paths

These concepts form the foundation for continuous-time stochastic modeling in finance and insurance, providing the building blocks for jump-diffusion models, credit event modeling, and operational risk quantification.

---

## References

1. Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
2. Rick Durrett, "Probability: Theory and Examples", 4th ed., Cambridge University Press, Cambridge, 2010
