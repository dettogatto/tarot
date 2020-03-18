import React, { useState, useEffect } from 'react';
import {Socket, Presence} from "phoenix"

var thePresences = {}

function Loader(props) {

  const [presences, setPresences] = useState({})

  useEffect(() => {

    let socket = new Socket("/socket", {params: {token: window.userToken}})
    socket.connect()

    // Now that you are connected, you can join channels with a topic:
    let channel = socket.channel("game:lobby", {})
    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    channel.on("presence_state", state => {
      setPresences((prev) => (Presence.syncState(prev, state)))
    })

    channel.on("presence_diff", diff => {
      setPresences((prev) => (Presence.syncDiff(prev, diff)))
    })

  }, [])


  return (
    <div>
      {JSON.stringify(presences)}
    </div>
  )
}
export default props => <Loader {...props} />;
