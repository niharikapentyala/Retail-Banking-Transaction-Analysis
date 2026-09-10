-- Sprint 2: Database Setup
-- Design the Database from the ER Diagram and Data Import

CREATE DATABASE retail_banking;
USE retail_banking;

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(30),
    customer_since DATE,
    kyc_status VARCHAR(20),
    segment VARCHAR(30),
    annual_income DECIMAL(15,2),
    credit_score INT,
    is_active VARCHAR(3)
);

CREATE TABLE branches (
    branch_id VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(30),
    region VARCHAR(30),
    opening_date DATE,
    employee_count INT
);

CREATE TABLE accounts (
    account_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    branch_id VARCHAR(10),
    account_type VARCHAR(30),
    open_date DATE,
    close_date DATE,
    current_balance DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    overdraft_limit DECIMAL(12,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE loans (
    loan_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    branch_id VARCHAR(10),
    loan_type VARCHAR(30),
    principal_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    disbursement_date DATE,
    maturity_date DATE,
    emi_amount DECIMAL(12,2),
    outstanding_balance DECIMAL(15,2),
    loan_status VARCHAR(30),
    purpose VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE loan_payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    loan_id VARCHAR(20),
    payment_date DATE,
    scheduled_amount DECIMAL(12,2),
    paid_amount DECIMAL(12,2),
    principal_paid DECIMAL(12,2),
    interest_paid DECIMAL(12,2),
    penalty DECIMAL(12,2),
    days_late INT,
    payment_method VARCHAR(30),
    status VARCHAR(20),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

CREATE TABLE cards (
    card_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20),
    card_type VARCHAR(30),
    issue_date DATE,
    expiry_date DATE,
    credit_limit DECIMAL(12,2),
    outstanding_balance DECIMAL(12,2),
    reward_points INT,
    is_active VARCHAR(3),
    network VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20),
    transaction_date DATE,
    transaction_time TIME,
    transaction_type VARCHAR(30),
    amount DECIMAL(15,2),
    channel VARCHAR(30),
    description VARCHAR(50),
    balance_after DECIMAL(15,2),
    status VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM branches;

SELECT COUNT(*) FROM accounts;

SELECT COUNT(*) FROM loans;

SELECT COUNT(*) FROM loan_payments;

SELECT COUNT(*) FROM cards;

SELECT COUNT(*) FROM transactions;

-- Sprint 3: Basic Analysis / Data Exploration
-- What is the total number of customers?
SELECT COUNT(*) AS total_customers FROM customers;

-- What is the total number of accounts?
SELECT COUNT(*) AS total_accounts FROM accounts;

-- What are the different account types available?
SELECT DISTINCT account_type FROM accounts;

-- How many customers are currently active?
SELECT COUNT(*) AS active_customers FROM customers WHERE is_active = 'Yes';

-- What are the different transaction types available?
SELECT DISTINCT transaction_type FROM transactions;

-- What is the total amount of completed transactions?
SELECT SUM(amount) AS total_completed_amount FROM transactions WHERE status = 'Completed';

-- What are the different loan types available?
SELECT DISTINCT loan_type FROM loans;

-- What is the total number of loans?
SELECT COUNT(*) AS total_loans FROM loans;

-- What are the different card types available?
SELECT DISTINCT card_type FROM cards;

-- What is the total outstanding loan balance?
SELECT SUM(outstanding_balance) AS total_outstanding_balance FROM loans;

-- Sprint 4: Objective-Based Analysis

-- 4.1 Understand Customer Profile and Segmentation
-- Q1. How are customers distributed by gender?
SELECT gender, COUNT(*) AS customer_count 
FROM customers 
GROUP BY gender;

-- Q2. How are customers distributed across different states?
SELECT state, COUNT(*) AS customer_count 
FROM customers 
GROUP BY state ORDER BY customer_count DESC;

-- Q3. How are customers distributed across different cities?
SELECT city, COUNT(*) AS customer_count FROM customers 
GROUP BY city ORDER BY customer_count DESC;

-- Q4. What is the average income of customers by state?
SELECT state, ROUND(AVG(annual_income), 2) AS average_income
FROM customers GROUP BY state ORDER BY average_income DESC;

-- Q5. What is the average income of customers by segment?
SELECT segment, ROUND(AVG(annual_income), 2) AS average_income
FROM customers GROUP BY segment ORDER BY average_income DESC;

-- Q6. What is the average credit score of customers by segment?
SELECT segment, ROUND(AVG(credit_score), 2) AS average_credit_score
FROM customers 
GROUP BY segment ORDER BY average_credit_score DESC;

-- Q7. How are customers distributed by KYC status?
SELECT kyc_status, COUNT(*) AS customer_count
FROM customers 
GROUP BY kyc_status ORDER BY customer_count DESC;

-- Q8. How many active customers are there in each segment?
SELECT segment, COUNT(*) AS active_customers FROM customers
WHERE is_active = 'Yes' 
GROUP BY segment ORDER BY active_customers DESC;

-- Q9. What is the KYC status distribution among active customers?
SELECT kyc_status, COUNT(*) AS active_customer_count 
FROM customers
WHERE is_active = 'Yes' 
GROUP BY kyc_status 
ORDER BY active_customer_count DESC;

-- Q10. How many customers joined the bank in each year?
SELECT YEAR(customer_since) AS join_year, COUNT(*) AS customer_count 
FROM customers 
GROUP BY YEAR(customer_since) 
ORDER BY join_year;

-- 4.2 Understand Account Usage and Branch Activity
-- Q1. How many accounts are there for each account type?
SELECT account_type, COUNT(*) AS account_count FROM accounts
GROUP BY account_type ORDER BY account_count DESC;

-- Q2. What is the average account balance for each account type?
SELECT account_type, ROUND(AVG(current_balance), 2) AS average_balance FROM accounts
GROUP BY account_type ORDER BY average_balance DESC;

-- Q3. Which branches have the most accounts?
SELECT branch_id, COUNT(*) AS account_count FROM accounts
GROUP BY branch_id ORDER BY account_count DESC;

-- Q4. What is the average interest rate for each account type?
SELECT account_type, ROUND(AVG(interest_rate), 2) AS average_interest_rate FROM accounts 
GROUP BY account_type ORDER BY average_interest_rate DESC;

-- Q5. How many accounts are currently active vs. closed?
SELECT status, COUNT(*) AS account_count FROM accounts
GROUP BY status ORDER BY account_count DESC;

-- Q6. What is the average current balance of active vs. closed accounts?
SELECT status, ROUND(AVG(current_balance), 2) AS average_balance FROM accounts
GROUP BY status ORDER BY average_balance DESC;

-- Q7. Which branches have the highest average account balance?
SELECT branch_id, ROUND(AVG(current_balance), 2) AS average_balance FROM accounts
GROUP BY branch_id ORDER BY average_balance DESC;

-- Q8. Which account types have the highest total current balance?
SELECT account_type, ROUND(SUM(current_balance), 2) AS total_balance FROM accounts
GROUP BY account_type ORDER BY total_balance DESC;

-- Q9. How many active accounts are there for each account type?
SELECT account_type, COUNT(*) AS active_account_count FROM accounts
WHERE status = 'Active' GROUP BY account_type ORDER BY active_account_count DESC;

-- Q10. Which branches have the highest total account balance?
SELECT branch_id, ROUND(SUM(current_balance), 2) AS total_balance 
FROM accounts
GROUP BY branch_id ORDER BY total_balance DESC;

-- Q11. How many closed accounts are there for each account type?
SELECT account_type, COUNT(*) AS closed_account_count FROM accounts
WHERE status = 'Closed' GROUP BY account_type 
ORDER BY closed_account_count DESC;

-- Q12. What is the average number of accounts held by each customer?
SELECT ROUND(AVG(account_count), 2) AS average_accounts_per_customer
FROM (SELECT customer_id, COUNT(*) AS account_count 
FROM accounts GROUP BY customer_id) AS customer_accounts;

-- 4.3 Analyze Transaction Patterns
-- Q1. How many transactions are there for each transaction type?
SELECT transaction_type, COUNT(*) AS transaction_count FROM transactions
GROUP BY transaction_type ORDER BY transaction_count DESC;

-- Q2. What is the total transaction amount for each transaction type?
SELECT transaction_type, ROUND(SUM(amount), 2) AS total_amount FROM transactions 
GROUP BY transaction_type ORDER BY total_amount DESC;

-- Q3. What is the average transaction amount for each transaction type?
SELECT transaction_type, ROUND(AVG(amount), 2) AS average_amount
FROM transactions GROUP BY transaction_type ORDER BY average_amount DESC;

-- Q4. How many transactions are made through each channel?
SELECT channel, COUNT(*) AS transaction_count FROM transactions
GROUP BY channel ORDER BY transaction_count DESC;

-- Q5. What are the most common transaction descriptions?
SELECT description, COUNT(*) AS transaction_count FROM transactions
GROUP BY description ORDER BY transaction_count DESC;

-- Q6. How does transaction activity change over the years?
SELECT  YEAR(transaction_date) AS transaction_year, COUNT(*) AS transaction_count 
FROM transactions GROUP BY YEAR(transaction_date) ORDER BY transaction_year;

-- Q7. Which accounts have the highest transaction activity?
SELECT account_id, COUNT(*) AS transaction_count FROM transactions
GROUP BY account_id ORDER BY transaction_count DESC;

-- Q8. How does transaction activity differ across customer segments?
SELECT c.segment, COUNT(t.transaction_id) AS transaction_count FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.segment ORDER BY transaction_count DESC;

-- Q9. How does transaction type affect the balance after a transaction?
SELECT transaction_type, ROUND(AVG(balance_after), 2) AS average_balance_after
FROM transactions
GROUP BY transaction_type
ORDER BY average_balance_after DESC;

-- 4.4 Evaluate Loan Performance and Repayment Behaviour
-- Q1. How many loans are there for each loan type?
SELECT loan_type, COUNT(*) AS loan_count
FROM loans
GROUP BY loan_type
ORDER BY loan_count DESC;

-- Q2. What is the total loan amount for each loan type?
SELECT loan_type, ROUND(SUM(principal_amount), 2) AS total_loan_amount
FROM loans
GROUP BY loan_type
ORDER BY total_loan_amount DESC;

-- Q3. What is the average outstanding balance for each loan type?
SELECT loan_type, ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance
FROM loans
GROUP BY loan_type
ORDER BY average_outstanding_balance DESC;

-- Q4. How many loans are in each loan status?
SELECT loan_status, COUNT(*) AS loan_count
FROM loans
GROUP BY loan_status
ORDER BY loan_count DESC;

-- Q5. Which loans have repayment delays?
SELECT loan_id,
       COUNT(*) AS late_payment_count,
       SUM(days_late) AS total_days_late
FROM loan_payments
WHERE days_late > 0
GROUP BY loan_id
ORDER BY total_days_late DESC;

-- Q6. What is the total penalty amount for each loan?
SELECT loan_id, ROUND(SUM(penalty), 2) AS total_penalty
FROM loan_payments
GROUP BY loan_id
ORDER BY total_penalty DESC;

-- Q7. How does repayment behaviour differ across loan types?
SELECT l.loan_type,
       COUNT(lp.payment_id) AS payment_count,
       ROUND(AVG(lp.paid_amount), 2) AS average_paid_amount,
       ROUND(AVG(lp.days_late), 2) AS average_days_late
FROM loans l
JOIN loan_payments lp ON l.loan_id = lp.loan_id
GROUP BY l.loan_type
ORDER BY average_days_late DESC;

-- Q8. What payment methods are used by customers for loan repayments?
SELECT payment_method, COUNT(*) AS payment_count
FROM loan_payments
GROUP BY payment_method
ORDER BY payment_count DESC;

-- 4.5 Understand Card Usage and Product Engagement
-- Q1. How many cards are there for each card type?
SELECT card_type, COUNT(*) AS card_count FROM cards
GROUP BY card_type
ORDER BY card_count DESC;

-- Q2. What is the average credit limit for each card type?
SELECT card_type, ROUND(AVG(credit_limit), 2) AS average_credit_limit
FROM cards
GROUP BY card_type
ORDER BY average_credit_limit DESC;

-- Q3. What is the average outstanding balance for each card type?
SELECT card_type, ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance
FROM cards
GROUP BY card_type
ORDER BY average_outstanding_balance DESC;

-- Q4. How many cards are active vs inactive?
SELECT is_active, COUNT(*) AS card_count
FROM cards
GROUP BY is_active
ORDER BY card_count DESC;

-- Q5. What is the average reward points earned for each card type?
SELECT card_type, ROUND(AVG(reward_points), 2) AS average_reward_points
FROM cards
GROUP BY card_type
ORDER BY average_reward_points DESC;

-- Q6. Which card networks are used the most?
SELECT network, COUNT(*) AS card_count
FROM cards
GROUP BY network
ORDER BY card_count DESC;

-- Q7. Which customers use multiple banking products (accounts, cards, and loans)?
SELECT c.customer_id, 
	   CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       COUNT(DISTINCT a.account_id) AS account_count,
       COUNT(DISTINCT cd.card_id) AS card_count,
       COUNT(DISTINCT l.loan_id) AS loan_count
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN cards cd ON a.account_id = cd.account_id
LEFT JOIN loans l ON c.customer_id = l.customer_id
GROUP BY c.customer_id, customer_name
HAVING account_count > 0 AND card_count > 0 AND loan_count > 0
ORDER BY account_count DESC, card_count DESC, loan_count DESC;

-- Q8. Which customers have cards, accounts, and loans together?
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN cards cd ON a.account_id = cd.account_id
JOIN loans l ON c.customer_id = l.customer_id
ORDER BY customer_name;