# Introduction

## Course Overview

FRE 6103: Valuation Methods for Financial Engineering is a graduate-level course that establishes the quantitative foundations for valuing financial assets. Unlike traditional corporate finance which relies on static formulas, this course emphasizes dynamic valuation methods using benchmarking, simulation, and risk-neutral pricing.

## Prerequisites

Students should have a solid background in:
- **Calculus:** Single and multivariable calculus, integration, differentiation
- **Linear Algebra:** Matrix operations, solving systems of equations
- **Probability and Statistics:** Probability distributions, expected value, variance
- **Basic Finance:** Time value of money, present value concepts
- **Programming:** Familiarity with Python, MATLAB, or R is helpful for simulations

## Learning Objectives

By the end of this course, students will be able to:

1. **Apply the General Valuation Equation (GVE)** to price various assets
   - Understand the equilibrium of required and expected returns
   - Value risk-free and risky cash flows
   - Apply to stocks, bonds, derivatives, and real assets

2. **Master Time Value of Money** calculations
   - Work with annuities and perpetuities
   - Handle complex cash flow patterns
   - Account for taxes, transaction costs, and other complications

3. **Price Fixed Income Securities**
   - Calculate bond prices and yields
   - Understand duration and convexity
   - Model the term structure of interest rates

4. **Implement Simulation Methods**
   - Use Monte Carlo methods for valuation
   - Model stochastic processes (Brownian motion, geometric Brownian motion)
   - Simulate complex derivatives and portfolios

5. **Apply Asset Pricing Models**
   - Understand and use the Capital Asset Pricing Model (CAPM)
   - Apply the Cash Flow Pricing Model (CFPM)
   - Price derivatives in static equilibrium frameworks

## Course Structure

This course is organized into **9 chapters** covering four main areas:

### Part I: Valuation Foundations (Chapters 1-3)

**Chapter 1: Valuation Methods for Financial Engineers**
- The General Valuation Equation (GVE)
- Benchmarking approach to valuation
- Risk-free and risky cash flows
- Insurance reserve calculations

**Chapter 2: Annuities and Perpetuities, Basic and Complex**
- Present value of annuities
- Growing perpetuities
- Complex payment streams
- Mortgage and loan calculations

**Chapter 3: Complications and Resolutions**
- Taxes and transaction costs
- Liquidity considerations
- Credit risk adjustments
- Currency and inflation effects

### Part II: Fixed Income (Chapter 4)

**Chapter 4: Bonds**
- Bond pricing fundamentals
- Yield to maturity and spot rates
- Duration and convexity
- Term structure models

### Part III: Simulation Methods (Chapters 5-6)

**Chapter 5: Simulation**
- Monte Carlo methods
- Random number generation
- Variance reduction techniques
- Applications to derivatives pricing

**Chapter 6: Stochastic Processes in Finance**
- Brownian motion
- Geometric Brownian motion
- Jump processes
- Stochastic differential equations

### Part IV: Asset Pricing (Chapters 7-9)

**Chapter 7: Risk, Capital and Valuation**
- Risk measures (VaR, CVaR)
- Capital requirements
- Risk-adjusted valuation
- Economic capital allocation

**Chapter 8: The Single Period CAPM and CFPM**
- Capital Asset Pricing Model
- Cash Flow Pricing Model
- Market equilibrium
- Beta and systematic risk

**Chapter 9: Derivative Pricing in the Static CAPM**
- Option pricing in CAPM framework
- Risk-neutral probabilities
- Replication and arbitrage
- Extensions to exotic derivatives

## Philosophy and Approach

This course adopts a **practitioner-oriented** approach to financial engineering:

1. **Benchmarking over Theory**: We value assets by referencing traded instruments, not just abstract models
2. **Simulation over Closed Forms**: We emphasize numerical methods that handle real-world complexity
3. **Risk-Neutral Pricing**: We use the powerful framework that unifies derivative pricing
4. **Applications First**: Every concept is illustrated with real financial engineering problems

## How to Use These Notes

1. **Before Class:** Review the chapter overview and key definitions
2. **During Class:** Follow derivations and note practical applications
3. **After Class:** Work through examples and practice problems
4. **For Projects:** Reference the simulation code and implementation notes

## Mathematical Notation

Throughout these notes, we use standard financial mathematics notation:
- $PV$ = Present Value
- $FV$ = Future Value
- $r$ = interest rate (risk-free)
- $E[X]$ or $\mathbb{E}[X]$ = expected value of $X$
- $\text{var}[X]$ = variance of $X$
- $\beta$ = systematic risk (beta)
- $\sigma$ = volatility (standard deviation)
- $S_t$ = asset price at time $t$
- $dW_t$ = increment of Brownian motion

## Recommended References

Primary textbook:
1. David C. Shimko, "Finance in Continuous Time: A Primer", Kolb Publishing, 1992

Supplementary references:
1. Hull, J., "Options, Futures and Other Derivatives", Pearson
2. Luenberger, D., "Investment Science", Oxford University Press
3. Shreve, S., "Stochastic Calculus for Finance I & II", Springer

Additional references are provided at the end of each chapter.

## Practical Tools

The course makes use of:
- **Excel**: For basic cash flow calculations
- **Python**: For simulations and numerical methods
- **MATLAB/R**: Alternative platforms for quantitative work

---

Let's begin with Chapter 1: Valuation Methods for Financial Engineers!
