import ConnectDB as db


#To load customers data from csv file to database,  
# Make sure to have the customers.csv file in the data folder
#  and the database connection details correctly set in ConnectDB.py.
def load_customers():
    conn = db.connect_to_db()
    if conn:
        cursor = conn.cursor()
        try:
            with open('data/customers.csv', 'r') as f:
                next(f)  # Skip the header row
                cursor.copy_from(f, 'customer', sep=',')
            conn.commit()
            print("Customers loaded successfully.")
        except Exception as e:
            print(f"Error loading customers: {e}")
        finally:
            cursor.close()
            conn.close()

#To load products data from csv file to database, 
# Make sure to have the products.csv file in the data folder
#  and the database connection details correctly set in ConnectDB.py.
def load_products():
    conn = db.connect_to_db()
    if conn:
        cursor = conn.cursor()
        try:
            with open('data/products.csv', 'r') as f:
                next(f)  # Skip the header row
                cursor.copy_from(f, 'products', sep=',')
            conn.commit()
            print("Products loaded successfully.")
        except Exception as e:
            print(f"Error loading products: {e}")
        finally:
            cursor.close()
            conn.close()

#To load orders data from csv file to database,
# Make sure to have the orders.csv file in the data folder  
#  and the database connection details correctly set in ConnectDB.py.
def load_orders():
    conn = db.connect_to_db()
    if conn:
        cursor = conn.cursor()
        try:
            with open('data/orders.csv', 'r') as f:
                next(f)  # Skip the header row
                cursor.copy_from(f, 'orders', sep=',')
            conn.commit()
            print("Orders loaded successfully.")
        except Exception as e:
            print(f"Error loading orders: {e}")
        finally:
            cursor.close()
            conn.close()

#To load order items data from csv file to database,
# Make sure to have the order_items.csv file in the data folder 
#  and the database connection details correctly set in ConnectDB.py.
def load_order_items():
    conn = db.connect_to_db()
    if conn:
        cursor = conn.cursor()
        try:
            with open('data/order_items.csv', 'r') as f:
                next(f)  # Skip the header row
                cursor.copy_from(f, 'order_items', sep=',')
            conn.commit()
            print("Order items loaded successfully.")
        except Exception as e:
            print(f"Error loading order items: {e}")
        finally:
            cursor.close()
            conn.close()

def main():
    #load_customers()   
    #load_products()
    #load_orders()
    load_order_items()

main()             