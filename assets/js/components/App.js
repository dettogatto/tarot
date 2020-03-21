import React, { useState, useEffect } from 'react';
import UsersList from './UsersList';
import Deck from './Deck';
import {Socket, Presence} from "phoenix"

function App(props) {

  const [astate, setAstate] = useState("");
  const [presences, setPresences] = useState([]);
  const [looking, setLooking] = useState(0);

  useEffect(() => {
    setPresences(
      Object.keys(props.presences).map((x) => {
        let metas = props.presences[x].metas[0]
        return metas
      })
    );
  }, [props.presences])

  useEffect(() => {
    window.cardsToPreload.forEach((pic) => {
      new Image().src = "/images/decks/" + pic;
    })
  }, [])



  function handleEmptyHand(){
    window.channel.push("empty_hand")
  }

  function handleBackToMyHand(){
    setLooking(0)
  }

  function getMainButton(){
    if(looking === 0){
      return (
        <button onClick={handleEmptyHand}>riponi tutte le carte</button>
      )
    }
    return <button onClick={handleBackToMyHand}>torna alla tua mano</button>
  }

  return (
    <div>
      <h3 className="text-center">Ciao {window.currentUserName}</h3>
      <div className="container text-center">
        {getMainButton()}
      </div>
      <div className="row">
        <Deck deckType="arcani_minori" name="Arcani Minori" presences={presences} looking={looking} />
        <Deck deckType="arcani_maggiori" name="Arcani Maggiori" presences={presences} looking={looking} />
      </div>
      <UsersList presences={presences} looking={looking} setLooking={setLooking} />
    </div>
  )
}
export default props => <App {...props} />;
