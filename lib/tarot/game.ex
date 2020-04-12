defmodule Tarot.Game do
  alias Tarot.Repo
  alias Tarot.Card
  alias Tarot.Auth.User
  import Ecto.Query, only: [from: 2]
  require Logger

  def draw_card(deck, user_id) do
    query = from c in Card,
      where: is_nil(c.user_id) and c.deck == ^deck,
      order_by: fragment("RANDOM()"),
      limit: 1
    card = Repo.one(query)
    if card do
      result = card
        |> Card.changeset(%{user_id: user_id, state: 0})
        |> Repo.update!
      {:ok, result}
    else
      {:error, :empty_deck}
    end
  end

  def reset_deck(deck) do
    query = from c in Card,
      where: c.deck == ^deck
    Repo.update_all(query, set: [user_id: nil, state: 0])
  end

  def reset_all_decks() do
    Repo.update_all(Card, set: [user_id: nil, state: 0])
  end

  def empty_hand(user_id) do
    query = from c in Card,
      where: c.user_id == ^user_id
    Repo.update_all(query, set: [user_id: nil, state: 0])
    {:ok, nil}
  end

  def undraw_card(card_id) do
    update_card(card_id, %{user_id: nil, state: 0})
  end

  def peek_card(card_id) do
    update_card(card_id, %{state: 1})
  end

  def reveal_card(card_id) do
    update_card(card_id, %{state: 2})
  end

  def unreveal_card(card_id) do
    update_card(card_id, %{state: 0})
  end

  def get_card_state(card_id) do
    Repo.get(Card, card_id).state
  end

  def user_hand(user_id) do
    query = from c in Card,
      where: c.user_id == ^user_id
    res = Repo.all(query)
    # Enum.map(res, fn(x) -> Map.take(Map.from_struct(x), [:id, :deck, :name, :state, :image]) end)
    Enum.map(res, fn(x) ->
        if x.state > 0 do
          x.id
        else
          -x.id
        end
    end)
  end

  defp update_card(card_id, changes) do
    card = Repo.get(Card, card_id)
    if card do
      result = card
        |> Card.changeset(changes)
        |> Repo.update!
      {:ok, result}
    else
      {:error, :no_such_card}
    end
  end

end

# Tarot.Repo.all(Tarot.Card)
