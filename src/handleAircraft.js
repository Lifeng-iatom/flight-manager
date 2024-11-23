import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Aircraft = () => {
  const [aircrafts, setAircrafts] = useState([]);
  const [idAircraft, setIdAircraft] = useState('');
  const [typeAircraft, setTypeAircraft] = useState('');
  const [updateId, setUpdateId] = useState('');
  const [updateType, setUpdateType] = useState('');
  const [deleteId, setDeleteId] = useState('');

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

  // Update an existing aircraft
  const handleUpdateAircraft = () => {
    if (!updateId || !updateType) {
      alert("Please provide both ID and Type to update.");
      return;
    }

    axios.put(`http://127.0.0.1:5000/api/aircraft/${updateId}`, {
      type: updateType,
    })
      .then((response) => {
        alert(response.data.message);
        setAircrafts(aircrafts.map(aircraft => 
          aircraft.id === updateId ? { ...aircraft, type: updateType } : aircraft
        ));
        setUpdateId('');
        setUpdateType('');
      })
      .catch((error) => {
        console.error('There was an error updating the aircraft!', error);
      });
  };

  // Delete an aircraft
  const handleDeleteAircraft = () => {
    if (!deleteId) {
      alert("Please provide an ID to delete.");
      return;
    }

    axios.delete(`http://127.0.0.1:5000/api/aircraft/${deleteId}`)
      .then((response) => {
        alert(response.data.message);
        setAircrafts(aircrafts.filter(aircraft => aircraft.id !== deleteId));
        setDeleteId('');
      })
      .catch((error) => {
        console.error('There was an error deleting the aircraft!', error);
      });
  };

  return (
    <div className="App">
      <h1>Aircraft Management</h1>
      
      {/* Display Aircrafts */}
      <h2>Aircraft List</h2>
      <ul>
        {aircrafts.map((aircraft) => (
          <li key={aircraft.id}>{aircraft.id}: {aircraft.type}</li>
        ))}
      </ul>

      {/* Add New Aircraft */}
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
      <button onClick={handleAddAircraft}>Add Aircraft</button>

      {/* Update Existing Aircraft */}
      <h2>Update Aircraft</h2>
      <input 
        type="text" 
        placeholder="Aircraft ID" 
        value={updateId}
        onChange={(e) => setUpdateId(e.target.value)} 
      />
      <input 
        type="text" 
        placeholder="New Aircraft Type" 
        value={updateType}
        onChange={(e) => setUpdateType(e.target.value)} 
      />
      <button onClick={handleUpdateAircraft}>Update Aircraft</button>

      {/* Delete Aircraft */}
      <h2>Delete Aircraft</h2>
      <input 
        type="text" 
        placeholder="Aircraft ID to Delete" 
        value={deleteId}
        onChange={(e) => setDeleteId(e.target.value)} 
      />
      <button onClick={handleDeleteAircraft}>Delete Aircraft</button>
    </div>
  );
};

export default Aircraft;
