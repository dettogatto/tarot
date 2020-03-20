import React, { useState, useEffect } from 'react';
function Card(props) {

  const [astate, setAstate] = useState("");

  useEffect(() => {

  }, [astate])

  function getImageUrl(){
    if((props.state > 0 && props.commands) || props.state > 1){
      return "url(/images/decks/"+props.deck+"/"+props.image+".png)"
    }
    return "url(/images/decks/retro.png)"
  }

  function handleUndraw(){
    window.channel.push("undraw_card", props.id)
  }

  function handlePeek(){
    window.channel.push("peek_card", props.id)
  }

  function handleReveal(){
    window.channel.push("reveal_card", props.id)
  }

  function getLookButton(){
    if(!props.commands){
      return null;
    }
    if(props.state === 1){
      return(<button className="float-right" onClick={handleReveal} className="float-right">Rivela</button>)
    } else if(props.state === 0){
      return(<button className="float-right" onClick={handlePeek} className="float-right">Sbircia</button>)
    }
    return null
  }

  return (
    <div className="column single-card-container">
      <div className="card-image" style={{backgroundImage: getImageUrl()}}></div>
      <div className="card-controls">
        {props.commands && <button className="float-left" onClick={handleUndraw}>X</button>}
        {getLookButton()}
      </div>
    </div>
  )
}
export default props => <Card {...props} />;
