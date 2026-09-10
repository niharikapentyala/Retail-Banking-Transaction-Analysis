# Retail Banking Transaction Analysis

## Project Overview

Retail Banking Transaction Analysis is a MySQL-based Business Analytics project focused on analyzing banking data to understand customer behaviour, banking activity, transaction patterns, loan performance, and product engagement.

The project uses relational banking data covering customers, accounts, branches, transactions, loans, loan payments, and cards. SQL analysis is used to identify patterns, compare business segments, and generate actionable insights to support banking-related decision-making.

---

## Business Scenario

The bank wants to leverage its data to better understand its customers and banking activities and support informed business decisions.

The analysis addresses key business questions related to:

- Customer characteristics and segment behaviour
- Account activity across account types and branches
- Transaction types and channels
- Loan performance and repayment behaviour
- Card usage and engagement with multiple banking products

---

## Business Objectives

### 1. Customer Profile & Segmentation

Analyze customer profiles and identify differences across customer segments, including financial characteristics and customer distribution.

### 2. Account Usage & Branch Activity

Evaluate account usage, account balances, account status, and differences in activity across account types and branches.

### 3. Transaction Patterns

Analyze transaction volumes, transaction amounts, transaction types, channels, and account activity to understand how money moves through the banking system.

### 4. Loan Performance & Repayment Behaviour

Evaluate loan volumes, outstanding balances, loan types, and repayment behaviour to understand loan performance and exposure.

### 5. Card Usage & Product Engagement

Analyze card types and usage patterns to understand customer product preferences and engagement with banking products.

---

## Dataset & Database Overview

The project consists of seven relational tables:

| Table | Description | Records |
|---|---|---:|
| `customers` | Customer details and segmentation | 500 |
| `accounts` | Account information and balances | 700 |
| `branches` | Branch details and locations | 40 |
| `loans` | Loan details and loan status | 300 |
| `loan_payments` | Loan repayment information | 2,000 |
| `cards` | Card details and usage information | 600 |
| `transactions` | Account transaction details | 5,000 |

### Database Relationships

The database connects the major banking entities through the following relationships:

- Customers → Accounts
- Accounts → Transactions
- Accounts → Cards
- Customers → Loans → Loan Payments
- Branches → Accounts & Loans

This relational structure enables analysis across customers, banking products, branches, transactions, and loans.

---

## Analytical Approach

The project follows a structured SQL-based analysis approach:

1. Understand the business scenario and analytical objectives.
2. Understand the ER diagram and relationships between banking entities.
3. Create and configure the MySQL database.
4. Import and verify the banking datasets.
5. Perform basic data exploration.
6. Conduct objective-based analysis using SQL queries.
7. Identify key findings and translate them into business insights.
8. Develop business recommendations based on the analysis.

---

## Key Findings

### Customer Analysis

- The **Student** segment has the highest number of customers.
- **Premium** customers have the highest average income.
- Customer segments differ in size and financial characteristics.

### Account & Branch Analysis

- Most accounts are currently active.
- **Certificate of Deposit (CD)** accounts have the highest average balance.
- Account balance and account-status patterns provide useful information for account management.

### Transaction Analysis

- **Transfer** has the highest transaction volume with 858 transactions.
- **ATM Withdrawal** follows closely with 857 transactions.
- Transfer transactions have the highest total transaction amount.
- The high transaction activity indicates strong usage of the bank's transaction services.

### Loan Performance Analysis

- **Education** loans have the highest loan count.
- **Business** loans have the highest total outstanding balance.
- Business loans therefore represent the highest outstanding loan exposure.

### Card & Product Engagement

- The bank has **600 cards** across Credit and Debit card types.
- **Debit cards** are more common, with 358 cards compared with 242 Credit cards.
- Card-level analysis helps identify customer product preferences and engagement.

---

## Overall Business Insights

The analysis highlights differences in customer segments, account usage, transaction behaviour, loan exposure, and card preferences.

Key observations include:

- Customer segmentation can support targeted banking strategies.
- Higher-balance account types represent important customer funds.
- Transfers and ATM withdrawals represent significant transaction activity.
- Business loans require closer attention because of their higher outstanding exposure.
- Card usage patterns can help the bank understand customer product preferences.

---

## Business Recommendations

Based on the analysis, the following recommendations were identified:

- Use customer segmentation to design targeted banking products and offers.
- Focus on high-balance account types to improve customer retention and product engagement.
- Monitor high-volume transaction types such as transfers and ATM withdrawals.
- Closely monitor business loans due to their high outstanding loan exposure.
- Promote suitable card products based on customer needs and usage patterns.

---

## Tools & Technologies

- **Database:** MySQL
- **Query Language:** SQL
- **Database Tool:** MySQL Workbench

---

## Project Presentation
The project presentation is available in the PPT folder.

## Author
Pentyala Niharika
