---
title: "Lecture 12: The Black-Scholes PDE and Finite Difference Methods"
author: "Agnès Tourin"
date: "November 25, 2024"
---

# The Black-Scholes Partial Differential Equation and the Finite Difference Method

This lecture introduces finite difference methods for solving the Black-Scholes partial differential equation. We begin with the heat equation, then extend to the Black-Scholes PDE for option pricing, covering discretization techniques, stability conditions, and practical implementation.

```{seealso}
**Recommended Reference:**
- J.W. Thomas, "Numerical Partial Differential Equations: Finite Difference Methods", Texts in Applied Mathematics, 22, 1995, Springer
```

## Introduction to Finite Difference Methods

```{note}
**Key Properties of Finite Difference Methods:**

- Practical for 1, 2, or at most 3 spatial dimensions
- Simple and easy to implement (with a learning curve to avoid pitfalls)
- Accurate and robust when designed properly
- Particularly suited for linear parabolic PDEs
```

```{important}
**Applications in Finance:**

Finite difference methods are widely used for pricing:
- European and American options
- Exotic derivatives
- Path-dependent options

They provide a deterministic alternative to Monte Carlo simulation for low-dimensional problems.
```

## Discretization of Time and Space

### Time Discretization

We discretize the time interval $[0, T]$ into $N$ subintervals.

```{important}
**Time Grid:**

- Time step: $\Delta t$
- Number of steps: $N$ such that $N\Delta t = T$
- Discrete times: $\{0, \Delta t, 2\Delta t, \ldots, n\Delta t = T\}$

**Convergence:** As $\Delta t \to 0$ and $n \to +\infty$, the discrete grid converges to the continuous time interval $[0, T]$.
```

**Physical Meaning:** We approximate continuous time by sampling at regular intervals. Smaller time steps give better approximations but require more computation.

### Space Discretization

```{important}
**Space Grid:**

- Mesh points: $\{x_i = i\Delta x \mid i \in \mathbb{Z}\}$ where $\Delta x$ is the mesh size
- As $\Delta x \to 0$, the mesh converges to the whole real line

**Approximation Quality:** For $\Delta x$ small enough, the mesh provides a good approximation of the real line.
```

### The Computational Mesh

```{note}
**Complete Mesh:**

We work with the mesh:
$$
\{(n\Delta t, i\Delta x) \mid n = 0, \ldots, N; \, i \in \mathbb{Z}\}
$$

where $(\Delta t, \Delta x)$ are the discretization steps and $N$ satisfies $N\Delta t = T$.
```

**Notation:** We denote by $u_i^n$ the approximation of the option value $u$ at the grid point $(n\Delta t, i\Delta x)$:

$$
u(n\Delta t, i\Delta x) \approx u_i^n
$$

**Physical Meaning:** Instead of knowing the option value at every point in continuous space-time, we compute it only at discrete grid points.

## The Heat Equation

### Problem Formulation

```{important}
**Heat Equation (Linear Parabolic PDE):**

$$
u_t(t, x) - u_{xx}(t, x) = 0 \quad \text{for } (t, x) \in (0, T] \times \mathbb{R}
$$

**Initial condition:**
$$
u(0, x) = u_0(x)
$$

**Assumptions:** $u_0$ is continuous and bounded in $\mathbb{R}$.
```

**Physical Meaning:** The heat equation models diffusion processes. In finance, it's related to option pricing through variable transformations.

### Notation

- **Mesh:** $\{(n\Delta t, i\Delta x) \mid n = 0, \ldots, N; \, i \in \mathbb{Z}\}$ where $N\Delta t = T$
- **Approximation:** $u_i^n$ denotes the numerical solution on the mesh

## The Standard Explicit Scheme

### Finite Difference Approximations

```{important}
**Explicit Scheme for the Heat Equation:**

$$
\frac{u_i^{n+1} - u_i^n}{\Delta t} - \frac{u_{i+1}^n + u_{i-1}^n - 2u_i^n}{\Delta x^2} = 0
$$

**Rearranged form:**
$$
u_i^{n+1} = u_i^n + \Delta t \left\{\frac{u_{i+1}^n + u_{i-1}^n - 2u_i^n}{\Delta x^2}\right\}
$$

**Initial condition:**
$$
u_i^0 = u_0(i\Delta x)
$$
```

**Physical Meaning:** The scheme is "explicit" because we can directly compute $u_i^{n+1}$ at time step $n+1$ from known values at time step $n$, without solving a system of equations.

```{note}
**Algorithm Simplicity:**

The explicit scheme is very easy to implement:
1. Initialize with discretized initial condition
2. For each time step, update each spatial point using the formula above
3. March forward in time
```

### Consistency Analysis

```{important}
**Truncation Error:**

The scheme is **consistent** with the continuous equation since the truncation error is:
- **Order 2 in space:** $O(\Delta x^2)$
- **Order 1 in time:** $O(\Delta t)$
```

```{dropdown} Derivation of Truncation Error

**Taylor expansion for spatial derivative:**

$$
u_i^n(i+1) = u_i^n + u_x(n\Delta t, x_i)\Delta x + \frac{1}{2}u_{xx}(n\Delta t, x_i)\Delta x^2 + \frac{1}{6}u_{xxx}\Delta x^3 + \frac{1}{24}u_{xxxx}\Delta x^4 + \Delta x^4 \epsilon(\Delta x)
$$

$$
u_{i-1}^n = u_i^n - u_x(n\Delta t, x_i)\Delta x + \frac{1}{2}u_{xx}(n\Delta t, x_i)\Delta x^2 - \frac{1}{6}u_{xxx}\Delta x^3 + \frac{1}{24}u_{xxxx}\Delta x^4 + \Delta x^4 \epsilon(\Delta x)
$$

where $\lim_{\Delta x \to 0} \epsilon(\Delta x) = 0$.

**Adding the two expansions:**

$$
\frac{u_{i+1}^n + u_{i-1}^n - 2u_i^n}{\Delta x^2} = u_{xx} + \frac{1}{12}u_{xxxx}\Delta x^2 + \Delta x^2 \epsilon(\Delta x)
$$

Thus, the truncation error for the second spatial derivative is **order 2**.

**Taylor expansion for time derivative:**

$$
u_i^{n+1} = u_i^n + u_t(n\Delta t, x_i)\Delta t + \frac{1}{2}u_{tt}(n\Delta t, x_i)\Delta t^2 + \Delta t^2 \epsilon(\Delta t)
$$

Therefore:
$$
\frac{u_i^{n+1} - u_i^n}{\Delta t} = u_t(n\Delta t, x_i) + \frac{1}{2}u_{tt}\Delta t + \Delta t \epsilon(\Delta t)
$$

The truncation error for the first time derivative is **order 1**.
```

### Stability: The CFL Condition

```{warning}
**CFL Condition (Courant-Friedrichs-Lewy):**

The explicit scheme is **stable and convergent** if and only if:

$$
\left(1 + \frac{2\Delta t}{\Delta x^2}\right) \geq 0
$$

**Equivalent form:**
$$
\Delta t \leq \frac{1}{2}\Delta x^2
$$

**Consequence:** If this condition is violated, instabilities occur and the scheme does not converge.
```

**Physical Meaning:** The time step must be small enough relative to the spatial step. This is a fundamental limitation of explicit schemes: very small time steps may be required, leading to high computational cost.

## The Standard Implicit Scheme

### Motivation

```{note}
**Why Use Implicit Schemes?**

For many financial applications, the explicit scheme is very inaccurate because:
- The CFL condition forces the time step to be extremely small
- Small time steps cause **rounding errors** to dominate the total computational error
- **Total error = Truncation error + Rounding error**

Most of the time, an implicit scheme is preferred because it is **unconditionally convergent**, regardless of time step size.
```

### Formulation

```{important}
**Implicit Scheme for Heat Equation:**

The second derivative is evaluated at time $(n+1)\Delta t$ instead of $n\Delta t$:

$$
\frac{u_i^{n+1} - u_i^n}{\Delta t} - \frac{u_{i+1}^{n+1} + u_{i-1}^{n+1} - 2u_i^{n+1}}{\Delta x^2} = 0
$$
```

**Physical Meaning:** The scheme is "implicit" because $u_i^{n+1}$ appears on both sides of the equation, requiring us to solve a system of equations at each time step.

### Implementation

```{note}
**Key Implementation Steps:**

1. Convert the set of discrete implicit equations into a **linear system**
2. Use an efficient solver (tridiagonal system solver)
3. The truncation errors are the same as for the explicit scheme
4. The implicit scheme is **unconditionally stable** for any choice of $(\Delta t, \Delta x)$
```

**Physical Meaning:** We trade computational simplicity (no longer just plug-and-chug) for stability (can take larger time steps).

## The Black-Scholes-Merton PDE

### Original Formulation

```{important}
**Black-Scholes PDE for European Call:**

The price $u(t, x)$ of a European call option satisfies:

$$
u_t + ru - \frac{1}{2}\sigma^2 x^2 u_{xx} - rx u_x = 0, \quad \text{in } [0, T) \times [0, +\infty)
$$

**Terminal condition:**
$$
u(T, x) = (x - K)^+
$$

where:
- $r$ = risk-free interest rate
- $\sigma$ = volatility
- $K$ = strike price
- $x$ = stock price
```

```{note}
**Solution Properties:**

The solution is:
- No longer bounded
- Non-negative
- Grows at most linearly for large values of $x$

The general framework needs only slight modification to accommodate linear growth at infinity.
```

### Change of Time Variable

```{important}
**Backward Time Variable:**

We make the change of variable $\tau = T - t$ where:
- $\tau$ = time to expiration
- $t$ = real time

Define the new function:
$$
v(\tau, x) = u(t, x)
$$

**Derivatives:**
$$
u_t = -v_\tau, \quad u_x = v_x, \quad u_{xx} = v_{xx}
$$
```

```{dropdown} Derivation of PDE for $v$

Substituting derivatives into the Black-Scholes PDE:

$$
-v_\tau + rv - \frac{1}{2}\sigma^2 x^2 v_{xx} - rx v_x = 0
$$

**Rearranged:**
$$
v_\tau + rv - \frac{1}{2}\sigma^2 x^2 v_{xx} - rx v_x = 0, \quad \text{in } (0, T] \times [0, +\infty)
$$

**Initial condition:**
$$
v(0, x) = (x - K)^+
$$
```

**Physical Meaning:** This change converts the terminal condition into an initial condition, which is more natural for finite difference schemes that march forward in time.

### Removing Degeneracy: Log Transformation

```{note}
**Issue with Degeneracy:**

The Black-Scholes PDE is **degenerate** at $x = 0$ because the second derivative term vanishes when $x = 0$. This makes the equation difficult to handle mathematically.
```

```{important}
**Change of Variable:**

Make the change of variable $y = \log x$ and define:
$$
w(\tau, y) = v(\tau, x)
$$

**Derivatives:**
$$
v_\tau = w_\tau, \quad v_x = w_y \frac{1}{x}, \quad v_{xx} = w_{yy}\frac{1}{x^2} + w_y\left(-\frac{1}{x^2}\right)
$$
```

```{dropdown} Derivation of PDE for $w$

Substituting into the PDE for $v$:

$$
w_\tau + rw - \frac{1}{2}\sigma^2 w_{yy} - \left(r - \frac{1}{2}\sigma^2\right)w_y = 0, \quad \text{in } (0, T] \times \mathbb{R}
$$

**Initial condition:**
$$
w(0, y) = (e^y - K)^+
$$
```

**Physical Meaning:** Working in log-price space removes the degeneracy and makes the PDE uniformly parabolic. This is analogous to working with log-returns in empirical finance.

## Boundary Condition at $x = 0$

### Analysis of Degenerate Boundary

```{admonition} What Happens at $x = 0$?
:class: tip

We study the behavior of the solution at $x = 0$ (equivalently, $y \to -\infty$).

**Key Result:** The Black-Scholes PDE actually holds at $x = 0$ and can be solved explicitly.
```

```{dropdown} Derivation of Boundary Condition

Plugging $x = 0$ into the original Black-Scholes PDE:

$$
u_t(t, 0) = -ru(t, 0)
$$

This is an **ODE** with terminal condition $u(T, 0)$.

**Solution:**
$$
u(t, 0) = e^{-r(T-t)} u(T, 0)
$$

Since $u(T, 0) = (0 - K)^+ = 0$, we have:
$$
u(t, 0) = 0
$$
```

```{important}
**Boundary Condition:**

At the left boundary ($x = 0$ or $y = -R$):
$$
w(\tau, -R) \approx 0
$$
```

**Physical Meaning:** A call option with zero stock price is worthless, both at maturity and before.

## Finite Difference Scheme for Black-Scholes

### Mesh and Notation

```{note}
**Mesh Definition:**

$$
\{(\tau_n, y_i) \mid n = 0, \ldots, N; \, i \in \mathbb{Z}\}
$$

where:
- $N$ is such that $N\Delta\tau = T$
- $\tau_n = n\Delta\tau$
- $y_i = i\Delta y$
```

**Approximation:** We use $u_i^n$ for the approximation of $w(\tau_n, y_i)$:

$$
w(n\Delta\tau, y_i) \approx u_i^n
$$

### Centered Difference for First Derivative

```{important}
**Centered Finite Difference:**

$$
-\left(r - \frac{1}{2}\sigma^2\right)w_y \approx -\left(r - \frac{1}{2}\sigma^2\right)\frac{u_{i+1}^{n+1} - u_{i-1}^{n+1}}{2\Delta y}
$$

**Truncation Error:** Order 2 in space (better than left- or right-sided differences, which are order 1).
```

**Physical Meaning:** The centered difference uses information from both sides of the point, leading to better accuracy.

### Zero-Order Term

```{note}
**Implicit Evaluation:**

$$
rw(\tau, y) \approx r u_i^{n+1}
$$
```

### Complete Implicit Scheme

```{important}
**Implicit Scheme for Black-Scholes:**

$$
\frac{u_i^{n+1} - u_i^n}{\Delta\tau} + r u_i^{n+1} - \frac{1}{2}\sigma^2 \frac{u_{i+1}^{n+1} + u_{i-1}^{n+1} - 2u_i^{n+1}}{\Delta y^2} - \left(r - \frac{1}{2}\sigma^2\right)\frac{u_{i+1}^{n+1} - u_{i-1}^{n+1}}{2\Delta y} = 0
$$

**Initial condition:**
$$
u_i^0 = (e^{y_i} - K)^+
$$

**Stability:** The scheme is **unconditionally stable** and hence convergent for every arbitrary pair $(\Delta\tau, \Delta y)$.
```

**Physical Meaning:** Being fully implicit, the scheme is stable for any time step size, allowing us to balance accuracy and computational efficiency.

## Matrix Form of the Implicit Scheme

### Definitions

Let $h = (\Delta\tau, \Delta y)$ and define:

```{important}
**Vector and Matrix Notation:**

$$
\mathbf{u}_h^n = \begin{bmatrix}
\vdots \\
u_{i-1}^n \\
u_i^n \\
u_{i+1}^n \\
\vdots
\end{bmatrix}, \quad A_h = \begin{bmatrix}
\ddots & \ddots & \ddots \\
\cdots & a & b & c & \cdots \\
\ddots & \ddots & \ddots
\end{bmatrix}
$$

where the matrix $A_h$ is **tridiagonal**.
```

### Coefficient Values

```{important}
**Tridiagonal Coefficients:**

$$
a = -\frac{1}{2}\sigma^2\frac{\Delta\tau}{\Delta y^2} + \left(r - \frac{1}{2}\sigma^2\right)\frac{\Delta\tau}{2\Delta y}
$$

$$
b = 1 + \left(r\Delta\tau + \frac{\sigma^2\Delta\tau}{\Delta y^2}\right)
$$

$$
c = -\left(r - \frac{1}{2}\sigma^2\right)\frac{\Delta\tau}{2\Delta y} - \frac{1}{2}\sigma^2\frac{\Delta\tau}{\Delta y^2}
$$

where:
- $a$ = coefficient of $u_{i-1}^{n+1}$
- $b$ = coefficient of $u_i^{n+1}$
- $c$ = coefficient of $u_{i+1}^{n+1}$
```

### Matrix Equation

```{important}
**Matrix Form:**

$$
A_h \mathbf{u}_h^{n+1} = \mathbf{u}_h^n
$$

**Solution:**
$$
\mathbf{u}_h^{n+1} = A_h^{-1} \mathbf{u}_h^n
$$
```

```{warning}
**Efficient Solution Required:**

Since $A_h$ is **tridiagonal**, solving the system can be done efficiently and accurately using a specialized tridiagonal solver.

**Never:**
- Use a general matrix inversion
- Use MATLAB's `inv` operator (too slow and inaccurate)

**Do:**
- Use a tridiagonal system solver
- In MATLAB, use the backslash operator `\` (recognizes tridiagonal structure)
```

**Physical Meaning:** The tridiagonal structure means each spatial point only directly couples to its immediate neighbors, making the system very efficient to solve.

## Boundary Conditions on Finite Domain

### Truncated Domain

```{note}
**Practical Consideration:**

In practice, we work on a bounded domain $[-R, R]$ where $R$ is large enough.

**New Mesh:**
$$
\{(\tau_n, y_i) \mid n = 0, \ldots, N; \, i = -M, \ldots, M\}
$$

where:
- $N\Delta\tau = T$
- $M\Delta y = R$
```

### Boundary Values

```{important}
**Boundary Conditions:**

**At $y = -R$ (left boundary, $x \approx 0$):**
$$
w(\tau, -R) \approx 0
$$

**At $y = R$ (right boundary, $x \to \infty$):**
$$
w(\tau, R) \approx e^R - e^{-r\tau}K
$$

This corresponds to the deep in-the-money call value.
```

**Physical Meaning:**
- Left boundary: worthless option when stock price near zero
- Right boundary: option behaves like stock minus discounted strike when deep in-the-money

### Interior and Boundary Schemes

```{note}
**Scheme Applicability:**

- The general scheme holds for **interior points**: $i = -M+1, \ldots, M-1$
- At boundary points $i = -M$ and $i = M$, we need special treatment
```

### Handling the Left Boundary ($i = -M+1$)

```{note}
**Left Boundary Treatment:**

For $i = -M+1$, the scheme includes $u_{-M}^{n+1}$, multiplied by coefficient $a$.

**Solution:** We can safely ignore $u_{-M}^n$ in the scheme since $u_{-M}^n = 0$ by the boundary condition.

The first row of matrix $A_h$ has only 2 coefficients (coefficient $a$ is missing, but it would multiply zero anyway).
```

### Handling the Right Boundary ($i = M-1$)

```{important}
**Right Boundary Treatment:**

We must impose:
$$
u_M^n = e^{M\Delta y} - e^{-r(n\Delta\tau)}K
$$

For $i = M-1$, coefficient $c$ is missing in the last row of $A_h$. This coefficient would multiply $u_M^n$.

**Solution:** Incorporate the Dirichlet condition in the **right-hand side**.

The last component of the right-hand side becomes:
$$
u_{M-1}^n + \left\{-\frac{1}{2}\sigma^2\frac{\Delta\tau}{\Delta y^2} + \left(r - \frac{1}{2}\sigma^2\right)\frac{\Delta\tau}{2\Delta y}\right\}\left(e^{M\Delta y} - e^{-r((n+1)\Delta\tau)}K\right)
$$
```

**Physical Meaning:** We build the known boundary value into the system, converting a constraint into part of the right-hand side vector.

## Recapitulation: Complete System

### Matrix Structure

```{important}
**Tridiagonal System:**

We solve:
$$
A_h \mathbf{u}_h^{n+1} = \mathbf{B}_h^n
$$

where $A_h$ is a $(2M-1) \times (2M-1)$ matrix:

$$
A_h = \begin{bmatrix}
b & c & & & \\
a & b & c & & \\
& \ddots & \ddots & \ddots & \\
& & a & b & c \\
& & & a & b
\end{bmatrix}
$$
```

### Right-Hand Side Vector

```{important}
**Modified Right-Hand Side:**

$$
\mathbf{B}_h^n = \begin{bmatrix}
u_{-M+1}^n \\
\vdots \\
u_{i-1}^n \\
u_i^n \\
u_{i+1}^n \\
\vdots \\
u_{M-2}^n \\
u_{M-1}^n - c(e^{M\Delta y} - e^{-r((n+1)\Delta\tau)}K)
\end{bmatrix}
$$

**Note:** The last entry is modified to incorporate the right boundary condition.
```

## Implementation Guidelines

```{warning}
**Critical Implementation Notes:**

1. **Use a tridiagonal solver:** Don't create and invert a full matrix
2. **Memory efficiency:** Define 3 vectors for coefficients $(a, b, c)$ rather than a full $(2M-1) \times (2M-1)$ matrix
3. **MATLAB backslash operator:** Can use `\`, but:
   - Requires creating a sparse matrix
   - Consumes more memory than 3 vectors
   - Still better than `inv` operator
4. **Never use `inv` operator:** Too slow and potentially inaccurate
```

**Physical Meaning:** Efficient implementation is crucial because we solve this linear system many times (once per time step).

## Complete Algorithm

```{admonition} Step-by-Step Algorithm
:class: tip

**Step 1: Set Parameters**
- $T, K, r, \sigma$ (option parameters)
- $\Delta\tau, \Delta y$ (discretization steps)
- $N, M$ (integers for grid size)

**Step 2: Define Matrix Diagonals**
- Define vectors $\mathbf{a}, \mathbf{b}, \mathbf{c}$ (or full matrix $A_h$)

**Step 3: Initialize**
$$
u_i^0 = (e^{i\Delta y} - K)^+, \quad \text{for } i = -M, \ldots, M
$$

**Step 4: Time Loop**

For $n = 0, \ldots, N-1$:

4.1. Define $\mathbf{B}_h^n$ (right-hand side)

4.2. Given $(u_i^n)_{i=-M}^M$, solve:
$$
A_h \mathbf{u}_h^{n+1} = \mathbf{B}_h^n
$$
to compute $u_i^{n+1}$ for $i = -M+1, \ldots, M-1$

4.3. Set boundary values:
$$
u_{-M}^{n+1} = 0, \quad u_M^{n+1} = e^{M\Delta y} - e^{-r((n+1)\Delta\tau)}K
$$

**Step 5: Extract Solution**
- Option price at time 0: $u_0^N$ (at $y = 0$, i.e., $x = K$)
```

## Tridiagonal System Solver in MATLAB

```{note}
**MATLAB Implementation:**

The following function efficiently solves tridiagonal systems.
```

```matlab
function x = TDMAsolver(a, b, c, d)
% a, b, c are column vectors for the compressed tridiagonal matrix
% d is the right-hand side vector
n = length(d); % n is the number of rows

% Modify the first-row coefficients
c(1) = c(1) / b(1); % Division by zero risk
d(1) = d(1) / b(1);

for i = 2:n-1
    temp = b(i) - a(i) * c(i-1);
    c(i) = c(i) / temp;
    d(i) = (d(i) - a(i) * d(i-1)) / temp;
end

d(n) = (d(n) - a(n) * d(n-1)) / (b(n) - a(n) * c(n-1));

% Back substitution
x(n) = d(n);
for i = n-1:-1:1
    x(i) = d(i) - c(i) * x(i+1);
end
end
```

```{note}
**Algorithm Complexity:**

The Thomas algorithm (TDMA) solves a tridiagonal system in $O(n)$ operations, compared to $O(n^3)$ for general Gaussian elimination. This efficiency is crucial for real-time pricing.
```

## Summary

In this lecture, we covered:

1. **Finite Difference Fundamentals:**
   - Discretization of time and space
   - Explicit vs. implicit schemes
   - Stability and the CFL condition

2. **Heat Equation:**
   - Standard explicit and implicit schemes
   - Consistency and truncation error analysis

3. **Black-Scholes PDE:**
   - Change of variables (backward time and log-price)
   - Removal of degeneracy
   - Boundary conditions

4. **Numerical Implementation:**
   - Matrix formulation
   - Tridiagonal system structure
   - Efficient solution methods
   - Complete algorithm

5. **Practical Considerations:**
   - Boundary condition treatment
   - Memory-efficient implementation
   - MATLAB code for tridiagonal solver

```{important}
**Key Takeaway:**

Finite difference methods provide a powerful framework for pricing options numerically. The implicit scheme's unconditional stability makes it the method of choice for many financial applications, despite requiring solution of linear systems at each time step.
```

---

## References

1. J.W. Thomas, "Numerical Partial Differential Equations: Finite Difference Methods", Texts in Applied Mathematics, 22, 1995, Springer
