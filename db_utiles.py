# Have db_utils file and demonstrate the use of exception handling
from logging import raiseExceptions

import mysql.connector
from config_file import HOST, USER, PASSWORD

class DbConnectionError(Exception):
    pass

def _connect_to_db(db_name):
    cnx = mysql.connector.connect(
        host=HOST,
        user=USER,
        password=PASSWORD,
        auth_plugin='mysql_native_password',
        database=db_name
    )
    return cnx

# Using SQL queries to interact with the db - to get a list of all the available Pilates sessions that cost more than 20.00.
def _map_values(services):
    mapped = []
    for item in services:
        mapped.append({
            'service_id': item[0],
            'service_name': item[1],
            'duration': item [2],
            'price': item[3],
        })
    return mapped

def get_all_sessions(price):
    prices = []
    try:
        db_name = 'body_focus'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print(f"Connected to DB:{db_name}")

        query = """
        SELECT service_id,service_name, duration, price
        FROM services
        WHERE price >20.00
        """.format(price)

        cur.execute(query)
        result = cur.fetchall()
        prices = _map_values(result)
        cur.close()

    except Exception:
        raise DbConnectionError("Failed to get data from the DB")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is now closed")

    return prices

# Using SQL queries to interact with the db - to book onto a Pilates sessions.
def booking_pilates(service_id, service_name, price, customer_name):
    try:
        db_name = 'body_focus'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print(f"Connected to DB:{db_name}")

        query = f"""
        UPDATE services
        SET 
            '{price}' = 1,
            '{service_id} = {customer_name}
            WHERE booking = '{price}', AND service_name = '{service_name}'
        """.format(service_id=service_id, service_name=service_name, customer_name=customer_name, price=price)

        cur.execute(query)
        db_connection.commit()
        cur.close()

    except Exception:
        raise DbConnectionError("Failed to read data from the DB")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is now closed")

# Getting information on the instructors from the db

def get_all_instructors(instructor):
    employee = []
    try:
        db_name = 'body_focus'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print(f"Connected to DB:{db_name}")

        query = """
        SELECT employee_id,first_name, last_name, position
        FROM employees
        """.format(instructor)

        cur.execute(query)
        result = cur.fetchall()
        cur.close()

    except Exception:
        raise DbConnectionError("Failed to read data from the DB")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is now closed")