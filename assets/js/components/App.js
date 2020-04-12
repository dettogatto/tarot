import React, { useState, useEffect } from 'react';
import UsersList from './UsersList';
import Deck from './Deck';
import {Socket, Presence} from "phoenix"

function App(props) {

  const [astate, setAstate] = useState("");
  const [presences, setPresences] = useState([]);
  const [looking, setLooking] = useState(0);
  const [preload, setPreload] = useState("/images/decks/retro.png");

  useEffect(() => {
    setPresences(
      Object.keys(props.presences).map((x) => {
        let metas = props.presences[x].metas[0]
        return metas
      })
    );
  }, [props.presences])

  useEffect(() => {
    window.cardsToPreload = Object.values(window.allCards).map((x) => ("/images/decks/" + x["deck"] + "/" + x["image"] + ".png"))
    setTimeout(preloadCards, 50)
  }, [])

  function preloadCards(){
    let img = window.cardsToPreload.pop()
    setPreload(img)
    if(window.cardsToPreload.length > 0){
      setTimeout(preloadCards, 50)
    }
  }

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
      <div className="image-preloader" style={{backgroundImage: "url("+preload+")"}}></div>
      <div className="user-info">
        <h3 className="text-center">{window.currentUserName}</h3>
        <div className="logout-btn-container">
          <a href="/process_logout" className="button button-clear">Logout</a>
        </div>
      </div>
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
