---
title: "Lecture 14: American Options, the Greeks, and Hedging"
author: "Agnès Tourin"
date: "November 9, 2024"
---

# Complements in Option Pricing: American Options and the Greeks

This lecture covers advanced topics in option pricing including American options, the Greeks (sensitivity measures), and hedging strategies. We explore the early exercise feature of American options, compute hedge ratios, and analyze delta-neutral and delta-gamma-neutral portfolios.

```{note}
**Historical Note:**

The first draft of these notes was originally written by Andrew Papanicolaou.
```

## American Options

### Introduction to American Options

```{important}
**Key Difference from European Options:**

An American call option has the **additional feature** of being exercised at any time prior to maturity $T$.
```

**Physical Meaning:** The holder has flexibility—they can exercise immediately or wait. This optionality makes American options more valuable than their European counterparts.

### Pricing Formula

Let $C_A(t)$ denote the price of an American call option at time $t$, with strike $K$ and maturity $T$.

```{important}
**American Option Value:**

At any time $t \leq T$:
$$
C_A(t) = \max(S(t) - K, C_{\text{cont}}(t))
$$

where:
- $S(t) - K$ = immediate exercise value (intrinsic value)
- $C_{\text{cont}}(t)$ = continuation value (value of waiting)
```

**Physical Meaning:** At each moment, the holder chooses the better of two options: exercise now or continue holding.

### Comparison with European Options

```{important}
**Value Relationship:**

$$
C_A(t) \geq C_E(t)
$$

where $C_E(t)$ is the European call option price.

**Reason:** The American option includes all the rights of the European option plus early exercise flexibility.
```

```{dropdown} Heuristic Argument

Consider time $t$ very close to maturity $T$.

At time $t$, you can either:
1. Exercise immediately: receive $S(t) - K$
2. Wait until $T$: receive $C_{\text{cont}}(t)$

Therefore:
$$
C_A(t) = \max(S(t) - K, C_{\text{cont}}(t)) \geq C_{\text{cont}}(t) = C_E(t)
$$

**Backward induction:** Iterate this argument backward in time to show $C_A(t) \geq C_E(t)$ for all $t \leq T$.
```

## The American Call Without Dividend

### Main Result

```{important}
**Theorem: No Early Exercise for Calls Without Dividends**

For an American call option on a **non-dividend-paying** asset:
$$
C_A(t) = C_{\text{cont}}(t) = C_E(t) \quad \text{for all } t \leq T
$$

**Conclusion:** It is **never optimal** to exercise early a call on a non-dividend-paying asset.
```

```{dropdown} Proof Using Put-Call Parity

For $t < T$, by put-call parity for European options:

$$
\begin{align}
C_A(t) &= \max(S(t) - K, C_{\text{cont}}(t)) \\
&\geq C_E(t) \\
&= P_E(t) + S(t) - Ke^{-r(T-t)} \\
&> S(t) - Ke^{-r(T-t)} \\
&> S(t) - K
\end{align}
$$

where the last inequality holds because $e^{-r(T-t)} < 1$ for $t < T$ and $r > 0$.

**Conclusion:**
$$
\max(S(t) - K, C_{\text{cont}}(t)) > S(t) - K \quad \text{for all } t < T
$$

Therefore:
$$
C_A(t) = C_{\text{cont}}(t) = C_E(t)
$$
```

**Physical Meaning:** Even when in-the-money, it's better to sell the American call or hold it than to exercise it early. The time value of the option exceeds the benefit of immediate exercise.

## Example: Why Not Exercise Early?

```{admonition} Example: In-the-Money American Call
:class: tip

**Setup:**
- Current stock price: $S(t) = \$105$
- American call strike: $K = \$100$
- Time to maturity: 3 months
- Risk-free rate: $r = 0.05$
- The option is **in-the-money**

**Scenario:** You predict the stock will fall to $S(T) < \$100$ (out-of-the-money at maturity).

**Should you exercise early?**
```

### Strategy 1: Exercise Immediately

```{note}
**Steps:**
1. Pay $K = \$100$ for one share
2. Sell the share at $\$105$
3. Invest proceeds of $\$5$ in a 3-month bond

**Cash position in 3 months:**
$$
5 \times e^{0.05 \times 0.25} = 5 \times 1.0126 = \$5.06
$$
```

### Strategy 2: Short the Asset and Hold the Option

```{note}
**Steps:**
1. At time $t$: Short the asset at $\$105$
2. Invest proceeds in a 3-month bond
3. Hold the American call

**In 3 months:**
1. Sell bond for $105 \times 1.0126 = \$106.32$
2. Cover short position: pay no more than $\$100$ (use the option if needed)
3. Net cash position: **at least $\$6.32$**
```

```{important}
**Comparison:**

- Strategy 1: $\$5.06$
- Strategy 2: At least $\$6.32$

**Edge of Strategy 2:** At least $\$1.26$

**Conclusion:** Strategy 2 dominates. Early exercise is suboptimal.
```

```{note}
**Alternative:**

Simply **sell the call** in the market. This captures both intrinsic value and time value, which is even better than exercising.
```

**Physical Meaning:** Early exercise throws away the time value of the option. It's always better to either sell the option or implement a synthetic short position.

## American Options with Dividends

### Model with Continuous Dividends

```{important}
**Black-Scholes Model with Dividends:**

Under the risk-neutral measure:
$$
dS(t) = (r - \delta)S(t)dt + \sigma S(t)d\tilde{W}(t)
$$

where:
- $\delta > 0$ = continuous dividend rate
- $e^{-(r-\delta)t}S(t)$ is a martingale under $\tilde{P}$
```

**Physical Meaning:** Dividends reduce the stock price growth rate. The stock "leaks value" through dividend payments.

### Dividend Cash Account

```{dropdown} Dividend Accumulation

If dividends are reinvested in the cash account, $D(t)$ satisfies:
$$
dD(t) = (rD(t) + \delta S(t))dt, \quad D(0) = 0
$$

**Discounted dividend process:**
$$
d(e^{-rt}D(t)) = \delta e^{-rt}S(t)dt
$$

**Integrating from 0 to $t$:**
$$
e^{-rt}D(t) = \int_0^t e^{-ru}S(u)\delta \, du
$$

**Taking expectations:**
$$
\tilde{E}[e^{-rt}D(t)] = \int_0^t \tilde{E}[e^{-ru}S(u)]\delta \, du = \int_0^t S(0)e^{-\delta u}\delta \, du = S(0)(1 - e^{-\delta t})
$$

by the martingale property of $e^{-(r-\delta)t}S(t)$.
```

### Put-Call Parity with Dividends

```{important}
**Put-Call Parity (Dividend Case):**

At time $T$:
$$
(K - S(T))^+ + S(T) = (S(T) - K)^+ + K
$$

**Taking discounted expectations under $\tilde{P}$:**
$$
e^{-rT}\tilde{E}[(K - S(T))^+] + e^{-rT}\tilde{E}[S(T)] = e^{-rT}\tilde{E}[(S(T) - K)^+] + e^{-rT}K
$$

**Using martingale property:**
$$
S(0)e^{-\delta T} + P_E(0) = C_E(0) + e^{-rT}K
$$
```

### Early Exercise with Dividends

```{warning}
**Early Exercise May Be Optimal:**

For American calls on dividend-paying assets, early exercise **may be optimal**.
```

```{dropdown} Analysis

From put-call parity:
$$
C_A(0) \geq C_E(0) = P_E(0) + S(0)e^{-\delta T} - e^{-rT}K
$$

But:
$$
P_E(0) + S(0)e^{-\delta T} - e^{-rT}K \not\geq S(0) - K
$$

in general (depends on $\delta$).

The presence of $\delta$ means we cannot use the same argument as in the no-dividend case.
```

**Physical Meaning:** Dividends provide an incentive to exercise early—by exercising, you can collect future dividends. This trades off against the time value of waiting.

## American Put Options

```{warning}
**Early Exercise for Puts:**

If the interest rate is **positive**, it may be optimal to exercise early an American put option on a **non-dividend-paying** asset.

**Special case:** With **zero interest rate**, it is never optimal to exercise early, and $P_A = P_E$.
```

```{note}
**Complexity:**

In general, the standard Black-Scholes theory does **not work** for pricing American puts.

Pricing American puts requires:
- Numerical methods (finite differences, binomial trees, Monte Carlo with LSM)
- Free boundary problems
- Optimal stopping theory
```

**Physical Meaning:** For puts, exercising early allows you to invest the strike price and earn interest. This creates an incentive for early exercise that doesn't exist for calls.

## The Greeks

### Introduction

```{important}
**Definition: The Greeks**

The Greeks measure the **sensitivity** of an option price to changes in variables and parameters.

We focus on three main Greeks:
- **Delta ($\Delta$):** Sensitivity to stock price
- **Gamma ($\Gamma$):** Sensitivity of delta to stock price
- **Theta ($\Theta$):** Sensitivity to time
```

### Notation

Let $c(t, s)$ denote the price of a call option at time $t$ when the underlying security's price is $s$.

```{important}
**Greek Definitions:**

$$
\Delta(t, s) = \frac{\partial c}{\partial s}(t, s) > 0
$$

$$
\Gamma(t, s) = \frac{\partial^2 c}{\partial s^2}(t, s) > 0
$$

$$
\Theta(t, s) = \frac{\partial c}{\partial t}(t, s)
$$
```

**Physical Meaning:**
- **Delta:** How much the option price changes per $1 change in stock price
- **Gamma:** How much delta changes per $1 change in stock price (curvature)
- **Theta:** How much the option price changes per unit time (time decay)

### Black-Scholes PDE in Terms of Greeks

```{important}
**PDE Formulation:**

The Black-Scholes PDE:
$$
\frac{\partial c}{\partial t} + \frac{1}{2}\sigma^2 s^2 \frac{\partial^2 c}{\partial s^2} + rs\frac{\partial c}{\partial s} - rc = 0
$$

can be rewritten as:
$$
\frac{1}{2}\sigma^2 s^2 \Gamma = \Theta + r(c - s\Delta)
$$
```

**Physical Meaning:** This equation balances the convexity correction (gamma term) against time decay and the cost of carry.

### Interpretations

```{note}
**Economic Interpretations:**

1. **Delta ($\Delta = c_s$):** The **hedge ratio** (seen in continuous-time pricing theory)
   - Measures sensitivity to stock price changes
   - Number of shares to hold to hedge one option

2. **Gamma ($\Gamma = c_{ss}$):** Sensitivity of the hedge
   - Measures how quickly delta changes
   - Large gamma means frequent rebalancing needed

3. **Theta ($\Theta = c_t$):** Time value of the option
   - Usually $\Theta > 0$ (option loses value as time passes)
   - Exceptionally, $\Theta < 0$ for low-strike puts
```

## Black-Scholes Greeks: Explicit Formulas

### European Call Greeks

```{important}
**Greeks for European Call:**

**Delta:**
$$
\Delta(t, s) = N(d_+(T-t, s))
$$

**Gamma:**
$$
\Gamma(t, s) = \frac{N'(d_+(T-t, s))}{s\sigma\sqrt{T-t}}
$$

**Theta:**
$$
\Theta(t, s) = -\frac{1}{2}\sigma s \frac{N'(d_+(T-t, s))}{\sqrt{T-t}} + rKe^{-r(T-t)}N(d_-(T-t, s))
$$

where:
$$
d_\pm(T-t, s) = \frac{\ln(s/K) + (r \pm \frac{1}{2}\sigma^2)(T-t)}{\sigma\sqrt{T-t}}
$$

and $N(\cdot)$ is the standard normal CDF, $N'(\cdot)$ is the standard normal PDF.
```

### European Put Greeks

```{important}
**Greeks for European Put:**

**Delta:**
$$
\Delta(t, s) = N(d_+(T-t, s)) - 1
$$

**Gamma:**
$$
\Gamma(t, s) = \frac{N'(d_+(T-t, s))}{s\sigma\sqrt{T-t}}
$$

**Theta:**
$$
\Theta(t, s) = -\frac{1}{2}\sigma s \frac{N'(d_+(T-t, s))}{\sqrt{T-t}} - rKe^{-r(T-t)}N(-d_-(T-t, s))
$$
```

### Properties

```{note}
**Bounds and Signs:**

**For European calls:**
- $0 \leq \Delta \leq 1$
- $\Gamma > 0$

**For European puts:**
- $-1 \leq \Delta \leq 0$
- $\Gamma > 0$ (same as call)
```

**Physical Meaning:**
- Call delta is positive: call value increases with stock price
- Put delta is negative: put value decreases with stock price
- Both have positive gamma: both are convex in stock price

## Hedging Interpretation of Theta

### Portfolio Dynamics

Consider a portfolio that is:
- **Long** the call option
- **Short** the $\Delta$-hedge

```{important}
**Hedging Portfolio Evolution:**

The hedging portfolio value $X(t)$ evolves as:
$$
dX(t) = \Delta(t, S(t))dS(t) + r(X(t) - \Delta(t, S(t))S(t))dt
$$

**Interpretation:**
- First term: gains/losses from holding stock
- Second term: interest earned on cash position
```

### Delta-Hedged Portfolio

```{dropdown} Derivation of P&L Dynamics

The value of the portfolio (long call, short hedge):
$$
d(c(t, S(t)) - X(t))
$$

Expanding:
$$
\begin{align}
&= dc(t, S(t)) - \Delta(t, S(t))dS(t) - r(X(t) - \Delta(t, S(t))S(t))dt \\
&= \left(\Theta(t, S(t)) + \frac{1}{2}\sigma^2 S(t)^2 \Gamma(t, S(t))\right)dt + \Delta(t, S(t))dS(t) \\
&\quad - \Delta(t, S(t))dS(t) - r(X(t) - \Delta(t, S(t))S(t))dt \\
&= \left(\Theta(t, S(t)) - r(X(t) - \Delta(t, S(t))S(t)) + \frac{1}{2}\sigma^2 S(t)^2 \Gamma(t, S(t))\right)dt
\end{align}
$$
```

```{important}
**Interpretation of Theta:**

$\Theta$ can be seen as the **premium earned by the hedge** compared to the benchmark given by the risk-free rate.

The total P&L has three components:
1. Time decay ($\Theta$)
2. Interest cost of hedge ($-r(X - \Delta S)$)
3. Convexity adjustment ($\frac{1}{2}\sigma^2 S^2 \Gamma$)
```

**Physical Meaning:** Theta represents the option's time value erosion, which compensates for the gamma risk (convexity) the hedger is exposed to.

## Effect of Time Discretization on Hedging

### Discrete-Time Rebalancing

```{warning}
**Discretization Error:**

In practice, we apply the hedging strategy in **discrete time**, introducing error and additional risk.
```

```{important}
**Discrete-Time Approximation:**

$$
\begin{align}
&c(t + \Delta t, S(t + \Delta t)) - X(t + \Delta t) - (c(t, S(t)) - X(t)) \\
&\approx c(t + \Delta t, S(t + \Delta t)) - c(t, S(t)) \\
&\quad - \Delta(t, S(t))(S(t + \Delta t) - S(t)) - r(X(t) - \Delta(t, S(t))S(t))\Delta t
\end{align}
$$
```

**Physical Meaning:** Even with a perfect delta hedge ($\Delta = c_s$), we cannot completely eliminate risk because of:
1. Truncation error in time discretization
2. Gamma risk between rebalances

## Delta-Neutral Portfolios

### Construction

```{note}
**Portfolio Setup:**

Consider a portfolio that is:
- **Long** a call option with price $c(t, s)$
- **Short** the delta hedge

**Portfolio value:**
$$
V(t) = c(t, S(t)) - \Delta_c(t)S(t)
$$

where $\Delta_c(t) = \Delta(t, S(t))$ is the delta of the call.
```

### Delta of the Portfolio

Define the portfolio value function:
$$
v(t, s) = c(t, s) - \Delta_c(t)s
$$

```{important}
**Portfolio Delta:**

$$
\Delta_V(t) = \frac{\partial v}{\partial s}(t, S(t)) = c_s(t, S(t)) - \Delta_c(t) = 0
$$

**Conclusion:** The portfolio is **delta-neutral**.
```

**Physical Meaning:** A delta-neutral portfolio has no first-order sensitivity to small stock price changes. The portfolio value is locally flat with respect to stock price.

### Gamma Exposure

```{warning}
**Remaining Risk:**

The delta-neutral portfolio is still sensitive to stock price changes, especially when the option's gamma is **large**.

**Large gamma occurs when:**
- The option is **at-the-money**
- Maturity is near

**Consequence:** The hedging portfolio must be **rebalanced frequently** when gamma is large.
```

**Physical Meaning:** Zero delta means the portfolio is hedged against small moves, but large gamma means delta changes rapidly, requiring frequent rebalancing.

## Delta-Neutral and Gamma-Neutral Hedging

### Motivation

```{admonition} Goal: Eliminate Both Delta and Gamma Risk
:class: tip

To construct a hedging strategy that is both:
- **Delta-neutral:** $\Delta_V = 0$
- **Gamma-neutral:** $\Gamma_V = 0$

We introduce a **second option** for hedging.
```

### Setup

```{note}
**Two Options:**

- **Option 1:** Call with strike $K$ and price $c(t, s)$
- **Option 2:** Call with strike $K'$ and price $c'(t, s)$
- **Both options:** Same maturity $T$, same underlying

**Hedging portfolio:**
- $\beta$ shares of underlying asset
- $\alpha$ shares of Option 2
```

### Portfolio Differential

```{dropdown} Derivation

$$
\begin{align}
&dc(t, S(t)) - dX(t) \\
&= c_t dt + c_s dS(t) + \frac{1}{2}c_{ss}(dS(t))^2 \\
&\quad - \beta dS(t) - \alpha dc'(t) - r(X(t) - \beta S(t) - \alpha c')dt \\
&= c_t dt + c_s dS(t) + \frac{1}{2}c_{ss}(dS(t))^2 \\
&\quad - \beta dS(t) - \alpha(c'_t dt + c'_s dS(t) + \frac{1}{2}c'_{ss}(dS(t))^2) \\
&\quad - r(X(t) - \beta S(t) - \alpha c')dt
\end{align}
$$
```

### Gamma Neutrality

```{important}
**Choose $\alpha$ to Cancel Second Derivatives:**

$$
\alpha = \frac{c_{ss}}{c'_{ss}} = \frac{\Gamma_c}{\Gamma_{c'}}
$$

where $\Gamma_c$ and $\Gamma_{c'}$ are the gammas of the two options.
```

**Physical Meaning:** We hold options in proportion to their gammas to cancel out convexity risk.

### Delta Neutrality

```{important}
**Choose $\beta$ to Cancel First Derivatives:**

$$
\beta = c_s - \alpha c'_s
$$
```

### Resulting P&L

```{important}
**P&L Dynamics:**

$$
dc(t, S(t)) - dX(t) = (\Theta_c - \alpha\Theta_{c'} - r(X(t) - \beta S(t) - \alpha c'))dt
$$

where $\Theta_c$ and $\Theta_{c'}$ are the thetas of the two options.

**Premium over risk-free:**
$$
\Theta_c - \alpha\Theta_{c'}
$$

**Key observation:** No $dS$ term (delta-neutral) and no $(dS)^2$ term (gamma-neutral)!
```

**Physical Meaning:** The delta-gamma-neutral portfolio earns theta (time decay) without exposure to stock price movements or convexity risk.

### Portfolio Greeks

Define the portfolio value:
$$
H(t) = c(t, S(t)) - \beta S(t) - \alpha c'(t, S(t))
$$

```{important}
**Portfolio Greeks:**

$$
\Delta_H(t) = c_s - \beta - \alpha c'_s = 0
$$

$$
\Gamma_H(t) = c_{ss} - \alpha c'_{ss} = 0
$$

**Conclusion:** The portfolio is both **delta-neutral** and **gamma-neutral**.
```

**Physical Meaning:** This portfolio is locally immune to stock price changes up to second order. It earns pure theta without taking directional or convexity risk.

## Profit and Loss Analysis

### Unhedged Position

```{note}
**Unhedged P&L:**

For a holder of a European call who does **not hedge**:

**At maturity:**
$$
\text{P\&L}(T) = (S(T) - K)^+ - e^{rT}C(0, S(0))
$$

**Interpretation:** Payoff minus the future value of the initial cost.
```

### Hedged Position

```{important}
**Hedged P&L:**

For a holder who **does hedge**:
$$
\text{P\&L}(T) = (S(T) - K)^+ - X(T)
$$

where $X(T)$ is the terminal value of the hedging portfolio.
```

**Physical Meaning:** The hedge transforms the risky payoff into a (hopefully) deterministic profit equal to the option's initial theoretical value.

## Delta-Hedged P&L Dynamics

```{important}
**Delta-Hedge P&L Evolution:**

$$
dc(t, S(t)) - dX(t) = \left(\Theta + \frac{1}{2}\sigma^2 S^2 \Gamma - r(X(t) - \Delta S(t))\right)dt
$$

**Interpretation:**
- The option holder is **long gamma** ($\Gamma = c_{ss} > 0$ by convexity)
- The hedger is **long theta** ($\Theta = c_t$)
```

**Physical Meaning:**
- **Long gamma:** Benefits from volatility (realized variance)
- **Long theta:** Earns time decay

These two effects balance in the Black-Scholes framework.

## Delta-Gamma-Hedged P&L Dynamics

```{important}
**Delta-Gamma-Hedge P&L Evolution:**

$$
\begin{align}
dc(t, S(t)) - dX(t) &= c_t dt + c_s dS(t) + \frac{1}{2}c_{ss}(dS(t))^2 \\
&\quad - \beta dS(t) - \alpha c'_t dt - \alpha c'_s dS(t) - \frac{1}{2}\alpha c'_{ss}(dS(t))^2 \\
&\quad - r(X(t) - \beta S(t) - \alpha c')dt \\
&= (\Theta_c - \alpha\Theta_{c'} - r(X(t) - \beta S(t) - \alpha c'))dt
\end{align}
$$

**Key feature:** No $dS$ or $(dS)^2$ terms!
```

**Physical Meaning:** The delta-gamma-neutral hedge eliminates both directional risk and convexity risk. The P&L is purely deterministic (in continuous time).

## Other Greeks

### Vega

```{important}
**Vega Definition:**

Measures sensitivity to volatility $\sigma$:
$$
\mathcal{V} = \frac{\partial c}{\partial \sigma}
$$

**Black-Scholes Formula:**
$$
\mathcal{V} = sN'(d_+(T-t, s))\sqrt{T-t} = s\sqrt{T-t}\sigma \Gamma
$$

where $s = S(t)$.
```

**Physical Meaning:** Vega measures how much the option price changes for a 1% change in volatility. It's crucial for volatility trading and risk management.

```{note}
**Relationship to Gamma:**

Vega is proportional to gamma. Options with high gamma also have high vega.
```

### Volga and Vanna

```{important}
**Higher-Order Greeks:**

**Volga (Vomma):** Second derivative with respect to volatility
$$
\frac{\partial^2 c}{\partial \sigma^2}
$$

**Vanna:** Cross-derivative
$$
\frac{\partial^2 c}{\partial s \partial \sigma}
$$
```

**Physical Meaning:**
- **Volga:** Convexity in volatility (sensitivity of vega to volatility changes)
- **Vanna:** How delta changes with volatility (or how vega changes with stock price)

### Rho

```{important}
**Rho Definition:**

Measures sensitivity to interest rate $r$:
$$
\rho = \frac{\partial c}{\partial r}
$$
```

**Physical Meaning:** How much the option price changes when interest rates change by 1%. Less important for short-dated options, more important for long-dated options.

## Stochastic Volatility and the Greeks

### Model with Stochastic Volatility

```{note}
**Generalization:**

Let volatility fluctuate randomly over time: $\sigma(t)$.

**Option price:** Now depends on $\sigma(t)$:
$$
c(t, S(t), \sigma(t))
$$
```

### Ito's Formula

```{important}
**Differential with Stochastic Volatility:**

$$
\begin{align}
dc(t, S(t), \sigma(t)) &= c_t dt + c_s dS(t) + c_\sigma d\sigma(t) \\
&\quad + \frac{1}{2}c_{ss}(dS(t))^2 + \frac{1}{2}c_{\sigma\sigma}(d\sigma(t))^2 \\
&\quad + c_{s\sigma}dS(t)d\sigma(t)
\end{align}
$$
```

### Delta-Gamma Hedge with Two Options

```{admonition} Key Result
:class: tip

If we construct a delta-gamma-neutral hedge using:
- Option with strike $K$ (price $c$)
- Option with strike $K'$ (price $c'$)
- Both sharing the same volatility process $\sigma(t)$

Then the portfolio is also **vega-neutral**!
```

```{dropdown} Proof

**Portfolio vega:**
$$
\mathcal{V}_{\text{portfolio}} = c_\sigma - \alpha c'_\sigma = s\sqrt{T-t}\sigma \Gamma_c - \alpha s\sqrt{T-t}\sigma \Gamma_{c'}
$$

Since $\alpha = \Gamma_c / \Gamma_{c'}$:
$$
\mathcal{V}_{\text{portfolio}} = s\sqrt{T-t}\sigma \Gamma_c - \frac{\Gamma_c}{\Gamma_{c'}} s\sqrt{T-t}\sigma \Gamma_{c'} = 0
$$
```

**Physical Meaning:** Hedging gamma automatically hedges vega when using options on the same underlying with the same volatility exposure.

### P&L with Stochastic Volatility

```{important}
**P&L Dynamics (Stochastic Volatility):**

$$
\begin{align}
d(\text{P\&L}(t)) &= (\Theta_c - \alpha\Theta_{c'} - r(X(t) - \beta S(t) - \alpha c'))dt \\
&\quad + (c_{s\sigma} - \alpha c'_{s\sigma})dS(t)d\sigma(t) \\
&\quad + \frac{1}{2}(c_{\sigma\sigma} - \alpha c'_{\sigma\sigma})(d\sigma(t))^2
\end{align}
$$
```

**Physical Meaning:** Even with delta-gamma-vega neutrality, there remain higher-order risks:
- Vanna risk: $dS \cdot d\sigma$ cross-terms
- Volga risk: $(d\sigma)^2$ terms

### Vanna and Volga Neutrality

```{note}
**Complete Hedging:**

With **two additional call options**, we could construct a hedging strategy that is:
- Delta-neutral
- Gamma-neutral
- Vega-neutral
- Vanna-neutral
- Volga-neutral

This requires **three options** plus the underlying asset for a complete hedge.
```

**Physical Meaning:** As we hedge more Greeks, we need more instruments. Complete hedging of all sensitivities requires a portfolio of multiple derivatives.

## Summary

In this lecture, we covered:

1. **American Options:**
   - Early exercise feature
   - Comparison with European options
   - No early exercise for calls without dividends
   - Early exercise for puts and dividend-paying calls

2. **The Greeks:**
   - Delta, gamma, and theta definitions
   - Explicit formulas for European options
   - Economic interpretations

3. **Hedging Strategies:**
   - Delta-neutral portfolios
   - Delta-gamma-neutral portfolios using two options
   - Time discretization effects

4. **Profit and Loss:**
   - Unhedged vs. hedged positions
   - Delta-hedge P&L dynamics
   - Delta-gamma-hedge P&L dynamics

5. **Additional Greeks:**
   - Vega, volga, vanna, and rho
   - Stochastic volatility considerations
   - Higher-order hedging

```{important}
**Key Takeaways:**

- American options provide early exercise flexibility, valuable for dividend-paying stocks and puts
- The Greeks measure different dimensions of option risk
- Delta hedging eliminates first-order price risk but leaves gamma exposure
- Delta-gamma hedging using two options eliminates convexity risk
- Stochastic volatility introduces additional complexity and higher-order Greeks
- Perfect hedging requires multiple instruments and continuous rebalancing
```

---

## References

There are no specific references listed for this lecture. The material draws from standard option pricing theory and Andrew Papanicolaou's original draft.
