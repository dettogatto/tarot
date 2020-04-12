import React, { useState, useEffect } from 'react';
import {Socket, Presence} from "phoenix"
import App from "./App"


function Loader(props) {

  const [presences, setPresences] = useState({})

  useEffect(() => {

    const socket = new Socket("/socket", {params: {token: window.userToken}})
    socket.connect()
    window.channel = socket.channel("game:lobby", {})

    window.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    window.channel.on("presence_state", state => {
      setPresences((prev) => (Presence.syncState(prev, state)))
    })

    window.channel.on("presence_diff", diff => {
      setPresences((prev) => (Presence.syncDiff(prev, diff)))
    })

    return(() => {
      window.channel.leave();
    })

  }, [])


  return (
    <App presences={presences} />
  )
}
export default props => <Loader {...props} />;
