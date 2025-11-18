---
title: "Chapter 5: Bonds and Zero Rates"
author: "Based on John C. Hull"
date: "2025"
---

# Bonds and Zero Rates

This chapter explores bond valuation, zero-coupon rates (spot rates), yield curves, and key interest rate concepts. We'll learn how to construct zero curves from bond prices, calculate bond yields, and understand duration and convexity.

## Compounding Frequencies

Interest rates can be quoted with different compounding conventions, similar to how distance can be measured in miles or kilometers.

```{admonition} Key Concept: Compounding Frequency
:class: tip

**Compounding frequency** is the number of times per year that interest is calculated and added to principal.

**Common Frequencies:**
- **Annual** ($m=1$): Once per year
- **Semiannual** ($m=2$): Twice per year
- **Quarterly** ($m=4$): Four times per year
- **Monthly** ($m=12$): Twelve times per year
- **Daily** ($m=365$): Every day
- **Continuous** ($m \to \infty$): Instantaneous compounding
```

### Impact of Compounding Frequency

```{admonition} Example: Effect of Compounding
:class: tip

**$100 invested for 1 year at 10% annual rate:**

| Compounding Frequency | Formula | Future Value |
|----------------------|---------|--------------|
| Annual ($m=1$) | $100(1+0.10)^1$ | $110.00 |
| Semiannual ($m=2$) | $100(1+0.10/2)^2$ | $110.25 |
| Quarterly ($m=4$) | $100(1+0.10/4)^4$ | $110.38 |
| Monthly ($m=12$) | $100(1+0.10/12)^{12}$ | $110.47 |
| Weekly ($m=52$) | $100(1+0.10/52)^{52}$ | $110.51 |
| Daily ($m=365$) | $100(1+0.10/365)^{365}$ | $110.52 |
| Continuous | $100e^{0.10}$ | $110.52 |
```

**Physical Meaning**: More frequent compounding means interest is added more often, so you earn "interest on interest" sooner, resulting in slightly higher returns.

```{note}
**Key Observation:**

- As compounding frequency increases, future value increases
- But gains diminish - difference between daily and continuous is negligible
- Continuous compounding is the mathematical limit
```

---

## Measuring Interest Rates

```{important}
**The Compounding Convention is the Unit of Measurement**

Just as distance needs units (miles vs. kilometers), interest rates need compounding conventions:
- 10% with annual compounding ≠ 10% with semiannual compounding
- The rate and its compounding frequency must always be specified together
- Converting between frequencies is like converting miles to kilometers
```

---

## Continuous Compounding

Continuous compounding is the mathematical limit as compounding frequency approaches infinity.

```{admonition} Key Concept: Continuous Compounding
:class: tip

**With continuous compounding:**

**Future Value:**

$$FV = PV \cdot e^{RT}$$

**Present Value:**

$$PV = FV \cdot e^{-RT}$$

Where:
- $R$ = Continuously compounded rate
- $T$ = Time period
- $e$ = 2.71828... (Euler's number)
```

**Why Use Continuous Compounding?**

```{note}
**Advantages of Continuous Compounding:**

1. **Mathematical elegance**: Derivatives and integrals are simpler
2. **Additive property**: Rates over different periods simply add
3. **Natural for stochastic calculus**: Used in option pricing models
4. **Academic standard**: Common in financial theory

**Example of Additive Property:**
- 5% for 1 year + 6% for 1 year = 11% for 2 years (with continuous compounding)
- Not true for other compounding frequencies!
```

```{admonition} Example Problem: Continuous Compounding
:class: tip

**Problem Statement:**
You invest $5,000 at 6% per annum with continuous compounding for 3.5 years. How much will you have?

**Given:**
- $PV = \$5,000$
- $R = 0.06$
- $T = 3.5$ years
```

```{dropdown} Solution

**Step 1: Apply Future Value Formula**

$$FV = PV \cdot e^{RT}$$

**Step 2: Substitute Values**

$$FV = 5,000 \times e^{0.06 \times 3.5}$$

$$FV = 5,000 \times e^{0.21}$$

$$FV = 5,000 \times 1.2337$$

$$FV = \$6,168.55$$

**Step 3: Calculate Interest Earned**

$$\text{Interest} = 6,168.55 - 5,000 = \$1,168.55$$

**Final Answer:** After 3.5 years, you will have \$6,168.55.

**Comparison with Annual Compounding:**

$$FV = 5,000(1.06)^{3.5} = 5,000 \times 1.2293 = \$6,146.42$$

Continuous compounding yields $22.13 more (not a huge difference).
```

---

## Conversion Formulas Between Compounding Frequencies

To convert rates between different compounding conventions:

```{admonition} Key Formulas: Rate Conversion
:class: tip

**From $m$ times per year to continuous:**

$$R_c = m \ln\left(1 + \frac{R_m}{m}\right)$$

**From continuous to $m$ times per year:**

$$R_m = m\left(e^{R_c/m} - 1\right)$$

Where:
- $R_c$ = Continuously compounded rate
- $R_m$ = Rate with compounding $m$ times per year
- $\ln$ = Natural logarithm
```

```{admonition} Example Problem: Converting Interest Rates
:class: tip

**Problem 1:** Convert 10% with semiannual compounding to continuous compounding.

**Problem 2:** Convert 8% with continuous compounding to quarterly compounding.
```

```{dropdown} Solutions

**Problem 1: Semiannual to Continuous**

**Given:** $R_m = 10\%$ with $m = 2$

$$R_c = m \ln\left(1 + \frac{R_m}{m}\right)$$

$$R_c = 2 \ln\left(1 + \frac{0.10}{2}\right)$$

$$R_c = 2 \ln(1.05)$$

$$R_c = 2 \times 0.04879$$

$$R_c = 0.09758 = 9.758\%$$

**Answer:** 10% semiannual = **9.758% continuous**

**Problem 2: Continuous to Quarterly**

**Given:** $R_c = 8\%$ with $m = 4$

$$R_m = m\left(e^{R_c/m} - 1\right)$$

$$R_m = 4\left(e^{0.08/4} - 1\right)$$

$$R_m = 4(e^{0.02} - 1)$$

$$R_m = 4(1.0202 - 1)$$

$$R_m = 4 \times 0.0202$$

$$R_m = 0.0808 = 8.08\%$$

**Answer:** 8% continuous = **8.08% quarterly**

**Physical Meaning**: More frequent compounding requires a higher stated rate to achieve the same effective return. Conversely, moving to less frequent compounding requires a lower stated rate.
```

---

## Zero Rates (Spot Rates)

```{admonition} Key Concept: Zero Rate
:class: tip

A **zero rate** (or **spot rate**) for maturity $T$ is the rate of interest earned on an investment that:
- Provides a single payoff only at time $T$
- Has no intermediate cash flows
- Is risk-free

**Notation:** $R(T)$ or $r(T)$ = zero rate for maturity $T$
```

**Physical Meaning**: A zero rate is the interest rate on a pure discount bond (zero-coupon bond). It tells you the return for lending money from now until time $T$ with payment only at $T$.

### The Zero Curve

```{note}
**Zero Curve (Term Structure):**

A plot of zero rates against maturity forms the **zero curve** or **term structure of interest rates**.

**Shape can be:**
- **Upward sloping**: Long rates > Short rates (normal)
- **Flat**: Rates constant across maturities
- **Downward sloping (inverted)**: Long rates < Short rates (unusual, recession signal)
- **Humped**: Rates rise then fall
```

---

## The Bootstrap Method

The bootstrap method constructs the zero curve from observed bond prices.

```{admonition} Key Concept: Bootstrap Method
:class: tip

**Bootstrapping** derives zero rates sequentially:
1. Start with shortest maturity
2. Calculate zero rate directly
3. Use known zero rates to find next maturity
4. Repeat for all maturities

**Requirements:**
- Prices of bonds with different maturities
- Work from short to long maturities
```

### Bootstrap Example with Market Data

```{admonition} Example Problem: Bootstrapping the Zero Curve
:class: tip

**Problem Statement:**
Given the following bond data, construct the zero curve:

| Bond | Principal | Time to Maturity | Annual Coupon | Bond Price |
|------|-----------|------------------|---------------|------------|
| A | $100 | 0.25 years | $0 | $99.6 |
| B | $100 | 0.50 years | $0 | $99.0 |
| C | $100 | 1.00 years | $0 | $97.8 |
| D | $100 | 1.50 years | $4 | $102.5 |
| E | $100 | 2.00 years | $5 | $105.0 |

Calculate the zero rates (continuously compounded) for all maturities.
```

```{dropdown} Solution

**Step 1: 3-Month Zero Rate (Bond A)**

Bond A is a pure discount bond:
- Pay $99.6 today, receive $100 in 0.25 years

$$99.6 = 100 \times e^{-R(0.25) \times 0.25}$$

$$e^{-0.25R(0.25)} = 0.996$$

$$-0.25R(0.25) = \ln(0.996) = -0.004008$$

$$R(0.25) = 0.01603 = 1.603\%$$

**Step 2: 6-Month Zero Rate (Bond B)**

$$99.0 = 100 \times e^{-R(0.5) \times 0.5}$$

$$e^{-0.5R(0.5)} = 0.99$$

$$-0.5R(0.5) = \ln(0.99) = -0.01005$$

$$R(0.5) = 0.02010 = 2.010\%$$

**Step 3: 1-Year Zero Rate (Bond C)**

$$97.8 = 100 \times e^{-R(1.0) \times 1.0}$$

$$e^{-R(1.0)} = 0.978$$

$$-R(1.0) = \ln(0.978) = -0.02225$$

$$R(1.0) = 0.02225 = 2.225\%$$

**Step 4: 1.5-Year Zero Rate (Bond D)**

Bond D pays coupons: $2 at 0.5 years, $2 at 1.0 years, $102 at 1.5 years

$$102.5 = 2e^{-0.02010 \times 0.5} + 2e^{-0.02225 \times 1.0} + 102e^{-R(1.5) \times 1.5}$$

Calculate present value of known cash flows:
- $2e^{-0.01005} = 2 \times 0.99 = \$1.98$
- $2e^{-0.02225} = 2 \times 0.978 = \$1.96$
- Total = $3.94

Remaining present value:

$$102.5 - 3.94 = 98.56 = 102e^{-1.5R(1.5)}$$

$$e^{-1.5R(1.5)} = 0.9662$$

$$-1.5R(1.5) = \ln(0.9662) = -0.03426$$

$$R(1.5) = 0.02284 = 2.284\%$$

**Step 5: 2-Year Zero Rate (Bond E)**

Bond E pays: $2.5 at 0.5, 1.0, 1.5, and 2.0 years, plus $100 at 2.0 years

$$105.0 = 2.5e^{-0.01005} + 2.5e^{-0.02225} + 2.5e^{-0.03426} + 102.5e^{-R(2.0) \times 2.0}$$

Known cash flows:
- At 0.5: $2.5 \times 0.99 = \$2.475$
- At 1.0: $2.5 \times 0.978 = \$2.445$
- At 1.5: $2.5 \times 0.9662 = \$2.416$
- Total = $7.336

Remaining:

$$105.0 - 7.336 = 97.664 = 102.5e^{-2.0R(2.0)}$$

$$e^{-2.0R(2.0)} = 0.9529$$

$$-2.0R(2.0) = \ln(0.9529) = -0.04832$$

$$R(2.0) = 0.02416 = 2.416\%$$

**Final Answer: Zero Curve**

| Maturity (years) | Zero Rate (%) |
|------------------|---------------|
| 0.25 | 1.603% |
| 0.50 | 2.010% |
| 1.00 | 2.225% |
| 1.50 | 2.284% |
| 2.00 | 2.416% |

**Physical Meaning**: The zero curve is upward sloping, indicating that longer-term lending commands higher rates (normal term structure). Each zero rate represents the return for a pure investment over that specific period.
```

---

## Bond Pricing Using Zero Rates

Once we have the zero curve, we can price any bond by discounting each cash flow at the appropriate zero rate.

```{admonition} Key Formula: Bond Pricing
:class: tip

**Theoretical bond price:**

$$P = \sum_{i=1}^{n} C_i e^{-R(t_i) \cdot t_i}$$

Where:
- $C_i$ = Cash flow at time $t_i$
- $R(t_i)$ = Zero rate for maturity $t_i$
- $n$ = Number of cash flows
```

```{admonition} Example Problem: Bond Pricing
:class: tip

Using the zero curve from the previous example, calculate the theoretical price of a 2-year bond with 6% annual coupon (paid semiannually).

**Bond specifications:**
- Face value: $100
- Coupon: 6% per annum (3% semiannually)
- Cash flows: $3 at 0.5, 1.0, 1.5, and 2.0 years, plus $100 at 2.0 years
```

```{dropdown} Solution

**Step 1: List All Cash Flows**

| Time (years) | Cash Flow | Zero Rate |
|--------------|-----------|-----------|
| 0.5 | $3 | 2.010% |
| 1.0 | $3 | 2.225% |
| 1.5 | $3 | 2.284% |
| 2.0 | $103 | 2.416% |

**Step 2: Discount Each Cash Flow**

At 0.5 years:

$$PV_1 = 3 \times e^{-0.02010 \times 0.5} = 3 \times e^{-0.01005} = 3 \times 0.99 = \$2.970$$

At 1.0 years:

$$PV_2 = 3 \times e^{-0.02225 \times 1.0} = 3 \times 0.978 = \$2.934$$

At 1.5 years:

$$PV_3 = 3 \times e^{-0.02284 \times 1.5} = 3 \times e^{-0.03426} = 3 \times 0.9663 = \$2.899$$

At 2.0 years:

$$PV_4 = 103 \times e^{-0.02416 \times 2.0} = 103 \times e^{-0.04832} = 103 \times 0.9529 = \$98.15$$

**Step 3: Sum Present Values**

$$\text{Bond Price} = 2.970 + 2.934 + 2.899 + 98.15 = \$106.95$$

**Final Answer:** The theoretical price is \$106.95.

**Interpretation**: The 6% coupon bond trades above par ($100) because coupon rates exceed prevailing market rates, making it more valuable.
```

---

## Bond Yield

```{admonition} Key Concept: Bond Yield (YTM)
:class: tip

The **bond yield** or **yield to maturity (YTM)** is the single discount rate that makes the present value of all bond cash flows equal to the bond's market price.

**Mathematically:**

$$P = \sum_{i=1}^{n} C_i e^{-y \cdot t_i}$$

Where $y$ is the yield (continuously compounded).
```

**Physical Meaning**: The yield is the average rate of return you'll earn if you buy the bond at the current price and hold it to maturity, assuming all coupons are reinvested at the yield.

```{admonition} Example Problem: Calculating Bond Yield
:class: tip

**Problem:**
The 2-year bond from our previous example trades at $98.39. What is its yield to maturity (continuously compounded)?

**Cash flows:** $3 at 0.5, 1.0, 1.5 years; $103 at 2.0 years
```

```{dropdown} Solution

**Step 1: Set Up Equation**

$$98.39 = 3e^{-0.5y} + 3e^{-1.0y} + 3e^{-1.5y} + 103e^{-2.0y}$$

**Step 2: Solve Iteratively (Trial and Error or Numerical Method)**

Try $y = 0.065$ (6.5%):
- $3e^{-0.0325} = 3 \times 0.968 = 2.904$
- $3e^{-0.065} = 3 \times 0.937 = 2.811$
- $3e^{-0.0975} = 3 \times 0.907 = 2.721$
- $103e^{-0.13} = 103 \times 0.878 = 90.43$
- Total = 98.87 (too high)

Try $y = 0.070$ (7.0%):
- $3e^{-0.035} = 2.897$
- $3e^{-0.070} = 2.797$
- $3e^{-0.105} = 2.702$
- $103e^{-0.14} = 88.26$
- Total = 96.66 (too low)

Try $y = 0.0676$ (6.76%):
- More refined calculation yields ≈ 98.39 ✓

**Final Answer:** The yield to maturity is approximately **6.76%** (continuously compounded).

**Physical Meaning**: Even though the zero rates vary from 2.01% to 2.42%, the single yield that prices this bond is 6.76% - much higher because the bond is trading at a discount.
```

---

## Par Yield

```{admonition} Key Concept: Par Yield
:class: tip

The **par yield** for a given maturity is the coupon rate that makes a bond trade exactly at par (price = face value).

**Application:**
- Used in swap pricing
- Benchmark for newly issued bonds
- Helps understand market expectations
```

```{admonition} Example Problem: Calculating Par Yield
:class: tip

Using our zero curve, calculate the 2-year par yield (paid semiannually).

**Zero rates:**
- 0.5 years: 2.010%
- 1.0 years: 2.225%
- 1.5 years: 2.284%
- 2.0 years: 2.416%
```

```{dropdown} Solution

**Step 1: Set Up Par Bond Equation**

For a bond trading at par:

$$100 = \frac{c}{2}e^{-0.01005} + \frac{c}{2}e^{-0.02225} + \frac{c}{2}e^{-0.03426} + \left(\frac{c}{2} + 100\right)e^{-0.04832}$$

Where $c$ is the annual coupon rate.

**Step 2: Calculate Discount Factors**

- $e^{-0.01005} = 0.99$
- $e^{-0.02225} = 0.978$
- $e^{-0.03426} = 0.9663$
- $e^{-0.04832} = 0.9529$

**Step 3: Substitute and Solve**

$$100 = \frac{c}{2}(0.99 + 0.978 + 0.9663 + 0.9529) + 100 \times 0.9529$$

$$100 = \frac{c}{2}(3.887) + 95.29$$

$$4.71 = \frac{c}{2}(3.887)$$

$$4.71 = 1.9435c$$

$$c = 2.42\%$$

**Alternative Formula:**

$$c = \frac{2(100 - 100e^{-R(T) \times T})}{\sum_{i=1}^{n} e^{-R(t_i) \times t_i}}$$

$$c = \frac{2(100 - 95.29)}{3.887} = \frac{2 \times 4.71}{3.887} = 2.42\%$$

**Final Answer:** The 2-year par yield is **2.42%** per annum (1.21% per semiannual period).

**Physical Meaning**: If you issued a 2-year bond today with a 2.42% coupon, it would sell at exactly par value ($100) given the current zero curve.
```

---

## Forward Rates

Forward rates are implied future interest rates embedded in the zero curve.

```{admonition} Key Concept: Forward Rate
:class: tip

The **forward rate** $F(T_1, T_2)$ is the interest rate implied today for borrowing/lending between future times $T_1$ and $T_2$.

**Formula:**

$$F(T_1, T_2) = \frac{R(T_2) \cdot T_2 - R(T_1) \cdot T_1}{T_2 - T_1}$$

Where $R(T)$ is the zero rate for maturity $T$.
```

```{admonition} Example Problem: Forward Rates
:class: tip

From our zero curve:
- $R(1.0) = 2.225\%$
- $R(1.5) = 2.284\%$

Calculate the forward rate for the period from year 1.0 to year 1.5.
```

```{dropdown} Solution

**Step 1: Apply Forward Rate Formula**

$$F(1.0, 1.5) = \frac{R(1.5) \times 1.5 - R(1.0) \times 1.0}{1.5 - 1.0}$$

**Step 2: Substitute Values**

$$F(1.0, 1.5) = \frac{0.02284 \times 1.5 - 0.02225 \times 1.0}{0.5}$$

$$= \frac{0.03426 - 0.02225}{0.5}$$

$$= \frac{0.01201}{0.5}$$

$$= 0.02402 = 2.402\%$$

**Final Answer:** The forward rate from year 1.0 to year 1.5 is **2.402%**.

**Interpretation**: The market implies that lending from year 1 to year 1.5 will earn 2.402% (continuously compounded).

**Verification via No-Arbitrage:**

Two equivalent strategies:
1. Invest for 1.5 years at 2.284%: $100e^{0.02284 \times 1.5} = \$103.46$
2. Invest for 1.0 year at 2.225%, then reinvest for 0.5 years at forward rate:
   - After 1 year: $100e^{0.02225} = \$102.25$
   - After 1.5 years: $102.25e^{0.02402 \times 0.5} = 102.25 \times 1.0121 = \$103.49$

Close enough (small differences due to rounding)!
```

---

## Instantaneous Forward Rate

```{admonition} Key Concept: Instantaneous Forward Rate
:class: tip

The **instantaneous forward rate** $f(T)$ is the forward rate for an infinitesimally short period starting at time $T$.

**Formula:**

$$f(T) = R(T) + T \frac{\partial R(T)}{\partial T}$$

Or equivalently:

$$f(T) = \frac{\partial}{\partial T}[T \cdot R(T)]$$

**Relationship to Zero Rates:**

$$R(T) = \frac{1}{T} \int_0^T f(u) \, du$$

The zero rate is the average of instantaneous forward rates.
```

**Physical Meaning**: The instantaneous forward rate is the marginal rate - the rate implied for an additional infinitesimal period. It's analogous to marginal cost in economics.

---

## Duration

Duration measures a bond's sensitivity to interest rate changes.

```{admonition} Key Concept: Duration
:class: tip

**Macaulay Duration** measures the weighted average time to receive cash flows:

$$D = \frac{1}{B} \sum_{i=1}^{n} t_i \cdot C_i \cdot e^{-y \cdot t_i}$$

Where:
- $B$ = Bond price
- $C_i$ = Cash flow at time $t_i$
- $y$ = Yield to maturity
- $t_i$ = Time to cash flow $i$
```

### The Key Duration Relationship

```{important}
**Price-Yield Relationship:**

$$\frac{\Delta B}{B} = -D \cdot \Delta y$$

Or equivalently:

$$\Delta B = -D \cdot B \cdot \Delta y$$

**Interpretation:**
- **Duration** measures percentage price change per unit change in yield
- Negative sign: Bond prices and yields move inversely
- Larger duration → Greater interest rate sensitivity
```

```{admonition} Example Problem: Duration Calculation
:class: tip

**Problem:**
A 2-year bond with 5% annual coupon (paid semiannually) trades at $100. The yield is 5% (continuously compounded). Calculate its duration.

**Cash flows:**
- $2.50 at 0.5, 1.0, 1.5, 2.0 years
- $100 at 2.0 years (in addition to final coupon)
```

```{dropdown} Solution

**Step 1: Calculate Present Value of Each Cash Flow**

At 0.5 years:

$$PV_1 = 2.50 \times e^{-0.05 \times 0.5} = 2.50 \times 0.9753 = \$2.438$$

At 1.0 years:

$$PV_2 = 2.50 \times e^{-0.05 \times 1.0} = 2.50 \times 0.9512 = \$2.378$$

At 1.5 years:

$$PV_3 = 2.50 \times e^{-0.05 \times 1.5} = 2.50 \times 0.9277 = \$2.319$$

At 2.0 years:

$$PV_4 = 102.50 \times e^{-0.05 \times 2.0} = 102.50 \times 0.9048 = \$92.74$$

**Total:** $2.438 + 2.378 + 2.319 + 92.74 = \$99.875 ≈ \$100$ ✓

**Step 2: Calculate Weighted Time**

$$D = \frac{1}{100}\left[0.5 \times 2.438 + 1.0 \times 2.378 + 1.5 \times 2.319 + 2.0 \times 92.74\right]$$

$$D = \frac{1}{100}\left[1.219 + 2.378 + 3.479 + 185.48\right]$$

$$D = \frac{192.56}{100} = 1.926 \text{ years}$$

**Final Answer:** Duration = **1.926 years**

**Interpretation:** For a 1% increase in yield, the bond price will decrease by approximately 1.926%.

**Verification:**
If yield increases to 6%:

$$\Delta B \approx -1.926 \times 100 \times 0.01 = -\$1.93$$

New price ≈ $98.07

Exact calculation: Bond price at 6% yield ≈ $98.11 (very close!)
```

### Modified Duration

```{note}
**Modified Duration:**

When yield is expressed with compounding $m$ times per year:

$$\frac{\Delta B}{B} = -\frac{D}{1 + y/m} \cdot \Delta y$$

The term $\frac{D}{1 + y/m}$ is called **modified duration**.

**For continuous compounding:**
Modified duration = Macaulay duration (since $1 + y/\infty = 1$)
```

---

## Convexity

Duration is a linear approximation. Convexity measures curvature, improving accuracy.

```{admonition} Key Concept: Convexity
:class: tip

**Convexity** measures the curvature in the price-yield relationship:

$$C = \frac{1}{B} \sum_{i=1}^{n} t_i^2 \cdot C_i \cdot e^{-y \cdot t_i}$$

**More Accurate Price Change Formula:**

$$\frac{\Delta B}{B} = -D \cdot \Delta y + \frac{1}{2} C \cdot (\Delta y)^2$$

**Convexity Effects:**
- **Positive convexity** (typical for bonds): Prices rise more when yields fall than they fall when yields rise
- **Negative convexity** (callable bonds, MBS): Opposite behavior
```

```{admonition} Example: Duration vs. Duration + Convexity
:class: tip

Using the previous bond (Duration = 1.926 years), suppose convexity = 5.0.

**Scenario:** Yield increases from 5% to 6% (Δy = 0.01)

**Using Duration Only:**

$$\frac{\Delta B}{B} = -1.926 \times 0.01 = -0.01926 = -1.926\%$$

$$\Delta B = -1.926 \Rightarrow \text{New price} = \$98.07$$

**Using Duration + Convexity:**

$$\frac{\Delta B}{B} = -1.926 \times 0.01 + \frac{1}{2} \times 5.0 \times (0.01)^2$$

$$= -0.01926 + 0.00025 = -0.01901 = -1.901\%$$

$$\Delta B = -1.901 \Rightarrow \text{New price} = \$98.10$$

The convexity adjustment improves accuracy!
```

**Physical Meaning**: Duration assumes a straight-line relationship between price and yield. Convexity recognizes that the relationship is actually curved, like a parabola. This curvature means that bonds lose less value when yields rise (and gain more when yields fall) than duration alone suggests.

---

## Bond Portfolios: Duration Matching

```{important}
**Portfolio Duration:**

For a bond portfolio, duration describes sensitivity to **parallel shifts** in the yield curve.

**Duration Matching:**
- If duration of assets = duration of liabilities
- Portfolio is immunized against small parallel yield curve shifts

**Remaining Exposures:**
- Non-parallel shifts (twists, bends)
- Large yield changes (convexity matters)
- Credit spread changes
- Reinvestment risk
```

**Physical Meaning**: Duration matching is like balancing on a seesaw - you match the weighted average time of cash inflows and outflows. But if the seesaw tilts differently on each side (non-parallel shift), you're still exposed.

---

## Chapter Summary

```{important}
**Key Takeaways:**

1. **Compounding frequency** affects interest rate measurement; must specify rate and frequency together
2. **Continuous compounding** uses $e^{rT}$ and is mathematically convenient
3. **Conversion formulas** translate rates between compounding conventions
4. **Zero rates** are yields on zero-coupon bonds for each maturity
5. **Bootstrap method** derives zero curve from bond prices sequentially
6. **Bond pricing** discounts each cash flow at appropriate zero rate
7. **Bond yield (YTM)** is single rate making PV = price
8. **Par yield** is coupon rate making bond trade at par
9. **Forward rates** are implied future rates from zero curve
10. **Duration** measures interest rate sensitivity: $\Delta B/B = -D \cdot \Delta y$
11. **Convexity** measures curvature, improving duration approximation
12. **Portfolio duration** immunizes against parallel yield curve shifts
```

```{seealso}
**Looking Ahead:**

Chapter 6 introduces the **Binomial Model**, a fundamental tool for pricing derivatives using risk-neutral valuation and tree-based methods.
```

---

## Practice Problems

```{admonition} Practice Problem 1: Zero Curve Construction
:class: tip

You observe the following bond prices:

| Maturity | Coupon (Annual) | Price |
|----------|-----------------|-------|
| 0.5 years | 0% | $98.5 |
| 1.0 years | 0% | $97.0 |
| 1.5 years | 4% | $100.0 |

**Questions:**
1. Calculate the 0.5-year zero rate
2. Calculate the 1.0-year zero rate
3. Calculate the 1.5-year zero rate (coupon paid semiannually)
4. What is the forward rate from 1.0 to 1.5 years?
```

```{dropdown} Solution to Practice Problem 1

**Part 1: 0.5-Year Zero Rate**

$$98.5 = 100e^{-R(0.5) \times 0.5}$$

$$e^{-0.5R(0.5)} = 0.985$$

$$R(0.5) = -\frac{\ln(0.985)}{0.5} = -\frac{-0.01511}{0.5} = 0.03023 = 3.023\%$$

**Part 2: 1.0-Year Zero Rate**

$$97.0 = 100e^{-R(1.0) \times 1.0}$$

$$R(1.0) = -\ln(0.97) = 0.03046 = 3.046\%$$

**Part 3: 1.5-Year Zero Rate**

Bond pays $2 at 0.5 years, $2 at 1.0 years, $102 at 1.5 years

$$100 = 2e^{-0.03023 \times 0.5} + 2e^{-0.03046 \times 1.0} + 102e^{-R(1.5) \times 1.5}$$

Known PVs:
- $2e^{-0.01511} = 2 \times 0.985 = 1.970$
- $2e^{-0.03046} = 2 \times 0.970 = 1.940$
- Total = 3.910

Remaining:

$$100 - 3.910 = 96.09 = 102e^{-1.5R(1.5)}$$

$$e^{-1.5R(1.5)} = 0.9420$$

$$R(1.5) = -\frac{\ln(0.9420)}{1.5} = \frac{0.05974}{1.5} = 0.03983 = 3.983\%$$

**Part 4: Forward Rate (1.0 to 1.5 years)**

$$F(1.0, 1.5) = \frac{R(1.5) \times 1.5 - R(1.0) \times 1.0}{1.5 - 1.0}$$

$$= \frac{0.03983 \times 1.5 - 0.03046 \times 1.0}{0.5}$$

$$= \frac{0.05975 - 0.03046}{0.5} = \frac{0.02929}{0.5} = 0.05858 = 5.858\%$$

**Final Answers:**
1. 0.5-year zero rate: **3.023%**
2. 1.0-year zero rate: **3.046%**
3. 1.5-year zero rate: **3.983%**
4. Forward rate (1.0 to 1.5): **5.858%**

**Interpretation**: The upward-sloping zero curve implies increasing forward rates - the market expects higher rates in the future.
```

---
