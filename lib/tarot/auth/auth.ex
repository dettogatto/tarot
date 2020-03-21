defmodule Tarot.Auth do
  alias Tarot.Repo
  alias Tarot.Auth.User

  def sign_in(username, master) do
    changes = %{username: username, master: master}
    result =
      case Repo.get_by(User, username: username) do
        nil -> %User{}
        user -> user
      end
      |> User.changeset(changes)
      |> Repo.insert_or_update

    result
  end

  def sign_out() do
    true
  end

  def current_user(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: Repo.get(User, user_id)
  end

  def user_signed_in?(conn) do
    !!current_user(conn)
  end

  end
