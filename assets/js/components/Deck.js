import React, { useState, useEffect } from 'react';
import Card from './Card';
function Deck(props) {

  const [astate, setAstate] = useState("");
  const [userId, setUserId] = useState(window.currentUserId);

  useEffect(() => {

  }, [astate])

  function printHand(){
    let userId = window.currentUserId;
    if(props.looking !== 0){
      userId = props.looking;
    }
    let hand = props.presences.find((x) => (x.user_id == userId))
    if(hand){
      return hand.cards.map((card) => {
        if(card.deck === props.deckType){
          return <Card key={card.id} id={card.id} name={card.name} image={card.image} state={card.state} deck={card.deck} commands={props.looking === 0} />
        }
        return null
      })
    }
    return null
  }

  function handleDrawCard(){
    window.channel.push("draw_card", props.deckType)
  }

  return (
    <div className={"column text-center deck"}>
      <h3>{props.name}</h3>
      {props.looking === 0 && <button onClick={handleDrawCard}>Pesca</button>}
      <div className="row hand center" style={{flexWrap: "wrap"}}>
        {printHand()}
      </div>
    </div>
  )
}
export default props => <Deck {...props} />;
