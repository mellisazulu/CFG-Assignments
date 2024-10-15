# client side interactions
import json

import requests
from urllib3 import request

def get_pilates_prices(price):
    result = requests.get(f'http://127.0.0.1:5001/prices/{price}', headers={'content-type': 'application/json'})
    return result.json()

def booking_pilates(service_id, service_name, price, customer_name):
    booking = {
        "service_id": service_id,
        "service_name": service_name,
        "price": price,
        "customer_name":customer_name
    }
    result = requests.put(
        'http://127.0.0.1:5001/booking',
        headers={'content-type': 'application/json'},
        data=json.dumps(booking)
    )
    return result.json()

def get_all_instructors(instructor):
    result = requests.get(f'http://127.0.0.1:5001/instructor', headers={'content-type': 'application/json'})
    return result.json()


def run():
    print('##################################################')
    print('Hello, prepare to stretch your mind, body and soul')
    print('###################################################')
    print()
    price = input('What is your budget for a session: Range between 50.00 - 95.00: ')
    print()
    print('###### PRICES ######')
    print()
    print(get_pilates_prices(price))

if __name__ == '__main__':
    run()