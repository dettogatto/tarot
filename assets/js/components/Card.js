import React, { useState, useEffect } from 'react';
function Card(props) {

  const [revealed, setRevealed] = useState(props.state > 1)
  const url = "url(/images/decks/"+window.allCards[props.id]["deck"]+"/"+window.allCards[props.id]["image"]+".png)"
  const retroUrl = "url(/images/decks/retro.png)"

  function handleUndraw(){
    window.channel.push("undraw_card", props.id)
  }

  function handleMouseEnter(){
    if(!isTouch() && !revealed){
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
      <div className={revealed ? "card-image revealed" : "card-image"} onClick={handleClick} onMouseEnter={handleMouseEnter} onMouseLeave={handleMouseLeave} style={{backgroundImage: url}}>
        <div className="card-retro" style={{backgroundImage: retroUrl}}></div>
      </div>
      <div className="card-controls">
        <button onClick={handleUndraw}>X</button>
      </div>
    </div>
  )
}
export default props => <Card {...props} />;
