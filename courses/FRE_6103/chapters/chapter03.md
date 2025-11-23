---
title: "Chapter 3: Complications and Resolutions"
subtitle: "Advanced Valuation Techniques for Real-World Financial Instruments"
author: "David C. Shimko"
date: "2025"
---

# Chapter 3: Complications and Resolutions

## Chapter Overview

In previous chapters, we operated in a simplified world: payments occurred annually, interest rates were constant, and cash flows were risk-free. Chapter 3 strips away these simplifications to address the messy reality of financial markets.

This chapter introduces the critical adjustments required for:
1.  **Frequency Mismatches:** When payments (e.g., monthly) differ from quoted rates (e.g., annual).
2.  **Compounding Regimes:** From discrete compounding to continuous "force of interest."
3.  **Inflation:** The erosion of purchasing power and the distinction between nominal and real rates.
4.  **Taxation:** How varying tax treatments for income versus capital gains alter valuation.
5.  **Variable Interest Rates:** Spot rates, forward rates, and the bootstrapping of yield curves.
6.  **Currency Risk:** Valuing foreign cash flows using Interest Rate Parity (IRP).
7.  **Event Risk:** Modeling probabilistic cash flows like default, death, or accidents.

These "complications" are not mere edge cases; they represent the standard operating environment for a financial engineer.

### Learning Objectives

By the end of this chapter, you will be able to:

1.  **Convert** interest rates between any compounding frequency, including calculating Effective Annual Rates (EAR) and continuous Force of Interest ($\delta$).
2.  **Derive** the relationship between nominal rates, real rates, and inflation using the Fisher Equation.
3.  **Value** assets with varying tax treatments by solving for the effective tax rate and after-tax yield.
4.  **Construct** a Zero Coupon Bond (ZCB) yield curve from coupon-bearing bonds using the "bootstrapping" method.
5.  **Calculate** implied forward interest rates from spot rates and explain the "no arbitrage" condition.
6.  **Apply** Interest Rate Parity (IRP) to price forward currency contracts and value foreign cash flows.
7.  **Integrate** event risk (probability of default or death) into the General Valuation Equation (GVE) to price insurance and defaultable bonds.

### Prerequisites

```{admonition} Prerequisites
:class: warning

Before studying this chapter, you should be familiar with:
- **Chapter 1 & 2:** The General Valuation Equation (GVE) and basic annuity formulas.
- **Logarithms and Exponentials:** Properties of $\ln(x)$ and $e^x$ for continuous compounding.
- **Probability Theory:** Expected Value $E[x]$ for discrete random variables (e.g., default/no default).
- **Calculus:** Basic limits (L'Hopital's Rule) to derive continuous compounding formulas.
```

---

## Part 1: Frequency and Compounding

Real-world debt instruments rarely pay annually. Consumer loans pay monthly; corporate bonds often pay quarterly; US Government bonds pay semi-annually. We must reconcile these frequencies with standard annual rate quotes.

### 1. Simple Annual Rate (SAR) vs. Effective Annual Rate (EAR)

**Definitions:**
* **Simple Annual Rate (SAR):** The quoted annual rate. It ignores compounding within the year. Also called the Annual Percentage Rate (APR).
* **Periodic Rate:** The rate actually applied to the balance each period.

    $$
    \text{Periodic Rate} = \frac{\text{SAR}}{m}
    $$

    where $m$ is the number of compounding periods per year.
* **Effective Annual Rate (EAR):** The rate you actually earn if you hold the asset for one year, accounting for interest-on-interest.

**Fundamental Relationship:**
The accumulation of \$1 over one year with $m$ periods must equal the accumulation at the EAR.

$$

1 + \text{EAR} = \left( 1 + \frac{\text{SAR}}{m} \right)^m

$$

**Formulas:**
To find EAR given SAR:

$$

\text{EAR} = \left( 1 + \frac{\text{SAR}}{m} \right)^m - 1

$$

To find SAR given EAR:

$$

\text{SAR} = m \left[ (1 + \text{EAR})^{1/m} - 1 \right]

$$



### 2. Continuous Compounding (The Limit as $m \to \infty$)

As we increase the frequency $m$ (monthly $\to$ daily $\to$ hourly), the EAR increases, but it converges to a limit.

**Derivation:**
We want to find $\lim_{m \to \infty} \left( 1 + \frac{r}{m} \right)^m$.
Let $L = \lim_{m \to \infty} \left( 1 + \frac{r}{m} \right)^m$.
Take the natural log:

$$

\ln(L) = \lim_{m \to \infty} m \ln\left( 1 + \frac{r}{m} \right) = \lim_{m \to \infty} \frac{\ln(1 + r/m)}{1/m}

$$

This is a $0/0$ indeterminate form. Apply L'Hopital's Rule (differentiate with respect to $m$):

$$

\ln(L) = \lim_{m \to \infty} \frac{\frac{1}{1+r/m} \cdot (-r/m^2)}{-1/m^2} = \lim_{m \to \infty} \frac{r}{1+r/m} = r

$$

So $\ln(L) = r \implies L = e^r$.

**Result:**

$$

1 + \text{EAR} = e^{\text{SAR}_{continuous}}

$$

**Terminology:**
The continuously compounded rate is often symbolized by $\delta$ (delta) and called the **Force of Interest**.

$$

\delta = \ln(1 + \text{EAR})

$$

**Discount Factors:**
* **Discrete ($t$ years):** $v_t = \frac{1}{(1+r)^t}$
* **Continuous ($t$ years):** $v_t = e^{-\delta t}$ 

### 3. Frequency Mismatch Strategy

**Problem:** You have a loan with monthly payments, but the rate is quoted as "8% Simple Annual."
**Common Mistake:** Using the annual formula with $r=8\%$ and dividing the final answer.
**Correct Strategy:**
1.  Find the discount rate **for the payment frequency**.
    * If payments are monthly, use $r_{monthly} = 8\% / 12$.
2.  If the rate is quoted as an EAR, convert it to the periodic rate first.
    * $r_{monthly} = (1 + \text{EAR})^{1/12} - 1$.
3.  Discount the cash flows using this periodic rate.



---

## Part 2: Inflation and Purchasing Power

Inflation erodes the value of money. We must distinguish between the number of dollars (Nominal) and the purchasing power of those dollars (Real).

### 1. Definitions

* **Nominal Dollars:** The face value of currency.
* **Real Dollars:** Purchasing power relative to a base year.
* **CPI (Consumer Price Index):** A standardized basket of goods used to measure price levels.

$$
\text{Inflation Rate (i)} = \frac{\text{CPI}_{new}}{\text{CPI}_{old}} - 1
$$

### 2. The Fisher Equation

The relationship between Nominal Rate ($r$), Real Rate ($\rho$), and Inflation Rate ($i$) is given by the **Fisher Equation**:

$$

(1 + r) = (1 + \rho)(1 + i)

$$

**Implication:**
You earn the nominal rate $r$. Part of that pays for the higher cost of goods ($i$), and the rest is your real increase in wealth ($\rho$).

**Approximation:**

$$

r \approx \rho + i

$$

**Exact (Continuous):**
For continuous rates, the approximation becomes an exact equality:

$$

e^r = e^{\rho} e^i \implies r = \rho + i

$$



### 3. Valuation Rule of Thumb

To avoid errors, follow this strict rule:
* **Nominal Cash Flows** must be discounted at **Nominal Rates**.
* **Real Cash Flows** must be discounted at **Real Rates**.

**Example: COLA (Cost of Living Adjustment)**
A contract pays \$100,000 adjusted for inflation ($C_1 = C_0(1+i)$).
* **Method A (Nominal):** Project the inflated cash flows ($100k(1.02), 100k(1.02)^2...$) and discount at the nominal rate $r$. This is a Growing Annuity.
* **Method B (Real):** Recognize that the *Real* cash flow is constant (\$100k). Discount this flat annuity at the Real Rate $\rho$.

Both methods yield the exact same Present Value.

---

## Part 3: Taxation

Taxes complicate valuation because different components of return (Ordinary Income vs. Capital Gains) are often taxed at different rates.

### 1. Tax Regimes

* **Ordinary Income (OI):** Interest payments, coupons, wages. Tax rate $\tau_{OI}$.
* **Capital Gains (CG):** Profit from price appreciation ($P_{sell} - P_{buy}$). Tax rate $\tau_{CG}$.

### 2. After-Tax Valuation

If $\tau_{OI} = \tau_{CG} = \tau$, valuation is simple:

$$
r_{after-tax} = r_{pre-tax} (1 - \tau)
$$

Simply discount after-tax cash flows at the after-tax rate. The GVE remains unchanged because both sides are multiplied by $(1-\tau)$.

**The Problem: Differential Taxes**
If $\tau_{OI} \neq \tau_{CG}$, we cannot simply adjust the discount rate.
**The GVE Adjustment:**

$$

r_{AT} V_0 = (1 - \tau_{CG}) E[V_1 - V_0] + (1 - \tau_{OI}) E[C_1]

$$

This implies an **Effective Tax Rate ($\tau_e$)** for the entire instrument, which depends on the mix of income vs. gains.

**Procedure for Valuation:**
1.  Compute the Pre-tax Value $V_0$ using pre-tax cash flows and rates.
2.  Calculate the After-tax Cash Flows explicitly in a table.
    * Tax on CF = $CF \times \tau_{OI}$
    * Tax on CG = $(V_{end} - V_{start}) \times \tau_{CG}$
3.  Find the Internal Rate of Return (IRR) of these after-tax flows. This is the true after-tax yield.

---

## Part 4: Variable Interest Rates and Term Structure

Interest rates are not constant over time. The yield curve (Term Structure) tells us the spot rate for every maturity.

### 1. Spot Rates vs. Forward Rates

* **Spot Rate ($r_{st}$):** The rate earned on a Zero Coupon Bond (ZCB) maturing at time $t$. It is the average rate over the period $0$ to $t$.
* **Forward Rate ($f_{t,u}$):** The rate implied for a future period starting at $t$ and ending at $u$. It is the marginal rate.

**No Arbitrage Condition:**
Investing for 2 years must yield the same result as investing for 1 year and rolling over at the forward rate.

$$

(1 + r_{s2})^2 = (1 + r_{s1})(1 + f_{1,2})

$$



**General Formula:**

$$

(1 + r_{sn})^n = (1 + r_{s1})(1 + f_{1,2})(1 + f_{2,3})\dots(1 + f_{n-1,n})

$$

This implies that the Spot Rate is the **geometric average** of the Forward Rates.

### 2. Bootstrapping the Yield Curve

We often cannot observe spot rates directly for all maturities (only coupons). We must "strip" them.

**The Algorithm:**
1.  **Year 1:** Observe a 1-year ZCB (or coupon bond nearing maturity). Its yield is the 1-year spot rate $r_{s1}$.
2.  **Year 2:** Observe a 2-year Coupon Bond with price $P$.
    * It pays Coupon $C$ at Year 1. Discount this using known $r_{s1}$.
    * It pays $C+F$ at Year 2.
    * Solve for $r_{s2}$:

        $$
        P = \frac{C}{(1+r_{s1})} + \frac{C+F}{(1+r_{s2})^2}
        $$

3.  **Recursion:** Use $r_{s1}, r_{s2}$ to find $r_{s3}$ from a 3-year bond, and so on.

### 3. Valuing Floating Rate Notes (FRN)

An FRN pays a coupon linked to the future spot rate ($r_t$).
**Value at Reset Date:**
An FRN is unique: at every reset date, its value resets to Par ($F$).

**Proof via GVE:**
At time 0, the bond promises to pay $r_0 F$ (known) at time 1, plus the value of the bond at time 1 ($V_1$).

$$
r_0 V_0 = E[V_1 - V_0] + r_0 F
$$

If the bond resets to Par at time 1 ($V_1 = F$), then:

$$
r_0 V_0 = (F - V_0) + r_0 F
$$

$$
V_0 (1+r_0) = F(1+r_0) \implies V_0 = F
$$

**Implication:** The value of a pure FRN is always Par immediately after a coupon payment.

---

## Part 5: Currency and Exchange Rates

Valuing foreign assets involves two sources of risk: the asset's performance and the exchange rate.

### 1. Definitions

* **Spot Exchange Rate ($X$):** Price of foreign currency today.
    * *Direct Quote:* Domestic per Foreign (e.g., \$1.30/€).
    * *Indirect Quote:* Foreign per Domestic (e.g., ¥100/\$).
* **Forward Exchange Rate ($F$):** The locked-in price for future delivery.

### 2. Interest Rate Parity (IRP)

IRP relates Spot Rates, Forward Rates, and Interest Rates. It prevents risk-free arbitrage between currencies.

**The Logic:**
Two strategies must have the same return:
1.  **Domestic:** Invest \$1 at domestic rate $r_{dom}$.

    $$
    \text{Value} = (1 + r_{dom})
    $$

2.  **Foreign:** Convert \$1 to Foreign ($1/X$), invest at $r_{for}$, then convert back at locked Forward rate $F$.

    $$
    \text{Value} = \frac{1}{X} (1 + r_{for}) F
    $$

**The Equation:**

$$

(1 + r_{dom}) = \frac{F}{X} (1 + r_{for})

$$

Rearranging for the Forward Rate:

$$

F = X \frac{(1 + r_{dom})}{(1 + r_{for})}

$$



**Approximation:**

$$
\frac{F - X}{X} \approx r_{dom} - r_{for}
$$

The percentage premium of the forward rate equals the interest rate differential.

---

## Part 6: Event Risk and Default

Finally, we leave the world of "guaranteed" cash flows. We incorporate probabilities of events (Death, Default, Accident) into valuation.

### 1. The Probabilistic GVE

The GVE is robust enough to handle randomness.

$$
\text{Required Return} = E[\text{Capital Gain}] + E[\text{Cash Flow}]
$$

**Example: Life Insurance**
* Policy pays $C$ upon death.
* $\pi$ = Probability of death.
* $r$ = Risk-free rate.
* $V_0$ = Value of policy.

**Expected Cash Flow:**
* If Death (prob $\pi$): Pay $C$.
* If Survive (prob $1-\pi$): Pay $0$.
* $E[CF] = \pi C$.

**Expected Capital Gain:**
* If Death (prob $\pi$): Policy terminates ($V=0$). Loss is $-V_0$.
* If Survive (prob $1-\pi$): Policy continues. Value remains $V_0$. Gain is $0$.
* Wait! The text clarifies:
    If the insured *survives*, the value at time 1 is roughly the same as time 0 ($V_1 \approx V_0$).
    If the insured *dies*, the value is 0 (policy ends).
    $E[CG] = \pi(0 - V_0) + (1-\pi)(V_0 - V_0) = -\pi V_0$.

**GVE Solution:**

$$
r V_0 = -\pi V_0 + \pi C
$$

$$
V_0 (r + \pi) = \pi C
$$

$$
V_0 = \frac{\pi C}{r + \pi}
$$

This looks like a perpetuity $\frac{C}{r}$, but the discount rate is increased by the hazard rate $\pi$.

### 2. Default Risk on Bonds

* **$\pi$**: Probability of default.
* **$\lambda$**: Loss Given Default (LGD). (Recovery = $1-\lambda$).
* **$F$**: Face Value.

**Expected Payoff at Maturity:**

$$
E[\text{Payoff}] = (1-\pi)F + \pi(1-\lambda)F
$$

$$
E[\text{Payoff}] = F [1 - \pi\lambda]
$$

**Valuation:**

$$
V_0 = \frac{F (1 - \pi\lambda)}{1 + r}
$$

**Credit Spread Approximation:**
We can model this as a risk-free bond with a higher yield $y$.

$$
V_0 = \frac{F}{1 + y} \approx \frac{F (1 - \pi\lambda)}{1 + r}
$$

Implies:

$$
1 + y \approx \frac{1+r}{1-\pi\lambda} \approx (1+r)(1+\pi\lambda)
$$

$$
y \approx r + \pi\lambda
$$

**Credit Spread $\approx$ Expected Loss Rate ($\pi\lambda$)**.

---

## Part 7: Worked Examples

```{admonition} Example 1: Frequency Conversion
:class: tip

**Context:** Converting a quarterly compounded rate to a monthly compounded rate.

**Problem:** A bank quotes a Simple Annual Rate (SAR) of 8% compounded quarterly. What is the equivalent SAR compounded monthly?

**Given:**
* $SAR_{quarterly} = 0.08$
* $m_1 = 4$ (Quarterly)
* $m_2 = 12$ (Monthly)

**Step 1: Find the EAR**

$$
\text{EAR} = \left( 1 + \frac{0.08}{4} \right)^4 - 1 = (1.02)^4 - 1 = 1.082432 - 1 = 8.2432\%
$$

**Step 2: Convert EAR to Monthly SAR**

$$
\text{SAR}_{monthly} = 12 \left[ (1.082432)^{1/12} - 1 \right]
$$

$$
(1.082432)^{1/12} \approx 1.006622
$$

$$
\text{SAR}_{monthly} = 12 \times 0.006622 = 0.07947 = 7.947\%
$$

**Result:** The monthly compounded rate is slightly lower (7.95%) because it compounds more frequently to achieve the same yield.
```

---

```{admonition} Example 2: Continuous Compounding "Force of Interest"
:class: tip

**Problem:** An investment pays 3% simple interest per half-year. What is the equivalent continuously compounded annual rate ($\delta$)?

**Analysis:**
"3% simple interest per half-year" means the periodic rate is 3% every 6 months.
This corresponds to an EAR of $(1.03)^2 - 1 = 6.09\%$.

**Calculation:**

$$
\delta = \ln(1 + \text{EAR}) = \ln(1.0609)
$$

Alternatively, directly from the semi-annual accumulation:

$$
e^{\delta \times 0.5} = 1.03
$$

$$
0.5 \delta = \ln(1.03)
$$

$$
\delta = 2 \ln(1.03) \approx 2(0.02956) = 5.91\%
$$
```

---

```{admonition} Example 3: Interest Rate Parity
:class: tip

**Problem:**
* Spot Exchange Rate ($X$): \$1.30 USD/EUR.
* USD Rate ($r_{USD}$): 10%.
* EUR Rate ($r_{EUR}$): 8%.
* Find the 1-year Forward Rate ($F$).

**Logic:**
The currency with the *higher* interest rate (USD) must trade at a forward *discount* to offset the yield advantage. The EUR (lower rate) must trade at a premium.

**Calculation:**

$$
F = 1.30 \times \frac{1.10}{1.08}
$$

$$
F = 1.30 \times 1.0185
$$

$$
F = 1.324 \text{ USD/EUR}
$$

**Check:**
Invest \$1.30 USD $\to$ \$1.43.
Invest €1.00 (converted) $\to$ €1.08.
Convert €1.08 back at 1.324 $\to$ \$1.43.
Arbitrage free.
```

---

```{admonition} Example 4: Defaultable Bond Price
:class: tip

**Problem:**
* 1-year Zero Coupon Bond.
* Face Value: \$100.
* Price: \$95.
* Risk-free rate: 3%.
* Recovery rate ($1-\lambda$): 40% (so Loss Rate $\lambda = 60\%$).
* Find the Implied Default Probability ($\pi$).

**Formula:**

$$
V_0 = \frac{F [1 - \pi\lambda]}{1+r}
$$

**Setup:**

$$
95 = \frac{100 [1 - \pi(0.60)]}{1.03}
$$

**Algebra:**

$$
95(1.03) = 100 - 60\pi
$$

$$
97.85 = 100 - 60\pi
$$

$$
60\pi = 100 - 97.85 = 2.15
$$

$$
\pi = \frac{2.15}{60} = 0.0358
$$

**Result:** The market is pricing in a **3.58% probability of default**.
```

---

## Part 8: Practice Problems

```{admonition} Practice Problem 1: After-Tax Yield
:class: tip

**Problem:** A bond pays 5% coupons (Ordinary Income) and is priced at Par. The tax rate on Ordinary Income is 40%. The tax rate on Capital Gains is 20%. What is the after-tax yield?

**Hint:** Since the bond is at Par, are there any Capital Gains?

<details>
<summary><strong>Click for Solution</strong></summary>

Since the bond is at Par ($P=F$), there is **no Capital Gain** or Loss upon maturity. The Capital Gains tax rate is irrelevant.
We only tax the coupons.

$$
r_{AT} = r_{pre-tax} (1 - \tau_{OI})
$$

$$
r_{AT} = 5\% (1 - 0.40) = 3\%
$$

</details>
```

```{admonition} Practice Problem 2: Bootstrapping
:class: tip

**Problem:**
* 1-year ZCB Yield: 2.0%.
* 2-year Par Bond Coupon: 3.0%.
* Find the 2-year Spot Rate ($r_{s2}$).

**Hint:** A Par bond's price equals its Face Value (\$100).

<details>
<summary><strong>Click for Solution</strong></summary>

Price = \$100. Coupon = \$3.

$$
100 = \frac{3}{1.02} + \frac{103}{(1+r_{s2})^2}
$$

$$
100 = 2.941 + \frac{103}{(1+r_{s2})^2}
$$

$$
97.059 = \frac{103}{(1+r_{s2})^2}
$$

$$
(1+r_{s2})^2 = \frac{103}{97.059} = 1.0612
$$

$$
1+r_{s2} = \sqrt{1.0612} = 1.03015
$$

$$
r_{s2} = 3.015\%
$$

</details>
```

```{admonition} Practice Problem 3: Continuous Inflation
:class: tip

**Problem:** Nominal continuous rate $r = 8\%$. Inflation continuous rate $i = 3\%$. What is the exact Real continuous rate $\rho$?

**Hint:** Use the continuous version of the Fisher equation.

<details>
<summary><strong>Click for Solution</strong></summary>

For continuous rates, the Fisher equation is additive:

$$
r = \rho + i
$$

$$
8\% = \rho + 3\%
$$

$$
\rho = 5\%
$$

(Note: This is exact, unlike the discrete approximation).

</details>
```

---

## Part 9: Chapter Summary

### Key Concepts Recap
:class: important

**1. Frequency is Fundamental:** Never mix annual rates with monthly payments. Always align the rate frequency to the payment frequency first.

**2. The Fisher Equation:** $1+r = (1+\rho)(1+i)$. Nominal returns are composed of real growth plus inflation compensation.

**3. Tax Efficiency:** The effective tax rate isn't just the bracket rate; it's a weighted average of income tax and capital gains tax, heavily influenced by the structure of the bond (Par vs. Discount).

**4. Bootstrapping:** The yield curve is constructed recursively. We use the known short-term present values to isolate and solve for the unknown long-term spot rates.

**5. Interest Rate Parity:** Forward exchange rates are determined by interest rate differentials, not just market sentiment. Currencies with high rates trade at a forward discount.

**6. Probabilistic Valuation:** The GVE adapts to risk by modifying the discount rate ($r + \pi\lambda$) or the cash flows. A defaultable bond is just a risk-free bond with an "expected loss" deduction.

### Formula Cheat Sheet

| Concept | Formula |
| :--- | :--- |
| **EAR from SAR** | $(1 + \text{SAR}/m)^m - 1$ |
| **Continuous Rate** | $\delta = \ln(1 + \text{EAR})$ |
| **Fisher Equation** | $1+r = (1+\rho)(1+i)$ |
| **After-Tax Yield** | $r_{AT} \approx r(1-\tau)$ (Simple case) |
| **Forward Rate** | $(1+r_{s2})^2 / (1+r_{s1}) - 1$ |
| **Interest Rate Parity** | $F = X \frac{1+r_{dom}}{1+r_{for}}$ |
| **Defaultable Value** | $V = \frac{F(1-\pi\lambda)}{1+r}$ |

