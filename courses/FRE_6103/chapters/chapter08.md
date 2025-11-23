---
title: "Chapter 8: The Single Period CAPM and CFPM"
subtitle: "Equilibrium Pricing, Portfolio Mathematics, and the Efficient Frontier"
author: "David C. Shimko"
date: "2025"
---

# Chapter 8: The Single Period CAPM and CFPM

## Chapter Overview

In the preceding chapters, we focused on **valuation given a discount rate**. We assumed the rate of return was known, or we estimated it using ad-hoc methods. In Chapter 8, we fundamentally shift our perspective. We move from *using* a discount rate to *determining* the discount rate based on market equilibrium.

This chapter introduces two related but distinct frameworks:
1.  **The Cash Flow Portfolio Model (CFPM):** Also known as the Lintner-Mossin framework. This model values assets based on the properties of their liquidating *cash flows* (dollars) rather than percentage returns. It is robust for assets that are not fully funded or where percentage returns are difficult to define.
2.  **The Capital Asset Pricing Model (CAPM):** The classical Sharpe-Markowitz framework. This model focuses on *percentage returns* and standard deviations. While mathematically elegant, it relies on assumptions (like fully funded assets) that financial engineers often need to look beyond.

We will traverse the landscape of portfolio mathematics, moving from the utility maximization of a single investor to the aggregation of the entire market. We will derive the efficient frontier using matrix calculus and prove the separation theorem that leads to the Tangency Portfolio.

### Learning Objectives

By the end of this chapter, you will be able to:

1.  **Contrast** the Cash Flow Portfolio Model (CFPM) with the traditional CAPM, explaining why CFPM is often more suitable for financial engineering applications involving derivatives or leverage.
2.  **Formulate** the investor's utility maximization problem using matrix algebra and derive the First Order Condition (The General Valuation Equation vector).
3.  **Derive** the equilibrium price vector $\mathbf{V}$ for a market of $N$ risky assets by applying the market-clearing condition ($\nu = \mathbf{J}$).
4.  **Calculate** the aggregate Risk Aversion parameter ($A$) and the Market Price of Risk from fundamental cash flow data.
5.  **Prove** that the "Black Ratio" (Risk Premium divided by Beta) is constant across all assets in an equilibrium market.
6.  **Construct** the Efficient Frontier by solving the Markowitz constrained optimization problem using Lagrange Multipliers.
7.  **Determine** the weights of the Tangency Portfolio and the equation of the Capital Market Line (CML) in the presence of a risk-free asset.

### Prerequisites

```{admonition} Prerequisites
:class: warning

Before studying this chapter, you should be familiar with:
- **Matrix Algebra:** Matrix multiplication, inversion, transposes, and differentiation (gradients).
- **Multivariate Statistics:** Covariance matrices, expectation vectors, and properties of linear combinations of random vectors.
- **Calculus:** Constrained optimization using Lagrange Multipliers.
- **Chapter 7:** The concept of "Risk Capital" and the single-factor risk model.
```

---

##  The Cash Flow Portfolio Model (CFPM)

The CFPM allows us to value assets based on dollars of cash flow. This avoids the singularities involved in calculating percentage returns for zero-cost investments (like swaps or forwards).

### 1. Assumptions and Notation

We assume a market exists for one period.
* **Assets:** $N$ distinct assets.
* **Payoff:** Each asset $i$ produces a single, random liquidating cash flow $CF_i$ at the end of the period.
* **Distribution:** The cash flows are jointly normally distributed.

**Vector Notation:**
To handle $N$ assets simultaneously, we use linear algebra.

* **Cash Flow Vector ($\mathbf{CF}$):** An $N \times 1$ random vector.

$$
\mathbf{CF} = \begin{pmatrix} CF_1 \\ CF_2 \\ \vdots \\ CF_N \end{pmatrix}
$$

* **Expected Cash Flow Vector ($\mathbf{\mu}$):**

$$
\mathbf{\mu} = E[\mathbf{CF}] = \begin{pmatrix} E[CF_1] \\ E[CF_2] \\ \vdots \\ E[CF_N] \end{pmatrix}
$$

* **Covariance Matrix ($\mathbf{\Sigma}$):** An $N \times N$ symmetric matrix.

$$
\mathbf{\Sigma} = E[(\mathbf{CF} - \mathbf{\mu})(\mathbf{CF} - \mathbf{\mu})^T]
$$

Where the element $\sigma_{ij} = \text{Cov}(CF_i, CF_j)$.

* **Unit Vector ($\mathbf{J}$):** An $N \times 1$ vector of ones. (Note: The text sometimes uses $\mathbf{1}$, but we will use $\mathbf{J}$ to avoid confusion with the scalar number 1) .

$$
\mathbf{J} = \begin{pmatrix} 1 \\ 1 \\ \vdots \\ 1 \end{pmatrix}
$$

* **Price Vector ($\mathbf{V}$):** The unknown variables we wish to solve for.

$$
\mathbf{V} = \begin{pmatrix} V_1 \\ V_2 \\ \vdots \\ V_N \end{pmatrix}
$$

* **Holdings Vector ($\mathbf{\nu}$):** The number of units of each asset held by an investor. $\nu$ is the Greek letter "nu".

### 2. The Investor's Problem

Investors start with initial wealth $W_0$. They allocate this wealth across $N$ risky assets and a risk-free asset (borrowing or lending at rate $r$).

**End-of-Period Wealth ($W_1$):**
The wealth at time 1 is the sum of the risky cash flows plus the residual cash invested at the risk-free rate.

**Step 1: Cost of Risky Assets**
The cost to purchase the portfolio $\mathbf{\nu}$ is the dot product of holdings and prices:

$$\text{Cost} = \mathbf{\nu}^T \mathbf{V}$$

**Step 2: Residual Wealth**

$$\text{Residual} = W_0 - \mathbf{\nu}^T \mathbf{V}$$

This amount grows at the risk-free rate $(1+r)$.

**Step 3: Total Wealth Equation**

$$W_1 = \underbrace{\mathbf{\nu}^T \mathbf{CF}}_{\text{Risky Payoff}} + \underbrace{(W_0 - \mathbf{\nu}^T \mathbf{V})(1+r)}_{\text{Risk-Free Payoff}}$$


**Expected Wealth ($E[W_1]$):**

$$E[W_1] = \mathbf{\nu}^T \mathbf{\mu} + (W_0 - \mathbf{\nu}^T \mathbf{V})(1+r)$$


**Variance of Wealth ($Var(W_1)$):**
Since $W_0, \mathbf{V}, r$ are constants, the variance comes solely from the risky cash flows.

$$Var(W_1) = Var(\mathbf{\nu}^T \mathbf{CF}) = \mathbf{\nu}^T \mathbf{\Sigma} \mathbf{\nu}$$


### 3. Maximizing Expected Utility

We assume investors are risk-averse and maximize a **Mean-Variance Utility Function**.

$$

U = E[W_1] - \frac{1}{2} A \cdot Var(W_1)

$$

Where:

- $A$: The coefficient of risk aversion

**The Utility Function in Matrix Form:**

$$U(\mathbf{\nu}) = \left[ \mathbf{\nu}^T \mathbf{\mu} + (W_0 - \mathbf{\nu}^T \mathbf{V})(1+r) \right] - A (\mathbf{\nu}^T \mathbf{\Sigma} \mathbf{\nu})$$


---

##  Deriving Market Equilibrium

To find the optimal portfolio, the investor chooses the vector $\mathbf{\nu}$ that maximizes $U$. This is a calculus problem requiring matrix differentiation.

### 1. The First Order Condition (GVE)

We take the gradient (vector of partial derivatives) of $U$ with respect to $\mathbf{\nu}$ and set it to zero.

$$

\nabla_{\nu} U = \mathbf{0}

$$

**Term-by-Term Differentiation:**

1. $\frac{\partial}{\partial \nu} (\mathbf{\nu}^T \mathbf{\mu}) = \mathbf{\mu}$

2. $\frac{\partial}{\partial \nu} (W_0(1+r)) = \mathbf{0}$

3. $\frac{\partial}{\partial \nu} (-\mathbf{\nu}^T \mathbf{V}(1+r)) = -\mathbf{V}(1+r)$

4. $\frac{\partial}{\partial \nu} \left(-\frac{1}{2}A \mathbf{\nu}^T \mathbf{\Sigma} \mathbf{\nu}\right) = -A \mathbf{\Sigma} \mathbf{\nu}$

This gives: $\nabla U = \mathbf{\mu} - \mathbf{V}(1+r) - A \mathbf{\Sigma} \mathbf{\nu}$

**The Optimal Holdings Vector:**
Setting the gradient to zero:

$$\mathbf{0} = \mathbf{\mu} - \mathbf{V}(1+r) - A \mathbf{\Sigma} \mathbf{\nu}$$

Rearranging to solve for $\mathbf{\nu}$:

$$A \mathbf{\Sigma} \mathbf{\nu} = \mathbf{\mu} - \mathbf{V}(1+r)$$

$$\mathbf{\nu} = \frac{1}{A} \mathbf{\Sigma}^{-1} [\mathbf{\mu} - \mathbf{V}(1+r)]$$


This equation tells us exactly how many units of each asset an investor *wants* to hold given their risk aversion $A$ and the prices $\mathbf{V}$.

### 2. Market Clearing and Equilibrium Prices

In equilibrium, every asset must be held by someone. If we aggregate across all investors, the sum of all holdings vectors must equal the total supply of assets.
To simplify, we normalize the total supply of each asset to **1 unit**.

**Market Clearing Condition:**

$$\mathbf{\nu}_{market} = \mathbf{J} = \begin{pmatrix} 1 \\ \vdots \\ 1 \end{pmatrix}$$


**Solving for Price ($\mathbf{V}$):**
We substitute $\mathbf{\nu} = \mathbf{J}$ into the First Order Condition derived above. Note that $A$ now represents the *aggregate* market risk aversion.

$$

A \mathbf{\Sigma} \mathbf{J} = \mathbf{\mu} - \mathbf{V}(1+r)

$$

Rearranging to solve for $\mathbf{V}$:

$$\mathbf{V}(1+r) = \mathbf{\mu} - A \mathbf{\Sigma} \mathbf{J}$$

$$

\mathbf{V} = \frac{\mathbf{\mu} - A \mathbf{\Sigma} \mathbf{J}}{1+r}

$$


```{important}
**Fundamental Valuation Formula of CFPM:**

$$
\mathbf{V} = \frac{\mathbf{\mu} - A \mathbf{\Sigma} \mathbf{J}}{1+r}
$$

where:

- $\mathbf{V}$ = Value vector of assets today
- $\mathbf{\mu}$ = Expected future cash flows
- $A$ = Market risk aversion parameter
- $\mathbf{\Sigma}$ = Covariance matrix
- $\mathbf{J}$ = Unit vector (market portfolio weights)
```

**Physical Meaning**: The value is reduced by the risk aversion times the covariance of the assets with the "Market Portfolio" ($\mathbf{J}$). This is the Risk Discount term.

### 3. The Market Price of Risk ($A$)

What is $A$? We can solve for it by pre-multiplying the valuation equation by $\mathbf{J}^T$ (summing across all assets).

$$

\mathbf{J}^T \mathbf{V} (1+r) = \mathbf{J}^T \mathbf{\mu} - A \mathbf{J}^T \mathbf{\Sigma} \mathbf{J}

$$

* $\mathbf{J}^T \mathbf{V}$: Total Market Value ($V_{mkt}$).
* $\mathbf{J}^T \mathbf{\mu}$: Total Expected Cash Flow of Market ($\mu_{mkt}$).
* $\mathbf{J}^T \mathbf{\Sigma} \mathbf{J}$: Variance of the Market Portfolio ($\sigma_{mkt}^2$).

Substituting these scalars:

$$V_{mkt} (1+r) = \mu_{mkt} - A \sigma_{mkt}^2$$

Solving for $A$:

$$

A = \frac{\mu_{mkt} - V_{mkt}(1+r)}{\sigma_{mkt}^2}

$$

$$

A = \frac{\text{Total Expected Market Risk Premium}}{\text{Variance of Market}}

$$


This is often called $\lambda$, the **Market Price of Risk**. It tells us how much extra dollar return the market demands for every unit of variance it bears.

---

##  Beta and The "Black Ratio"

We can now relate individual assets to the market portfolio, deriving the concept of Beta from first principles.

### 1. Defining Beta ($\mathbf{\beta}$)

Beta is the covariance of an asset with the market, divided by the variance of the market.

**Dollar Beta:**

$$\mathbf{\beta}_{dollar} = \frac{\mathbf{\Sigma} \mathbf{J}}{\mathbf{J}^T \mathbf{\Sigma} \mathbf{J}}$$


**Percentage Beta:**

$$\mathbf{\beta}_{\%} = \frac{\mathbf{\Sigma} (\mathbf{J} \oslash \mathbf{V})}{(\mathbf{J}^T \mathbf{V})^2}$$

The Beta vector $\mathbf{\beta}$ is defined as:

$$\mathbf{\beta} = \frac{\mathbf{\Sigma} \mathbf{J} \oslash \mathbf{V}}{\mathbf{J}^T \mathbf{\Sigma} \mathbf{J} / (\mathbf{J}^T \mathbf{V})^2}$$

Let's simplify using the property that $\mathbf{\Sigma} \mathbf{J}$ is the vector of covariances with the market total cash flow.

### 2. The Black Ratio

A crucial finding in CFPM is the relationship between Risk Premium and Beta.
From the valuation equation:

$$\text{Risk Premium} = \mathbf{\mu} - \mathbf{V}(1+r) = A \mathbf{\Sigma} \mathbf{J}$$

We know that $\mathbf{\beta} \propto \mathbf{\Sigma} \mathbf{J}$.
Therefore, for every asset $i$:

$$

\frac{\text{Risk Premium}_i}{\text{Beta}_i} = \text{Constant}

$$

This constant is the **Black Ratio**. It implies that the risk premium is perfectly proportional to Beta. There is no reward for idiosyncratic risk (risk not correlated with $\mathbf{\Sigma} \mathbf{J}$).

---

##  Sub-Portfolio Pricing

One of the unique strengths of CFPM is that we can price any portfolio relative to any *other* portfolio, not just the total market.

Suppose we have two sub-portfolios, $X$ and $Y$, defined by weight vectors $\mathbf{w}_X$ and $\mathbf{w}_Y$.

**Valuation Relationship:**
We can express the required return of portfolio $Y$ in terms of portfolio $X$:

$$

\mu_Y - V_Y(1+r) = \beta_{YX} (\mu_X - V_X(1+r))

$$

Where $\beta_{YX}$ is the beta of $Y$ with respect to $X$:

$$\beta_{YX} = \frac{Cov(Y, X)}{Var(X)}$$



**The Risk-Free Construction:**
By rearranging the equation:

$$\frac{\mu_Y - V_Y(1+r)}{\beta_{YX}} = \mu_X - V_X(1+r)$$

This implies we can construct a zero-beta (risk-free) portfolio by combining $Y$ and $X$ in specific ratios. Buying $Y$ and shorting $\beta_{YX}$ units of $X$ eliminates the systematic risk relative to $X$.

---

##  The Classical Markowitz Model

We now shift to the percentage-return framework (Modern Portfolio Theory). Here, we solve for the **Efficient Frontier**: the set of portfolios that minimize variance for a given target return $R$.

### 1. The Optimization Problem

We want to find the weight vector $\mathbf{w}$ that minimizes portfolio variance, subject to two constraints:
1.  **Budget Constraint:** Weights sum to 1 ($\mathbf{w}^T \mathbf{J} = 1$).
2.  **Return Constraint:** Expected return equals target $R$ ($\mathbf{w}^T \mathbf{r} = R$).

**The Objective Function:**

$$\min \frac{1}{2} \mathbf{w}^T \mathbf{\Sigma} \mathbf{w}$$

**The Lagrangian ($L$):**

$$L = \frac{1}{2} \mathbf{w}^T \mathbf{\Sigma} \mathbf{w} - \lambda (\mathbf{w}^T \mathbf{J} - 1) - \gamma (\mathbf{w}^T \mathbf{r} - R)$$


### 2. Solving the Lagrangian

We take the derivative w.r.t $\mathbf{w}$ and set to zero:

$$\mathbf{\Sigma} \mathbf{w} - \lambda \mathbf{J} - \gamma \mathbf{r} = \mathbf{0}$$

Solving for optimal weights $\mathbf{w}_e$ (efficient weights):

$$\mathbf{w}_e = \mathbf{\Sigma}^{-1} (\lambda \mathbf{J} + \gamma \mathbf{r})$$


To find the multipliers $\lambda$ and $\gamma$, we substitute this back into the constraints. This generates a system of linear equations involving four fundamental scalars:

$$

A = \mathbf{J}^T \mathbf{\Sigma}^{-1} \mathbf{J}, \quad B = \mathbf{J}^T \mathbf{\Sigma}^{-1} \mathbf{r}

$$

$$
C = \mathbf{r}^T \mathbf{\Sigma}^{-1} \mathbf{r}, \quad D = AC - B^2

$$


### 3. The Efficient Frontier (The Hyperbola)

Solving the system yields the variance of the efficient portfolio as a function of its target return $R$:

$$

\sigma_p^2 (R) = \frac{A R^2 - 2B R + C}{D}

$$


This equation traces a **Parabola** in Mean-Variance space, or a **Hyperbola** in Mean-Standard Deviation space.

**Global Minimum Variance Portfolio:**
The absolute lowest risk portfolio is found at the vertex of the parabola.

$$R_{min} = B/A$$

$$\sigma_{min}^2 = 1/A$$


---

##  The Tangency Portfolio

When we introduce a risk-free asset $r_f$, the efficient frontier changes from a hyperbola to a straight line: the **Capital Market Line (CML)**.

### 1. The Tangency Logic

We want to find the portfolio of risky assets $\mathbf{w}_T$ that, when combined with the risk-free asset, produces the highest possible Sharpe Ratio (slope of the line).


**Slope:**

$$\text{Slope} = \frac{\mathbf{w}^T \mathbf{r} - r_f}{(\mathbf{w}^T \mathbf{\Sigma} \mathbf{w})^{1/2}}$$


### 2. The Solution

Maximizing the slope leads to the optimal weights for the **Tangency Portfolio**:

$$

\mathbf{w}_T = \frac{\mathbf{\Sigma}^{-1} (\mathbf{r} - r_f \mathbf{J})}{B - A r_f}

$$



This is a profound result. It states that the optimal mix of risky assets is proportional to the inverse covariance matrix times the vector of excess returns. This is the mathematical justification for the **Separation Theorem**: all investors should hold the *same* mix of risky assets (the Tangency Portfolio) and adjust their risk only by borrowing or lending cash.

---

##  Worked Examples

```{admonition} Example 1: 2-Asset CFPM Equilibrium
:class: tip

**Context:** A mini-market with 2 assets. We want to find the equilibrium prices.

**Given:**
* **Expected Cash Flows:** $\mathbf{\mu} = \begin{pmatrix} 110 \\ 220 \end{pmatrix}$.
* **Covariance Matrix:** $\mathbf{\Sigma} = \begin{pmatrix} 100 & 50 \\ 50 & 400 \end{pmatrix}$.
* **Risk-Free Rate:** $r = 5\%$.
* **Aggregate Risk Aversion:** $A = 0.01$.

**Step 1: Calculate Market Covariance Sum ($\mathbf{\Sigma} \mathbf{J}$)**

$$\mathbf{\Sigma} \mathbf{J} = \begin{pmatrix} 100 & 50 \\ 50 & 400 \end{pmatrix} \begin{pmatrix} 1 \\ 1 \end{pmatrix} = \begin{pmatrix} 150 \\ 450 \end{pmatrix}$$

**Step 2: Calculate Risk Discount**

$$A \mathbf{\Sigma} \mathbf{J} = 0.01 \begin{pmatrix} 150 \\ 450 \end{pmatrix} = \begin{pmatrix} 1.5 \\ 4.5 \end{pmatrix}$$

**Step 3: Calculate Equilibrium Prices ($\mathbf{V}$)**

$$\mathbf{V} = \frac{\mathbf{\mu} - A \mathbf{\Sigma} \mathbf{J}}{1+r}$$

$$\mathbf{V} = \frac{1}{1.05} \left[ \begin{pmatrix} 110 \\ 220 \end{pmatrix} - \begin{pmatrix} 1.5 \\ 4.5 \end{pmatrix} \right]$$

$$\mathbf{V} = \frac{1}{1.05} \begin{pmatrix} 108.5 \\ 215.5 \end{pmatrix} = \begin{pmatrix} 103.33 \\ 205.24 \end{pmatrix}$$

**Interpretation:**
Asset 2 has higher expected cash flow (220 vs 110) but much higher risk (Variance 400 vs 100). The market penalizes Asset 2 more heavily (\$4.50 discount vs \$1.50), lowering its price relative to the risk-free valuation.

```

---

```{admonition} Example 2: Calculating the Tangency Portfolio
:class: tip

**Context:** You have 2 risky stocks and a risk-free rate of 2%. Find the optimal risky portfolio weights.

**Given:**
* $\mathbf{r} = \begin{pmatrix} 0.10 \\ 0.15 \end{pmatrix}$
* $\mathbf{\Sigma} = \begin{pmatrix} 0.04 & 0.01 \\ 0.01 & 0.09 \end{pmatrix}$
* $r_f = 0.02$

**Step 1: Inverse Covariance Matrix ($\mathbf{\Sigma}^{-1}$)**
Determinant $D = (0.04)(0.09) - (0.01)(0.01) = 0.0036 - 0.0001 = 0.0035$.

$$\mathbf{\Sigma}^{-1} = \frac{1}{0.0035} \begin{pmatrix} 0.09 & -0.01 \\ -0.01 & 0.04 \end{pmatrix}$$

**Step 2: Excess Returns Vector**

$$\mathbf{Z} = \mathbf{r} - r_f \mathbf{J} = \begin{pmatrix} 0.10 - 0.02 \\ 0.15 - 0.02 \end{pmatrix} = \begin{pmatrix} 0.08 \\ 0.13 \end{pmatrix}$$

**Step 3: Unscaled Weights ($\mathbf{\Sigma}^{-1} \mathbf{Z}$)**

$$\mathbf{u} = \frac{1}{0.0035} \begin{pmatrix} 0.09 & -0.01 \\ -0.01 & 0.04 \end{pmatrix} \begin{pmatrix} 0.08 \\ 0.13 \end{pmatrix}$$

$$\mathbf{u} \propto \begin{pmatrix} (0.09)(0.08) + (-0.01)(0.13) \\ (-0.01)(0.08) + (0.04)(0.13) \end{pmatrix}$$

$$\mathbf{u} \propto \begin{pmatrix} 0.0072 - 0.0013 \\ -0.0008 + 0.0052 \end{pmatrix} = \begin{pmatrix} 0.0059 \\ 0.0044 \end{pmatrix}$$

**Step 4: Normalize Weights**
Sum = $0.0059 + 0.0044 = 0.0103$.
$w_1 = 0.0059 / 0.0103 = 57.3\%$.
$w_2 = 0.0044 / 0.0103 = 42.7\%$.

**Result:** The Tangency Portfolio is 57.3% Asset 1 and 42.7% Asset 2.

```

---

##  Practice Problems

```{admonition} Practice Problem 1: The Market Price of Risk
:class: tip

**Problem:** The total market portfolio has an expected value of \$1,000,000 and a variance of 100,000,000. The current price of the market is \$900,000. The risk-free rate is 5%. Calculate the aggregate risk aversion parameter $A$.

**Given:**
* $\mu_{mkt} = 1,000,000$
* $\sigma^2_{mkt} = 100,000,000$
* $V_{mkt} = 900,000$
* $r = 0.05$

<details>
<summary><strong>Click for Solution</strong></summary>

**Formula:**

$$A = \frac{\mu_{mkt} - V_{mkt}(1+r)}{\sigma^2_{mkt}}$$

**Calculation:**

$$A = \frac{1,000,000 - 900,000(1.05)}{100,000,000}$$

$$A = \frac{1,000,000 - 945,000}{100,000,000}$$

$$A = \frac{55,000}{100,000,000} = 0.00055$$

**Answer:** $A = 0.00055$. The market demands 0.055 cents of premium for every dollar of variance.

</details>
```

```{admonition} Practice Problem 2: Sub-Portfolio Beta
:class: tip

**Problem:** Portfolio $X$ has a variance of 0.04. Portfolio $Y$ has a covariance with $X$ of 0.06. If Portfolio $X$ yields 10% and the risk-free rate is 4%, what return would CFPM predict for Portfolio $Y$ if it were priced solely relative to $X$?

<details>
<summary><strong>Click for Solution</strong></summary>

**Step 1: Calculate Beta of Y relative to X**

$$\beta_{YX} = \frac{Cov(Y,X)}{Var(X)} = \frac{0.06}{0.04} = 1.5$$

**Step 2: Apply CFPM/CAPM Relation**

$$E[r_Y] = r_f + \beta_{YX} (E[r_X] - r_f)$$

$$E[r_Y] = 0.04 + 1.5 (0.10 - 0.04)$$

$$E[r_Y] = 0.04 + 1.5 (0.06)$$

$$E[r_Y] = 0.04 + 0.09 = 0.13$$

**Answer:** 13%.

</details>
```

---

##  Chapter Summary

```{important}
**Key Concepts Recap**

**1. CFPM vs. CAPM:**
* **CFPM:** Values assets based on *dollars*. Essential for derivatives, leverage, and non-standard assets.
* **CAPM:** Values assets based on *returns*. Good for stocks and mutual funds.
* **Link:** Both models are consistent. CAPM is just CFPM normalized by price.

**2. The Fundamental Pricing Equation:**

$$\mathbf{V} = \frac{\mathbf{\mu} - A \mathbf{\Sigma} \mathbf{J}}{1+r}$$

This equation summarizes the entire chapter. Price = (Expected Cash Flow - Risk Penalty) / Time Value.

**3. The Market Portfolio:**
The market portfolio is not arbitrary; it is the unique aggregate of all optimal individual portfolios. Its risk aversion $A$ sets the price of risk for every other asset in the economy.

**4. Efficiency:**
* **Minimum Variance Portfolio:** The vertex of the parabola. Lowest possible risk.
* **Tangency Portfolio:** The point where the Capital Market Line touches the efficient frontier. Highest possible Sharpe Ratio.
```

### Formula Cheat Sheet

| Concept | Formula |
| :--- | :--- |
| **CFPM Equilibrium** | $\mathbf{V} = \frac{\mathbf{\mu} - A \mathbf{\Sigma} \mathbf{J}}{1+r}$ |
| **Risk Aversion (A)** | $A = \frac{\mu_{mkt} - V_{mkt}(1+r)}{\sigma^2_{mkt}}$ |
| **Efficient Weights** | $\mathbf{w} = \mathbf{\Sigma}^{-1} (\lambda \mathbf{J} + \gamma \mathbf{r})$ |
| **Tangency Weights** | $\mathbf{w}_T \propto \mathbf{\Sigma}^{-1} (\mathbf{r} - r_f \mathbf{J})$ |
| **Scalars** | $A = \mathbf{J}^T \mathbf{\Sigma}^{-1} \mathbf{J}, \quad B = \mathbf{J}^T \mathbf{\Sigma}^{-1} \mathbf{r}$ |

