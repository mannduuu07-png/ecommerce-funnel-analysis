# eCommerce Transaction & Behavior Analysis

## Overview
Analyzed transaction, clickstream, and customer data from an Indonesian eCommerce platform to identify key drop-off points and evaluate payment performance across the purchase funnel.

## Data Sources
- `transactions` — payment and order-level transaction records
- `click_stream` — user session behavior logs
- `customer` — user demographic and location data

## Tools
SQL (SQLite), Tableau

## Key Analysis
- Funnel analysis using event sequence tracking
- Segmentation of non-converting sessions for behavioral analysis
- Drop-off identification based on last interaction events

## Key Questions
1. Is the payment success rate stable across regions and devices?
2. Where do users drop off before completing a purchase?

## Key Findings
- Payment success rate remained stable at 95.7% across regions and devices
- Minimal gap between new and returning users (0.04%p), suggesting failure drivers are not user-segment-specific
- 95% overlap between sessions and transactions suggests dataset bias toward completed purchases
- Of 42,621 non-converting sessions, 15.3% dropped off at ADD_TO_CART, identifying cart abandonment as the highest-impact intervention point
- High cart abandonment at this stage indicates a critical revenue leakage point, as users have already demonstrated strong purchase intent

## Recommendation
Prioritize targeted re-engagement strategies (e.g., push notifications or promo incentives within a few hours of cart activity) to recover high-intent users abandoning at the cart stage.

## Business Interpretation
- Shifted focus from payment system performance to user behavior optimization, prioritizing cart abandonment recovery as the key lever for conversion improvement.
- Even small improvements at this stage can significantly impact overall conversion, making it a high-leverage optimization point.
- This analytical approach can be extended to financial services, where identifying drop-off in user decision flows is critical for improving user engagement and investment conversion.

## Project Structure
**queries**
- 01_booking_level.sql
- 02_daily_success_rate.sql
- 03_success_rate_by_region.sql
- 04_funnel_analysis.sql
- 05_dropoff_last_event.sql

## Dashboard Preview
![DAU Trend](1_dau_trend.png)
![Daily Success Rate](2_daily_success_rate.png)
![Success Rate by Region](3_success_rate_by_region.png)
![Drop-Off Analysis](4_dropoff_analysis.png)
![Funnel Overview](5_funnel_overview.png)
