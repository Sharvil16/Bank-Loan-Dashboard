 SELECT * FROM bank_loan_data
 SELECT COUNT(id) AS Total_Loan_Applications FROM bank_loan_data

 /* MTD Total Loan Applications */
 SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM bank_loan_data
 WHERE MONTH(issue_date) = 12
 
 /* Total Funded Amount */
 SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

/* MTD Total Funded Amount */
SELECT SUM(loan_amount) AS MTD_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

/* PMTD Total Funded Amount*/
SELECT SUM(loan_amount) AS PMTD_Funded_Amount FROM  bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

/* Total Amount Received */
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

/* Average Interest Rate */
SELECT AVG(int_rate) *100 AS Avg_Interest_Rate FROM bank_loan_data

/* Average Debt to Income ratio */
SELECT AVG(dti) * 100 AS Avg_dti_Ratio FROM bank_loan_data


SELECT ROUND(AVG(dti), 4) *100 AS Avg_dti_Ratio FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND  YEAR(issue_date) = 2021

/* Good Loan Application Percentage */
SELECT 
	ROUND((COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) *100.0), 2)
	/
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

/* Good Loan Applications */
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/* Good Loan Funded Amount*/
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/* Good Loan Total Received Amount*/
SELECT SUM(total_payment) AS Good_Loan_Received_Amount FROM bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/* Bad Loan Application Percentage */
SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0)
	/
	COUNT(id) AS Bad_Loan_Percentage 
FROM bank_loan_data

/* Bad Loan Applications */
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data WHERE loan_status = 'Charged Off'

/* Bad Loan Funded Amount*/
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM bank_loan_data 
WHERE loan_status = 'Charged Off'

/* Bad Loan Total Received Amount*/
SELECT SUM(total_payment) AS Bad_Loan_Received_Amount FROM bank_loan_data 
WHERE loan_status = 'Charged Off'

SELECT
	loan_status,
	COUNT(ID) as Total_Applications,
	SUM(total_payment) as Total_amt_Received,
	AVG(int_rate) *100 as Interest_rate,
	AVG(dti) *100 as DTI
	FROM 
		bank_loan_data
	GROUP BY 
		 loan_status

 SELECT
	loan_status,
	SUM(total_payment) AS MTD_Total_Amt_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amt
	FROM bank_loan_data
	WHERE MONTH(issue_date) = 12
	GROUP BY loan_status

/* 1st Dashboard Done*/

/* 2nd Dashboard Begins*/
/* Monthly Trends by Issue Date*/
SELECT
	MONTH(issue_date),
	DATENAME(MONTH, issue_date) AS 'Month',
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

/* Regional Analysis by State*/
SELECT
	address_state AS 'State',
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY COUNT(id) DESC 

/* Loan Term Analysis*/
SELECT
	term AS Term,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term ASC

/* Employee Length Analysis */
SELECT
	emp_length AS Employee_Length,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length ASC

/* Loan Purpose Breakdown */
SELECT
	purpose AS Purpose,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC

/* Home Ownership Status */
SELECT
	home_ownership AS Ownership_Status,
	COUNT(id) AS Total_loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC

 