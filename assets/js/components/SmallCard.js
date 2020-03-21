import React from 'react';
function SmallCard(props) {

  function getImageUrl(){
    if((props.state > 0 && props.commands) || props.state > 1){
      return "url(/images/decks/"+props.deck+"/"+props.image+".jpg)"
    }
    return "url(/images/decks/retro.jpg)"
  }

  return (
    <div className="column single-small-card-container">
      <div className="card-image" style={{backgroundImage: getImageUrl()}}></div>
    </div>
  )
}
export default props => <SmallCard {...props} />;
