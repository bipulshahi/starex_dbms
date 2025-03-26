import mysql.connector
import random
from datetime import datetime, timedelta

# Establish a database connection
conn = mysql.connector.connect(
    host="localhost",
    user="your_user",     # Replace with your MySQL username
    password="your_password",  # Replace with your MySQL password
    database="your_database"   # Replace with your database name
)
cursor = conn.cursor()

# Create sales_data table (if not exists)
cursor.execute("""
    CREATE TABLE IF NOT EXISTS sales_data (
        id INT AUTO_INCREMENT PRIMARY KEY,
        customer_id INT,
        product_id INT,
        sale_date DATE,
        quantity INT,
        unit_price DECIMAL(10,2),
        total_price DECIMAL(10,2),
        region VARCHAR(100),
        sales_rep VARCHAR(100),
        payment_mode VARCHAR(50)
    );
""")

# Function to generate random date within last 1 year
def random_date():
    return datetime.today() - timedelta(days=random.randint(1, 365))

# List of payment modes
payment_modes = ["Credit Card", "UPI", "Net Banking"]

# Insert 500 rows
for _ in range(500):
    customer_id = random.randint(1, 10)  # Assuming 10 customers exist
    product_id = random.randint(1, 10)  # Assuming 10 products exist
    sale_date = random_date().strftime('%Y-%m-%d')
    quantity = random.randint(1, 5)
    
    # Fetch random unit price from products
    cursor.execute("SELECT unit_price FROM products ORDER BY RAND() LIMIT 1")
    unit_price = cursor.fetchone()[0] if cursor.rowcount else 100.00  # Default price if no product

    total_price = unit_price * quantity
    
    # Fetch random region from customers
    cursor.execute("SELECT region FROM customers ORDER BY RAND() LIMIT 1")
    region = cursor.fetchone()[0] if cursor.rowcount else "Delhi"

    sales_rep = f"Sales Rep {random.randint(1, 5)}"
    payment_mode = random.choice(payment_modes)

    # Insert data
    cursor.execute("""
        INSERT INTO sales_data (customer_id, product_id, sale_date, quantity, unit_price, total_price, region, sales_rep, payment_mode)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s);
    """, (customer_id, product_id, sale_date, quantity, unit_price, total_price, region, sales_rep, payment_mode))

# Commit changes
conn.commit()

# Close connection
cursor.close()
conn.close()

print("500 rows inserted successfully into sales_data table!")
