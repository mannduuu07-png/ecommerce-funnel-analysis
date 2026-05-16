# eCommerce Revenue Leakage & Conversion Optimization Analysis

## Overview
Analyzed 850K+ transactions and 12.8M clickstream events from an Indonesian eCommerce 
platform to diagnose revenue loss across the purchase funnel and identify high-impact 
intervention opportunities.

**Business Question:** Where are we losing revenue, and what's the highest-leverage 
point to recover it?

---

## 📊 Data Sources
- `transactions` — 852,584 rows (2016.07 ~ 2022.07)
- `click_stream` — 12,833,602 rows (2016.07 ~ 2022.08)
- `customer` — 100,000 rows
- `product` — 42,388 rows

**Tools:** SQL (SQLite), Tableau

---

## 🎯 Key Questions
1. Is the payment success rate stable across regions and devices?
2. Where do users drop off before completing a purchase?
3. Which drop-off stage represents the highest revenue recovery opportunity?

---

## 🔍 Analysis Approach

### 1. Payment System Validation
- Evaluated payment success rate across regions, devices, and user segments
- **Goal:** Rule out technical/system issues before investigating behavioral factors

### 2. Funnel Analysis
- Built 5-stage event sequence tracking to quantify drop-off at each decision point
- **Goal:** Identify where potential revenue is being lost

### 3. Non-Converting Session Segmentation
- Isolated 42,621 sessions without completed purchases
- Categorized by last interaction event to pinpoint abandonment patterns
- **Goal:** Determine which stage has the highest recovery potential

---

## 💡 Key Findings

### ✅ Payment System is Not the Problem
- Payment success rate: **95.7%** (stable across regions and devices)
- Minimal gap between new vs returning users (0.04%p)
- **Insight:** Failure drivers are operational, not user-segment-specific

### 🚨 Cart Abandonment is the Primary Revenue Leak
- Of 42,621 non-converting sessions, **15.3% dropped off at ADD_TO_CART**
- These users demonstrated strong purchase intent but abandoned before checkout
- **Insight:** This is the highest-impact intervention point

### ⚠️ Dataset Limitation Identified
- 95% overlap between sessions and transactions suggests bias toward completed purchases
- Real-world abandonment rates are likely higher
- **Action Taken:** Acknowledged limitation and focused analysis on available data

---

## 📈 Business Recommendation

**Prioritize cart abandonment recovery** as the primary revenue optimization lever:

- **Tactic 1:** Time-sensitive push notifications (within 2-4 hours of cart activity)
- **Tactic 2:** Personalized promo incentives for high-value abandoned carts
- **Tactic 3:** A/B test messaging strategies (urgency vs discount-driven)

**Expected Impact:** Even a 10% recovery rate at this stage could significantly 
improve overall conversion, as these users have already cleared earlier funnel stages.

---

## 🔄 Transferable Skills to Revenue Management

This analysis demonstrates core capabilities applicable to hospitality revenue management:

| eCommerce Analysis | Hotel Revenue Management Equivalent |
|-------------------|-------------------------------------|
| Cart abandonment funnel | Booking abandonment analysis (search → reserve) |
| Regional demand patterns | Market segment forecasting (leisure/corporate/group) |
| Payment success rate validation | Channel performance evaluation (OTA vs Direct) |
| Re-engagement strategy | Yield management & dynamic pricing adjustments |

**Core Principle:** Whether optimizing eCommerce conversion or hotel occupancy, 
the approach is the same—**identify demand patterns, quantify leakage points, 
and intervene at high-leverage stages.**

**Industries where this framework applies:**  
✅ Hospitality (hotel/function space revenue optimization)  
✅ SaaS (subscription conversion & churn reduction)  
✅ Travel & Transportation (flight/package booking optimization)

---

## 📂 Project Structure

## Project Structure
**queries**
- 01_booking_level.sql
- 02_daily_success_rate.sql
- 03_success_rate_by_region.sql
- 04_funnel_analysis.sql
- 05_dropoff_last_event.sql

queries/
├── 01_booking_level.sql          # Transaction-level data aggregation
├── 02_daily_success_rate.sql     # Payment success rate time series
├── 03_success_rate_by_region.sql # Regional/device segmentation
├── 04_funnel_analysis.sql        # 5-stage conversion funnel
└── 05_dropoff_last_event.sql     # Non-converting session classification

*All SQL queries use SQLite syntax with CTEs and window functions for multi-stage analysis.*

---

## 📊 Dashboard Preview

### 1. Daily Active Users (DAU) Trend
![DAU Trend](1_dau_trend.png)
*Tracked platform engagement over time to establish baseline activity levels*

### 2. Payment Success Rate Monitoring
![Daily Success Rate](2_daily_success_rate.png)
*Validated 95.7% success rate stability, ruling out system issues*

### 3. Regional Performance Breakdown
![Success Rate by Region](3_success_rate_by_region.png)
*Confirmed consistent performance across geographies and devices*

### 4. Drop-Off Stage Analysis
![Drop-Off Analysis](4_dropoff_analysis.png)
*Identified cart abandonment (15.3%) as primary intervention opportunity*

### 5. Full Funnel Overview
![Funnel Overview](5_funnel_overview.png)
*End-to-end conversion flow showing volume loss at each stage*

---

## 🛠️ Technical Implementation

**SQL Techniques Used:**
- Window functions for event sequencing
- CTEs for multi-stage funnel construction
- CASE statements for session classification
- LEFT JOINs to isolate non-converting behavior

**Tableau Features:**
- Calculated fields for conversion rate metrics
- Parameter-driven filtering (date range, region)
- Dual-axis charts for trend + benchmark comparison

---

## 📌 Key Takeaways

1. **Data-driven prioritization:** Shifted focus from payment system to user behavior 
   after quantifying technical vs behavioral failure rates

2. **High-leverage thinking:** Identified cart abandonment as the stage where 
   intervention has the highest ROI (strong intent + clear drop-off signal)

3. **Transferable methodology:** This funnel-based revenue recovery framework 
   applies to any industry with multi-stage customer decision flows
