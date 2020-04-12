import React from 'react';
function SmallCard(props) {

  function getImageUrl(){
    if(props.visible){
      return "url(/images/decks/"+window.allCards[props.id]["deck"]+"/"+window.allCards[props.id]["image"]+".png)"
    }
    return "url(/images/decks/retro.png)"
  }

  return (
    <div className="column single-small-card-container">
      <div className="card-image" style={{backgroundImage: getImageUrl()}}></div>
    </div>
  )
}
export default props => <SmallCard {...props} />;
