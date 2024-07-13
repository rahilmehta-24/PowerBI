select * from bank_loan_data

/* Total Loan applications */
select count(id) as total_applications from bank_loan_data

/* MTD (Month To Date) Loan Applications */
select count(id) as MTD_total_applications from bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

/* PMTD (Previous Month To Date) Loan Applications */
select count(id) as MTD_total_applications from bank_loan_data
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

/* Total Funded Amount */
select SUM(loan_amount) as total_funded_amount from bank_loan_data

/* MTD (Month To Date) Total Funded Amount */
select SUM(loan_amount) as MTD_total_funded_amount from bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

/* PMTD (Previous Month To Date) Total Funded Amount */
select SUM(loan_amount) as PMTD_total_funded_amount from bank_loan_data
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

/* Total Amount Recieved*/
select SUM(total_payment) as total_funded_amount from bank_loan_data

/* MTD (Month To Date) Total Amount Recieved */
select SUM(total_payment) as MTD_total_amount_recieved from bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

/* PMTD (Previous Month To Date) Total Amount Recieved */
select SUM(total_payment) as PMTD_total_amount_recieved from bank_loan_data
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

/* Average Interest Rate */
select avg(int_rate)*100 as average_interest_rate from bank_loan_data

/* MTD (Month To Date) Average Interest Rate */
select avg(int_rate)*100 as MTD_average_interest_rate from bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

/* PMTD (Previous Month To Date) Average Interest Rate */
select avg(int_rate)*100 as PMTD_average_interest_rate from bank_loan_data
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

/* Average DTI */
select avg(dti)*100 as average_dti from bank_loan_data

/* MTD (Month To Date) Average Interest Rate */
select  avg(dti)*100 as MTD_average_dti from bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

/* PMTD (Previous Month To Date) Average Interest Rate */
select  avg(dti)*100 as PMTD_average_dti from bank_loan_data
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

/* GOD LOAN ISSUED */

/* Good loan percentage */
select
	(count(case when loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100.0) / COUNT(id) as Good_Loan_Percentage
from bank_loan_data

/* Good loan applications */
select COUNT(id) as Good_Loan_applications from bank_loan_data
where loan_status = 'Fully Paid' OR loan_status = 'Current'

/* Good Loan Funded Amount */
select SUM(loan_amount) as Good_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Fully Paid' OR loan_status = 'Current'

/* Good Loan Amount Received */
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/* BAD LOAN ISSUED */

/* Bad Loan Percentage */
select
	(count(case when loan_status = 'Charged Off'  THEN id END)*100.0) / COUNT(id) as Good_Loan_Percentage
from bank_loan_data

/* Bad loan applications */
select COUNT(id) as Bad_Loan_applications from bank_loan_data
where loan_status = 'Charged Off'

/* Bad Loan Funded Amount */
select SUM(loan_amount) as Bad_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Charged Off'

/* Bad Loan Amount Received */
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
where loan_status = 'Charged Off'

/* LOAN STATUS */
select 
	loan_status
	,COUNT(id) as Loan_count
	,SUM(total_payment) as Total_amount_recieved
	,SUM(loan_amount) as Total_funded_amount
	,AVG(int_rate)*100 as Average_interest_rate
	,AVG(dti)*100 as DTI
from
	bank_loan_data
group by
	loan_status

/* MTD amount_recieved v amount funded */
select
	loan_status
	,SUM(total_payment) as Total_amount_recieved
	,SUM(loan_amount) as Total_funded_amount
from bank_loan_data
where MONTH(issue_date) = 12
group by loan_status

/** B. BANK LOAN REPORT | OVERVIEW **/

/* By Month */
select
	MONTH(issue_date) as Month_number
	,DATENAME(MONTH, issue_date) as Month_name
	,COUNT(id) as No_of_applications
	,SUM(total_payment) as Total_amount_recieved
	,SUM(loan_amount) as Total_funded_amount
from bank_loan_data
group by MONTH(issue_date), DATENAME(MONTH, issue_date)
order by MONTH(issue_date)

/* By State */
select
	address_state as State
	,COUNT(id) as No_of_applications
	,SUM(total_payment) as Total_amount_recieved
	,SUM(loan_amount) as Total_funded_amount
from bank_loan_data
group by address_state
order by address_state

/* By Term */
select
	term as Term
	,COUNT(id) as No_of_applications
	,SUM(total_payment) as Total_amount_recieved
	,SUM(loan_amount) as Total_funded_amount
from bank_loan_data
group by term
order by term

/* By Employee Length */
select
	emp_length as Employee_Length
	,COUNT(id) as No_of_applications
	,SUM(total_payment) as Total_amount_recieved
	,SUM(loan_amount) as Total_funded_amount
from bank_loan_data
group by emp_length
order by emp_length

/* By Purpose */
select
	purpose as PURPOSE
	,COUNT(id) as No_of_applications
	,SUM(total_payment) as Total_amount_recieved
	,SUM(loan_amount) as Total_funded_amount
from bank_loan_data
group by purpose
order by purpose

/* By Ownership */
select
	home_ownership as Home_Ownership
	,COUNT(id) as No_of_applications
	,SUM(total_payment) as Total_amount_recieved
	,SUM(loan_amount) as Total_funded_amount
from bank_loan_data
group by home_ownership
order by home_ownership


SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose