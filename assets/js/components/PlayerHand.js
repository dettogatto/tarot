import React, { useState, useEffect } from 'react';
import SmallCard from './SmallCard';
function PlayerHand(props) {

  const [astate, setAstate] = useState("");

  useEffect(() => {

  }, [astate])

  function getDeck(deck){
    return props.cards.map((card) => {
      if(window.allCards[Math.abs(card)]["deck"] === deck){
        return <SmallCard key={card} id={Math.abs(card)} visible={card > 0} />
      }
      return null
    })
  }

  return (
    <div className="container player-hand">
      <div className="player-name text-center">
        <h5 className="text-center">{props.username}</h5>
      </div>
      <div className="row">
        <div className="column column-50">
          <div className="row row-wrap center">
            {getDeck("arcani_minori")}
          </div>
        </div>
        <div className="column column-50 row">
          <div className="row row-wrap center">
            {getDeck("arcani_maggiori")}
          </div>
        </div>
      </div>
    </div>
  )
}
export default props => <PlayerHand {...props} />;
