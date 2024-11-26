from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector
import os
from dotenv import load_dotenv
import time

# Load environment variables
load_dotenv()

DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')
DB_HOST = os.getenv('DB_HOST')
DB_NAME = os.getenv('DB_NAME')
print(DB_USER)
print(DB_PASSWORD)
app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "http://localhost:3000"}})

# MySQL connection setup
def create_connection():
    config = {
        'user': DB_USER,
        'password': DB_PASSWORD,
        'host': DB_HOST,
        'database': DB_NAME,
        'raise_on_warnings': True,
        'ssl_disabled': True
    }
    return mysql.connector.connect(**config)

def check_mysql_connection():
    try:
        conn = create_connection()
        conn.close()
        print("MySQL is connected.")
        return True
    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
        return False


def wait_for_mysql():
    while not check_mysql_connection():
        print("Waiting for MySQL to be available...")
        time.sleep(5)


wait_for_mysql()

@app.route('/')
def home():
    return jsonify({"message": "Welcome to the Flask API! Available endpoints: /api/locations, /api/location [POST, PUT, DELETE], /api/aircrafts, /api/aircraft [POST, PUT, DELETE]"})

# -------------------- Locations API --------------------

# API to fetch all locations
@app.route('/api/locations', methods=['GET'])
def get_locations():
    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT * FROM Location")
        rows = cursor.fetchall()
        locations = [{'id': row[0], 'name': row[1]} for row in rows]
        return jsonify(locations)
    except mysql.connector.Error as err:
        print(f"Error fetching locations: {err}")
        return jsonify({"error": "Failed to fetch locations."}), 500
    finally:
        cursor.close()
        conn.close()

# API to add a new location
@app.route('/api/location', methods=['POST'])
def insert_location():
    data = request.get_json()
    id_location = data.get('id')
    name_location = data.get('name')

    if not id_location or not name_location:
        return jsonify({"error": "Both ID and Name are required!"}), 400

    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO Location (idLocation, nameLocation) VALUES (%s, %s)",
            (id_location, name_location)
        )
        conn.commit()
        return jsonify({"message": "Location added successfully!"}), 201
    except mysql.connector.Error as err:
        print(f"Error adding location: {err}")
        return jsonify({"error": "Failed to add location."}), 500
    finally:
        cursor.close()
        conn.close()

# API to update a location
@app.route('/api/location/<int:id>', methods=['PUT'])
def update_location(id):
    data = request.get_json()
    name_location = data.get('name')

    if not name_location:
        return jsonify({"error": "Name is required to update!"}), 400

    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "UPDATE Location SET nameLocation = %s WHERE idLocation = %s",
            (name_location, id)
        )
        conn.commit()
        return jsonify({"message": "Location updated successfully!"})
    except mysql.connector.Error as err:
        print(f"Error updating location: {err}")
        return jsonify({"error": "Failed to update location."}), 500
    finally:
        cursor.close()
        conn.close()

# API to delete a location
@app.route('/api/location/<int:id>', methods=['DELETE'])
def delete_location(id):
    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM Location WHERE idLocation = %s", (id,))
        conn.commit()
        return jsonify({"message": "Location deleted successfully!"})
    except mysql.connector.Error as err:
        print(f"Error deleting location: {err}")
        return jsonify({"error": "Failed to delete location."}), 500
    finally:
        cursor.close()
        conn.close()

# -------------------- Aircraft API --------------------

# API to fetch all aircrafts
@app.route('/api/aircrafts', methods=['GET'])
def get_aircrafts():
    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT * FROM Aircraft")
        rows = cursor.fetchall()
        aircrafts = [{'id': str(row[0]), 'type': row[1]} for row in rows]
        return jsonify(aircrafts)
    except mysql.connector.Error as err:
        print(f"Error fetching aircrafts: {err}")
        return jsonify({"error": "Failed to fetch aircrafts."}), 500
    finally:
        cursor.close()
        conn.close()

# API to get an aircraft by id
@app.route('/api/aircraft/<string:id>', methods=['GET'])
def get_aircraft(id):
    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT * FROM Aircraft WHERE idAircraft = %s", (id,))
        row = cursor.fetchone()
        if row:
            aircraft = {'id': row[0], 'type': row[1]}
            return jsonify(aircraft)
        else:
            return jsonify({"error": "Aircraft not found"}), 404
    except mysql.connector.Error as err:
        print(f"Error fetching aircraft: {err}")
        return jsonify({"error": "Failed to fetch aircraft."}), 500
    finally:
        cursor.close()
        conn.close()

# API to add a new aircraft
@app.route('/api/aircraft', methods=['POST'])
def insert_aircraft():
    data = request.get_json()
    id_aircraft = data.get('id')
    type_aircraft = data.get('type')

    if not id_aircraft or not type_aircraft:
        return jsonify({"error": "Both ID and Type are required!"}), 400

    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO Aircraft (idAircraft, typeAircraft) VALUES (%s, %s)",
            (id_aircraft, type_aircraft)
        )
        conn.commit()
        return jsonify({"message": "Aircraft added successfully!"}), 201
    except mysql.connector.Error as err:
        print(f"Error adding aircraft: {err}")
        return jsonify({"error": "Failed to add aircraft."}), 500
    finally:
        cursor.close()
        conn.close()

# API to update an aircraft
@app.route('/api/aircraft/<string:id>', methods=['PUT'])
def update_aircraft(id):
    data = request.get_json()
    type_aircraft = data.get('type')

    if not type_aircraft:
        return jsonify({"error": "Type is required to update!"}), 400

    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "UPDATE Aircraft SET typeAircraft = %s WHERE idAircraft = %s",
            (type_aircraft, id)
        )
        conn.commit()
        return jsonify({"message": "Aircraft updated successfully!"})
    except mysql.connector.Error as err:
        print(f"Error updating aircraft: {err}")
        return jsonify({"error": "Failed to update aircraft."}), 500
    finally:
        cursor.close()
        conn.close()

# API to delete an aircraft
@app.route('/api/aircraft/<string:id>', methods=['DELETE'])
def delete_aircraft(id):
    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM Aircraft WHERE idAircraft = %s", (id,))
        conn.commit()
        return jsonify({"message": "Aircraft deleted successfully!"})
    except mysql.connector.Error as err:
        print(f"Error deleting aircraft: {err}")
        return jsonify({"error": "Failed to delete aircraft."}), 500
    finally:
        cursor.close()
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
