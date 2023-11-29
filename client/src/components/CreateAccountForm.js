import React, { useState } from 'react';
import Form from 'react-bootstrap/Form'
import Button from 'react-bootstrap/Button';
import Alert from 'react-bootstrap/Alert';
import Image from 'react-bootstrap/Image';

function CreateAccountForm({ onLogin }) {
  
  const [formData, setFormData] = useState({
    name: '',
    username: '',
    bio: '',
    pfp_url: '',
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

  function handleSignUpSubmit(e) {
    e.preventDefault();
    setLoading(true);

    fetch('/signup', {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        user: {
          username: formData.username,
          password: formData.password,
          password_confirmation: formData.password_confirmation,
        }
      })
    }).then((r)=>{
      setLoading(false)
      if (r.ok) {
        r.json().then((user)=>onLogin(user))
      } else {
        r.json().then((errors)=> setErrors(errors.errors))
      }
    })
  }
  
  return(
    <Form onSubmit={handleSignUpSubmit}>
      <Image height={50}className='mb-3' roundedCircle src={formData.pfp_url}/>
      <Form.Group className='mb-3'>
        <Form.Label>Profile Image URL</Form.Label>
        <Form.Control
          id='pfp_url'
          type='text'
          value={formData.pfp_url}
          placeholder='Enter an image URL for a profile picture'
          onChange={handleFormChange}
        />
      </Form.Group>
      <Form.Group className='mb-3'>
        <Form.Label>Username</Form.Label>
        <Form.Control
          id='username'
          type='text'
          value={formData.username}
          placeholder='Choose a username'
          onChange={handleFormChange}
        />
      </Form.Group>
      <Form.Group className='mb-3'>
        <Form.Label>Password</Form.Label>
        <Form.Control
          id='password'
          type='password'
          value={formData.password}
          placeholder='Enter a password'
          onChange={handleFormChange}
        />
      </Form.Group>
      <Form.Group className='mb-3'>
        <Form.Label>Password Confirmation</Form.Label>
        <Form.Control
          id='password_confirmation'
          type='password'
          value={formData.password_confirmation}
          placeholder='Confirm your password'
          onChange={handleFormChange}
        />
      </Form.Group>
      <Button
        variant='primary'
        type='submit'
        className='mb-3'
      >
        {loading ? 'Loading...' : 'Sign Up'}
      </Button>
      {errors.map((error) => {
        return <Alert key={error} variant='danger'>{error}</Alert>
      })}
    </Form>
  )
}

export default CreateAccountForm;