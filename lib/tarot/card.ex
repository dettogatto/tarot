defmodule Tarot.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :deck, :string
    field :image, :string
    field :name, :string
    field :state, :integer
    field :suit, :string
    field :value, :integer
    timestamps()
    belongs_to :user, EctoAssoc.User
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:deck, :name, :value, :suit, :image, :state, :user_id])
    |> validate_required([:deck, :name])
  end
end
