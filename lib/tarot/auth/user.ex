defmodule Tarot.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :master, :boolean
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :master])
    |> validate_required([:username])
    |> unique_constraint(:username)
  end
end
