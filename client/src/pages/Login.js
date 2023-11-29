import { useState } from 'react';
import LoginForm from "../components/LoginForm";
import CreateAccountForm from '../components/CreateAccountForm';
import { Button, Container } from 'react-bootstrap';

function Login({ onLogin }) {
  const [login, setLogin] = useState(true);

  return(
    <Container>
    {login ? (
      <>
        <LoginForm onLogin={onLogin}/>
      </>
    ) : (
      <>
       <CreateAccountForm onLogin={onLogin}/>
      </>
    )}
    <hr/>
    <Button onClick={()=>setLogin(!login)}>
      {login ? 'Create account instead' : 'Login instead'}
    </Button>
    </Container>
  )

}

export default Login