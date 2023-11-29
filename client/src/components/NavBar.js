import React from 'react';
import { Navbar, Nav, Container, Button } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';

function NavBar({ setUser, user }) {

  function logout() {
    fetch('/logout', { method: "DELETE" }).then((r) => {
      if (r.ok) {
        setUser(null);
      }
    });
  }
  return(
  <Navbar>
    <Container>
      <Navbar.Brand>Browser Blackjack</Navbar.Brand>
      <Nav>
        <LinkContainer to='/profile'>
          <Nav.Link>Profile</Nav.Link>
        </LinkContainer>
        <LinkContainer to='/game'>
          <Nav.Link>Play Blackjack</Nav.Link>
        </LinkContainer>
      </Nav>
    </Container>
    <Container>
        <Navbar.Text>Signed in as: {user.username}</Navbar.Text>
        <Button onClick={logout}>Log out</Button>
    </Container>
  </Navbar>
  )
}

export default NavBar;