defmodule TarotWeb.SessionController do
  use TarotWeb, :controller
  alias Tarot.Auth

  def login(conn, %{"username" => username, "master" => master}) do
    case Auth.sign_in(username, master) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "You have successfully signed in!")
        |> redirect(to: "/play")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Something went wrong :(")
        |> redirect(to: "/login")
    end
  end

  def logout(conn, _params) do
    #Auth.sign_out()
    conn
      |> delete_session(:current_user_id)
      |> put_flash(:info, "You have successfully signed out!")
      |> redirect(to: "/")
  end

end
