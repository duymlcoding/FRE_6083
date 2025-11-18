---
title: "Lecture 5: The Binomial Asset Pricing Model"
author: "Agnès Tourin"
date: "August 7, 2024"
---

# The Binomial Asset Pricing Model

We dedicate this chapter to a basic introduction to the Binomial asset pricing model. We present first the one-period Binomial model before turning to the more general multi-period binomial tree model. This framework provides the foundation for derivative pricing and introduces fundamental concepts like no-arbitrage, risk-neutral pricing, and delta-hedging.

```{seealso}
**Recommended References:**
- Steven E. Shreve, "Stochastic Calculus for Finance I: The Binomial Asset Pricing Model", 2004, Springer
- Stanley R. Pliska, "Introduction to Mathematical Finance, Discrete Time Models", 1997, Blackwell Publishing
- Paul Wilmott, Sam Howison, and Jeff Dewynne, "Mathematics of Financial Derivatives: A Student Introduction", Cambridge University Press, 1995
```

```{note}
**Acknowledgment:**

We draw heavily from Shreve [1] and use similar notations. Any mistake is the sole responsibility of the author of these slides.
```

## The One-Period Binomial Model

### Model Setup

```{note}
**Time Structure:**

- Beginning of the time period: **time 0**
- End of the time period: **time 1**
```

At time 0, we have a stock whose price per share is denoted by $S_0$. We assume that $S_0$ is a given positive number.

### The Experiment

An experiment is performed: one tosses a coin once and obtains either:
- **Head** with probability $p$
- **Tail** with probability $1-p$

We assume that $p$ and $1-p$ are both positive but they are not necessarily equal (the coin is not necessarily a fair coin).

### Stock Price Evolution

```{important}
**Stock Price at Time 1:**

- If a **head** is obtained: the price is $S_1(H)$
- If a **tail** is obtained: the price is $S_1(T)$
```

The **multiplicative up and down factors** are denoted by $u$ and $d$ respectively:

$$
u = \frac{S_1(H)}{S_0}, \quad d = \frac{S_1(T)}{S_0}
$$

We assume that $d < u$.

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

**Physical Meaning:** The stock can either go up by a factor $u$ or down by a factor $d$. This simplified model captures the essential uncertainty in asset prices while remaining tractable.

### The Money Market Account

We also incorporate in this model a constant risk-free simple interest rate $r \geq 0$.

```{note}
**Practical Application:**

In practice, for applications to option pricing, one could use a 3-month or 6-month London Inter-Bank Offered Rate (LIBOR) in a specified currency.
```

The market model we consider is composed of **two assets**:
1. One **risky asset** (stock)
2. A **bank account** (money market account)

Denoting by $B_0$ the initial price of one share of the bank account, and by $B_1$ the price of one share of the bank account at the end of the time period, the relation:

$$
B_1 = (1+r)B_0
$$

describes the evolution of the bank account over the time period.

**Physical Meaning:** Money in the bank grows deterministically at rate $r$, providing a risk-free benchmark for comparing risky investments.

## No Arbitrage Condition

```{important}
**No Arbitrage Condition:**

In order to rule out arbitrage in the above model, we must have the inequalities:

$$
0 < d < 1 + r < u \tag{1}
$$
```

**Physical Meaning:** The risk-free rate must lie between the down and up factors. If this fails, you can make guaranteed profits with zero initial investment.

### What is Arbitrage?

```{warning}
**Definition: Arbitrage Strategy**

An **arbitrage strategy** is a trading strategy that allows an investor starting with zero initial wealth at time 0 to make a profit with a nonzero probability, without taking any risk.
```

### Example 1: When $u > d \geq 1+r$

```{dropdown} Arbitrage Strategy When Stock Always Beats Risk-Free Rate

**Scenario:** Suppose $u > d \geq 1+r$.

**Strategy:**
- An investor with initial wealth $X_0 = 0$ borrows $S_0$ from the money market to buy one share of stock
- Debt at time 0: $S_0$
- Debt at time 1: $S_0(1+r)$

**Payoff at Time 1:**
- Stock price is either $S_0 u$ or $S_0 d$
- In the **worst case** scenario (tail), wealth is:
  $$
  S_0 d - S_0(1+r) \geq 0
  $$
- In the **best case** (head), net worth is:
  $$
  S_0 u - S_0(1+r) > 0
  $$

**Conclusion:** The investor is guaranteed to finish with nonnegative wealth and has a positive probability of strictly positive wealth. This is an arbitrage opportunity!
```

### Example 2: When $(1+r) \geq u > d$

```{dropdown} Arbitrage Strategy When Risk-Free Rate Always Beats Stock

**Scenario:** Suppose $(1+r) \geq u > d$.

**Strategy:**
- An investor can sell the stock short (borrow and sell it)
- Invest proceeds $S_0$ in the money market

**Payoff at Time 1:**
- Money market value: $(1+r)S_0$
- Stock repurchase cost: either $S_0 d$ or $S_0 u$
- In the **worst case** (head), wealth is:
  $$
  (1+r)S_0 - S_0 u \geq 0
  $$
- In the **best case** (tail), wealth is:
  $$
  (1+r)S_0 - S_0 d > 0
  $$

**Conclusion:** Again, this exhibits an arbitrage opportunity!
```

```{important}
**Fundamental Result:**

We just proved that if we want to rule out arbitrage opportunities in the market model, we must have the inequalities (1).

**Converse:** If the inequalities (1) hold, there is no arbitrage opportunity in the market (see Shreve [1]).
```

## European Call Option

```{important}
**Definition: European Call Option**

By definition, the holder of a European call option has the **right (but not the obligation)** to buy one share of stock at time 1 for the **strike price** $K$.
```

### Interesting Case

Clearly, the only interesting case is when:

$$
S_1(T) < K < S_1(H)
$$

In this case:
- If a **head** is obtained: the holder exercises the option, profit is $S_1(H) - K$
- If a **tail** is obtained: the option expires worthless

Therefore, the value of the option at time 1 can be written as:

$$
V_1 = (S_1 - K)^+
$$

where $(x)^+ = \max(x, 0)$ denotes the positive part.

**Physical Meaning:** The call option gives you the right to profit from stock price increases above $K$ while limiting your downside to the premium paid.

## Replicating Portfolio and Delta-Hedging

### Pricing Goal

One of our primary goals is to determine the value $V_0$ of the option at time 0, **before we know the outcome** of the coin toss.

### No Arbitrage Pricing Theory

We will use the **no arbitrage pricing theory** which consists in replicating the option by trading in the stock and money markets.

```{note}
**Hedging Portfolio Setup:**

Suppose the investor:
- Begins with wealth $X_0$
- Constructs a hedging portfolio by buying $\Delta_0$ shares of stock at time 0
- Cash position at time 0: $X_0 - \Delta_0 S_0$
- Invests cash position in the money market
```

### Self-Financing Strategy

The investor's strategy must be **self-financing** in the sense that there is absolutely no cash flow in or out of the hedging portfolio. In particular:
- The investor does not earn income during the time period
- The investor does not pay taxes during the time period

Consequently, at time 1, the value of the investor's portfolio becomes:

$$
X_1 = (X_0 - \Delta_0 S_0)(1+r) + \Delta_0 S_1 = (1+r)X_0 + \Delta_0(S_1 - (1+r)S_0)
$$

**Physical Meaning:** The portfolio value at time 1 equals the growth of the initial investment plus the profit/loss from the stock position (relative to investing at the risk-free rate).

```{note}
**Cash Position:**

The cash position may be negative or positive. One can say that the investor finances the position in the stock market by lending or borrowing from the money market account.
```

### Replication Strategy

As stated earlier, the investor's approach consists in **replicating the option value**, which makes the portfolio they construct a **hedge** against their position in the European call.

Next, our aim is to calculate both $V_0$ (the option value at time 0) and $\Delta_0$ (the hedging ratio at time 0).

Starting with an initial portfolio satisfying $X_0 = V_0$, we seek $\Delta_0$ and $V_0$ such that:

$$
V_1(T) = X_1(T), \quad V_1(H) = X_1(H)
$$

### The System of Equations

This leads to the equations:

$$
V_1(T) = (1+r)X_0 + \Delta_0(S_1(T) - (1+r)S_0) \tag{2}
$$

$$
V_1(H) = (1+r)X_0 + \Delta_0(S_1(H) - (1+r)S_0) \tag{3}
$$

Or equivalently (dividing by $1+r$):

$$
\frac{1}{1+r} V_1(T) = X_0 + \Delta_0 \left(\frac{1}{1+r} S_1(T) - S_0\right) \tag{4}
$$

$$
\frac{1}{1+r} V_1(H) = X_0 + \Delta_0 \left(\frac{1}{1+r} S_1(H) - S_0\right) \tag{5}
$$

### Deriving the Risk-Neutral Probability

We multiply the first equation by an arbitrary real number $1 - \tilde{p}$ and the second equation by $\tilde{p}$, where $\tilde{p} \in (0, 1)$, and add them:

$$
X_0 + \Delta_0 \left(\frac{1}{1+r}(\tilde{p} S_1(H) + (1-\tilde{p})S_1(T)) - S_0\right) = \frac{1}{1+r}[\tilde{p} V_1(H) + (1-\tilde{p})V_1(T)]
$$

Next, we would like to choose $\tilde{p}$ so that:

$$
X_0 = \frac{1}{1+r}[\tilde{p} V_1(H) + (1-\tilde{p})V_1(T)]
$$

This particular choice leads to the simple option pricing formula:

```{important}
**Risk-Neutral Option Pricing Formula:**

$$
V_0 = \frac{1}{1+r}(\tilde{p} V_1(H) + (1-\tilde{p})V_1(T))
$$
```

Indeed, since $V_0 = X_0$, the above choice gives us a formula for the option price at time 0, in terms of the coefficient $\tilde{p}$, option payoff, and risk-free rate.

**Physical Meaning:** The option value at time 0 can be interpreted as the **discounted expected payoff**, where the expectation is computed using the probability weights $\tilde{p}$ and $1-\tilde{p}$.

$$
V_0 = \frac{1}{1+r} \tilde{E}[V_1]
$$

where $\tilde{P}$ denotes the probability defined by setting:

$$
\tilde{P}(H) = \tilde{p}, \quad \tilde{P}(T) = 1 - \tilde{p}
$$

### Finding the Risk-Neutral Probability

In order to be able to justify the above formula further, we still need to determine $\tilde{p}$.

Solving the equation:

$$
S_0 = \frac{1}{1+r}(\tilde{p} u S_0 + (1-\tilde{p}) d S_0) = \frac{S_0}{1+r}(\tilde{p}(u-d) + d)
$$

for $\tilde{p}$, we find:

```{important}
**Risk-Neutral Probabilities:**

$$
\tilde{p} = \frac{1+r-d}{u-d}, \quad 1-\tilde{p} = \frac{u-1-r}{u-d}
$$
```

Note that under the assumptions we made (no-arbitrage condition), $\tilde{p}$ belongs to the interval $(0, 1)$.

**Physical Meaning:** These are not the actual probabilities of up/down moves, but rather probabilities under which discounted stock prices are martingales (fair games). They're called "risk-neutral" because they make all assets grow at the risk-free rate on average.

### Computing the Delta-Hedge

Finally, we can compute $\Delta_0$ by subtracting equation (4) from equation (5) to derive the so-called **delta-hedging formula**:

```{important}
**Delta-Hedging Formula:**

$$
\Delta_0 = \frac{V_1(H) - V_1(T)}{S_1(H) - S_1(T)}
$$
```

**Physical Meaning:** The hedge ratio equals the change in option value divided by the change in stock price. This is the number of shares needed to replicate the option's payoff.

```{note}
**Sign of Delta:**

- In the case of a European **call**: $\Delta_0 > 0$ (long stock position)
- In the case of a European **put**: $\Delta_0 < 0$ (short stock position)
```

```{important}
**General Applicability:**

In general, this approach is valid for **any derivative security**, not just a European call. We will see later in these slides the example of a European put and a Lookback option.
```

## Short Position in a European Call

Consider an investor who **sold** one European call with payoff $V_1$.

Their initial wealth is equal to the proceeds of the sale:

$$
X_0 = V_0
$$

Then, in order to hedge their short position, they buy at time 0, $\Delta_0 > 0$ shares of stock, where $\Delta_0$ is given by the formula in the last slide.

At time 1, their portfolio will be worth:
- $V_1(H)$ if the coin toss is a head
- $V_1(T)$ if it is a tail

The investor will have hedged their short position in the derivative security.

### No Arbitrage Price

Finally, the price of the European call at time 0 should not introduce any arbitrage opportunity. The **no arbitrage price** is given by the risk-neutral pricing formula:

$$
V_0 = X_0 = \frac{1}{1+r}[\tilde{p} V_1(H) + (1-\tilde{p})V_1(T)]
$$

### Cash Position for Short Call

The cash position of an investor who is short a European call is:

$$
V_0 - \Delta_0 S_0
$$

```{note}
**Observation:**

It can be shown easily that in the case of an investor who is short a European call, the cash position at time 0 is **negative**.

In other words, the investor finances the hedging strategy by **borrowing from the bank account** at the rate $r$.
```

## Risk-Neutral Probabilities

```{important}
**Important Distinction:**

Keep in mind that $\tilde{p}, 1-\tilde{p}$ are distinct from the actual probability weights $p, 1-p$.
```

### Why "Risk-Neutral"?

They are often called **risk-neutral probabilities** because under the risk-neutral probabilities, the mean rate of growth of the stock is the same as the mean rate of growth of the money market account:

$$
u\tilde{p} + d(1-\tilde{p}) = 1 + r
$$

**Physical Meaning:** In this framework, the risk has been fully eliminated and stock prices grow at the same rate on average as a money market account. This is as if investors were indifferent to risk (risk-neutral).

### Risk-Neutral Valuation Formula

Finally, as seen earlier, you may rewrite the risk-neutral pricing formula as the expectation under the risk-neutral probability measure of the discounted payoff at the end of the period:

```{important}
**Risk-Neutral Valuation:**

$$
V_0 = \frac{1}{1+r} \tilde{E}[V_1]
$$
```

This fundamental formula is the cornerstone of derivative pricing theory.

## The Multi-Period Asset Pricing Model

### The Experiment

**Experiment:** One tosses a coin infinitely many times and the outcome of each toss $i$ is either a head ($\omega_i = H$) with probability $p$ or a tail ($\omega_i = T$) with probability $1-p$.

### Stock Price Evolution

We start with an initial stock price $S_0$ at time 0.

If one obtains a **tail** at the first toss:

$$
S_1(T) = d S_0
$$

If one obtains a **head** at the first toss:

$$
S_1(H) = u S_0
$$

We assume that $0 < d < u$.

### Two-Period Prices

Next, we iterate this procedure. After the toss number 2, the price at time 2 becomes:

$$
\begin{align}
S_2(HH) &= u S_1(H) = u^2 S_0 \\
S_2(HT) &= d S_1(H) = du S_0 \\
S_2(TH) &= u S_1(T) = du S_0 \\
S_2(TT) &= d S_1(T) = d^2 S_0
\end{align}
$$

The third toss has 8 possible outcomes and, given $S_2$, you can compute the asset price $S_3$ for each of these outcomes.

### A Binomial Tree Example

To illustrate this procedure, we show a plot of a 4-period binomial asset-pricing model for the convenient values $S_0 = 4$, $u = 2$, and $d = 1/2$.

```{note}
**Visual Representation:**

```
                                64
                            /
                        16
                        /   \
                    /       4
                8
                /   \       /   \
            /       4       1
        4
        /   \       /   \       /   \
    /       2       1       1/4
2
    \       /   \       /   \
        1       1/2     1/4
        \       /   \
            1/2     1/4
            \
                1/4
```
```

## Multi-Period Model Setup

We denote by $S_n$ the risky asset price at time $n$, for every $n$.

As in the one-period case, we introduce the risk-free interest rate $r \geq 0$.

We assume again that the following set of inequalities holds:

$$
0 < d < 1 + r < u
$$

**Physical Meaning:** This ensures no arbitrage in the multi-period model, just as in the one-period case.

## European Derivative Security

Consider now a European derivative security that expires at a time $N \geq 2$.

```{admonition} Example: European Call
:class: tip

For instance, the payoff of a European call with strike price $K$ and expiration $N = 2$ is:

$$
V_2 = (S_2 - K)^+
$$

where $S_2$ (and hence $V_2$) depends on the first two coin tosses.
```

### Pricing Goal

We want to determine the fair price of the European call at time 0, or more generally the price of any European derivative security at time 0.

We proceed in a similar fashion as for the one-period model and compute **recursively** the value of:
- The portfolio
- The derivative security
- The hedging strategy

We skip the calculations and only present the recursive equations that are needed for the computation of the option price and hedging strategy in practice.

## General Procedure: Recursive Formulas

```{important}
**Wealth Evolution:**

The wealth $X_{n+1}$ at time $n+1$ is defined recursively as:

$$
X_{n+1} = \Delta_n S_{n+1} + (1+r)(X_n - \Delta_n S_n), \quad \text{for all } n = 0, 1, \ldots, N-1
$$
```

```{important}
**Risk-Neutral Probabilities:**

$$
\tilde{p} = \frac{1+r-d}{u-d}, \quad 1-\tilde{p} = \frac{u-1-r}{u-d}
$$

(Same as in the one-period case!)
```

```{important}
**Derivative Value (Backward Induction):**

The value of the derivative security is defined recursively as:

$$
V_n(\omega_1 \ldots \omega_n) = \frac{1}{1+r}[\tilde{p} V_{n+1}(\omega_1 \ldots \omega_n H) + (1-\tilde{p})V_{n+1}(\omega_1 \ldots \omega_n T)]
$$

for all $n = 0, 1, \ldots, N-1$.
```

**Physical Meaning:** Work backwards from the known terminal payoff $V_N$, computing the value at each node as the discounted risk-neutral expected value of the next period.

```{important}
**Hedging Strategy (Delta):**

The hedging strategy is given by:

$$
\Delta_n(\omega_1 \ldots \omega_n) = \frac{V_{n+1}(\omega_1 \ldots \omega_n H) - V_{n+1}(\omega_1 \ldots \omega_n T)}{S_{n+1}(\omega_1 \ldots \omega_n H) - S_{n+1}(\omega_1 \ldots \omega_n T)}
$$

for all $n = 0, 1, \ldots, N-1$.
```

### Perfect Replication

Then we have at maturity, i.e., for $n = N$:

$$
X_N(\omega_1 \omega_2 \ldots \omega_N) = V_N(\omega_1 \omega_2 \ldots \omega_N)
$$

for all outcomes $\omega_1 \omega_2 \ldots \omega_N$.

```{important}
**Market Completeness:**

Finally, in addition to being free of arbitrage, this model is said to be **complete** because every derivative security can be replicated.
```

**Physical Meaning:** Completeness means that any payoff can be achieved by trading the stock and bond. There are no payoffs that cannot be synthesized.

## Example 1: Three-Period European Call

```{admonition} Example: Numerical Calculation
:class: tip

**Parameters:**
- $S_0 = 4$
- $u = 2$
- $d = 1/2$
- $r = 1/4$
- Strike $K = 3$
- Maturity $N = 3$

**Payoff:**
$$
V_3 = (S_3 - 3)^+
$$
```

### Risk-Neutral Probabilities

$$
\tilde{p} = \frac{1 + 1/4 - 1/2}{2 - 1/2} = \frac{3/4}{3/2} = \frac{1}{2}
$$

$$
1 - \tilde{p} = \frac{1}{2}
$$

### Payoff at Time $N = 3$

For the various outcomes:

$$
\begin{align}
V_3(HHH) &= 32 - 3 = 29 \\
V_3(HHT) &= 8 - 3 = 5 \\
V_3(HTH) &= 8 - 3 = 5 \\
V_3(HTT) &= (2 - 3)^+ = 0 \\
V_3(TTH) &= (2 - 3)^+ = 0 \\
V_3(TTT) &= (1/2 - 3)^+ = 0 \\
V_3(THH) &= 8 - 3 = 5 \\
V_3(THT) &= (2 - 3)^+ = 0
\end{align}
$$

### Backward Induction: Time 2

```{dropdown} Computing Values at Time 2

We can compute recursively backward $V_2, V_1$, and $V_0$:

$$
\begin{align}
V_2(HH) &= \frac{4}{5}\left[\frac{1}{2} V_3(HHH) + \frac{1}{2} V_3(HHT)\right] \\
&= \frac{4}{5} \left[\frac{1}{2} \cdot 29 + \frac{1}{2} \cdot 5\right] \\
&= \frac{4}{5} \cdot 17 \\
&= \frac{68}{5} = 13.6
\end{align}
$$

$$
\begin{align}
V_2(HT) &= \frac{4}{5}\left[\frac{1}{2} V_3(HTH) + \frac{1}{2} V_3(HTT)\right] \\
&= \frac{4}{5} \left[\frac{1}{2} \cdot 5 + \frac{1}{2} \cdot 0\right] \\
&= 2
\end{align}
$$

$$
\begin{align}
V_2(TH) &= \frac{4}{5}\left[\frac{1}{2} V_3(THH) + \frac{1}{2} V_3(THT)\right] \\
&= \frac{4}{5} \left[\frac{1}{2} \cdot 5 + \frac{1}{2} \cdot 0\right] \\
&= 2
\end{align}
$$

$$
\begin{align}
V_2(TT) &= \frac{4}{5}\left[\frac{1}{2} V_3(TTH) + \frac{1}{2} V_3(TTT)\right] \\
&= \frac{4}{5} \cdot 0 \\
&= 0
\end{align}
$$
```

### Backward Induction: Time 1

```{dropdown} Computing Values at Time 1

$$
\begin{align}
V_1(H) &= \frac{4}{5}\left[\frac{1}{2} V_2(HH) + \frac{1}{2} V_2(HT)\right] \\
&= \frac{4}{5} \left[\frac{1}{2} \cdot 13.6 + \frac{1}{2} \cdot 2\right] \\
&= \frac{4}{5} \cdot 7.8 \\
&= 6.24
\end{align}
$$

$$
\begin{align}
V_1(T) &= \frac{4}{5}\left[\frac{1}{2} V_2(TH) + \frac{1}{2} V_2(TT)\right] \\
&= \frac{4}{5} \left[\frac{1}{2} \cdot 2 + \frac{1}{2} \cdot 0\right] \\
&= 0.8
\end{align}
$$
```

### Initial Option Value

Finally:

$$
\begin{align}
V_0 &= \frac{4}{5}\left[\frac{1}{2} V_1(H) + \frac{1}{2} V_1(T)\right] \\
&= \frac{4}{5} \left[\frac{1}{2} \cdot 6.24 + \frac{1}{2} \cdot 0.8\right] \\
&= 2.816
\end{align}
$$

### Initial Hedge Ratio

Also, the hedge at time 0 is:

$$
\Delta_0 = \frac{V_1(H) - V_1(T)}{S_1(H) - S_1(T)} = \frac{6.24 - 0.8}{8 - 2} = \frac{5.44}{6} \approx 0.907
$$

### Cash Position

We can also compute the cash position at time 0 of an investor who is short the European call:

$$
V_0 - \Delta_0 S_0 = 2.816 - 0.907 \times 4 = -0.812 < 0
$$

So, the investor **borrows from the bank account** to finance their hedging strategy.

## Implementation Considerations

```{warning}
**Computational Complexity:**

If you implement this algorithm in a naive manner, its complexity is **exponential**, i.e., the number of computations grows exponentially with the number of periods considered.

For example, for $n = 100$ periods, there are $2^{100} \approx 10^{30}$ possible outcomes.
```

```{important}
**Efficiency Improvement:**

The code can be made more efficient by **grouping nodes that lead to the same option value**.

For instance, in our previous application, there are 8 possible outcomes for $V_3$ but only 4 different values: $\{0, 5, 8, 29\}$ (note: the value 8 doesn't actually appear in the payoffs, should be values like $0, 2, 5, 29$).

By recognizing that many paths lead to the same stock price (and hence same option value), we can reduce computations significantly.
```

**Physical Meaning:** The binomial tree "recombines" - an up move followed by a down move gives the same price as a down move followed by an up move. This structure allows for efficient computation.

## Lookback Option Pricing in a 3-Period Model

```{admonition} Example: Path-Dependent Derivative
:class: tip

**Setup:** Compute the value of a lookback option with payoff:

$$
V_3 = \max_{0 \leq n \leq 3} S_n - S_3
$$

**Parameters:** Take $S_0 = 4$, $u = 2$, $d = 1/2$, and $r = 1/4$ as before.
```

### Result

It turns out that:
- Option value at time 0: $V_0 = 1.376$
- Corresponding hedge at time 0: $\Delta_0 = 0.1733$

### Path-Dependent Payoff Calculation

The only significant difference with the previous example lies in the calculation of the payoff $V_3$ at time 3. Indeed, you need to notice that the payoff is **path dependent** and make sure you compute it correctly in every possible scenario.

```{dropdown} Scenario-by-Scenario Calculation

**Scenario 1:** $\omega = HHH$
- Path: $4 \to 8 \to 16 \to 32$
- Maximum: $32$
- $V_3(HHH) = 32 - 32 = 0$

**Scenario 2:** $\omega = HHT$
- Path: $4 \to 8 \to 16 \to 8$
- Maximum: $16$
- $V_3(HHT) = 16 - 8 = 8$

**Scenario 3:** $\omega = HTH$
- Path: $4 \to 8 \to 4 \to 8$
- Maximum: $8$
- $V_3(HTH) = 8 - 8 = 0$

**Scenario 4:** $\omega = HTT$
- Path: $4 \to 8 \to 4 \to 2$
- Maximum: $8$
- $V_3(HTT) = 8 - 2 = 6$

**Scenario 5:** $\omega = THH$
- Path: $4 \to 2 \to 4 \to 8$
- Maximum: $8$
- $V_3(THH) = 8 - 8 = 0$

**Scenario 6:** $\omega = THT$
- Path: $4 \to 2 \to 4 \to 2$
- Maximum: $4$
- $V_3(THT) = 4 - 2 = 2$

**Scenario 7:** $\omega = TTH$
- Path: $4 \to 2 \to 1 \to 2$
- Maximum: $4$
- $V_3(TTH) = 4 - 2 = 2$

**Scenario 8:** $\omega = TTT$
- Path: $4 \to 2 \to 1 \to 0.5$
- Maximum: $4$
- $V_3(TTT) = 4 - 0.5 = 3.5$
```

**Physical Meaning:** The lookback option pays the difference between the maximum price reached and the final price. It's valuable because it gives you the "perfect timing" payoff - as if you sold at the peak.

## Summary

In this lecture, we covered:

1. **One-Period Binomial Model:**
   - Stock and money market account
   - No-arbitrage condition
   - Risk-neutral probabilities
   - Delta-hedging

2. **Derivative Pricing:**
   - Replication strategy
   - Risk-neutral valuation formula
   - Self-financing portfolios

3. **Multi-Period Model:**
   - Recursive pricing formulas
   - Backward induction algorithm
   - Market completeness

4. **Applications:**
   - European call option pricing
   - Lookback options (path-dependent)
   - Implementation considerations

5. **Key Concepts:**
   - No arbitrage
   - Risk-neutral measure
   - Complete markets
   - Delta-hedging

These concepts form the discrete-time foundation for derivative pricing theory and will generalize to continuous-time models (Black-Scholes) through limiting arguments.

---

## References

1. Steven E. Shreve, "Stochastic Calculus for Finance I: The Binomial Asset Pricing Model", 2004, Springer
2. Stanley R. Pliska, "Introduction to Mathematical Finance, Discrete Time Models", 1997, Blackwell Publishing
3. Paul Wilmott, Sam Howison, and Jeff Dewynne, "Mathematics of Financial Derivatives: A Student Introduction", Cambridge University Press, 1995
