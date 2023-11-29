
import React, { useEffect, useState } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { Container, Nav } from 'react-bootstrap';
import Login from '../pages/Login';
import NavBar from './NavBar';
import 'bootstrap/dist/css/bootstrap.min.css'; 

function App() {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetch('/me').then((r)=> {
      if (r.ok) {
        r.json().then((user)=>setUser(user));
      }
    })
  }, []);

  if (!user) return (
  <Container style={{margin: '50px'}}>
    <Login onLogin={setUser}/>
  </Container>
  )
  return (
    <Container>
      <NavBar setUser={setUser} user={user}/>
      <hr/>
      <Routes>
        <Route path='/profile' element={<h1>profile</h1>}/>
        <Route path='/game' element={<h1>Game</h1>}/>
      </Routes>
    </Container>
  )
  }
export default App;
