defmodule TarotWeb.PageView do
  use TarotWeb, :view
  alias Tarot.Repo
  alias Tarot.Card

  def cards_to_preload() do
    Repo.all(Card)
      |> Enum.map(fn(x) -> "#{x.deck}/#{x.image}" end)
      |> List.insert_at(0, "retro")
      |> Enum.map(fn(x) -> "#{x}.png" end)
      |> Jason.encode!
  end
end
