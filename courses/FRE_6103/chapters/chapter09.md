---
title: "Chapter 9: Derivative Pricing in the Static CAPM"
subtitle: "Deriving Black-Scholes from the Cash Flow Portfolio Model"
author: "David C. Shimko"
date: "2025"
---

# Chapter 9: Derivative Pricing in the Static CAPM

## Chapter Overview

In Chapter 8, we established the Cash Flow Portfolio Model (CFPM), which allows us to value risky cash flows based on their covariance with a market portfolio. However, traditional CFPM and CAPM rely on linear relationships (Beta). Financial derivatives, such as call and put options, have **nonlinear** payoffs (e.g., $\max(S-K, 0)$).

This chapter bridges the gap between the static, linear world of CAPM and the dynamic, nonlinear world of option pricing. We will not rely on the complex stochastic calculus (Ito's Lemma) or continuous trading assumptions (delta hedging) typically used to derive the Black-Scholes model. Instead, we will derive the Black-Scholes formula purely from **Risk-Neutral Valuation** principles within the CFPM framework.

By treating the derivative as a contract on the end-of-period value of a reference asset, we can calculate its "Risk-Neutral Expected Value" and discount it at the risk-free rate. This approach demystifies the famous formula by connecting it directly to the fundamental valuation equation $V_0 = \frac{CE}{1+r}$.

### Learning Objectives

By the end of this chapter, you will be able to:

1.  **Define** a financial derivative in the context of the CFPM as a function of the end-of-period value of a reference portfolio.
2.  **Derive** the risk-neutral expectation of a lognormally distributed asset price.
3.  **Evaluate** the integral of a call option payoff $\int \max(S-X, 0) f(S) dS$ using the properties of the lognormal density function.
4.  **Construct** the Black-Scholes formula by applying the risk-neutral substitution ($\mu \to r$) to the expected payoff.
5.  **Interpret** the terms $N(d_1)$ and $N(d_2)$ not just as probabilities, but as components of the expected value of a truncated lognormal distribution.
6.  **Contrast** the "Physical Measure" (Real World) valuation with the "Risk-Neutral Measure" valuation.

### Prerequisites

```{admonition} Prerequisites
:class: warning

Before studying this chapter, you should be familiar with:
- **Chapter 6:** Geometric Random Walk (GRW) and the Lognormal distribution properties ($E[e^X] = e^{\mu + 0.5\sigma^2}$).
- **Chapter 8:** The concept of Risk-Neutral Valuation (valuing assets using risk-free rates and risk-adjusted probabilities).
- **Calculus:** Integration by substitution and "Completing the Square" for Gaussian integrals.
- **Probability:** Standard Normal CDF $N(x)$ and PDF $n(x)$.
```


```

```

---

## Part 1: Derivatives in the CFPM Framework

### 1. Abstract Definition

In this chapter, a **Financial Derivative** $D$ is defined abstractly as a contract whose payoff is a function of the end-of-period value of a **Reference Portfolio** $R$.

* **$R$:** The Reference Portfolio (e.g., the S&P 500, a specific stock).
* **$CF_R$:** The random end-of-period cash flow/value of $R$.
* **$CF_D$:** The random end-of-period payoff of the derivative.

$$
CF_D = g(CF_R)
$$

where $g(\cdot)$ is potentially nonlinear.

### 2. Examples of Payoff Functions

1.  **Forward Contract:** Linear payoff.

$$
CF_D = a(CF_R - F)
$$

where $F$ is the forward price.

2.  **Power Derivative:** Nonlinear payoff.

$$
CF_D = a(CF_R)^b
$$

While rare, these are easy to value if $CF_R$ is lognormal (since powers of lognormals are lognormal).

3.  **European Call Option:** Piecewise linear (kinked) payoff.

$$
CF_D = \max(CF_R - X, 0)
$$

where $X$ is the strike price.

**The Valuation Goal:**
Find the present value $V_D$ of the derivative given the current price $V_R$ and the risk-free rate $r$.

---

## Part 2: The Lognormal Model for Asset Prices

To value the option, we must model the probability distribution of the reference asset $S_T$. We assume the stock follows a **Geometric Random Walk (GRW)**.

### 1. Review of GRW Dynamics

From Chapter 6, the stock price $S_T$ at time $T$ is:

$$

S_T = S_0 \exp\left( (\alpha - \frac{1}{2}\sigma^2)T + \sigma \sqrt{T} Z \right)

$$

Where:
* $S_0$: Current price.
* $\alpha$: Expected continuously compounded return (drift).
* $\sigma$: Volatility.
* $Z \sim N(0,1)$.

**Distribution:**
The logarithm of the price is normally distributed:

$$ \ln(S_T) \sim N\left( \ln(S_0) + (\alpha - 0.5\sigma^2)T, \, \sigma^2 T \right) $$

Let's define the parameters of this normal distribution for simplicity:
* Mean $\mu' = \ln(S_0) + (\alpha - 0.5\sigma^2)T$
* Standard Deviation $\sigma' = \sigma \sqrt{T}$

So $\ln(S_T) \sim N(\mu', \sigma'^2)$.

### 2. Expected Value of the Stock

Recall the expectation of a lognormal variable $Y = e^X$:

$$ E[Y] = e^{E[X] + \frac{1}{2}Var(X)} $$

$$ E[S_T] = \exp\left( \mu' + \frac{1}{2}\sigma'^2 \right) $$

$$ E[S_T] = \exp\left( \ln(S_0) + \alpha T - 0.5\sigma^2 T + 0.5\sigma^2 T \right) $$

$$ E[S_T] = S_0 e^{\alpha T} $$

We define $\mu = E[S_T]$ as the expected future price. Note the distinction: $\mu$ is the expected *price* (arithmetic mean), while $\alpha$ is the expected *return* (geometric drift). 

---

## Part 3: Analytic Derivation of the Call Option Value

We seek to calculate the expected payoff of a call option $E[C_T]$ under the physical measure, then convert it to the risk-neutral measure.

**Objective:** Calculate $E[\max(S_T - X, 0)]$.

### 1. Setting up the Integral

$$

E[C_T] = \int_{-\infty}^{\infty} \max(S_T(z) - X, 0) n(z) dz

$$

Where $n(z) = \frac{1}{\sqrt{2\pi}} e^{-z^2/2}$ is the standard normal PDF.
The payoff is non-zero only when $S_T > X$.
Let's find the threshold value of $z$ where $S_T = X$.

$$

S_0 e^{\mu' + \sigma' z} = X

$$

(Note: Here we assume $S_T = e^{\mu' + \sigma' Z}$ for simpler notation, recognizing $\mu'$ incorporates the drift terms).

Solving for the threshold $z^*$:

$$ \mu' + \sigma' z^* = \ln(X) $$

$$ z^* = \frac{\ln(X) - \mu'}{\sigma'} $$

Since $S_T$ increases with $z$, the option is in-the-money for $z > z^*$.
(Note: The text defines the integral limits differently, essentially integrating over $S$ or using a substitution that flips the sign. Let's follow the text's derivation path involving $\ln(S/X)$).

**The Integral Split:**

$$

E[C_T] = \int_{z^*}^{\infty} (S_T(z) - X) n(z) dz

$$

$$

E[C_T] = \underbrace{\int_{z^*}^{\infty} S_T(z) n(z) dz}_{Term 1} - \underbrace{X \int_{z^*}^{\infty} n(z) dz}_{Term 2}

$$

### 2. Evaluating Term 2 (The Cash Part)

Term 2 is simply $X$ times the probability that $z > z^*$.

$$ \int_{z^*}^{\infty} n(z) dz = P(Z > z^*) = P(Z < -z^*) = N(-z^*) $$

Let's define $d_2 = -z^*$.

$$ d_2 = \frac{\mu' - \ln(X)}{\sigma'} = \frac{\ln(S_0) + (\alpha - 0.5\sigma^2)T - \ln(X)}{\sigma \sqrt{T}} $$

$$ d_2 = \frac{\ln(S_0/X) + (\alpha - 0.5\sigma^2)T}{\sigma \sqrt{T}} $$

So Term 2 is **$X N(d_2)$**. 

### 3. Evaluating Term 1 (The Asset Part)

Term 1 is the expected value of the stock *conditional* on it being above the strike, weighted by the probability.

$$

I_1 = \int_{z^*}^{\infty} S_0 e^{\mu' + \sigma' z} \frac{1}{\sqrt{2\pi}} e^{-z^2/2} dz

$$

Combine the exponents:

$$ \text{Exponent} = \mu' + \sigma' z - \frac{z^2}{2} = -\frac{1}{2} (z^2 - 2\sigma' z - 2\mu') $$

**Completing the Square:**
We want to form $-(z - \sigma')^2 / 2$.

$$ z^2 - 2\sigma' z = (z - \sigma')^2 - \sigma'^2 $$

So the exponent becomes:

$$ -\frac{1}{2} \left( (z - \sigma')^2 - \sigma'^2 - 2\mu' \right) = -\frac{(z-\sigma')^2}{2} + \frac{\sigma'^2}{2} + \mu' $$

Substitute back into the integral:

$$ I_1 = S_0 e^{\mu' + \sigma'^2/2} \int_{z^*}^{\infty} \frac{1}{\sqrt{2\pi}} e^{-(z-\sigma')^2/2} dz $$

Recall that $E[S_T] = S_0 e^{\mu' + \sigma'^2/2} = \mu_{stock}$.
The integral is the probability that a variable $Y \sim N(\sigma', 1)$ is greater than $z^*$.
Let $u = z - \sigma'$. The limit changes to $z^* - \sigma'$.

$$ \text{Integral} = \int_{z^* - \sigma'}^{\infty} n(u) du = N(-(z^* - \sigma')) = N(\sigma' - z^*) $$

Let $d_1 = \sigma' - z^* = \sigma' + d_2$.

$$ d_1 = \sigma \sqrt{T} + \frac{\ln(S_0/X) + (\alpha - 0.5\sigma^2)T}{\sigma \sqrt{T}} $$

$$ d_1 = \frac{\sigma^2 T + \ln(S_0/X) + \alpha T - 0.5\sigma^2 T}{\sigma \sqrt{T}} $$

$$ d_1 = \frac{\ln(S_0/X) + (\alpha + 0.5\sigma^2)T}{\sigma \sqrt{T}} $$

So Term 1 is **$\mu_{stock} N(d_1)$**. 

### 4. The Physical Measure Formula

Putting it all together, the expected payoff of the call under the physical (real-world) measure is:

$$

E[C_T] = E[S_T] N(d_1(\alpha)) - X N(d_2(\alpha))

$$

Where $d_1, d_2$ depend on the real drift $\alpha$.

---

## Part 4: The Risk-Neutral Substitution

We have the expected future value. To get the present value $V_0$, the CFPM tells us we can use **Risk-Neutral Valuation**.

### 1. The Principle

Instead of discounting the real expected payoff at a risky rate (which is hard to determine for options), we:
1.  Replace the risky drift $\alpha$ with the risk-free rate $r$ (continuous).
2.  Discount the resulting "risk-neutral expected payoff" at the risk-free rate $r$.

**Substitution:**
* Real Drift $\alpha \to r$.
* Expected Stock Price $E[S_T] = S_0 e^{\alpha T} \to F = S_0 e^{rT}$ (Forward Price).

### 2. Calculating Risk-Neutral Parameters

Substitute $\alpha = r$ into the $d_1, d_2$ formulas:

$$

d_1 = \frac{\ln(S_0/X) + (r + 0.5\sigma^2)T}{\sigma \sqrt{T}}

$$

$$

d_2 = d_1 - \sigma \sqrt{T} = \frac{\ln(S_0/X) + (r - 0.5\sigma^2)T}{\sigma \sqrt{T}}

$$

### 3. The Black-Scholes Formula

The value of the call is the discounted risk-neutral expectation:

$$

C_0 = e^{-rT} \left[ (S_0 e^{rT}) N(d_1) - X N(d_2) \right]

$$

Distributing the discount factor $e^{-rT}$:
* Term 1: $e^{-rT} S_0 e^{rT} N(d_1) = S_0 N(d_1)$.
* Term 2: $e^{-rT} X N(d_2) = X e^{-rT} N(d_2)$.

**Final Result:**

$$

C_0 = S_0 N(d_1) - X e^{-rT} N(d_2)

$$



**Interpretation:**
* **$N(d_2)$**: The risk-neutral probability that the option finishes in-the-money ($S_T > X$).
* **$X e^{-rT} N(d_2)$**: The present value of the strike payment, weighted by the probability of paying it.
* **$N(d_1)$**: The "Delta" of the option. It represents the number of shares of stock to hold to replicate the option.
* **$S_0 N(d_1)$**: The value of the asset component of the replication strategy.

---

## Part 5: Worked Examples

```{admonition} Example 1: Calculating $d_1$ and $d_2$
:class: tip

**Problem:** Calculate the Black-Scholes parameters.
* Stock Price $S_0 = 100$.
* Strike Price $X = 100$.
* Risk-free rate $r = 5\%$.
* Volatility $\sigma = 20\%$.
* Time $T = 1$ year.

**Step 1: Calculate $d_1$**

$$ d_1 = \frac{\ln(100/100) + (0.05 + 0.5(0.04))1}{0.2 \sqrt{1}} $$

$$ d_1 = \frac{0 + 0.05 + 0.02}{0.2} = \frac{0.07}{0.2} = 0.35 $$

**Step 2: Calculate $d_2$**

$$ d_2 = d_1 - \sigma \sqrt{T} = 0.35 - 0.20 = 0.15 $$

**Step 3: Look up Probabilities**
From standard normal tables:
$N(0.35) \approx 0.6368$.
$N(0.15) \approx 0.5596$.

```

---

```{admonition} Example 2: Pricing the Call
:class: tip

**Problem:** Using the values from Example 1, find the Call Price.

**Formula:**

$$ C_0 = S_0 N(d_1) - X e^{-rT} N(d_2) $$

**Calculation:**

$$ C_0 = 100(0.6368) - 100 e^{-0.05}(0.5596) $$

$$ C_0 = 63.68 - 100(0.9512)(0.5596) $$

$$ C_0 = 63.68 - 53.23 = 10.45 $$

**Answer:** The call option is worth **\$10.45**.

**Physical Interpretation:**
To replicate this option, you would buy 0.6368 shares of stock (costing \$63.68) and borrow \$53.23. The net cost is \$10.45.

```

---

```{admonition} Example 3: The Probability of Exercise
:class: tip

**Problem:** What is the real-world probability that the option in Example 1 will be exercised if the stock's actual expected return is $\alpha = 15\%$?

**Analysis:**
The Black-Scholes formula uses $N(d_2)$ with $r=5\%$ for *pricing*.
To find the *actual* probability, we must recalculate $d_2$ using $\alpha = 15\%$.

**Calculation:**

$$ d_2^{real} = \frac{\ln(100/100) + (0.15 - 0.5(0.04))1}{0.2} $$

$$ d_2^{real} = \frac{0.15 - 0.02}{0.2} = \frac{0.13}{0.2} = 0.65 $$

**Probability:**

$$ P(S_T > X) = N(d_2^{real}) = N(0.65) \approx 0.7422 $$

**Insight:**
The market prices the option as if the probability of exercise is 56% ($N(d_2)$ with $r$), but the real probability (if you believe $\alpha=15\%$) is 74%. The difference reflects the risk premium.

```

---

## Part 6: Practice Problems

```{admonition} Practice Problem 1: Put-Call Parity
:class: tip

**Problem:** Using the call price from Example 2 (\$10.45), calculate the price of a European Put with the same parameters.

**Hint:** Put-Call Parity states $C - P = S - X e^{-rT}$.

<details>
<summary><strong>Click for Solution</strong></summary>

$$ P = C - S + X e^{-rT} $$

$$ P = 10.45 - 100 + 100 e^{-0.05} $$

$$ P = 10.45 - 100 + 95.12 $$

$$ P = 10.45 - 4.88 = 5.57 $$

**Put Price: \$5.57**

</details>
```

```{admonition} Practice Problem 2: Intrinsic vs. Time Value
:class: tip

**Problem:** An option has $S=110, X=100, C=15$. What is the Intrinsic Value and Time Value?

<details>
<summary><strong>Click for Solution</strong></summary>

**Intrinsic Value:** The value if exercised today.

$$ IV = \max(S-X, 0) = \max(110-100, 0) = 10 $$

**Time Value:** The premium paid for future volatility.

$$ TV = \text{Price} - \text{Intrinsic} = 15 - 10 = 5 $$

</details>
```

```{admonition} Practice Problem 3: Volatility Impact
:class: tip

**Problem:** If volatility $\sigma$ increases, what happens to $d_1$ and the Call Price? Analyze the limits as $\sigma \to \infty$.

<details>
<summary><strong>Click for Solution</strong></summary>

As $\sigma \to \infty$:
1.  $d_1 \approx \frac{0.5\sigma^2 T}{\sigma \sqrt{T}} = 0.5\sigma\sqrt{T} \to \infty$.
    So $N(d_1) \to 1$.
2.  $d_2 = d_1 - \sigma\sqrt{T} \approx -0.5\sigma\sqrt{T} \to -\infty$.
    So $N(d_2) \to 0$.

**Limit Price:**

$$ C \to S_0(1) - X e^{-rT}(0) = S_0 $$

**Interpretation:** If volatility is infinite, the upside is unlimited, but the downside is capped at 0 (limited liability). The option becomes as valuable as the stock itself because you are almost guaranteed to be deep in the money (or the probability weight of the strike payment vanishes relative to the massive upside tail).

</details>
```

---

## Part 7: Chapter Summary

### Key Concepts Recap
:class: important

**1. Derivatives are Contingent Claims:**
A derivative is just a function $g(S_T)$. Its value is the risk-neutral expectation of this function discounted at the risk-free rate.

**2. The Lognormal Assumption:**
Stock prices cannot be negative. The Geometric Random Walk leads to a lognormal distribution for prices, which requires us to handle the "convexity adjustment" ($\mu = \ln S + \alpha T - 0.5\sigma^2 T$) carefully.

**3. Risk-Neutral Valuation:**
We do not need to know the stock's beta or the market risk premium to price an option. We simply replace the unknown drift $\alpha$ with the known risk-free rate $r$. This works because the option can be perfectly hedged (in theory).

**4. The Black-Scholes Formula Components:**
* $S N(d_1)$: The value of the stock component (Asset).
* $X e^{-rT} N(d_2)$: The value of the cash component (Liability).
* The formula essentially says: "The option is equivalent to owning Delta shares of stock and borrowing money."

### Formula Cheat Sheet

| Concept | Formula |
| :--- | :--- |
| **Risk-Neutral Drift** | $\mu_{rn} = r$ |
| **d1** | $\frac{\ln(S/X) + (r + 0.5\sigma^2)T}{\sigma \sqrt{T}}$ |
| **d2** | $d_1 - \sigma \sqrt{T}$ |
| **Call Price** | $S N(d_1) - X e^{-rT} N(d_2)$ |
| **Put Price** | $X e^{-rT} N(-d_2) - S N(-d_1)$ |
| **Put-Call Parity** | $C - P = S - X e^{-rT}$ |

