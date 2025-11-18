# Introduction

## Course Overview

FRE 6083: Quantitative Methods is a graduate-level course that provides the mathematical and statistical foundations necessary for financial engineering. The course emphasizes both theoretical understanding and practical applications in quantitative finance.

## Prerequisites

Students should have a solid background in:
- **Calculus:** Single and multivariable calculus, integration techniques
- **Linear Algebra:** Matrix operations, eigenvalues, systems of equations
- **Probability and Statistics:** Probability distributions, expectation, variance
- **Programming:** Familiarity with Python, R, or MATLAB is helpful

## Learning Objectives

By the end of this course, students will be able to:

1. **Apply Probability Theory** to financial modeling
   - Understand sequences and sums of random variables
   - Work with convergence concepts and limit theorems
   - Apply Markov chains to credit risk and insurance problems

2. **Model Financial Assets** using stochastic processes
   - Understand the binomial asset pricing model
   - Work with Brownian motion and geometric Brownian motion
   - Apply the Poisson process to jump models

3. **Price Derivatives** using modern mathematical techniques
   - Derive and apply the Black-Scholes formula
   - Use risk-neutral pricing and martingale methods
   - Implement numerical methods for option pricing

4. **Optimize Portfolios** under uncertainty
   - Apply mean-variance optimization
   - Understand utility theory and expected utility maximization
   - Work with multi-period portfolio problems

5. **Manage Risk** using quantitative tools
   - Calculate the Greeks for sensitivity analysis
   - Implement delta-hedging strategies
   - Understand American option pricing

## Course Structure

This course is organized into **14 lectures** covering three main areas:

### Part I: Probability Foundations (Weeks 1-3)

**Lecture 1:** Sequences and Sums of Random Variables
- Expectation, variance, and covariance
- Portfolio return and risk
- Insurance aggregate loss models

**Lecture 2:** Convergence and Limit Theorems
- Law of Large Numbers
- Central Limit Theorem
- Markov and martingale properties

**Lecture 3:** Markov Chains
- Transition matrices and Chapman-Kolmogorov equations
- Ergodicity and stationary distributions
- Gambler's ruin problem and credit risk

### Part II: Stochastic Processes (Weeks 4-7)

**Lecture 4:** The Poisson Process
- Counting processes and memorylessness
- Inter-arrival times
- Applications to insurance

**Lecture 5:** Binomial Asset Pricing Model
- No-arbitrage principle
- Risk-neutral pricing
- European and path-dependent options

**Lecture 6:** Introduction to Stochastic Processes
- Independent and stationary increments
- Gaussian processes
- Stylized facts of financial data

**Lecture 7:** The Continuous-Time Limit of the Random Walk
- Scaling and convergence to Brownian motion
- Quadratic variation
- Geometric Brownian motion

### Part III: Advanced Topics (Weeks 9-14)

**Lecture 9:** The Brownian Motion
- Definition and properties
- Transition densities
- Reflection principle

**Lecture 10:** Stochastic Calculus
- Ito integral and Ito's formula
- Applications to SDEs
- Numerical schemes

**Lecture 11:** The Black-Scholes Model
- Derivation via formal integration
- Risk-neutral pricing
- Put-call parity

**Lecture 12:** Black-Scholes PDE and Finite Difference Methods
- Transformation to heat equation
- Explicit and implicit schemes
- Implementation

**Lecture 13:** Portfolio Optimization
- Utility functions
- Martingale approach
- Market completeness

**Lecture 14:** American Options and the Greeks
- American option pricing
- Delta, Gamma, Vega, Theta, Rho
- Hedging strategies

## How to Use These Notes

1. **Before Lecture:** Read the introductory material and key definitions
2. **During Lecture:** Follow along and take notes on derivations
3. **After Lecture:** Work through the examples and practice problems
4. **For Exam Prep:** Review the "Physical Meaning" explanations and key formulas

## Mathematical Notation

Throughout these notes, we use the following conventions:
- $\mathbb{R}$ = real numbers
- $\mathbb{N}$ = natural numbers
- $\mathbb{E}[X]$ or $E[X]$ = expectation of random variable $X$
- $\mathbb{P}(A)$ or $P(A)$ = probability of event $A$
- $\text{var}[X]$ = variance of $X$
- $\text{cov}(X,Y)$ = covariance of $X$ and $Y$
- $\sim$ = "is distributed as"
- $\xrightarrow{d}$ = convergence in distribution
- $\xrightarrow{a.s.}$ = almost sure convergence

## Recommended References

Primary textbooks:
1. Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
2. Jean Jacod and Philip Protter, "Probability Essentials", 2nd Edition, Springer, 2004
3. Hull, J., "Options, Futures and Other Derivatives", Pearson/Prentice Hall

Additional references are provided at the end of each lecture.

---

Let's begin with Lecture 1: Sequences and Sums of Random Variables!
