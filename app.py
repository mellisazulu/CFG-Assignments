# Implementing 2 API endpoints and one additional

from flask import Flask, jsonify, request

from db_utiles import get_all_sessions

app = Flask(__name__)

# get request for the visibility of the Pilates sessions and prices
@app.route('/prices/<price>', methods=['GET'])
def get_prices(price):
    res = get_all_sessions(price)
    return jsonify(res)

# Put method to add and update for a Pilates session
@app.route ('/booking', methods=['PUT'])
def booking_pilates():
    booking = request.get_json()
    booking_pilates(
        service_id=booking['service_id'],
        service_name=booking['service_name'],
        customer_name=booking['customer_name'],
        price=booking['price']
    )
    return booking

@app.route('/instructor', methods=['GET'])
def get_all_instructors(instructor):
    res = get_all_instructors(instructor)
    return jsonify(res)

if __name__ == '__main__':
    app.run(debug=True, port=5001)