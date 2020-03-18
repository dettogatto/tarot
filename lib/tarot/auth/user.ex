defmodule Tarot.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  require Logger

  schema "users" do
    field :username, :string
    field :master, :boolean
    timestamps()
    has_many :cards, Tarot.Card
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :master])
    |> validate_required([:username])
    |> unique_constraint(:username)
  end
end
