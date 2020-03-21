import React, { useState, useEffect } from 'react';
function UsersList(props) {

  const [astate, setAstate] = useState("");

  useEffect(() => {

  }, [astate])

  function handleUserClick(id){
    props.setLooking(id)
  }

  function printUsersList(){
    return props.presences.map((presence) => {
      if(Number(presence.user_id) === Number(window.currentUserId)){
        return null
      }

      let cl = Number(props.looking) === Number(presence.user_id) ? "" : "button button-outline"
      let sp = presence.cards.length > 0 ? <span>{presence.cards.length}</span> : null
      return(
        <button className={cl} key={presence.user_id} onClick={() => handleUserClick(presence.user_id)}>
          {presence.username}
          {sp}
        </button>
      )
    });
  }

  return (
    <div className="container text-center users-list">
      <p>I TUOI COMPAGNI DI VIAGGIO</p>
      {printUsersList()}
    </div>
  )
}
export default props => <UsersList {...props} />;


// [
//   [
//     {
//       "cards":[],
//       "phx_ref":"VeZl4c+Gias=",
//       "user_id":5,
//       "username":"nick"
//     }
//   ],
//   [
//     {
//       "cards":
//       [
//         {
//           "deck":"arcani_minori",
//           "id":5,
//           "image":null,
//           "name":"carta 5",
//           "state":0
//         },
//         {
//           "deck":"arcani_minori",
//           "id":4,
//           "image":null,
//           "name":"carta 4",
//           "state":0
//         }
//       ],
//       "phx_ref":"NNCbVtOtces=",
//       "user_id":11,
//       "username":"assss"
//     }
//   ]
// ]
