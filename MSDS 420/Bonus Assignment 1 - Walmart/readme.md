Connected to a dataset with ~3 million records and 5 fields using psycopg2 and ran the following queries on a Python relational mapper:

1. Find total sales by store
2. Find total sales by store and department
3. Find total sales by store and week
4. Find total sales by department and week
5. Find total weekly sales using **ROLLUP** clause for the hierarchical data: store, department and week
6. Find total weekly sales using **ROLLUP** clause for the hierarchical data: store and department
7. Find total weekly sales using **CUBE** clause for the hierarchical data: store, department and week
8. Get descriptive statistics for each store
9. Get the top 500 weekly sales and plot them (Red color for Holiday and Blue color for Not Holiday) against the weekly Unemployment and Temperature
10. Get descriptive statistics for each department
11. Produce a listing of total sales per department across the entire list of stores
12. Produce a listing of total sales per store across the entire list of departments for the week of 2010-02-19
13. Produce a listing of total sales per department across the entire list of stores for the week of 2010-02-19
14. Get the top 500 weekly sales and plot them (Red color for Unemployment greater than or equal to 5 and Green color if it is less than 5) against the weekly Unemployment and Temperature 
