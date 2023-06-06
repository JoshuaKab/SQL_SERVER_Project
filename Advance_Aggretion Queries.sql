/*Introduction
As a data student or professional, you know that SQL is a crucial 
tool for querying and manipulating data in relational databases. In this tutorial, we will delve into some of the more
 advanced features of SQL, including subqueries, joins, and aggregate functions. These techniques will allow you 
 to perform complex operations on your data and extract insights that 
would be difficult or impossible using basic SQL commands.

We will start by covering subqueries, which are nested 
queries that allow you to perform operations on data within a 
SELECT, INSERT, UPDATE, or DELETE statement. Subqueries are a powerful 
way to filter, aggregate, and update data, and they are an essential tool for any advanced SQL user.*/

 /* Next, we will look at the various types of joins available in SQL. Joins allow you to combine data from multiple tables,
 and they are a crucial technique for working with large and complex datasets. We will explore inner, outer, 
cross, and self-joins and more.*/

SELECT MAX(salary) FROM employees;

/* A row subquery returns a single row of data. For example, you might use a row subquery to find the employee
 with the highest salary: */
 
 SELECT * FROM employees WHERE salary = (SELECT MAX(salary) FROM employees);
 
 SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);
 
 SELECT * FROM orders WHERE customer_id IN (SELECT id FROM customers WHERE country = 'USA');
 
 /* This query returns all orders placed by customers in the USA. The subquery in the WHERE clause returns a list
 of customer IDs for  customers in the USA, and the outer query uses this list to filter orders placed by those customers.

You can also use subqueries to update or insert data. For example, you might use a subquery in an
 INSERT statement to insert records based on the results of another query: */
 
 INSERT INTO sales_by_month SELECT month, SUM(sales) FROM orders GROUP BY month;
 
 
/*Joins

Joins are a crucial technique for combining data from multiple tables in a database. They allow you to retrieve 
data from multiple tables in a single query, making it easy to work with large and complex datasets. */

SELECT employees.*, departments.* FROM employees INNER JOIN departments ON employees.department_id = departments.id;

/* left join */
SELECT employees.*, departments.* FROM employees LEFT OUTER JOIN departments ON employees.department_id = departments.id;

/* cross join */

SELECT * FROM employees CROSS JOIN departments;

 /* Aggregate Functions
Aggregate functions are used to perform calculations on sets of data. They allow you to extract insights from your data
 by performing calculations such as totals, averages, and maximum and minimum values. There are several common
 aggregate functions in SQL, including SUM, AVG, MAX, and MIN.

The SUM function returns the sum of a set of values. For example, you might use SUM to find the total sales for a
 particular month: */
 
 SELECT SUM(sales) FROM orders WHERE month = 'January';
 
 SELECT AVG(salary) FROM employees;
 
 SELECT MAX(salary) FROM employees;
 
 SELECT MIN(salary) FROM employees;
 
 SELECT month, SUM(sales) FROM orders GROUP BY month;
 
 SELECT department, AVG(salary) FROM employees GROUP BY department HAVING AVG(salary) > 50000;
 
 /* Conclusion
In this tutorial, we explored some of the more advanced features of SQL, including subqueries, 
joins, and aggregate functions. These techniques allow you to perform complex operations on your data and extract
 insights that would be difficult or impossible using basic SQL commands. */