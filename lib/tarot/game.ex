defmodule Tarot.Game do
  alias Tarot.Repo
  alias Tarot.Card
  alias Tarot.Auth.User
  import Ecto.Query, only: [from: 2]
  require Logger

  use GenServer

  @doc """
  Start game GenServer
  """
  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, get_cards_from_db(), name: __MODULE__)
  end

  @doc """
  GenServer.init/1 callback
  """
  def init(state), do: {:ok, state}

  def handle_call({:draw, deck, player}, _from, state) do
    cards = Enum.filter(state, fn(x) -> x.deck == deck && x.player == 0 end)
    if Enum.count(cards) > 0 do
      card = %{Enum.random(cards) | player: player, sorting: :os.system_time(:millisecond)}
      Logger.info("Carta pescata: #{inspect(card)}")
      state = Enum.map(state, fn(x) -> if x.id == card.id do card else x end end)
      Logger.info("FINE draw")
      {:reply, state, state}
    else
      Logger.info("Mazzo #{deck} terminato")
      {:reply, state, state}
    end
  end


  def handle_call(:reset, _from, state), do: {:reply, state, get_cards_from_db()}

  def handle_call({:empty_hand, player}, _from, state) do
    state = state
      |> Enum.map(fn(x) -> if x.player == player do %{x | player: 0, visible: 0} else x end end)
    {:reply, state, state}
  end


  def handle_call({:update_card, cs}, _from, state) do
    state = state
      |> Enum.map(fn(x) -> if x.id == cs.id do Map.merge(x, cs) else x end end)
    {:reply, state, state}
  end


  def handle_call({:player_hand, id}, _from, state) do
    reply = state
      |> Enum.filter(fn(x) -> x.player == id end)
      |> Enum.sort(fn(x, y) -> x.sorting < y.sorting end)
      |> Enum.map(fn(x) ->
          if x.visible > 0 do
            x.id
          else
            -x.id
          end
      end)
    {:reply, reply, state}
  end


  defp get_cards_from_db() do
    Repo.all(Card)
      |> Enum.map(fn(x) -> %{id: x.id, visible: 0, player: 0, deck: x.deck, sorting: 0} end)
  end

  def reset(), do: GenServer.call(__MODULE__, :reset)
  def reset_all_decks(), do: reset()
  def empty_hand(player), do: GenServer.call(__MODULE__, {:empty_hand, player})
  def draw_card(deck, player), do: GenServer.call(__MODULE__, {:draw, deck, player})
  def player_hand(user_id), do: GenServer.call(__MODULE__, {:player_hand, user_id})
  def undraw_card(card_id), do: GenServer.call(__MODULE__, {:update_card, %{id: card_id, player: 0, visible: 0}})
  def reveal_card(card_id), do: GenServer.call(__MODULE__, {:update_card, %{id: card_id, visible: 1}})
  def unreveal_card(card_id), do: GenServer.call(__MODULE__, {:update_card, %{id: card_id, visible: 0}})

end

# Tarot.Repo.all(Tarot.Card)
