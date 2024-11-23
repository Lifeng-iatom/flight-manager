import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

const App = () => {
  const [locations, setLocations] = useState([]);
  const [aircrafts, setAircrafts] = useState([]);
  const [idLocation, setIdLocation] = useState('');
  const [nameLocation, setNameLocation] = useState('');
  const [idAircraft, setIdAircraft] = useState('');
  const [typeAircraft, setTypeAircraft] = useState('');
  const [updateIdLocation, setUpdateIdLocation] = useState('');
  const [updateNameLocation, setUpdateNameLocation] = useState('');
  const [updateIdAircraft, setUpdateIdAircraft] = useState('');
  const [updateTypeAircraft, setUpdateTypeAircraft] = useState('');
  const [deleteIdLocation, setDeleteIdLocation] = useState('');
  const [deleteIdAircraft, setDeleteIdAircraft] = useState('');

  // Fetch all locations
  useEffect(() => {
    axios.get('http://127.0.0.1:5000/api/locations')
      .then((response) => {
        setLocations(response.data);
      })
      .catch((error) => {
        console.error('There was an error fetching the locations!', error);
      });
  }, []);

  // Fetch all aircrafts
  useEffect(() => {
    axios.get('http://127.0.0.1:5000/api/aircrafts')
      .then((response) => {
        setAircrafts(response.data);
      })
      .catch((error) => {
        console.error('There was an error fetching the aircrafts!', error);
      });
  }, []);

  // Insert a new location
  const handleAddLocation = () => {
    if (!idLocation || !nameLocation) {
      alert("Please provide both ID and Name of Location.");
      return;
    }

    axios.post('http://127.0.0.1:5000/api/location', {
      id: idLocation,
      name: nameLocation,
    })
      .then((response) => {
        alert(response.data.message);
        setLocations([...locations, { id: idLocation, name: nameLocation }]);
        setIdLocation('');
        setNameLocation('');
      })
      .catch((error) => {
        console.error('There was an error adding the location!', error);
      });
  };

  // Insert a new aircraft
  const handleAddAircraft = () => {
    if (!idAircraft || !typeAircraft) {
      alert("Please provide both ID and Type of Aircraft.");
      return;
    }

    axios.post('http://127.0.0.1:5000/api/aircraft', {
      id: idAircraft,
      type: typeAircraft,
    })
      .then((response) => {
        alert(response.data.message);
        setAircrafts([...aircrafts, { id: idAircraft, type: typeAircraft }]);
        setIdAircraft('');
        setTypeAircraft('');
      })
      .catch((error) => {
        console.error('There was an error adding the aircraft!', error);
      });
  };

  // Update a location
  const handleUpdateLocation = () => {
    if (!updateIdLocation || !updateNameLocation) {
      alert("Please provide both ID and Name to update the Location.");
      return;
    }

    axios.put(`http://127.0.0.1:5000/api/location/${updateIdLocation}`, {
      name: updateNameLocation,
    })
      .then((response) => {
        alert(response.data.message);
        setLocations(locations.map(location =>
          location.id === updateIdLocation ? { ...location, name: updateNameLocation } : location
        ));
        setUpdateIdLocation('');
        setUpdateNameLocation('');
      })
      .catch((error) => {
        console.error('There was an error updating the location!', error);
      });
  };

  // Update an aircraft
  const handleUpdateAircraft = () => {
    if (!updateIdAircraft || !updateTypeAircraft) {
      alert("Please provide both ID and Type to update the Aircraft.");
      return;
    }

    axios.put(`http://127.0.0.1:5000/api/aircraft/${updateIdAircraft}`, {
      type: updateTypeAircraft,
    })
      .then((response) => {
        alert(response.data.message);
        setAircrafts(aircrafts.map(aircraft =>
          aircraft.id === updateIdAircraft ? { ...aircraft, type: updateTypeAircraft } : aircraft
        ));
        setUpdateIdAircraft('');
        setUpdateTypeAircraft('');
      })
      .catch((error) => {
        console.error('There was an error updating the aircraft!', error);
      });
  };

  // Delete a location
  const handleDeleteLocation = (id) => {
    axios.delete(`http://127.0.0.1:5000/api/location/${id}`)
      .then((response) => {
        alert(response.data.message);
        setLocations(locations.filter(location => location.id !== id));
      })
      .catch((error) => {
        console.error('There was an error deleting the location!', error);
      });
  };

  // Delete an aircraft
  const handleDeleteAircraft = (id) => {
    axios.delete(`http://127.0.0.1:5000/api/aircraft/${id}`)
      .then((response) => {
        alert(response.data.message);
        setAircrafts(aircrafts.filter(aircraft => aircraft.id !== id));
      })
      .catch((error) => {
        console.error('There was an error deleting the aircraft!', error);
      });
  };

  return (
    <div className="app-container">
      <h1>Location and Aircraft Management</h1>

      {/* Display Locations */}
      <div className="section">
        <h2>Locations</h2>
        <ul>
          {locations.map((location) => (
            <li key={location.id}>
              {location.id}: {location.name}
              <button className="delete-btn" onClick={() => handleDeleteLocation(location.id)}>Delete</button>
            </li>
          ))}
        </ul>
      </div>

      {/* Add New Location */}
      <div className="section">
        <h2>Add Location</h2>
        <input
          type="text"
          placeholder="Location ID"
          value={idLocation}
          onChange={(e) => setIdLocation(e.target.value)}
        />
        <input
          type="text"
          placeholder="Location Name"
          value={nameLocation}
          onChange={(e) => setNameLocation(e.target.value)}
        />
        <button className="btn" onClick={handleAddLocation}>Add Location</button>
      </div>

      {/* Update Location */}
      <div className="section">
        <h2>Update Location</h2>
        <input
          type="text"
          placeholder="Location ID"
          value={updateIdLocation}
          onChange={(e) => setUpdateIdLocation(e.target.value)}
        />
        <input
          type="text"
          placeholder="New Location Name"
          value={updateNameLocation}
          onChange={(e) => setUpdateNameLocation(e.target.value)}
        />
        <button className="btn" onClick={handleUpdateLocation}>Update Location</button>
      </div>

      {/* Display Aircrafts */}
      <div className="section">
        <h2>Aircrafts</h2>
        <ul>
          {aircrafts.map((aircraft) => (
            <li key={aircraft.id}>
              {aircraft.id}: {aircraft.type}
              <button className="delete-btn" onClick={() => handleDeleteAircraft(aircraft.id)}>Delete</button>
            </li>
          ))}
        </ul>
      </div>

      {/* Add New Aircraft */}
      <div className="section">
        <h2>Add Aircraft</h2>
        <input
          type="text"
          placeholder="Aircraft ID"
          value={idAircraft}
          onChange={(e) => setIdAircraft(e.target.value)}
        />
        <input
          type="text"
          placeholder="Aircraft Type"
          value={typeAircraft}
          onChange={(e) => setTypeAircraft(e.target.value)}
        />
        <button className="btn" onClick={handleAddAircraft}>Add Aircraft</button>
      </div>

      {/* Update Aircraft */}
      <div className="section">
        <h2>Update Aircraft</h2>
        <input
          type="text"
          placeholder="Aircraft ID"
          value={updateIdAircraft}
          onChange={(e) => setUpdateIdAircraft(e.target.value)}
        />
        <input
          type="text"
          placeholder="New Aircraft Type"
          value={updateTypeAircraft}
          onChange={(e) => setUpdateTypeAircraft(e.target.value)}
        />
        <button className="btn" onClick={handleUpdateAircraft}>Update Aircraft</button>
      </div>
    </div>
  );
};

export default App;
