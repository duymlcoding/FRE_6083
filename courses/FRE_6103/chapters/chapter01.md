---
title: "Chapter 1: Valuation Methods for Financial Engineers"
subtitle: "Foundations of Benchmarking, Simulation, and the General Valuation Equation"
author: "David C. Shimko"
date: "2025"
---

# Chapter 1: Valuation Methods for Financial Engineers

## Chapter Overview

Welcome to the world of Financial Engineering. [cite_start]Unlike traditional corporate finance, which often relies on static formulas and historical averages, financial engineering is the discipline of applying technical methods to solve complex, dynamic, and practical problems in finance[cite: 1].

In this chapter, we establish the foundational philosophy for the entire course: **Valuation**.

[cite_start]Nearly every financial decision—whether buying a stock, issuing a bond, building a factory, or entering a complex derivative contract—requires a valuation[cite: 3]. [cite_start]However, the traditional models you may have learned, such as the Capital Asset Pricing Model (CAPM) or simple Price/Earnings (P/E) ratios, are often too simplistic for the complex cash flows encountered in modern financial engineering[cite: 3].

[cite_start]We will move away from closed-form formulas and towards a comprehensive simulation and benchmarking framework[cite: 5]. [cite_start]We will learn to value assets not just by what we *think* they are worth, but by referencing them against traded assets and contract prices in the market[cite: 6]. [cite_start]We will also derive the **General Valuation Equation (GVE)**, a powerful tool that unifies the pricing of stocks, bonds, derivatives, and real assets[cite: 56].

### Learning Objectives

By the end of this chapter, you will be able to:

1.  **Define** financial engineering and distinguish its valuation approach from traditional corporate finance.
2.  **Categorize** assets into capital, physical, derivative, and corporate classes, and explain how liability structures affect value.
3.  **Understand** the limitations of percentage returns in the context of short positions and derivatives, and apply "dollarized" returns instead.
4.  **Derive** the General Valuation Equation (GVE) from the equilibrium of Required and Expected returns.
5.  **Apply** the GVE to solve for the present value of risk-free and risky cash flows.
6.  **Analyze** insurance reserves using both retrospective (backward-looking) and prospective (forward-looking) methods.

### Prerequisites

```{admonition} Prerequisites
:class: warning

Before studying this chapter, you should be familiar with:
- **Basic Algebra:** Solving linear equations and manipulating variables.
- **Time Value of Money:** Concepts of Present Value (PV), Future Value (FV), and discounting.
- **Probability Theory:** Basic understanding of Expected Value ($E[x]$) and Standard Deviation ($\sigma$).
- **Financial Terminology:** Basic definitions of stocks, bonds, dividends, and interest.

If you need review, consult a standard introductory corporate finance textbook.
```

### Real-World Applications

The concepts in this chapter are used daily by:
* **Quantitative Analysts (Quants):** To price options and futures on Wall Street.
* **Risk Managers:** To determine the capital required to buffer against market crashes.
* **Corporate Treasurers:** To decide whether to issue debt or equity, or how to hedge foreign exchange risk.
* **Actuaries:** To calculate insurance reserves to ensure policyholders can be paid.

---

## Part 1: Fundamental Concepts

### What is Financial Engineering?

Financial engineering is often misunderstood as merely "creating new financial products." While that is part of it, the discipline is much broader.

```{admonition} Key Concept: Financial Engineering
:class: tip

[cite_start]**Definition:** Financial Engineering includes financial derivative security pricing, trading, risk models, product design, security structuring, and corporate finance decisions involving contingent capital[cite: 1].

[cite_start]**Why It Matters:** Financial engineers are needed to apply theoretical frameworks to solve specific, practical problems that employers face based on their unique circumstances[cite: 2]. It is the translation of math into money.

**Core Focus of this Course:**
* [cite_start]**Discrete-time modeling:** We will look at time in steps (e.g., days, months) rather than continuous time (calculus-based)[cite: 5].
* [cite_start]**Simulation:** Using flexible computational solutions rather than rigid formulas[cite: 5].
* [cite_start]**Benchmarking:** Valuing assets based on traded assets or contract prices[cite: 6].
```

### The Benchmarking Approach

One of the most critical shifts in mindset for this course is the move toward **Benchmarking**.

In traditional finance, you might value an asset by estimating its cash flows and picking a discount rate based on "gut feeling" or a generic beta. [cite_start]In financial engineering, we value an asset by asking: *How can we replicate this asset using things that are already trading?* [cite: 6]

**The Process:**
To value a complex asset (like an oil refinery):
1.  [cite_start]Build a stochastic pro-forma (a model of future financials)[cite: 6].
2.  [cite_start]Simulate the cash flows under various scenarios[cite: 7].
3.  [cite_start]**Benchmark** these cash flows against traded futures and options (e.g., energy futures)[cite: 7].
4.  [cite_start]Discount the components separately to reflect their specific risks[cite: 8].
5.  [cite_start]Determine the final valuation[cite: 8].

### Taxonomy of Assets

To value something, we must first understand what it is. [cite_start]We categorize assets into four distinct types[cite: 9].

#### 1. Capital Assets
[cite_start]These are financial instruments like **stocks and bonds**[cite: 9].
* **Characteristics:** They have contractual or expected cash flows.
* **Examples:** A share of IBM, a US Treasury Bond.
* **Ownership Rights:**
    * *Stock:* Entitles the holder to dividends and capital appreciation.
    * *Bond:* Entitles the holder to coupons, principal repayment, and capital gains.

#### 2. Physical Assets
[cite_start]These are non-financial assets[cite: 10].
* **Characteristics:** Value derives from tangible cash flows they produce or utility they provide.
* [cite_start]**Examples:** Real estate, a factory, a dairy cow[cite: 10, 23].
* [cite_start]**Note:** A dairy cow is an asset because it produces cash flows (milk) and has a terminal value (meat/sale price)[cite: 23].

#### 3. Derivatives
[cite_start]These are contracts, often requiring little initial investment[cite: 11].
* **Characteristics:** Their value is derived from an underlying asset. [cite_start]They can start with zero value but become significant assets or liabilities[cite: 11].
* **Examples:** Options, Futures, Forwards.
* [cite_start]**Crucial Insight:** One person’s asset is another person’s liability[cite: 12]. We must be able to value both sides.

#### 4. Corporate Assets and Liabilities
[cite_start]These are assets whose values are influenced by corporate decisions[cite: 13].
* **Influencing Decisions:**
    * [cite_start]*Capital Budgeting:* When to invest[cite: 13].
    * [cite_start]*Capital Structure:* Debt vs. Equity mix[cite: 14].
    * [cite_start]*Risk Management:* Hedging strategies[cite: 14].

### The Impact of Corporate Structure on Value

The legal structure of a corporation fundamentally alters valuation through three mechanisms:

1.  **Limited Liability:** Shareholders cannot lose more than their initial investment. This acts like an "insurance policy" or a "put option" for shareholders.
2.  **Bankruptcy:** The right to default on debt. Instead of paying cash, the firm surrenders its assets to debtholders.
3.  **Tax Incentives:** Interest on debt is often tax-deductible, increasing net cash flows to the firm.

**Summary:** Limited liability, bankruptcy protection, and tax incentives generally **increase** the value of the company.

### Contracts as Contingent Assets

A contract is a promise. [cite_start]In financial engineering, we view contracts as **Contingent Assets**[cite: 24].

```{admonition} Example: The Forward Contract
:class: note

[cite_start]Imagine a farmer signs a forward contract to sell wheat at \$4.00/bushel[cite: 25].
* **Scenario A:** Market price rises to \$5.00. The farmer *must* sell at \$4.00. [cite_start]The contract has **negative value** to the farmer (an opportunity loss of \$1.00)[cite: 25].
* **Scenario B:** Market price falls to \$3.00. The farmer sells at \$4.00. The contract has **positive value** to the farmer.

**Key Takeaway:** Contracts commit parties to actions that may create or destroy value. [cite_start]Even if a contract has zero value at inception, it can become a massive liability later[cite: 24].
```

### Market Terminology: Price vs. Value

[cite_start]It is vital to distinguish between *price* and *value*[cite: 26].

* **Bid Price:** The price a buyer offers (The price you sell at).
* **Ask Price:** The price a seller offers (The price you buy at).
* [cite_start]**Value:** The theoretical worth of the asset derived from a model[cite: 31].

**Public vs. Private Value:**
* [cite_start]**Public Value:** The consensus market value[cite: 27].
* [cite_start]**Private Value:** The value to a specific individual based on their unique constraints, tax situation, or beliefs[cite: 27].

**The Trading Rule:**
* [cite_start]**BUY** if Private Valuation > Public Valuation[cite: 28].
* [cite_start]**SELL** if Private Valuation < Public Valuation[cite: 29].

---

## Part 2: Mathematical Framework

### Section 1: Return Metrics

To compare assets, we measure returns. However, the standard definitions of "return" can break down in financial engineering contexts.

#### [cite_start]Standard Definitions [cite: 36-40]

1.  **Cash Flow ($C$):** Payments received (dividends, coupons). Positive = inflow, Negative = outflow.
2.  **Capital Gain ($CG$):** Change in asset price ($V_1 - V_0$).
3.  **Total Return:** Capital Gain + Cash Flow.
4.  **Rate of Return (ROR):** Growth rate expressed as a percentage.

$$
\text{ROR} = \frac{(V_1 - V_0) + C_1}{V_0}
$$

#### The Problem with Percentage Returns

Percentage returns work well for assets you buy with cash (Long positions). [cite_start]They fail for **Short Positions** and **Derivatives** where the initial investment ($V_0$) is zero or negative[cite: 58].

[cite_start]**The Short Sale Anomaly [cite: 58-61]:**
* A short sale involves borrowing stock, selling it, and buying it back later.
* If you sell at \$50 and buy back at \$60, you lose \$10.
* What is your denominator? You didn't pay money; you received money initially.
* Calculating a % return is mathematically ambiguous or impossible.

**The Forward Contract Anomaly:**
* [cite_start]Forward contracts often have $V_0 = 0$ (no money changes hands at signing)[cite: 61].
* [cite_start]If you make \$1 profit, your return is $\$1 / 0 = \text{Undefined}$[cite: 61].

#### The Solution: Dollarized Returns

[cite_start]In financial engineering, we often utilize **Dollar Returns** instead of percentages[cite: 62].

$$
\text{Total Dollar Return} = \text{Dollar Capital Gain} + \text{Dollar Cash Flow}
$$

$$
\text{Total Dollar Return} = (V_1 - V_0) + C_1
$$

This works for *any* asset, liability, or contract, regardless of whether the initial value is positive, negative, or zero.

---

### Section 2: The General Valuation Equation (GVE)

The GVE is the governing formula for this course. [cite_start]It relates what an investor *needs* to earn (Required Return) with what they *expect* to earn (Expected Return)[cite: 54].

#### Derivation

**Step 1: Define Required Return**
[cite_start]Investors require compensation for two things[cite: 46]:
1.  **Time Value:** Foregone interest on a risk-free investment ($r V_0$).
2.  **Risk Cost:** Compensation for taking risk. This is modeled as the quantity of risk ($\sigma$) times the price per unit of risk ($k$).

$$
\text{Required Return} = r V_0 + k \sigma
$$

**Step 2: Define Expected Return**
[cite_start]Investors expect to receive value from two sources[cite: 51]:
1.  **Expected Capital Gains:** $E[V_1 - V_0]$
2.  **Expected Cash Flows:** $E[C_1]$

$$
\text{Expected Return} = E[V_1 - V_0] + E[C_1]
$$

**Step 3: The Equilibrium Condition**
In a functioning market, for a transaction to occur, the buyer and seller must agree.
* [cite_start]Buyer demands: Required Return $\le$ Expected Return[cite: 52].
* [cite_start]Seller demands: Required Return $\ge$ Expected Return[cite: 53].
* [cite_start]**Equilibrium:** Required Return = Expected Return[cite: 54].

**Step 4: The General Valuation Equation**

[cite_start]Equating Step 1 and Step 2[cite: 56]:

$$
r V_0 + k \sigma = E[V_1 - V_0] + E[C_1]
$$

where:
* $r$ = risk-free interest rate
* $V_0$ = Value at time 0
* $k$ = Market price of risk
* $\sigma$ = Standard deviation (risk measure)
* $E[\cdot]$ = Expected value operator
* $V_1$ = Value at time 1
* $C_1$ = Cash flow at time 1

**Physical Interpretation:**
This equation states that the *cost* of holding the asset (lost interest + risk borne) must equal the *benefit* of holding the asset (price appreciation + cash income).

---

### Section 3: Insurance Valuation (Reserves)

[cite_start]Valuation applies to liabilities just as much as assets[cite: 67]. Insurance companies use "Reserves" to represent the value of future liabilities.

[cite_start]**Definition:** A Reserve is value kept back to pay future claims[cite: 68].

[cite_start]There are two ways to calculate reserves, and under consistent assumptions, they yield the same result[cite: 69].

#### 1. Retrospective Reserve (Looking Backward)
[cite_start]Calculated based on what has already happened[cite: 69].

$$
\text{Reserve} = \text{FV(Premiums Received)} - \text{FV(Benefits & Expenses Paid)}
$$

#### 2. Prospective Reserve (Looking Forward)
[cite_start]Calculated based on what is expected to happen[cite: 70]. This is essentially a Net Present Value calculation.

$$
\text{Reserve} = \text{PV(Future Benefits & Expenses)} - \text{PV(Future Premiums)}
$$

---

## Part 3: Worked Examples

### Example 1: Applying the GVE to a Risk-Free Asset

:class: tip

[cite_start]**Context:** We will use the General Valuation Equation to derive the standard Present Value formula for a risk-free bond[cite: 25].

**Problem Statement:**
Consider a risk-free asset that promises a single cash flow $C$ one year from now. The risk-free rate is $r$. There is no uncertainty, so risk $\sigma = 0$. Determine the value $V_0$ using the GVE.

**Given:**
* $C_1 = C$ (Guaranteed)
* Risk $\sigma = 0$
* $V_1 = 0$ (Asset expires after payment, so terminal value is 0)
* $E[C_1] = C$ (Since it's guaranteed)

**Find:**
* Current Value $V_0$

**Approach:**
[cite_start]Apply the GVE: $r V_0 + k \sigma = E[V_1 - V_0] + E[C_1]$[cite: 25].

**Step 1: Substitute Known Values**

$$
r V_0 + k(0) = (0 - V_0) + C
$$

**Step 2: Simplify**
The risk term vanishes.

$$
r V_0 = -V_0 + C
$$

**Step 3: Solve for $V_0$**
Add $V_0$ to both sides:

$$
r V_0 + V_0 = C
$$

Factor out $V_0$:

$$
V_0 (1 + r) = C
$$

Divide by $(1+r)$:

$$
V_0 = \frac{C}{1+r}
$$

**Physical Interpretation:**
[cite_start]This confirms that the GVE is consistent with the standard Present Value formula[cite: 26]. The value of a risk-free cash flow is simply the cash flow discounted by the risk-free rate.

---

### Example 2: The Walmart Investment (Return Calculation)

:class: tip

[cite_start]**Context:** Analyzing the components of return for a standard equity investment[cite: 20].

**Problem Statement:**
One year ago, you bought a share of Walmart for \$70 ($V_0$). You expected it to pay a \$1.00 dividend ($C_{expected}$) and appreciate by \$6.00 ($CG_{expected}$).
Actually, it paid \$0.50 in dividends and appreciated by \$10.00 ($V_1 = \$80$).

**Find:**
1.  Expected Total Dollar Return
2.  Realized Total Dollar Return
3.  Realized Percentage Return

**Step 1: Calculate Expected Returns (One Year Ago)**

$$
\text{Exp. Cap Gain} = \$6.00
$$

$$
\text{Exp. Cash Flow} = \$1.00
$$

$$
\text{Exp. Total Dollar Return} = \$6.00 + \$1.00 = \$7.00
$$

**Step 2: Calculate Realized Returns (Today)**

$$
\text{Realized Cap Gain} = V_1 - V_0 = \$80 - \$70 = \$10.00
$$

$$
\text{Realized Cash Flow} = \$0.50
$$

$$
\text{Realized Total Dollar Return} = \$10.00 + \$0.50 = \$10.50
$$

**Step 3: Calculate Realized Percentage Return**

$$
\text{ROR} \% = \frac{\text{Total Dollar Return}}{V_0}
$$

$$
\text{ROR} \% = \frac{10.50}{70.00} = 0.15 = 15\%
$$

**Key Insight:**
[cite_start]For a standard "long" asset like this, both dollar and percentage returns are easily calculated and meaningful [cite: 40-45].

---

### Example 3: The Short Sale (Negative Investment)

:class: tip

[cite_start]**Context:** Demonstrating why percentage returns fail for short sales and how to fix it using the "alternative" view[cite: 29, 63].

**Problem Statement:**
You short sell a stock at \$50 ($V_0$). One year later, the price drops, and you buy it back for \$40 ($V_1$).

**Given:**
* Initial Cash Flow from Shorting: $+\$50$
* Ending Cash Flow from Covering: $-\$40$

**Analysis 1: The Standard Confusion**
* Profit = $\$50 - \$40 = \$10$.
* Initial Investment? Technically, you received cash. If you treat the initial investment as 0 (since you put up no money), Return = $10/0 = \infty$.
* If you treat the initial price as the basis: Return = $10/50 = 20\%$. But is it positive or negative? The price went down (-20%), but you made money (+20%). The signs get confusing.

**Analysis 2: The "Alternative" Dollarized Approach**
[cite_start]Let's define the investment by the cash flows relative to the investor's pocket[cite: 63].

* **Initial Investment:** $-\$50$. (Wait, why negative? In this specific accounting view, we treat the liability created as a negative starting position to make the math work for percentages). *Note: The text suggests treating the \$50 received as a "negative investment" to force the math.*

Let's look at the text's logic carefully:
1.  [cite_start]"Initial investment = -\$50 (because you receive this amount...)" [cite: 63]
2.  [cite_start]"Ending cash flow = -\$40 (because you pay this amount...)" [cite: 63]
3.  "Dollar return = (-40) - (-50) = \$10".

**Percentage Return Calculation:**

$$
\% \text{Return} = \frac{\text{Dollar Return}}{\text{Initial Investment}}
$$

$$
\% \text{Return} = \frac{\$10}{-\$50} = -20\%
$$

**Interpretation:**
This result is mathematically consistent but intuitively strange. [cite_start]You made a profit of \$10, but the return is listed as -20%[cite: 63].
* [cite_start]**Reason:** "Shorting converts a negative percentage return into a positive dollar return because the original investment is negative"[cite: 63].
* Dollar Return = (-20%) $\times$ (-$50) = +$10.

**Conclusion:** This confusing sign-flipping is why **Dollar Returns** are preferred in financial engineering. It is unambiguous to say "I made \$10."

---

### Example 4: Insurance Reserves (Backward vs. Forward)

:class: tip

[cite_start]**Context:** A simple 3-year term policy to demonstrate how reserves work[cite: 33].

**Problem Statement:**
An insurance company issues a policy.
* **Year 1:** Premiums \$100, Benefits/Expenses \$50.
* **Year 2:** Premiums \$100, Benefits/Expenses \$100.
* **Year 3:** Premiums \$100, Benefits/Expenses \$150.
* Assume interest rate $r = 0\%$ for simplicity.

**Find:** The Reserve at the End of Year 2 (EOY 2).

**Method 1: Retrospective (Backward Looking)**
* Accumulated Premiums (Year 1 & 2) = $100 + 100 = 200$.
* Accumulated Benefits (Year 1 & 2) = $50 + 100 = 150$.
* [cite_start]Reserve = Premiums - Benefits = $200 - 150 = 50$[cite: 33, 69].

**Method 2: Prospective (Forward Looking)**
* Future Benefits (Year 3) = $150$.
* Future Premiums (Year 3) = $100$.
* Reserve = PV(Future Benefits) - PV(Future Premiums).
* [cite_start]Reserve = $150 - 100 = 50$[cite: 33, 70].

**Result:**
Both methods yield a Reserve of **50**. [cite_start]This requires the company to hold 50 in assets to ensure they can pay the Year 3 deficit[cite: 71].

---

## Part 4: Practice Problems

Test your understanding with these problems. Try them before looking at solutions!

### Practice Problem 1: Applying the GVE
:class: tip

**Problem:**
An asset has a current value $V_0 = \$100$. The risk-free rate is $5\%$. The asset carries risk $\sigma = 10$ units, and the market price of risk is $k = \$0.50$ per unit. The expected cash flow $E[C_1]$ is \$4. What is the expected capital gain $E[V_1 - V_0]$ required to satisfy the market equilibrium?

**Given:**
* $V_0 = 100$
* $r = 0.05$
* $\sigma = 10$
* $k = 0.5$
* $E[C_1] = 4$

**Find:** $E[V_1 - V_0]$

[cite_start]**Hint:** Use the equation $r V_0 + k \sigma = E[V_1 - V_0] + E[C_1]$[cite: 56].

<details>
<summary><strong>Click for Solution</strong></summary>

**Step 1: Calculate Required Return (LHS)**

$$
\text{Req. Return} = (0.05 \times 100) + (0.5 \times 10)
$$

$$
\text{Req. Return} = 5 + 5 = 10
$$

**Step 2: Set up GVE**

$$
10 = E[V_1 - V_0] + 4
$$

**Step 3: Solve for Expected Capital Gain**

$$
E[V_1 - V_0] = 10 - 4 = 6
$$

**Answer:** The expected capital gain must be **\$6**.
</details>

### Practice Problem 2: Dollar Returns on Forwards
:class: tip

**Problem:**
You enter a forward contract to buy oil at \$75/barrel in one year. The initial cost of the contract is \$0. One year later, the spot price of oil is \$72.
1. Calculate the Dollar Return.
2. Explain why the Percentage Return is undefined.

**Given:**
* Forward Price (Strike) $K = 75$
* Spot Price at maturity $S_T = 72$
* Initial Investment $V_0 = 0$

<details>
<summary><strong>Click for Solution</strong></summary>

**1. Dollar Return:**
You are obligated to buy at \$75. The asset is worth \$72.
[cite_start]Profit/Loss = Value - Cost = $72 - 75 = -\$3$[cite: 25].
**Dollar Return = -\$3 per barrel.**

**2. Percentage Return:**
$$
\% \text{Return} = \frac{\text{Dollar Return}}{\text{Initial Investment}} = \frac{-3}{0}
$$
Division by zero is undefined. [cite_start]This illustrates why we must use dollar returns for zero-cost derivatives[cite: 61].
</details>

### Practice Problem 3: Private vs. Public Value
:class: tip

**Problem:**
A publicly traded bond is priced at \$950 (Public Valuation). You have a specific tax advantage that makes the bond's cash flows worth \$980 to you (Private Valuation). According to the valuation trading rules, what should you do?

<details>
<summary><strong>Click for Solution</strong></summary>

[cite_start]**Rule:** Buy if Private Value > Public Value[cite: 28].
**Analysis:** $980 > 950$.
**Decision:** **Buy the bond.** You represent a "high value" user of this asset.
</details>

---

## Part 5: Advanced Topics and Extensions

### Extension 1: The GVE and CAPM

You may notice similarities between the General Valuation Equation and the Capital Asset Pricing Model (CAPM).

**GVE:** $Required = r V_0 + k \sigma$ (in dollars)
**CAPM:** $E[R] = r_f + \beta (R_m - r_f)$ (in percent)

The GVE is actually a generalization. If we define the risk measure $\sigma$ specifically as Beta ($\beta$) and the price of risk $k$ as the Market Risk Premium $(R_m - r_f)$, the GVE can be transformed into the CAPM. [cite_start]However, GVE is superior for financial engineering because it can handle non-linear risks ($\sigma$) that Beta (which assumes linear correlation) cannot capture[cite: 3, 56].

### Extension 2: Valuation Models

[cite_start]While we focus on Benchmarking and GVE, it is important to understand the hierarchy of valuation models used in practice[cite: 32]:

1.  **Liquidation Value:** The "fire sale" price. Usually the lowest bound.
2.  **Replacement Cost:** Cost to rebuild. Used often in insurance and physical assets.
3.  **Comparable Value:** Used in Real Estate (e.g., "What did the house next door sell for?").
4.  **Benchmark Valuation:** The gold standard for this course. [cite_start]Replicating cash flows using a portfolio of traded instruments[cite: 33].
5.  **Net Present Value (NPV):** Discounted cash flows.
6.  **Portfolio Value:** The marginal value added to a specific portfolio.

[cite_start]We will focus primarily on **#4 (Benchmark)** and **#5 (NPV)** throughout this course[cite: 34].

---

## Part 6: Chapter Summary

### Key Concepts Recap
:class: important

**Main Concepts:**

1.  [cite_start]**Financial Engineering:** The application of mathematical and simulation techniques to solve practical financial problems, specifically regarding valuation and risk[cite: 1, 2].
2.  [cite_start]**Benchmarking:** The most robust valuation method involves simulating cash flows and pricing them based on traded assets (benchmarks) rather than subjective estimates[cite: 6].
3.  **Asset Classes:**
    * [cite_start]**Capital:** Stocks/Bonds[cite: 9].
    * [cite_start]**Physical:** Real Estate/Commodities[cite: 10].
    * [cite_start]**Derivatives:** Options/Forwards (Contingent assets)[cite: 11].
    * [cite_start]**Corporate:** Assets affected by firm structure (Tax/Bankruptcy)[cite: 13].
4.  **Dollar vs. Percentage Returns:** Percentage returns fail for zero-investment assets (derivatives) and short positions. [cite_start]Dollar returns are universally applicable[cite: 62].

**Critical Formula: The General Valuation Equation (GVE)**

$$
r V_0 + k \sigma = E[V_1 - V_0] + E[C_1]
$$

[cite_start]This equation enforces that the compensation for time and risk must equal the expected financial gain[cite: 56].

### Study Tips
:class: tip

1.  [cite_start]**Think in Dollars:** Whenever you see a derivative or a short position, immediately switch your mental model from "% return" to "$ profit/loss"[cite: 62].
2.  **Master the GVE:** Practice rearranging the GVE variables. Can you solve for $k$? Can you solve for $V_0$?
3.  **Visualize Reserves:** When working with liabilities (insurance), draw a timeline. "Retrospective" looks left; "Prospective" looks right. [cite_start]They must meet in the middle[cite: 69, 70].
4.  [cite_start]**Remember the Goal:** We are not just calculating numbers; we are trying to determine the *fair market value* of assets by comparing them to what is already trading[cite: 6].

