import React, { useEffect, useState } from 'react'; 
import { Button, Image, Container, Row, Col } from 'react-bootstrap';
// import clubs_2 from '../resources/clubs_2.png';
function Game() {

  const [dealerHand, setDealer] = useState(null)
  const [playerHand, setPlayer] = useState(null)

  function startGame() {
    fetch('/games', {
      method: 'POST',
      headers: {
        "Content-Type": "application/json",
      }
    }).then((r)=>r.json().then((game)=>{
      console.log(game)
      setDealer(game.dealer);
      setPlayer(game.player);
    }));

  }

  function hit() {
    fetch('/hit').then((r)=> {
      if (r.ok) {
        r.json().then((res)=>setPlayer(res.player)); 
      }
    })
  };
  
  useEffect(() => {
    fetch('/games').then((r)=> {
      if (r.ok) {
        r.json().then((game)=>{
          console.log(game);
          setDealer(game.dealer);
          setPlayer(game.player);
        });
      }
    })
  }, []);


  if (dealerHand && playerHand) {
    return (
      <Container>
        <Row xs='auto'>
          {dealerHand.map((card)=>{
            return (
              <Col>
                <Image src={require(`../resources/${card.suit}_${card.face}.png`)}/>
              </Col>
            )
          })}
        </Row>
        <Row xs='auto'>
          {playerHand.map((card)=>{
            return (
              <Col>
                <Image src={require(`../resources/${card.suit}_${card.face}.png`)}/>
              </Col>
            )
          })}
        </Row>
        <hr/>
        <Row xs='auto'>
          <Col>
            <Button>Stay</Button>
          </Col>
          <Col>
            <Button>Hit</Button>
          </Col>
          <Col>
            <Button>End Game</Button>
          </Col>
        </Row>
      </Container>
    
    )
  } else {
    return <Button onClick={startGame}>Start Game</Button>
  }

}

export default Game; 