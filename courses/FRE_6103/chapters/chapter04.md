---
title: "Chapter 4: Bonds"
subtitle: "Government, Municipal, and Corporate Valuation Models"
author: "David C. Shimko"
date: "2025"
---

# Chapter 4: Bonds

## Chapter Overview

In financial engineering, bonds are not merely fixed-income instruments to be held for interest; they are rich sources of market data. While a theoretical model can tell you what a bond *should* be worth, the market price tells you what it *is* worth. The discrepancy between the two often reveals hidden parameters of the economy.

In this chapter, we reverse the valuation process. Instead of just calculating prices from known inputs, we will use observed bond prices to infer critical unknown parameters:
* **Inflation Expectations:** Derived from Treasury Inflation-Protected Securities (TIPS).
* **Implied Tax Rates:** Derived from the spread between Municipal and Treasury bonds.
* **Default Probabilities:** Derived from the spread between Corporate and Treasury bonds.
* **Risk Premiums:** Derived from the residual yield after accounting for default losses.

We will progress from "Risk-Free" US Government debt (T-Bills, Notes, Bonds) to tax-advantaged Municipal bonds, and finally to Corporate bonds where we must model the stochastic nature of default.

### Learning Objectives

By the end of this chapter, you will be able to:

1.  **Navigate** the complex quoting conventions of T-Bills (Discount Yield) versus Notes/Bonds (Yield to Maturity) and convert between them.
2.  **Construct** a Zero Coupon Bond (ZCB) yield curve via "bootstrapping" using both STRIPS and coupon-bearing instruments.
3.  **Analyze** TIPS cash flows to distinguish between nominal and real yields and calculate the market's break-even inflation rate.
4.  **Evaluate** Municipal bonds to calculate the "implied tax rate" perceived by the market.
5.  **Model** Corporate Bond valuation using two distinct methods:
    * The **Approximate Method** (Credit Spreads).
    * The **Exact Method** (Probabilistic valuation using the Geometric distribution of default times).
6.  **Derive** the risk-adjusted discount rates required to decompose a defaultable bond into "guaranteed" and "risky" annuity components.

### Prerequisites

```{admonition} Prerequisites
:class: warning

Before studying this chapter, you should be familiar with:
- **Chapter 3 Concepts:** Continuous compounding ($\delta = \ln(1+r)$), spot vs. forward rates, and the Fisher Equation ($r \approx \rho + i$).
- **Probability Theory:** Understanding of the **Geometric Distribution** (probability of $k$ failures before first success) is crucial for the exact default model.
- **Annuities:** Proficiency with annuity summation formulas from Chapter 2.
- **Calculus:** Basic limits and derivatives for sensitivity analysis.
```

---

## Part 1: US Government Debt ("Risk-Free")

[cite_start]The US Government debt market is the bedrock of global finance, valued at over \$30 trillion[cite: 202]. [cite_start]While theoretically "risk-free" due to the government's ability to print money, political risks (debt ceilings) do exist [cite: 203-204]. However, for valuation purposes, we treat these as the baseline for zero default risk.

### 1. Treasury Bills (T-Bills)

T-Bills are zero-coupon instruments with maturities of one year or less. Their valuation is complicated by an archaic quoting convention known as the **Bank Discount Basis**.

#### The Bank Discount Yield ($d$)

T-Bills are quoted in terms of a discount rate $d$, not an interest rate $r$.
* **Basis:** 360-day year.
* **Concept:** Interest is calculated as a discount from the Face Value ($F$), not an addition to the Price ($P$).

**Formula for Price:**

$$
P = F \left[ 1 - d \left( \frac{n}{360} \right) \right]
$$

Where:
* $P$ = Price
* $F$ = Face Value (usually \$10,000 for calculations)
* $d$ = Quoted Ask Yield (decimal)
* $n$ = Days to maturity

**Intuition:**
If you borrow \$10,000 at a discount rate $d$, the lender gives you less than \$10,000 today, but you pay back exactly \$10,000. [cite_start]The "interest" is pre-paid (deducted) at the start[cite: 210].

#### Converting Yields

Financial engineers cannot use the 360-day discount yield $d$ for modeling. We need the **True Yields**.

**1. Continuously Compounded Yield ($r_{cc}$):**
This is the fundamental rate used in derivation.

$$
P = F e^{-r_{cc} \left( \frac{n}{365} \right)}
$$

Solving for $r_{cc}$:

$$
r_{cc} = - \frac{365}{n} \ln\left( \frac{P}{F} \right)
$$

[cite_start][cite: 213]

**2. Effective Annual Yield (EAY):**
The annualized compound return over a 365-day year.

$$
P (1 + \text{EAY})^{n/365} = F
$$

$$
\text{EAY} = \left( \frac{F}{P} \right)^{365/n} - 1
$$

**3. Investment Yield / Bond Equivalent Yield (BEY):**
This converts the T-Bill return to a format comparable with coupon bonds (simple interest, 365-day year). Also called the "Asked Yield" in quotes.

$$
\text{BEY} = \frac{F - P}{P} \times \frac{365}{n}
$$

[cite_start][cite: 214]

---

### 2. Treasury Notes and Bonds

These are coupon-bearing instruments.
* **Notes:** 2, 3, 5, 7, 10 year maturities.
* **Bonds:** 20, 30 year maturities.

**Conventions:**
* **Coupons:** Paid Semi-Annually.
* **Compounding:** Semi-Annual.
* **Yield to Maturity (YTM):** Quoted as an Annual Percentage Rate (APR) based on semi-annual compounding.

**Valuation Formula:**

$$
P = \sum_{t=1}^{2N} \frac{C/2}{(1 + y/2)^t} + \frac{F}{(1 + y/2)^{2N}}
$$

Where:
* $y$ = Quoted YTM (BEY).
* $C$ = Annual Coupon Amount.
* $N$ = Years to Maturity.

[cite_start][cite: 218, 222]


---

### 3. STRIPS (Zero Coupon Curve)

STRIPS (Separate Trading of Registered Interest and Principal of Securities) allow investors to trade individual coupons or principal payments as separate Zero Coupon Bonds (ZCBs).

**Why Important?**
STRIPS provide a direct market observation of the spot rate $r_t$ for any maturity $t$.
* Price quoted per \$100 face value.
* Valuation follows standard ZCB logic:

$$
P = \frac{100}{(1 + \text{EAY})^{n/365}}
$$

$$
r_{cc} = \ln(1 + \text{EAY})
$$

[cite_start][cite: 227-229]

---

## Part 2: Bootstrapping the Yield Curve

When STRIPS data is unavailable or illiquid, we must infer the ZCB yield curve from coupon-bearing bonds. This process is called **Bootstrapping**.

### The Algorithm

**Goal:** Find the continuous spot rate function $y(t)$ such that the model prices match market prices.

**Assumption:** The yield curve can be approximated by a flexible function (e.g., Nelson-Siegel or a polynomial spline).
The text suggests a polynomial function for the spot rate $y(t)$:

$$
y(t) = a_1 + a_2 t + a_3 t^2 + a_4 e^{-t} + \dots
$$

**Procedure:**
1.  **Collect Data:** Gather a set of liquid "on-the-run" Treasury coupon bonds.
    * Prices $P_i^{market}$.
    * Cash flows $CF_{i, t}$ (coupons and principal) at specific dates $t$.
2.  **Define Model Price:**
    The model price of Bond $i$ is the sum of its cash flows discounted by the spot rate function $y(t)$.

    $$
    P_i^{model} = \sum_{t} CF_{i, t} e^{-y(t) \cdot t}
    $$

3.  **Optimization (Least Squares):**
    Find the parameters $\{a_1, a_2, \dots\}$ that minimize the sum of squared errors between model and market prices.

    $$
    \min_{\{a_k\}} \sum_{i} \left( P_i^{market} - P_i^{model} \right)^2
    $$

[cite_start][cite: 234-235]

**Result:** A continuous ZCB yield curve that can value *any* risk-free cash flow, even those without a matching STRIP.

---

## Part 3: TIPS and Inflation

**TIPS (Treasury Inflation-Protected Securities)** allow us to infer the market's expected inflation rate.

### 1. Mechanics of TIPS

TIPS are distinct from nominal bonds in two ways:
1.  **Principal Adjustment:** The principal $F_t$ grows with the Consumer Price Index (CPI).
    $$ F_t = F_0 \times \frac{CPI_t}{CPI_0} $$
2.  **Coupon Indexation:** The coupon rate $c$ is fixed, but it is applied to the *adjusted* principal.
    $$ C_t = \frac{c}{2} \times F_t $$

**Deflation Floor:** At maturity, the investor receives $\max(F_0, F_T)$. [cite_start]This is an embedded option (a put on inflation) protecting the investor from deflation[cite: 244, 249].

### 2. Tax Complications

Inflation adjustments are not free. The IRS taxes the increase in principal ($F_t - F_{t-1}$) as current income, even though the investor receives no cash for it until maturity.
* **Phantom Income:** Investors must pay tax on money they haven't received yet.
* **State Tax:** TIPS are exempt from state and local taxes.

[cite_start][cite: 248, 250]

### 3. The Break-Even Inflation Rate

By comparing a nominal Treasury Bond and a TIPS bond of the same maturity, we can derive the **Break-Even Inflation Rate (BEI)**.

**Logic (Fisher Equation):**
* Nominal Yield ($y_{nom}$) includes real return + inflation expectations + risk premiums.
* TIPS Yield ($y_{real}$) includes real return + liquidity premium.

$$
y_{nom} \approx y_{real} + E[i] + \text{Inflation Risk Premium} - \text{Liquidity Premium}
$$

**Approximation:**

$$
E[i] \approx y_{nom} - y_{real}
$$

**Interpretation:**
[cite_start]If the 10-year Treasury yields 4.0% and the 10-year TIPS yields 2.5%, the market expects average inflation to be roughly $4.0 - 2.5 = 1.5\%$ over the next decade [cite: 252-255].

---

## Part 4: Municipal Bonds and Implied Tax Rates

Municipal Bonds ("Munis") are issued by state and local governments. Their primary feature is tax exemption.

### 1. Tax Arbitrage

* **Treasuries:** Taxable at Federal level. Exempt at State level.
* **Munis:** Exempt at Federal level. Usually exempt at State level (if issued in-state).

**The Equilibrium Condition:**
An investor should be indifferent between a taxable corporate/treasury bond and a tax-free muni if the after-tax yields are equal.

$$
r_{muni} = r_{taxable} (1 - \tau)
$$

Where $\tau$ is the marginal tax rate.

### 2. The Implied Tax Rate

We can rearrange this to find the tax rate implied by market prices. Note that Munis also carry default risk ($\pi\lambda$) and liquidity risk ($\kappa$).

**Refined Equation:**

$$
r_{muni} = r_{treasury}(1 - \tau) + \pi\lambda + \kappa
$$

**Solving for Implied $\tau$:**

$$
\tau = \frac{r_{treasury} - r_{muni} + \pi\lambda + \kappa}{r_{treasury}}
$$

[cite_start][cite: 274-275]

**Example:**
If 10-year Treasury yields 2.25% and 10-year AAA Muni yields 1.95% (with negligible default/risk premium):
$$ \tau = \frac{2.25\% - 1.95\%}{2.25\%} = 13.3\% $$
If the statutory tax rate is 35%, and the implied rate is only 13%, Munis look "expensive" (yields are too low), or perhaps the market is pricing in significant risk premiums elsewhere.

---

## Part 5: Corporate Bonds and Credit Risk

This section introduces the most complex mathematics in the chapter: valuing bonds subject to default.

### 1. Components of Credit Risk

A corporate yield $y$ is composed of:
1.  **Risk-Free Rate ($r$):** Time value of money.
2.  **Expected Loss ($EL = \pi\lambda$):** The statistical expectation of default loss.
    * $\pi$: Probability of Default (PD).
    * $\lambda$: Loss Given Default (LGD).
3.  **Risk Premium ($\kappa$ or $\theta$):** Compensation for the *uncertainty* of default (variance) and illiquidity.

$$
y \approx r + \pi\lambda + \kappa
$$

[cite_start][cite: 277, 288]


### 2. Valuation: The Exact Method

We assume the bond pays annual coupon $C$ and face value $F$ at year $n$.
Default can occur in any year $i = 1, \dots, n$.

**The Geometric Probability Model:**
Let $X$ be the random variable representing the year of default.
Assume a constant annual conditional default probability $\pi$.
The probability that default occurs exactly in year $i$ is:

$$
P(X=i) = (1-\pi)^{i-1} \pi
$$

The probability that the bond survives past year $n$ (no default) is:

$$
P(X > n) = (1-\pi)^n
$$

[cite_start][cite: 299]

**Conditional Cash Flows:**
* **If $X > i$ (Survival):** Investor receives full payment $C$.
* **If $X \le i$ (Default):** Investor receives recovery value $(1-\lambda)C$ (or $(1-\lambda)F$ at maturity) in the year of default, and nothing thereafter. *Note: The text assumes recovery applies to the scheduled payment.*

**Expected Present Value Calculation:**
The value $V_0$ is the probability-weighted average of the PVs for every possible default scenario.

$$
V_0 = \sum_{i=1}^n P(X=i) \times PV(\text{Cash flows given default at } i) + P(X>n) \times PV(\text{Full Survival})
$$

[cite_start][cite: 324]

### 3. The Analytic Decomposition (Growing Annuity)

Calculating the summation above is tedious. The text derives a powerful analytic shortcut by decomposing the cash flow into "Guaranteed" and "Risky" components.

**Concept:**
Any expected cash flow $E[CF_i]$ can be split:
$$ E[CF_i] = \underbrace{(1-\lambda)CF_i}_{\text{Guaranteed}} + \underbrace{\lambda CF_i P(\text{No Default by } i)}_{\text{Risky}} $$

* **Component A (Guaranteed):** The recovery portion $(1-\lambda)$ is received regardless of whether default occurs or not. It is effectively risk-free (regarding default occurrence, though the recovery *rate* is assumed constant).
* **Component B (Risky):** The potentially lost portion $\lambda$ is received only if the bond survives.

**Valuation Formula:**

$$
V_0 = (1-\lambda) \cdot A + \lambda \cdot B
$$

Where:
1.  **$A$**: The value of the promised cash flows discounted at the **risk-adjusted rate** corresponding to the risk premium $\theta$ but *no* default loss.
    $$ A = \text{Annuity}(C, n, y_A) + PV(F, n, y_A) $$
    $$ y_A \approx r + \theta $$

2.  **$B$**: The value of the promised cash flows discounted at a **higher rate** $r^*$ that accounts for the probability of survival.
    $$ B = \text{Annuity}(C, n, r^*) + PV(F, n, r^*) $$
    The discount factor for $B$ includes the survival probability $(1-\pi)$.
    $$ \frac{1}{1+r^*} = \frac{1-\pi}{1+r+\theta} $$
    Solving for $r^*$:
    $$ r^* \approx r + \theta + \pi $$

[cite_start][cite: 346-350]

**Physical Interpretation:**
* Part A is valued like a Treasury bond (plus a small liquidity premium $\theta$).
* Part B is valued like a risky bond where the "growth rate" of the probability of payment is negative ($g = -\pi$).

---

## Part 6: Worked Examples

### Example 1: T-Bill Valuation
:class: tip

**Problem:** A 146-day T-Bill has a quoted Ask Yield (Discount) of 0.985%. Face Value is \$10,000. Find the Price and the EAY.

**Given:**
* $F = 10,000$
* $d = 0.00985$
* $n = 146$

**Step 1: Calculate Price (Bank Discount)**
$$ P = 10,000 \left[ 1 - 0.00985 \left( \frac{146}{360} \right) \right] $$
$$ P = 10,000 [ 1 - 0.0039947 ] = 10,000(0.996005) = \$9,960.05 $$

**Step 2: Calculate EAY**
$$ 9,960.05 (1 + \text{EAY})^{146/365} = 10,000 $$
$$ (1 + \text{EAY})^{0.4} = \frac{10,000}{9,960.05} = 1.00401 $$
$$ 1 + \text{EAY} = (1.00401)^{1/0.4} = (1.00401)^{2.5} $$
$$ \text{EAY} \approx 1.01005 \implies 1.005\% $$

[cite_start][cite: 215-217]

### Example 2: Corporate Bond Valuation (Approximate)
:class: tip

**Problem:** A corporate bond yields 4.04%. A comparable Treasury yields 2.84%. The bond has an AA rating with an annual default probability of 0.02%. Assume Loss Given Default (LGD) is 100%. Calculate the implied Risk Premium.

**Given:**
* $y_{corp} = 4.04\%$
* $r_{riskfree} = 2.84\%$
* $\pi = 0.0002$
* $\lambda = 1.00$

**Step 1: Calculate Credit Spread**
$$ \text{Spread} = 4.04\% - 2.84\% = 1.20\% $$

**Step 2: Calculate Expected Loss (EL)**
$$ EL = \pi \lambda = 0.0002 \times 1.00 = 0.02\% $$

**Step 3: Isolate Risk Premium ($\kappa$)**
$$ \text{Spread} = EL + \kappa $$
$$ 1.20\% = 0.02\% + \kappa $$
$$ \kappa = 1.18\% $$

**Insight:** The vast majority of the spread (1.18% vs 0.02%) is due to risk aversion (the premium), not the actuarial expected loss. This is typical for high-grade bonds.

[cite_start][cite: 289]

### Example 3: Exact Default Valuation (The Geometric Model)
:class: tip

**Problem:**
* 5-year bond, annual coupon \$55, Face \$1000.
* $r = 4\%$.
* $\pi = 3\%$.
* $\lambda = 60\%$ (Recovery = 40%).
* Value the bond using the expected cash flow method.

**Step 1: Calculate Survival Probabilities**
* Prob(Survival Year 1) = $(1-0.03) = 0.97$
* Prob(Survival Year 2) = $(0.97)^2 = 0.9409$
...
* Prob(Survival Year 5) = $(0.97)^5 = 0.8587$

**Step 2: Calculate Expected Cash Flows ($E[CF_t]$)**
Formula: $E[CF_t] = \text{Promised } CF_t \times [ (1-\lambda)\pi + (1-\pi)(1) ]$?
Actually, the text derivation simplifies this:
$E[CF_t] = (1-\lambda)CF_t + \lambda CF_t (1-\pi)^t$.
* Guaranteed portion: $0.40 \times 55 = 22$.
* Risky portion: $0.60 \times 55 \times (0.97)^t = 33(0.97)^t$.

**Step 3: Discount Expected CFs at Risk-Free Rate (4%)**
* Year 1: $E[CF_1] = 22 + 33(0.97) = 54.01$. $PV = 54.01/1.04 = 51.93$.
* Year 2: $E[CF_2] = 22 + 33(0.97)^2 = 53.05$. $PV = 53.05/1.04^2 = 49.05$.
* ...
* Year 5: $E[CF_5] = 0.4(1055) + 0.6(1055)(0.97)^5$.
    $E[CF_5] = 422 + 633(0.8587) = 965.58$.
    $PV = 965.58/1.04^5 = 793.63$.

**Total Value:** Sum of PVs.

[cite_start][cite: 322, 328]

---

## Part 7: Practice Problems

### Practice Problem 1: Muni Tax Implication
:class: tip

**Problem:** A 20-year Treasury yields 2.91%. A 20-year Muni yields 2.02%. Assuming the Muni has an expected loss rate of 0.05% and no liquidity premium, what is the implied marginal tax rate?

**Given:**
* $r_{tsy} = 2.91\%$
* $r_{muni} = 2.02\%$
* $\pi\lambda = 0.05\%$
* $\kappa = 0$

**Formula:**
$$ r_{muni} = r_{tsy}(1-\tau) + \pi\lambda $$

<details>
<summary><strong>Click for Solution</strong></summary>

$$ 2.02\% = 2.91\%(1-\tau) + 0.05\% $$
$$ 1.97\% = 2.91\%(1-\tau) $$
$$ 1-\tau = \frac{1.97}{2.91} = 0.677 $$
$$ \tau = 1 - 0.677 = 0.323 $$
**Implied Tax Rate = 32.3%**
[cite_start][cite: 275]

</details>

### Practice Problem 2: T-Bill "d" vs "r"
:class: tip

**Problem:** A T-Bill has a discount yield $d=2.00\%$ and 90 days to maturity. Is the continuously compounded yield $r$ higher or lower than 2.00%? Calculate it.

<details>
<summary><strong>Click for Solution</strong></summary>

**Intuition:** The discount yield underestimates the true yield because (1) it divides by 360 instead of 365, and (2) it divides the interest by Face Value rather than Price (Price < Face). Both factors make the true yield higher.

**Calculation:**
$$ P = 10,000 [ 1 - 0.02(90/360) ] = 10,000 [ 1 - 0.005 ] = 9,950 $$
$$ 9,950 = 10,000 e^{-r(90/365)} $$
$$ 0.995 = e^{-0.2466 r} $$
$$ \ln(0.995) = -0.2466 r $$
$$ -0.00501 = -0.2466 r $$
$$ r = 0.0203 \implies 2.03\% $$
**Result:** Higher, as expected.

</details>

### Practice Problem 3: Decomposition
:class: tip

**Problem:** Value a 1-year corporate ZCB with Face \$100. Risk-free rate 5%. Default prob 2%. Recovery 40% ($\lambda=60\%$). No risk premium ($\theta=0$). Use the $A$ and $B$ decomposition method.

<details>
<summary><strong>Click for Solution</strong></summary>

**Parameters:**
* $r = 0.05$
* $\pi = 0.02$
* $\lambda = 0.6$
* $\theta = 0$

**Component A (Guaranteed):**
Valued at rate $y_A \approx r = 5\%$.
$$ A = \frac{100}{1.05} = 95.238 $$

**Component B (Risky):**
Valued at rate $r^* \approx r + \pi = 7\%$.
$$ B = \frac{100}{1.07} = 93.458 $$

**Total Value:**
$$ V = (1-\lambda)A + \lambda B $$
$$ V = 0.40(95.238) + 0.60(93.458) $$
$$ V = 38.095 + 56.075 = 94.17 $$

**Check via Expected Cash Flow:**
$E[CF] = 0.98(100) + 0.02(40) = 98 + 0.8 = 98.8$.
$PV = 98.8 / 1.05 = 94.095$.
(Difference due to $r^*$ approximation $1+r+\pi \approx (1+r)(1+\pi)^{-1}$).

</details>

---

## Part 8: Chapter Summary

### Key Concepts Recap
:class: important

**1. Market Prices as Information:**
We do not just value bonds; we interrogate them. A TIPS price reveals inflation expectations. A Muni price reveals tax brackets. A Corporate price reveals default fears.

**2. Yield Conventions Matter:**
A T-Bill quoting 2.00% is not paying 2.00% interest. It is paying a discount based on a 360-day year. Always convert to **Effective Annual Yield (EAY)** or **Continuous Yield ($r$)** before comparing or modeling.

**3. Bootstrapping:**
To value cash flows occurring at arbitrary times, we must construct a continuous spot rate curve $y(t)$. This is done by stripping coupons from bonds conceptually and solving for the zero-coupon rates that justify current market prices.

**4. Credit Risk Decomposition:**
A defaultable bond is mathematically equivalent to a portfolio of:
* A **Risk-Free Bond** paying the recovery value.
* A **Risky Bond** paying the potential loss, which behaves like an annuity with a negative growth rate (the survival probability decays geometrically).

**5. The Exact Valuation Formula:**
$$ V = \sum_{i} PV(\text{Guaranteed CF}) + \sum_{i} PV(\text{Risky CF} | \text{Survival}) $$
By splitting the cash flows into $(1-\lambda)$ (Guaranteed) and $\lambda$ (Risky), we simplify the valuation of complex corporate debt structures.

### Formula Cheat Sheet

| Concept | Formula |
| :--- | :--- |
| **T-Bill Price** | $P = F [1 - d(n/360)]$ |
| **T-Bill BEY** | $\frac{F-P}{P} \times \frac{365}{n}$ |
| **Bootstrapping** | $P_{model} = \sum CF_t e^{-y(t) \cdot t}$ |
| **Implied Tax Rate** | $\tau = \frac{r_{tsy} - r_{muni} + EL}{r_{tsy}}$ |
| **Corporate Yield** | $y \approx r + \pi\lambda + \kappa$ |
| **Default Valuation** | $V = (1-\lambda)A(r+\theta) + \lambda B(r+\theta+\pi)$ |

