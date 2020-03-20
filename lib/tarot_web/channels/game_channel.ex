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

  def handle_in("draw_card", deck, socket) do
    user_id = socket.assigns[:current_user_id]
    Tarot.Game.draw_card(deck, user_id)
    Logger.debug("Player ##{user_id} drew one card from #{deck}")
    update_my_presence(socket)
    {:noreply, socket}
  end

  def handle_in("undraw_card", card_id, socket) do
    Tarot.Game.undraw_card(card_id)
    Logger.debug("Player ##{socket.assigns[:current_user_id]} undrew card #{card_id}")
    update_my_presence(socket)
    {:noreply, socket}
  end

  def handle_in("peek_card", card_id, socket) do
    Tarot.Game.peek_card(card_id)
    Logger.debug("Player ##{socket.assigns[:current_user_id]} peeked card #{card_id}")
    update_my_presence(socket)
    {:noreply, socket}
  end

  def handle_in("reveal_card", card_id, socket) do
    Tarot.Game.reveal_card(card_id)
    Logger.debug("Player ##{socket.assigns[:current_user_id]} revealed card #{card_id}")
    update_my_presence(socket)
    {:noreply, socket}
  end

  def handle_in("empty_hand", _, socket) do
    user_id = socket.assigns[:current_user_id]
    Tarot.Game.empty_hand(user_id)
    Logger.debug("Player ##{user_id} emptied hand")
    update_my_presence(socket)
    {:noreply, socket}
  end

  def update_my_presence(socket) do
    user = Repo.get(User, socket.assigns[:current_user_id]) |> Repo.preload(:cards)

    {:ok, _} = Presence.update(socket, "user:#{user.id}", %{
      user_id: user.id,
      username: user.username,
      cards: Tarot.Game.user_hand(user.id)
    })
  end


  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)

    user = Repo.get(User, socket.assigns[:current_user_id]) |> Repo.preload(:cards)

    {:ok, _} = Presence.track(socket, "user:#{user.id}", %{
      user_id: user.id,
      username: user.username,
      cards: Tarot.Game.user_hand(user.id)
    })

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(socket) do
    !!socket.assigns[:current_user_id]
  end
end
