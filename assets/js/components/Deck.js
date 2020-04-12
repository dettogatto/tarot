import React, { useState, useEffect } from 'react';
import Card from './Card';
function Deck(props) {

  const [astate, setAstate] = useState("");
  const [userId, setUserId] = useState(window.currentUserId);

  useEffect(() => {

  }, [astate])

  function printHand(){
    let userId = window.currentUserId;
    let hand = props.presences.find((x) => (x.user_id == userId))
    if(hand){
      return hand.cards.map((card) => {
        if(window.allCards[Math.abs(card)]["deck"] === props.deckType){
          return <Card key={Math.abs(card)} id={Math.abs(card)} visible={card > 0} commands={props.looking === 0} />
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
      <div className="row row-wrap hand center">
        {printHand()}
      </div>
    </div>
  )
}
export default props => <Deck {...props} />;
