defmodule TarotWeb.PageController do
  use TarotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def play(conn, params) do
    render(conn, "play.html")
  end

end
