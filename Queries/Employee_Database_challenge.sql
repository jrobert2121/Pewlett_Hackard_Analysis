-- Create Retirement Titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO Retirement_Titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO Unique_Titles
FROM Retirement_Titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

--Create Retiring Titles table containing number of titles who are about to retire
SELECT COUNT (ut.emp_no), ut.title
INTO Retiring_Titles
FROM Unique_Titles AS ut
GROUP BY ut.title
ORDER BY COUNT (ut.emp_no) DESC;

--Create Membership Eligibility table of employees eligible for mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO Mentorship_Eligibility
FROM employees as e
	INNER JOIN titles as t
		ON (e.emp_no = t.emp_no)
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
WHERE (de.to_date = ('9999-01-01'))
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;
	
	