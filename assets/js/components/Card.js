import React, { useState, useEffect } from 'react';
function Card(props) {

  const [revealed, setRevealed] = useState(props.state > 1);

  function getImageUrl(){
    if((props.state > 0 && props.commands) || props.state > 1){
      return "url(/images/decks/"+props.deck+"/"+props.image+".jpg)"
    }
    return "url(/images/decks/retro.jpg)"
  }

  function handleUndraw(){
    window.channel.push("undraw_card", props.id)
  }

  function handleMouseEnter(){
    if(!isTouch()){
      window.channel.push("reveal_card", props.id)
    }
  }

  function handleMouseLeave(){
    if(!isTouch() && !revealed){
      window.channel.push("unreveal_card", props.id)
    }
  }

  function handleClick(){
    setRevealed((prev) => {
      if(isTouch()){
        if(prev){
          window.channel.push("unreveal_card", props.id)
        } else {
          window.channel.push("reveal_card", props.id)
        }
      }
      return !prev
    });
  }

  function isTouch(){
    return !!matchMedia('(pointer:coarse)').matches
  }

  return (
    <div className="column single-card-container">
      <div className="card-image" onClick={handleClick} onMouseEnter={handleMouseEnter} onMouseLeave={handleMouseLeave} style={{backgroundImage: getImageUrl()}}></div>
      <div className="card-controls">
        {props.commands && <button onClick={handleUndraw}>X</button>}
      </div>
    </div>
  )
}
export default props => <Card {...props} />;
