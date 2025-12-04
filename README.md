# Time Series Modeling of Tech Stocks and Stablecoins
R pipeline for ARIMA, GARCH-family volatility modeling, EGARCH-t optimization, VAR/ARDL interaction analysis, and VaR estimation across tech stocks and stablecoins.


## Overview

1. This repository presents a full, end-to-end **time-series econometric analysis** comparing the return and volatility dynamics of:

- **Apple (AAPL)** — representative large-cap technology equity  
- **NASDAQ-100 (QQQ)** — diversified technology-heavy index  
- **Tether (USDT)** — largest USD-backed stablecoin  

2. The project systematically evaluates:

- **Naive / Drift Models**
- **ARIMA & ARMA models** (mean dynamics)
- **GARCH-family volatility models:**  
  - `sGARCH(1,1)`  
  - `eGARCH(1,1)` / `eGARCH(1,2)`  
  - Normal vs **Student-t** error structures  
- **VAR models** (AAPL ↔ NASDAQ interactions)  
- **ARDL dynamic regression** (USDT → NASDAQ short-run effects)  
- **Value-at-Risk** estimation under multiple volatility + distribution assumptions  

3. The analysis addresses three core research questions:

- **Do tech stocks and stablecoins share similar volatility properties?**
- **Which econometric framework best captures each asset's volatility structure?**
- **Are there measurable crypto → equity spillovers?**

---

## Methodology

---

## 1. Data Acquisition & Preprocessing

**1. Assets analyzed (with daily frequency)**

**2. Processing pipeline:**

- Remove missing values  
- Compute **log prices**  
- Compute **log returns**  
- Test stationarity (ADF + ACF/PACF)  
- Separate mean vs variance dynamics (ARIMA → GARCH)

**3. Why log returns?**

- Time-additive  
- Variance-stabilizing  
- Required for ARMA/GARCH stationarity assumptions  

---

## 2. Naive & Drift Models

Used only as baseline models.

**Findings:**

- For **log returns**, naive models fail (Ljung-Box p < 0.01 → strong autocorrelation).  
- For **log prices**, naive+drift approximates random walk → consistent with EMH.  

---

## 3. ARIMA Modeling

### **Model Selection**
Using `auto.arima()` + full diagnostic checking.

| Asset | Best ARIMA Model | Interpretation |
|-------|------------------|---------------|
| **AAPL** | `ARIMA(0,0,0)` | Efficient market behavior; returns ≈ white noise |
| **NASDAQ-100** | `ARIMA(3,0,3)` | Multi-layer autocorrelation from composite index |
| **USDT (Tether)** | `ARIMA(2,0,2)` | Short-term mean dependencies, slight mean reversion |

**Diagnostics:**

- Residual ACF/PACF → good  
- **Squared residuals show significant autocorrelation → ARCH effects**  
- → Necessitates GARCH-family models  

---

## 4. GARCH-Family Volatility Modeling

Evaluated models:

- **sGARCH(1,1)**
- **eGARCH(1,1)**, **eGARCH(1,2)**
- Error distributions:  
  - Normal  
  - **Student-t (heavy-tailed)**

### **Model Selection Criteria**
- AIC / BIC  
- Parameter significance  
- Ljung-Box on residuals  
- ARCH-LM test on squared residuals  
- Leverage effect detection  
- Tail-fatness via t-distribution shape parameter  

---

### **Best Volatility Models (Per Asset)**

| Asset | Best Model | Key Characteristics |
|-------|-----------|---------------------|
| **AAPL** | **eGARCH(1,1) – Student-t** | Strong leverage effect; fat tails; extremely persistent volatility (β ≈ 0.97) |
| **NASDAQ-100** | **eGARCH(1,2) – Student-t** | Asymmetric shocks; large 2025 volatility spike; significant tail risk |
| **USDT (Tether)** | **eGARCH(1,1) – Student-t** | Volatility clustering present; rare structural breaks; heavy-tailed behavior |

---

### **Summary of Technical Findings**

- **Student-t distributions consistently outperform normal distributions**  
- **EGARCH handles asymmetry + variance positivity** naturally  
- **All assets exhibit conditional heteroskedasticity**  
- **Stablecoins are *not* variance-constant** → common misconceptions fail empirically  

---

## 5. Cross-Market Interaction Models

---

### 5.1 VAR: AAPL ↔ NASDAQ-100

- Statistically significant **bidirectional** interactions  
- NASDAQ shocks transmit more strongly to AAPL  
- VAR stability conditions satisfied  

**Implication:**  
Tech equities are tightly co-integrated with the broader sector index.

---

### 5.2 ARDL: USDT → NASDAQ Short-Run Impact

**Key results:**

- Lag 0 and lag 1 **USDT returns significantly affect NASDAQ**  
- Effects vanish after 2 days  
- QQQ shows a small reversal at lag 3  
- No residual autocorrelation (p = 0.93)  

**Conclusion:**  
Stablecoin flows exert **immediate but short-lived** influence on tech-equity liquidity.

---

## 6. VaR Under Multiple Volatility Models

Models evaluated:

- sGARCH-Normal  
- sGARCH-t  
- eGARCH-Normal  
- eGARCH-t  


**Student-t errors generate dramatically higher (more realistic) VaR estimates.**

**Normality assumption → severely underestimates tail risk**, especially for single equities.

---

## Key Technical Insights

- All three assets exhibit **volatility clustering**  
- **Asymmetric volatility** is pronounced (negative shocks > positive shocks)  
- **Heavy-tailed distributions** fit financial data far better  
- **Crypto → equity spillovers exist**, but are very short-lived  

