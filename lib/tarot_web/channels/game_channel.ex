defmodule TarotWeb.GameChannel do
  use TarotWeb, :channel
  alias Tarot.Repo
  alias TarotWeb.Presence
  alias Tarot.Auth
  alias Tarot.Auth.User
  require Logger

  def join("game:lobby", payload, socket) do
    if authorized?(socket) do
      send(self(), :after_join)
      {:ok, %{channel: "game:lobby"}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    Logger.debug("AIUTO")
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (game:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end


  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)

    user = Repo.get(User, socket.assigns[:current_user_id])

    {:ok, _} = Presence.track(socket, "user:#{user.id}", %{
      user_id: user.id,
      username: user.username
    })

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(socket) do
    !!socket.assigns[:current_user_id]
  end
end
