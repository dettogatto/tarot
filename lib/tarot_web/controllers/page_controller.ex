defmodule TarotWeb.PageController do
  use TarotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, _params) do
    if conn.assigns.user_signed_in? do
      redirect(conn, to: "/play")
    else
      render(conn, "login.html")
    end
  end

  def play(conn, params) do
    if !conn.assigns.user_signed_in? do
      redirect(conn, to: "/")
    else
      render(conn, "play.html")
    end
  end

  def reset(conn, params) do
    Tarot.Game.reset_all_decks()
    redirect(conn, to: "/play")
  end

end
