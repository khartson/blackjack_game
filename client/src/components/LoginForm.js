import { useState } from 'react';
import { Form, Button, Alert } from 'react-bootstrap';

function LoginForm({ onLogin }) {
  const [formData, setFormData] = useState({
    username: '',
    password: '',
  })

  const [errors, setErrors] = useState([]);
  const [loading, setLoading] = useState(false);

  function handleFormChange(e) {
    const field = e.target.id;
    const input = e.target.value; 
    
    setFormData({
      ...formData,
      [field]: input
    })
  }


  function handleLoginSubmit(e) {
    e.preventDefault();
    setLoading(true);
    fetch('/login', {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
       username: formData.username,
       password: formData.password
      })
    }).then((r)=>{
      setLoading(false)
      if (r.ok) {
        r.json().then((user)=> onLogin(user));
      } else {
        r.json().then((errors)=> setErrors(errors.errors))
      }
    })
  }

  return(
    <Form onSubmit={handleLoginSubmit}>
      <Form.Group className='mb-3'>
        <Form.Label>Username</Form.Label>
        <Form.Control 
          id='username'
          type='text' 
          value={formData.username} 
          placeholder='Enter username'
          onChange={handleFormChange}
        />
      </Form.Group>

      <Form.Group className='mb-3'>
        <Form.Label>Password</Form.Label>
        <Form.Control 
          id='password'
          type='password' 
          value={formData.password}
          placeholder='password'
          onChange={handleFormChange}
        />
      </Form.Group>
        <Button 
          variant='primary' 
          type='submit'
          className='mb-3'
        >
          {loading? 'Loading...' : 'Log In'}
        </Button>
        {errors.map((error) => {
          return <Alert key={error} variant='danger'>{error}</Alert>
        })}
    </Form>
  )
}

export default LoginForm; 