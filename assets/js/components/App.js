import React, { useState, useEffect } from 'react';
import {Socket, Presence} from "phoenix"

function App(props) {

  const [astate, setAstate] = useState("");

  useEffect(() => {

  }, [astate])


  function prova(){
    window.channel.push("prova", "unabelllaprova")
    alert("ciao");
  }

  return (
    <div>
      <code style={{width: "600px", whitespace: "wrap"}}>
        {JSON.stringify(props.presences)}
      </code>
      <br />
      <br />
      <button onClick={prova}>PESCA</button>
    </div>
  )
}
export default props => <App {...props} />;
