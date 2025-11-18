---
title: "Chapter 4: Interest Rates and Repo Markets"
author: "Based on John C. Hull"
date: "2025"
---

# Interest Rates and Repo Markets

This chapter examines interest rate markets, focusing on risk-free rates, repo transactions, the LIBOR transition, and new reference rates like SOFR. Understanding these concepts is essential for pricing derivatives and managing funding costs.

## The U.S. Treasury Market

```{admonition} Key Concept: U.S. Treasury Market
:class: tip

The U.S. Treasury market is:
- **Deepest and most liquid** government securities market globally
- Primary means of **financing the U.S. Federal Government**
- Significant **investment instrument** and **hedging vehicle**
- **Benchmark** for other financial instruments
- Critical for **Federal Reserve monetary policy implementation**
```

### Why Treasury Markets Matter for Derivatives

```{note}
**Importance for Derivatives Pricing:**

1. **Benchmark rates**: Treasury rates serve as base rates for pricing
2. **Risk-free proxy**: Used as proxy for theoretical risk-free rate
3. **Collateral**: Treasuries widely used as collateral in derivatives
4. **Hedging**: Treasury futures used to hedge interest rate risk
5. **Funding**: Repo markets (based on Treasuries) provide financing
```

**Physical Meaning**: Think of the Treasury market as the foundation of the interest rate system - all other rates are built on top of this base, incorporating various risk premiums.

---

## The Risk-Free Rate

```{admonition} Key Concept: What is "Risk-Free"?
:class: important

The **risk-free rate** is the theoretical return on an investment with zero risk of financial loss.

**In practice:**
- No truly risk-free rate exists
- U.S. Treasury rates traditionally used as proxy
- However, Treasury rates may be artificially low
```

### Why Treasury Rates Are Artificially Low

```{note}
**Factors Depressing Treasury Rates:**

1. **Capital Requirements**:
   - Banks not required to hold capital against Treasury holdings
   - Makes Treasuries cheaper to hold than other assets
   - Increases demand, lowers yields

2. **Favorable Tax Treatment**:
   - State and local tax exemptions in the U.S.
   - Enhances after-tax returns
   - Increases demand from certain investors

3. **Safe Haven Status**:
   - Flight to quality during crises
   - Liquidity premium
   - Reserve currency status
```

### New Risk-Free Rate Proxies

```{important}
**Modern Risk-Free Rate Proxies:**

Following the LIBOR scandal and transition, new reference rates based on actual transaction data serve as better proxies for risk-free rates:

- **SOFR** (Secured Overnight Financing Rate) - U.S. Dollar
- **SONIA** (Sterling Overnight Index Average) - British Pound
- **ESTR** (Euro Short-Term Rate) - Euro
- **SARON** (Swiss Average Overnight Rate) - Swiss Franc
- **TONAR** (Tokyo Overnight Average Rate) - Japanese Yen
```

**Physical Meaning**: The "risk-free rate" is a theoretical concept. In practice, we use the rate closest to risk-free that reflects actual market transactions.

---

## Overnight Rates

```{admonition} Key Concept: Overnight Rates
:class: tip

**Overnight rates** represent unsecured borrowing and lending between banks as they adjust reserve requirements.

**Characteristics:**
- Very short-term (overnight)
- Interbank market
- Influenced by central bank policy
- Foundation for term rate construction
```

### The Federal Funds Rate

```{note}
**Fed Funds Rate (U.S.):**

- **Definition**: Rate at which banks lend reserve balances to each other overnight
- **Effective Fed Funds Rate**: Volume-weighted median of brokered transactions
- **Central Bank Influence**: Fed intervenes to maintain rate in target range
- **Policy Tool**: Primary mechanism for implementing monetary policy
```

```{admonition} Example: How Overnight Rates Work
:class: tip

**Scenario:**
Bank A has excess reserves of $100 million
Bank B is $50 million short of required reserves

**Transaction:**
- Bank A lends $50 million to Bank B overnight
- Bank B pays interest at the fed funds rate (e.g., 5.25%)
- Next day, Bank B repays: $50,000,000 × (1 + 0.0525/360) = $50,007,292

**Result:** Bank B meets reserve requirements, Bank A earns overnight interest
```

**Physical Meaning**: Banks must hold minimum reserves with the central bank. Those with excess lend to those with deficits, creating an overnight money market.

---

## Repo Markets

Repo (repurchase agreement) markets are crucial for financing and as the basis for modern risk-free rates.

```{admonition} Key Concept: Repurchase Agreement (Repo)
:class: tip

A **repo** is:
1. A sale of a security today
2. Plus an agreement to repurchase the same security at a pre-arranged price on a future date

**Economic Reality:**
- **Borrower's perspective**: Secured loan (security as collateral)
- **Lender's perspective**: Secured lending (protected by collateral)
- **Interest**: Difference between sale and repurchase price
```

### Repo Transaction Mechanics

```{note}
**Repo Components:**

1. **Initial Sale**: Party A sells securities to Party B for cash
2. **Repurchase Agreement**: A agrees to buy back securities from B
3. **Repurchase Price**: Higher than sale price (reflects interest)
4. **Security as Collateral**: If A defaults, B keeps securities

**Terminology:**
- Party selling securities = **Borrowing cash** = "Repo" from their perspective
- Party buying securities = **Lending cash** = "Reverse repo" from their perspective
```

```{admonition} Example Problem: Repo Transaction
:class: tip

**Problem Statement:**
A bank needs $10 million cash overnight. It sells Treasury bonds worth $10 million in a repo transaction at an overnight repo rate of 5.00% per annum.

**Questions:**
1. How much cash does the bank receive today?
2. What is the repurchase price tomorrow?
3. What is the repo interest paid?
```

```{dropdown} Solution

**Step 1: Cash Received Today**

The bank receives \$10,000,000 cash today by selling the Treasury bonds.

**Step 2: Calculate Repurchase Price**

For overnight repo with annual rate of 5.00%:

$$\text{Repurchase Price} = \text{Sale Price} \times \left(1 + \frac{r}{360}\right)$$

$$\text{Repurchase Price} = 10,000,000 \times \left(1 + \frac{0.05}{360}\right)$$

$$\text{Repurchase Price} = 10,000,000 \times 1.000139$$

$$\text{Repurchase Price} = \$10,001,389$$

**Step 3: Repo Interest**

$$\text{Interest} = 10,001,389 - 10,000,000 = \$1,389$$

Or directly:

$$\text{Interest} = 10,000,000 \times \frac{0.05}{360} = \$1,389$$

**Final Answer:**
1. Cash received: \$10,000,000
2. Repurchase price: \$10,001,389
3. Repo interest: \$1,389

**Physical Meaning**: The bank essentially borrowed $10 million overnight at 5% using Treasury bonds as collateral, paying $1,389 in interest.
```

### Default Protection in Repo

```{important}
**What Happens if the Borrower Defaults?**

If the securities seller (cash borrower) cannot repurchase:
1. Cash lender entitled to **liquidate the securities**
2. Proceeds used to recover loaned cash
3. Excess returned to borrower (if any)
4. Shortfall may result in loss (though rare)

**Risk Mitigation:**
- **Haircuts**: Lend less than security value (e.g., lend $98 on $100 security)
- **Mark-to-market**: Daily valuation adjustments
- **Quality collateral**: Typically high-grade securities
```

---

## LIBOR and Its Problems

```{admonition} Historical Context: LIBOR
:class: note

**LIBOR (London Interbank Offered Rate):**
- Rate at which AA-rated banks **estimated** they could borrow unsecured
- Quoted for multiple currencies and maturities
- Widely used as reference rate for derivatives, loans, mortgages
- **Problem**: Based on estimates, not actual transactions
```

### The LIBOR Scandal

```{warning}
**Why LIBOR Failed:**

1. **Based on estimates**, not real trades
2. **Easily manipulated**: Banks could misreport
3. **Limited actual transactions**: Interbank unsecured lending dried up
4. **Conflict of interest**: Banks profited from their own submissions

**Manipulation Incentives:**
- **Trading profits**: Banks' derivatives positions
- **Reputation**: Higher LIBOR implied weaker bank
- **Collusion**: Traders coordinated submissions
```

```{note}
**Result:** Major scandal, regulatory fines exceeding $9 billion, criminal prosecutions, loss of confidence in the rate.
```

---

## The LIBOR Phase-Out

```{important}
**LIBOR Transition:**

- **Timeline**: Phased out by end of 2021
- **Replacement**: Transaction-based overnight rates
- **Methodology**: Rates based on actual observed market transactions
- **Compounding**: New rates compound daily over reference period

**Why Overnight Rates?**
- Large transaction volumes ensure robustness
- Harder to manipulate
- Reflects actual market conditions
- Can construct term rates via compounding
```

### New Reference Rates by Currency

```{note}
**Alternative Reference Rates:**

| Currency | Rate | Administrator | Basis |
|----------|------|---------------|-------|
| **USD** | SOFR | NY Fed | Secured overnight financing (repo) |
| **GBP** | SONIA | Bank of England | Unsecured overnight deposits |
| **EUR** | ESTR (€STR) | ECB | Unsecured overnight deposits |
| **CHF** | SARON | SIX Swiss Exchange | Secured overnight repo |
| **JPY** | TONAR | Bank of Japan | Unsecured overnight call rate |
```

**Physical Meaning**: The shift from LIBOR to these rates is like moving from "asking someone what they think a house is worth" to "looking at actual house sales prices."

---

## SOFR: Secured Overnight Financing Rate

SOFR is the primary replacement for USD LIBOR in the U.S. market.

```{admonition} Key Concept: SOFR
:class: tip

**SOFR (Secured Overnight Financing Rate):**
- Based on **actual overnight Treasury repo transactions**
- Calculated as volume-weighted median rate
- Published daily by the Federal Reserve Bank of New York
- Reflects cost of overnight borrowing secured by Treasury collateral
```

### Three Segments of SOFR

SOFR is calculated from three segments of the Treasury repo market:

```{note}
**SOFR Data Sources:**

**1. Tri-Party Treasury GC Repo** (Segment 1)
- Cleared and settled by Bank of New York Mellon
- Excludes FICC GCF repo
- Excludes Fed as counterparty

**2. FICC GCF Repo** (Segment 2)
- General Collateral Finance repo through FICC
- FICC acts as central counterparty
- Anonymous trading through interdealer brokers

**3. Bilateral Treasury Repo - FICC DVP** (Segment 3)
- Bilateral repos cleared through FICC DVP service
- Filtered to remove "specials" (bottom 25% of rates)
- Intended to reflect general collateral
```

---

## General Collateral vs. Specials

```{admonition} Key Concept: General Collateral (GC)
:class: tip

**General Collateral:**
- Repo against a pool of acceptable securities
- Lender doesn't specify particular securities
- Population defined (e.g., "Treasury securities")
- Reflects general financing cost

**Special/Specific Collateral:**
- Repo for a particular security
- Cash lender accepts lower rate to obtain specific security
- Reflects supply/demand for that security
- Not representative of general funding costs
```

**Why SOFR Filters Out Specials:**

SOFR aims to measure general financing costs, not security-specific supply/demand. The filtering ensures SOFR reflects broad market conditions.

---

## Tri-Party Repo

```{admonition} Key Concept: Tri-Party Repo
:class: tip

**Tri-party repo** uses a custodian bank or clearing organization as intermediary.

**Participants:**
1. **Cash provider** (lender)
2. **Securities provider** (borrower)
3. **Tri-party agent** (custodian)

**Agent Responsibilities:**
- Manage collateral transfers
- Price securities
- Hold collateral separately from dealer assets
- Provide operational efficiency
- Add layer of protection in bankruptcy
```

### Benefits of Tri-Party Repo

```{note}
**Advantages:**

- **Operational efficiency**: Agent handles mechanics
- **Collateral management**: Professional valuation and custody
- **Segregation**: Collateral held separately
- **Standardization**: Common processes across transactions
- **Scale**: Enables large-volume transactions

**Major Tri-Party Agents:**
- Bank of New York Mellon
- JPMorgan Chase
```

**Physical Meaning**: Tri-party repo is like using an escrow service - a trusted third party manages the collateral, reducing operational burden and risk.

---

## FICC GCF Repo Market

```{admonition} Key Concept: GCF Repo
:class: tip

**General Collateral Finance (GCF) Repo:**
- Operated by Fixed Income Clearing Corporation (FICC)
- FICC acts as **central counterparty**
- Anonymous trading among netting members
- Cleared through interdealer brokers

**Key Features:**
- Eliminates bilateral counterparty risk
- Netting efficiency
- Anonymous pre-trade
- FICC becomes buyer to every seller, seller to every buyer
```

**Physical Meaning**: GCF repo is similar to futures trading - a central clearinghouse stands between parties, guaranteeing performance and eliminating bilateral credit risk.

---

## Bilateral Repo

```{admonition} Key Concept: Bilateral Repo
:class: tip

**Bilateral repo** involves direct agreement between two parties without a tri-party agent for collateral management.

**Characteristics:**
- **Direct negotiation** of terms
- **Specific securities** may be identified
- **May be cleared or non-cleared**
- Can trade "special" securities
```

### Cleared Bilateral Repo (FICC DVP)

```{note}
**FICC DVP (Delivery Versus Payment):**

- Clearing service for bilateral repos
- Settlement through FICC
- Securities transfer only after payment
- Sponsored access for non-dealers
- Used in SOFR calculation (with filtering)

**Filtering for SOFR:**
- Bottom 25% of rates removed
- Goal: Exclude transactions on "special" securities
- Retain general collateral transactions
```

### Non-Cleared Bilateral Repo

```{warning}
**Non-Cleared Bilateral Repos:**

- Do not settle on clearing bank tri-party platforms
- **Not included in SOFR calculation**
- Higher counterparty risk
- Less standardization
- May involve specific security requirements
```

---

## Volume-Weighted Median

```{admonition} Key Concept: Volume-Weighted Median
:class: tip

SOFR uses a **volume-weighted median** calculation, not a simple average.

**Process:**
1. Rank all transactions by rate (low to high)
2. Calculate cumulative volume
3. Find rate at 50th percentile of volume
4. This rate is the volume-weighted median
```

### Why Volume-Weighted Median?

```{note}
**Advantages Over Simple Average:**

1. **Robustness**: Less sensitive to outliers
2. **Actual rate**: Represents a rate at which business was actually conducted
3. **Volume-weighted**: Reflects market importance
4. **Consistency**: Aligns with Effective Fed Funds Rate methodology
5. **Manipulation resistance**: Harder to influence than an average
```

```{admonition} Example: Volume-Weighted Median Calculation
:class: tip

**Problem:**
Calculate the volume-weighted median from these repo transactions:

| Rate | Volume ($M) |
|------|-------------|
| 5.00% | $100 |
| 5.05% | $200 |
| 5.10% | $300 |
| 5.15% | $250 |
| 5.20% | $150 |

**Total Volume**: $1,000M
```

```{dropdown} Solution

**Step 1: Rank by Rate and Calculate Cumulative Volume**

| Rate | Volume ($M) | Cumulative Volume | Cumulative % |
|------|-------------|-------------------|--------------|
| 5.00% | $100 | $100 | 10% |
| 5.05% | $200 | $300 | 30% |
| 5.10% | $300 | $600 | 60% |
| 5.15% | $250 | $850 | 85% |
| 5.20% | $150 | $1,000 | 100% |

**Step 2: Find 50th Percentile**

50% of volume = $500M

This falls in the 5.10% rate category:
- Cumulative volume reaches $600M at 5.10%
- Previous cumulative was $300M
- $500M is between $300M and $600M

**Final Answer:** Volume-weighted median = **5.10%**

**Interpretation**: Half the transaction volume ($500M) occurred at rates ≤ 5.10%, and half at rates ≥ 5.10%.

**Comparison to Simple Average:**
Simple average = (5.00 + 5.05 + 5.10 + 5.15 + 5.20) / 5 = **5.10%**

In this case they match, but with different distributions, they would differ. The volume-weighted median gives more weight to where the most business was done.
```

---

## Compounding Overnight Rates

Since the new reference rates are overnight rates, term rates must be constructed by compounding.

```{admonition} Key Concept: Term Rate Construction
:class: tip

**For a 3-month period:**
- Observe daily overnight rate each day
- Compound daily returns
- Calculate equivalent 3-month rate
- Called "term SOFR" or "compounded SOFR"

**Formula (continuous compounding approximation):**

$$r_{term} = \frac{1}{T} \sum_{i=1}^{n} r_i \cdot t_i$$

Where:
- $r_i$ = Overnight rate on day $i$
- $t_i$ = Day count fraction for day $i$
- $T$ = Total period
- $n$ = Number of days
```

```{admonition} Example: Compounded SOFR
:class: tip

Calculate the 5-day compounded SOFR given these daily rates:

| Day | SOFR Rate |
|-----|-----------|
| 1 | 5.00% |
| 2 | 5.02% |
| 3 | 5.01% |
| 4 | 5.03% |
| 5 | 5.02% |

Assume each day represents 1/360 of a year.
```

```{dropdown} Solution

**Step 1: Calculate Daily Factors**

Day 1: $1 + \frac{0.0500}{360} = 1.000139$
Day 2: $1 + \frac{0.0502}{360} = 1.000139$
Day 3: $1 + \frac{0.0501}{360} = 1.000139$
Day 4: $1 + \frac{0.0503}{360} = 1.000140$
Day 5: $1 + \frac{0.0502}{360} = 1.000139$

**Step 2: Compound the Factors**

$$\text{Compound Factor} = 1.000139 \times 1.000139 \times 1.000139 \times 1.000140 \times 1.000139$$

$$= 1.000695$$

**Step 3: Annualize**

$$\text{5-day rate} = 1.000695 - 1 = 0.000695 = 0.0695\%$$

$$\text{Annualized rate} = 0.000695 \times \frac{360}{5} = 0.05004 = 5.004\%$$

**Final Answer:** 5-day compounded SOFR ≈ **5.004%** annualized

**Interpretation**: The average SOFR over 5 days was approximately 5.016%, which when compounded gives an annualized rate of 5.004%.
```

**Physical Meaning**: Compounding daily overnight rates is like calculating the effective annual rate on a savings account that compounds daily - you earn interest on interest each day.

---

## Chapter Summary

```{important}
**Key Takeaways:**

1. **U.S. Treasury market** is the deepest, most liquid government securities market and serves as foundation for interest rate markets
2. **Treasury rates** are artificially low due to regulatory advantages and safe-haven status
3. **Overnight rates** (like Fed Funds Rate) reflect unsecured interbank lending
4. **Repo** is a secured financing transaction - sale plus agreement to repurchase
5. **LIBOR** was phased out due to manipulation and lack of underlying transactions
6. **New reference rates** (SOFR, SONIA, ESTR, etc.) based on actual transaction data
7. **SOFR** calculated from three segments of Treasury repo market
8. **Volume-weighted median** provides robust, manipulation-resistant rate calculation
9. **General collateral** repos measure general financing costs
10. **Term rates** constructed by compounding daily overnight rates
11. **Tri-party repo** uses custodian for operational efficiency
12. **GCF repo** through FICC eliminates bilateral counterparty risk
```

```{seealso}
**Looking Ahead:**

Chapter 5 examines **bond pricing, zero rates, and yield curves**, building on interest rate concepts to understand fixed-income valuation.
```

---

## Practice Problems

```{admonition} Practice Problem 1: Repo Financing Cost
:class: tip

A hedge fund needs to finance a $50 million Treasury bond position for 7 days. The repo rate is 5.25% per annum.

**Questions:**
1. How much interest will the hedge fund pay?
2. If the hedge fund can lend out the cash at 5.35%, what is the net financing cost?
3. What is the repurchase price?
```

```{dropdown} Solution to Practice Problem 1

**Part 1: Repo Interest**

Using 360-day count convention:

$$\text{Interest} = \text{Principal} \times \text{Rate} \times \frac{\text{Days}}{360}$$

$$\text{Interest} = 50,000,000 \times 0.0525 \times \frac{7}{360}$$

$$\text{Interest} = 50,000,000 \times 0.00101875$$

$$\text{Interest} = \$50,938$$

**Part 2: Net Financing Cost**

If the hedge fund invests the borrowed cash at 5.35%:

$$\text{Interest earned} = 50,000,000 \times 0.0535 \times \frac{7}{360}$$

$$\text{Interest earned} = \$51,847$$

$$\text{Net cost} = 50,938 - 51,847 = -\$909$$

The hedge fund **earns** $909 (negative cost = profit)

**Alternative:** Direct calculation

$$\text{Net rate} = 5.35\% - 5.25\% = 0.10\%$$

$$\text{Net earnings} = 50,000,000 \times 0.001 \times \frac{7}{360} = \$972$$

(Small difference due to rounding)

**Part 3: Repurchase Price**

$$\text{Repurchase Price} = 50,000,000 + 50,938 = \$50,050,938$$

**Final Answer:**
1. Interest paid: \$50,938
2. Net financing cost: -\$909 (actually earns money from the spread)
3. Repurchase price: \$50,050,938

**Interpretation**: The hedge fund can earn a profit by borrowing at 5.25% in the repo market and lending at 5.35%, capturing a 10 bp spread.
```

```{admonition} Practice Problem 2: LIBOR Transition Impact
:class: tip

A company has a $100 million floating-rate loan that was based on 3-month LIBOR + 150 basis points. The loan is transitioning to 3-month compounded SOFR + spread adjustment.

**Historical averages:**
- 3-month LIBOR: 2.50%
- 3-month SOFR: 2.35%

**Questions:**
1. What spread adjustment should be added to SOFR to maintain economic equivalence?
2. What will the new reference rate be?
3. Explain why SOFR is typically lower than LIBOR was.
```

```{dropdown} Solution to Practice Problem 2

**Part 1: Spread Adjustment**

The spread adjustment should equal the historical difference:

$$\text{Spread Adjustment} = \text{LIBOR} - \text{SOFR}$$

$$\text{Spread Adjustment} = 2.50\% - 2.35\% = 0.15\% = 15 \text{ basis points}$$

**Part 2: New Reference Rate**

Old rate: 3-month LIBOR + 150 bps
New rate: 3-month SOFR + 15 bps (adjustment) + 150 bps (original spread)

Total new rate: **3-month SOFR + 165 bps**

**Verification:**
- Old: 2.50% + 1.50% = 4.00%
- New: 2.35% + 1.65% = 4.00% ✓

**Part 3: Why SOFR < LIBOR**

SOFR is typically lower than LIBOR was because:

1. **Credit risk**: LIBOR included bank credit risk; SOFR is secured (no credit risk)
2. **Term premium**: LIBOR was forward-looking term rate; SOFR is overnight
3. **Unsecured vs. Secured**: LIBOR was unsecured lending; SOFR is secured by Treasuries
4. **Liquidity**: Repo markets are more liquid than unsecured interbank lending

**Final Answer:**
1. Spread adjustment: **15 bps**
2. New rate: **SOFR + 165 bps**
3. SOFR lower because it's secured, overnight-based, and has no bank credit risk

**Practical Note**: Actual spread adjustments use historical median differences over specified lookback periods (e.g., 5 years) and are published by regulators.
```

---
