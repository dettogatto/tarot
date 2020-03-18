import React, { useState, useEffect } from 'react';
import {Socket, Presence} from "phoenix"

function App(props) {

  const [astate, setAstate] = useState("");

  useEffect(() => {

  }, [astate])

  return (
    <div>
      <h1>REACT HOOKS!!!</h1>
    </div>
  )
}
export default props => <App {...props} />;
