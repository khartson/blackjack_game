import { useState } from 'react';
import { Form, Container, Button, Col, Row, Alert } from 'react-bootstrap';

function Profile({ setUser, id }) {

  const [username, setUsername] = useState("");
  const [errors, setErrors] = useState([]);
  const [loading, setLoading] = useState(false);

  function handleUsernameSubmit(e) {
    e.preventDefault();
    setLoading(true);
    fetch(`users/${id}`, {
      method: 'PATCH',
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        user: {
          username: username 
        }
      })
    }).then((r)=>{
      setLoading(false);
      if (r.ok) {
        r.json().then((user)=>setUser(user));
      } else {
        r.json().then((err)=>setErrors(err.errors)); 
      }
    })

  }

  function addCredits(e) {
    fetch(`/addcredits`, {
      method: 'POST',
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        user: {
          credits: e.target.value
        }
      })
    }).then((r)=>r.json().then((user)=>setUser(user)));

  }
  return (
    <Container>
      <Form>
        <Form.Group className="mb-3">
          <Form.Label>Change username</Form.Label>
          <Form.Control value={username} onChange={(e)=>setUsername(e.target.value)}/>
        </Form.Group>
        <Button variant="primary" type="submit" onClick={handleUsernameSubmit}>
          {loading? 'Loading...' : 'Submit'}
        </Button>
      </Form>
      {errors.map((error) => {
          return <Alert key={error} variant='danger'>{error}</Alert>
      })}
      <hr/>
      <Container fluid>
        <h3>Add Credits</h3>
        <Row xs='auto'>
        <Col>
          <Button value={1} onClick={addCredits}>+1</Button>
        </Col>
        <Col>
          <Button value={5} onClick={addCredits}>+5</Button>
        </Col>
        <Col>
          <Button value={10} onClick={addCredits}>+10</Button>
        </Col>
        </Row>
      </Container>
    </Container>
  );
}

export default Profile; 