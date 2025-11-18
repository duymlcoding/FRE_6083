---
title: "Lecture 11: The Black-Scholes Lognormal Model via Formal Integration"
author: "Agnès Tourin"
date: "November 25, 2024"
---

# The Black-Scholes Lognormal Model via Formal Integration

This lecture presents a summary of the Black-Scholes-Merton no-arbitrage theory in continuous time. We begin with the dynamic asset price model before explaining the pricing of derivative securities using both the martingale approach and the PDE approach.

```{seealso}
**Recommended References:**
- Paul Wilmott, Sam Howison, and Jeff Dewynne, "Mathematics of Financial Derivatives: A Student Introduction", Cambridge University Press, 1995 (elementary)
- Steven E. Shreve, "Stochastic Calculus for Finance II: Continuous-time finance", 2004, Springer (advanced)
- Steven E. Shreve, "Stochastic Calculus for Finance I: The Binomial Asset Pricing Model", 2004, Springer
- Stanley R. Pliska, "Introduction to Mathematical Finance, Discrete Time Models", 1997, Blackwell Publishing
```

## Introduction

We present a summary of the Black-Scholes-Merton no-arbitrage theory in continuous time.

**Structure:**
1. Dynamic asset price model (this section)
2. Pricing of derivative securities (following sections)

```{note}
**Reference Level:**

Reference [4] (Wilmott et al.) is elementary, whereas Reference [2] (Shreve) is more advanced.
```

## The Geometric Brownian Motion Asset Price Model

### The Stock Price Dynamics

We consider an asset price $S(t)$ at time $t$ which follows the **geometric Brownian motion** model.

```{important}
**Stock Price SDE (Under Physical Measure $P$):**

$$
dS(t) = \mu S(t)dt + \sigma S(t)dW(t), \quad S(0) = S_0
$$

where:
- $W(t)$ is a **standard Brownian motion** under the probability measure $P$
- $\mu, \sigma$ are constants with $\sigma > 0$
- $P$ is the **true probability measure** (physical measure)
```

**Physical Meaning:** The stock price evolves with a deterministic drift $\mu$ (expected return) and random fluctuations governed by volatility $\sigma$.

### The Drift Term

Because of the presence of the drift coefficient $\mu$, the stock price tends to go up or down and **is not a martingale** under $P$.

### Risk-Free Asset

We also assume there exists a **risk-free rate** $r > 0$, which could be taken to be the interest rate paid by a money market account.

## Change of Measure

The key to option pricing is changing from the physical measure to a risk-neutral measure.

### The Risk-Neutral Measure

```{important}
**Risk-Neutral Probability Measure $\tilde{P}$:**

We can change the probability measure from $P$ to an equivalent probability measure $\tilde{P}$, under which the **discounted stock price** $e^{-rt}S(t)$ is a martingale:

$$
d(e^{-rt}S(t)) = \sigma(e^{-rt}S(t))d\tilde{W}(t)
$$

where $\tilde{W}(t)$ is a Brownian motion under the **risk-neutral probability measure** $\tilde{P}$.
```

**Physical Meaning:** Under the risk-neutral measure, there is no $dt$ term (no drift) in the equation for the discounted stock price. This makes it a martingale.

### Integral Form

Another way to see this is by rewriting in integral form:

$$
e^{-rt}S(t) - S(0) = \int_0^t e^{-ru}S(u)\sigma d\tilde{W}(u)
$$

The Ito integral on the right-hand side is a **martingale**.

### Existence and Absence of Arbitrage

```{note}
**Fundamental Theorem:**

The existence of such a risk-neutral probability measure is due to the **absence of arbitrage** in the Black-Scholes-Merton model.

The idea is exactly the same as for the binomial tree model seen earlier.
```

### Constructing the Risk-Neutral Measure

We "hide" the drift coefficient into the Brownian term:

$$
dS(t) = rS(t)dt + \sigma S(t)\left[\frac{\mu - r}{\sigma}dt + dW(t)\right]
$$

The ratio $\frac{\mu - r}{\sigma}$ represents the **market price of risk**.

```{important}
**Change of Measure Formula:**

It is possible to define a risk-neutral probability measure $\tilde{P}$ under which the process:

$$
\tilde{W}(t) = \frac{\mu - r}{\sigma}t + W(t)
$$

is a standard Brownian motion.

**Interpretation:** The change of measure "removes the mean" from the Brownian motion.
```

### Stock Price Under Risk-Neutral Measure

```{important}
**SDE Under Risk-Neutral Measure:**

$$
dS(t) = rS(t)dt + \sigma S(t)d\tilde{W}(t), \quad S(0) = S_0
$$

**Interpretation:** Under the risk-neutral probability measure $\tilde{P}$, the stock's instantaneous rate of return per unit time equals the risk-free rate $r$.
```

**Physical Meaning:** In the risk-neutral world, all assets earn the risk-free rate on average. This doesn't mean stocks actually earn $r$, but it's a mathematical convenience for pricing derivatives.

## The Black-Scholes Analytical Formula

### Goal

In this section, we compute the price of a **European call option** using the Black-Scholes-Merton no-arbitrage theory.

```{note}
**Approach:**

We present an outline of the theory and refer to the references for further details.
```

### Risk-Neutral Pricing Formula

Our first goal is to derive the **risk-neutral pricing formula**, which characterizes the fair price $V(t)$ of a European derivative security at time $t$.

**Purpose:** The risk-neutral pricing formula allows us to derive an analytical formula for the option price.

### The Discounted Stock Price is a Martingale

Recall that the discounted stock price is a martingale under $\tilde{P}$.

## Hedging Strategy

Consider an agent who is **short a call** and needs to hedge this short position.

```{note}
**Notation:**

- $X(t)$ = value of the hedging portfolio at time $t$
- $X(0) = V(0)$ = initial capital
- $X(T) = V(T)$ = terminal value must match the option payoff
- $\Delta(t)$ = number of shares of stock held at time $t$
```

### Assets Available

The agent can invest in:
1. A **money market account** which pays constant interest rate $r > 0$ (the risk-free rate)
2. The **underlying asset** (stock)

### Replication Condition

```{important}
**Perfect Replication:**

For perfect hedging (no arbitrage), the portfolio must replicate the option at every intermediate time:

$$
X(t) = V(t), \quad \text{for all } t \in [0, T]
$$

Any deviation would introduce an **arbitrage opportunity**.
```

**Physical Meaning:** At every moment, the capital needed to hedge the short position equals the option value. Otherwise, there would be a riskless profit opportunity.

### The Discounted Portfolio is a Martingale

It turns out that the **discounted portfolio** is also a martingale under the risk-neutral probability measure (this can be shown using stochastic calculus).

```{important}
**Martingale Property:**

$$
\begin{align}
e^{-rt}X(t) &= \tilde{E}[e^{-rT}X(T) \mid \{\tilde{W}(s); 0 \leq s \leq t\}] \\
&= \tilde{E}[e^{-rT}V(T) \mid \{\tilde{W}(s); 0 \leq s \leq t\}]
\end{align}
$$

where $\tilde{E}$ denotes expectation under $\tilde{P}$.
```

### Risk-Neutral Pricing Formula

Since $V(t) = X(t)$:

$$
e^{-rt}V(t) = \tilde{E}[e^{-rT}V(T) \mid \{\tilde{W}(s); 0 \leq s \leq t\}]
$$

Dividing both sides by $e^{-rt}$:

```{important}
**Risk-Neutral Pricing Formula:**

$$
V(t) = \tilde{E}[e^{-r(T-t)}V(T) \mid \{\tilde{W}(s); 0 \leq s \leq t\}], \quad t \in [0, T]
$$
```

**Physical Meaning:** The option value at time $t$ equals the expected discounted payoff under the risk-neutral measure, conditional on information up to time $t$.

### Using the Markov Property

Since the Brownian motion has **independent increments** and is the only source of uncertainty, and the drift and diffusion coefficients only depend on the current asset price, the asset price is a **Markovian process**.

```{important}
**Simplified Pricing Formula (Markov Property):**

$$
\begin{align}
V(t) &= \tilde{E}[e^{-r(T-t)}V(T) \mid \{S(s); 0 \leq s \leq t\}] \\
&= \tilde{E}[e^{-r(T-t)}V(T) \mid S(t)]
\end{align}
$$
```

**Physical Meaning:** Essentially, as in the binomial tree model, $V(t)$ equals the **discounted expected payoff** under the risk-neutral probability measure, given the asset price at time $t$.

## European Call Option

For a European call option, the payoff is:

$$
V(T) = (S(T) - K)^+
$$

where $K$ is the strike price.

```{important}
**Call Option Pricing Formula:**

$$
V(t) = \tilde{E}[e^{-r(T-t)}(S(T) - K)^+ \mid S(t)]
$$
```

It is fairly easy to derive a **closed-form formula** for the price of a European call from this risk-neutral pricing formula.

### Range of Applicability

```{note}
**When Does This Work?**

The risk-neutral pricing formula works as long as the payoff can be written as a function of the maturity date $T$.

**Examples:**
- **European options:** Straightforward application
- **Exotic options:** Some specific exotic options (e.g., barrier options, lookback options) can be priced using slightly more complex techniques
- **Path-dependent options:** When the payoff depends on the entire path (e.g., Asian options), this approach may not yield closed-form solutions
```

### The Martingale Approach

```{important}
**Advantages of the Martingale Approach:**

- Can be virtually generalized to **any derivative security**
- Helps solve many other financial applications
- Provides deep theoretical insights

**Limitation:**

This approach does not help determine the **hedging ratio** $\Delta(t)$.
```

### Alternative: No Stochastic Calculus Approach

```{note}
**Simple Case:**

In the simple case of a European derivative, it is possible to reach the same conclusions **without using stochastic calculus**, by relying on:
- Absence of arbitrage
- Law of one price
- Linearity of portfolios
- Rationality of agents
```

## Derivation of the Price of a European Option

### The Pricing Function

Since the price of the call $V(t)$ at time $t$ depends only on:
- The time $t$
- The price of the stock at time $t$ (not the stock price prior to $t$)

by the **Markov property**, there exists a function $v(t, s)$ such that:

$$
V(t) = v(t, S(t))
$$

```{important}
**Pricing Function:**

$$
v(t, s) = \tilde{E}[e^{-r(T-t)}V(T) \mid S(t) = s]
$$
```

### Goal

In this section, we use the risk-neutral pricing formula to derive an **analytical formula** for the price of a European call with payoff:

$$
V(T) = (S(T) - K)^+
$$

### When is This Possible?

The same approach can be used to compute the price of some other options, such as **binary options**.

```{warning}
**Limitation:**

Even when the risk-neutral pricing formula holds, it is **not always possible** to derive the price in closed form.

**Example:** The risk-neutral pricing formula is applicable to Asian options, but there is **no exact analytical formula** available for the price of an Asian option.
```

## Computing the Call Option Price

### Stock Price Under Risk-Neutral Measure

Recall that under the risk-neutral measure:

$$
S(t) = S(0)\exp\left\{\tilde{W}(t) + \left(r - \frac{1}{2}\sigma^2\right)t\right\}
$$

Similarly:

$$
S(T) = S(0)\exp\left\{\tilde{W}(T) + \left(r - \frac{1}{2}\sigma^2\right)T\right\}
$$

### Relating $S(T)$ to $S(t)$

Taking the ratio:

$$
S(T) = S(t)\exp\left\{(\tilde{W}(T) - \tilde{W}(t)) + \left(r - \frac{1}{2}\sigma^2\right)(T-t)\right\}
$$

Define the standard normal random variable:

$$
Y = \frac{\tilde{W}(T) - \tilde{W}(t)}{\sigma\sqrt{T-t}}
$$

Then:

$$
S(T) = S(t)\exp\left\{\sigma\sqrt{T-t} \, Y + \left(r - \frac{1}{2}\sigma^2\right)(T-t)\right\}
$$

### Setting Up the Expectation

Let $s = S(t)$ denote the current stock price.

```{dropdown} Detailed Calculation

$$
\begin{align}
v(t, s) &= \tilde{E}\left[\exp(-r(T-t))\left(s\exp\left\{\sigma\sqrt{T-t}Y + \left(r - \frac{1}{2}\sigma^2\right)(T-t)\right\} - K\right)^+\right] \\
&= \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{+\infty} \exp(-r(T-t))\left(s\exp\left\{\sigma\sqrt{T-t}y + \left(r - \frac{1}{2}\sigma^2\right)(T-t)\right\} - K\right)^+ \exp\left(-\frac{1}{2}y^2\right)dy
\end{align}
$$

The expression inside the expectation is positive if and only if:

$$
s\exp\left\{\sigma\sqrt{T-t}y + \left(r - \frac{1}{2}\sigma^2\right)(T-t)\right\} > K
$$

which is equivalent to:

$$
y < \frac{1}{\sigma\sqrt{T-t}}\left[\log\frac{s}{K} + \left(r + \frac{\sigma^2}{2}\right)(T-t)\right]
$$
```

### Defining $d_{\pm}$

```{important}
**Auxiliary Functions:**

Define:

$$
d_-(t, s) = \frac{1}{\sigma\sqrt{T-t}}\left[\log\frac{s}{K} + \left(r - \frac{\sigma^2}{2}\right)(T-t)\right]
$$

and:

$$
d_+(t, s) = d_-(t, s) + \sigma\sqrt{T-t} = \frac{1}{\sigma\sqrt{T-t}}\left[\log\frac{s}{K} + \left(r + \frac{\sigma^2}{2}\right)(T-t)\right]
$$

Equivalently, with $\tau = T - t$ (time to maturity):

$$
\begin{align}
d_-(\tau, s) &= \frac{1}{\sigma\sqrt{\tau}}\left[\log\frac{s}{K} + \left(r - \frac{\sigma^2}{2}\right)\tau\right] \\
d_+(\tau, s) &= \frac{1}{\sigma\sqrt{\tau}}\left[\log\frac{s}{K} + \left(r + \frac{\sigma^2}{2}\right)\tau\right]
\end{align}
$$
```

### The Black-Scholes Formula

```{dropdown} Detailed Derivation

$$
\begin{align}
v(t, s) &= \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{d_-(T-t, s)} \left[s\exp\left\{\sigma\sqrt{T-t}y + \frac{1}{2}\sigma^2(T-t) - \frac{1}{2}y^2\right\} - \exp(-r(T-t))K\exp\left(-\frac{1}{2}y^2\right)\right]dy \\
&= \frac{s}{\sqrt{2\pi}}\int_{-\infty}^{d_-(T-t, s)} \exp\left\{-\frac{1}{2}(y - \sigma\sqrt{T-t})^2\right\}dy - \exp(-r(T-t))K \cdot N(d_-(T-t, s)) \\
&= s \cdot N(d_+(T-t, s)) - \exp(-r(T-t))K \cdot N(d_-(T-t, s))
\end{align}
$$

where $N$ denotes the standard normal cumulative distribution function.
```

```{important}
**Black-Scholes Formula for European Call:**

$$
v(t, s) = s \, N(d_+(T-t, s)) - e^{-r(T-t)}K \, N(d_-(T-t, s))
$$

where:

$$
\begin{align}
d_+(\tau, s) &= \frac{\log(s/K) + (r + \sigma^2/2)\tau}{\sigma\sqrt{\tau}} \\
d_-(\tau, s) &= \frac{\log(s/K) + (r - \sigma^2/2)\tau}{\sigma\sqrt{\tau}} = d_+ - \sigma\sqrt{\tau}
\end{align}
$$

and $N(\cdot)$ is the standard normal CDF.
```

**Physical Meaning:**
- The first term $s \, N(d_+)$ represents the expected benefit from acquiring the stock
- The second term $e^{-r(T-t)}K \, N(d_-)$ is the present value of paying the strike price
- $N(d_-)$ can be interpreted as the risk-neutral probability that the option will be exercised

## How About the Price of a Put?

The payoff of a European put is:

$$
V(T) = (K - S(T))^+
$$

### Put-Call Parity

```{important}
**Put-Call Parity Formula:**

$$
F(t, s) = s - e^{-r(T-t)}K = v(t, s) - p(t, s)
$$

where:
- $p(t, s)$ = price of a put
- $v(t, s)$ = price of a call
- $F(t, s)$ = price of a forward contract
```

**Verification at Maturity:** At $T = t$:

$$
F(T, s) = v(T, s) - p(T, s)
$$

### Law of One Price

By the **law of one price**, this equality must still be true for every $0 \leq t < T$.

```{dropdown} Arbitrage Argument

If this equation were wrong, one could either sell or buy the portfolio that is:
- Long a call
- Short a put
- Short a forward

to realize a profit instantly, which contradicts the assumption of no arbitrage in the Black-Scholes model.
```

### Put Price Formula

```{important}
**Black-Scholes Formula for European Put:**

$$
\begin{align}
p(t, s) &= v(t, s) - s + Ke^{-r(T-t)} \\
&= s \, N(d_+(T-t, s)) - e^{-r(T-t)}K \, N(d_-(T-t, s)) - s + Ke^{-r(T-t)} \\
&= Ke^{-r(T-t)}N(-d_-(T-t, s)) - s \, N(-d_+(T-t, s))
\end{align}
$$
```

**Physical Meaning:** The put formula has a similar structure to the call formula, but with complementary probabilities $N(-d_+)$ and $N(-d_-)$ reflecting the payoff when the stock price falls below the strike.

## How About the Hedging Strategy? The PDE Approach

One can derive the **hedging strategy** in closed form along with the Black-Scholes partial differential equation using the **PDE approach**.

### Applying Ito's Lemma

Apply Ito's lemma to the price $v(t, S(t))$ at time $t$ of the European call:

```{dropdown} Ito's Formula Application

$$
\begin{align}
dv(t, S(t)) &= v_t(t, S(t))dt + v_s(t, S(t))dS(t) + \frac{1}{2}v_{ss}(t, S(t))dS(t)dS(t) \\
&= \left[v_t(t, S(t)) + \mu S(t)v_s(t, S(t)) + \frac{1}{2}\sigma^2 S(t)^2 v_{ss}(t, S(t))\right]dt \\
&\quad + \sigma S(t)v_s(t, S(t))dW(t)
\end{align}
$$
```

### The Hedging Portfolio

Consider an investor who is **short a European call** and needs to hedge the short position.

**Notation:**
- $X(t)$ = value of the hedging portfolio at time $t$
- $\Delta(t)$ = number of shares of underlying asset held at time $t$

### Self-Financing Condition

```{important}
**Self-Financing Portfolio:**

The evolution of the investor's self-financing portfolio is:

$$
dX(t) = \Delta(t)dS(t) + r(X(t) - \Delta(t)S(t))dt
$$
```

**Physical Meaning:** The change in portfolio value comes from:
- Gains/losses on the stock position: $\Delta(t)dS(t)$
- Interest earned on cash: $r(X(t) - \Delta(t)S(t))dt$

The **self-financing condition** means there is no cash flowing in or out of the portfolio on $[0, T]$ (same as in the binomial tree model).

### Deriving the PDE

Compute the differential of the investor's position (long hedging portfolio, short call):

```{dropdown} Detailed Derivation

$$
\begin{align}
d(X(t) - v(t, S(t))) &= \Delta(t)dS(t) + r(X(t) - \Delta(t)S(t))dt - dv(t, S(t)) \\
&= \mu\Delta(t)S(t)dt + \sigma\Delta(t)S(t)dW(t) + r(X(t) - \Delta(t)S(t))dt \\
&\quad - [v_t(t, S(t)) + \mu S(t)v_s(t, S(t)) + \frac{1}{2}\sigma^2 S(t)^2 v_{ss}(t, S(t))]dt \\
&\quad - \sigma S(t)v_s(t, S(t))dW(t)
\end{align}
$$

**Requirements:**
- $X(T) = v(T, S(T)) = (S(T) - K)^+$ (terminal condition)
- $X(0) = v(0, S(0))$ (initial capital)
- $X(t) = v(t, S(t))$ for all $0 \leq t \leq T$ (perfect replication)
```

### Eliminating Risk: Delta Hedging

To replicate the option payout with certainty, we cancel the **fluctuating Brownian terms** by choosing:

```{important}
**Delta-Hedging Strategy:**

$$
\Delta(t) = v_s(t, S(t))
$$

This is called the **Delta** of the option.
```

**Physical Meaning:** At each instant, hold a number of shares equal to the derivative of the option price with respect to the stock price. This makes the portfolio locally risk-free.

### The Black-Scholes PDE

After substituting the delta-hedging strategy and simplifying:

$$
v_t(t, S(t)) + rS(t)v_s(t, S(t)) + \frac{1}{2}\sigma^2 S(t)^2 v_{ss}(t, S(t)) = rv(t, S(t))
$$

```{important}
**Black-Scholes-Merton Partial Differential Equation:**

For all $t \in [0, T)$ and $s \geq 0$:

$$
v_t(t, s) + rsv_s(t, s) + \frac{1}{2}\sigma^2 s^2 v_{ss}(t, s) = rv(t, s)
$$

**Terminal Condition:**
$$
v(T, s) = (s - K)^+
$$
```

**Physical Meaning:** The option price must satisfy this PDE. The PDE incorporates:
- Time decay: $v_t$
- Sensitivity to stock price: $v_s$
- Convexity (gamma): $v_{ss}$
- Discounting: $rv$

### Why No Arbitrage Opportunities?

```{admonition} Arbitrage Prevention
:class: warning

If at any time $t$ we had:

$$
X(t) > v(t, S(t))
$$

one could borrow the difference $X(t) - v(t, S(t))$ from the money market account at rate $r > 0$ to invest in the portfolio that is:
- Long the hedging portfolio $X(t)$
- Short the European call $v(t, S(t))$

thus realizing a **riskless profit**.

This would constitute an **arbitrage opportunity**, which violates our assumptions.
```

## The Greeks: Delta

One can use the analytical formula previously derived and differentiate it to obtain the **Delta** of the call analytically.

```{important}
**Delta of European Call:**

$$
\Delta(t, s) = v_s(t, s) = N(d_+(T-t, s))
$$

**Interpretation:** The Delta represents the number of shares of stock in the hedging portfolio. It is also called one of the **Greeks**.
```

**Physical Meaning:**
- $\Delta$ is always between 0 and 1 for a call
- When $s \gg K$ (deep in-the-money), $\Delta \approx 1$
- When $s \ll K$ (deep out-of-the-money), $\Delta \approx 0$
- At-the-money options have $\Delta \approx 0.5$

## Monte Carlo Simulations

Since we can compute the option price analytically, we **do not need** to resort to Monte Carlo simulations in this case.

```{note}
**When is Monte Carlo Useful?**

Monte Carlo simulations can be very useful for:
- **Path-dependent options** (e.g., Asian options)
- **American options**
- Complex derivatives without closed-form solutions
```

### Closed-Form Formula for Terminal Stock Price

Recall:

$$
S(T) = S(0)\exp\left\{\left(r - \frac{1}{2}\sigma^2\right)T + \sigma\tilde{W}(T)\right\}
$$

Assume the initial stock price is given and equals $s$.

We can rewrite:

$$
S(T) = s\exp\left\{\left(r - \frac{1}{2}\sigma^2\right)T + \sigma\sqrt{T} \, Y\right\}
$$

where $Y$ is a standard normal random variable.

### The Algorithm

```{important}
**Monte Carlo Algorithm for European Call:**

1. **Start** with $S(0) = s$

2. **For each** $i = 1, \ldots, n$:

   2.1. **Generate** $S_i(T)$ using:
        $$
        S_i(T) = s\exp\left\{\left(r - \frac{1}{2}\sigma^2\right)T + \sigma\sqrt{T} \, Y_i\right\}
        $$
        where $Y_i$ is drawn from the standard normal distribution and $Y_1, Y_2, \ldots, Y_n$ are independent

   2.2. **Set** $C_i = e^{-rT}(S_i(T) - K)^+$

3. **Compute the average:**
   $$
   \hat{C}_n = \frac{1}{n}\sum_{i=1}^{n} C_i
   $$
```

**Physical Meaning:** Simulate many possible future stock prices under the risk-neutral measure, compute the discounted payoff for each, and average them.

### Convergence and Sample Size

```{note}
**Sample Size:**

Since the rate of convergence of Monte Carlo simulations is only $\frac{1}{\sqrt{n}}$, one needs to choose a very large value for $n$:
- At least $n = 100,000$
- Often $n = 1,000,000$
```

### Theoretical Guarantees

```{important}
**Statistical Properties:**

1. **Strong Law of Large Numbers:** The estimator:
   $$
   \hat{C}_n = \frac{1}{n}\sum_{i=1}^{n} C_i
   $$
   converges to the price of the European call as $n \to \infty$

2. **Unbiased Estimator:**
   $$
   E[\hat{C}_n] = \tilde{E}[e^{-rT}(S(T) - K)^+ \mid S(0) = s]
   $$

3. **Central Limit Theorem:** The distribution of the error is normal with:
   - Mean: 0
   - Standard deviation: $s_C/\sqrt{n}$

   where $s_C$ can be estimated by the unbiased estimator:
   $$
   s_C = \sqrt{\frac{1}{n-1}\sum_{i=1}^{n}(C_i - \hat{C}_n)^2}
   $$
```

**Physical Meaning:** Monte Carlo provides a probabilistic approximation. The error decreases as $1/\sqrt{n}$, and we can quantify our uncertainty using the standard deviation estimate.

---

## References

1. Steven E. Shreve, "Stochastic Calculus for Finance I: The Binomial Asset Pricing Model", 2004, Springer
2. Steven E. Shreve, "Stochastic Calculus for Finance II: Continuous-time finance", 2004, Springer
3. Stanley R. Pliska, "Introduction to Mathematical Finance, Discrete Time Models", 1997, Blackwell Publishing
4. Paul Wilmott, Sam Howison, and Jeff Dewynne, "Mathematics of Financial Derivatives: A Student Introduction", Cambridge University Press, 1995
