# Background
OnMart, a fictional online superstore, operates a complex logistics and supply chain network involving multiple warehouses, distribution centers, and delivery to customers across various zip codes and cities in the United States.

It has 97 distribution centers, 17 warehouses, and delivers to 785 zip codes. The supply chain structure involves multiple cities, each with unique latitude and longitude coordinates. Warehouses supply distribution centers, and some cities are served by warehouses from other locations. OnMart offers products in various departments, including Electronics, Clothing, Grocery, Furniture, and Sports.

The project involved connecting to the OnMart database using Python and PostgreSQL. Libraries like Pandas, Plotly, Seaborn, and Matplotlib are used for data analysis and visualization.

## Project Requirements and Analysis

- Order Returns by Zip Code:
  Calculated and visualized the total number of order returns per delivery zip code, highlighting top and bottom zip codes.

- Orders by Product Category and Zip Code:
  Analyzed and visualized the total number of orders for each product category in every delivery zip code, sorted by category.

- Total Sales by Zip Code:
  Calculated and presented the total sales per delivery zip code, sorted by total sales in descending order.

- Box Plot for Total Orders Count:
  Created a box plot using Seaborn to visualize the spread of total orders count for each product category and zip code.

- Total Orders per Product Category per Month:
  Analyzed the total number of orders per product category per delivery zip code per month, providing insights into monthly trends.

- Scatter Chart for 6-Month Bins:
  Utilized Seaborn to create scatter charts for 6-month bins, focusing on specific zip codes to observe order patterns.

- Top Distribution Centers for Delayed Deliveries:
  Identified and displayed the top 3 distribution centers with the maximum number of delayed deliveries.

- Expansion Planning Based on Orders:
  Explored the states with the highest number of orders to assist in planning the addition of a new warehouse.

- Busiest Day of the Week by Zip Code:
  Determined and visualized the busiest day of the week for order deliveries in each zip code.

- Influential Product Reviewers:
  Identified the most influential product reviewers for each product based on rating, reviews, friends, and shared product information.

## Conclusion
The project involves a comprehensive analysis of OnMart's logistics, supply chain, and customer-related data. It addresses key aspects such as returns, sales, order patterns, distribution center performance, and influential customer reviews. The use of Python and SQL with PostgreSQL allows for effective data extraction, transformation, and visualization, aiding OnMart in strategic decision-making and future planning.
