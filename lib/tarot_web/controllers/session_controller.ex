defmodule TarotWeb.SessionController do
  use TarotWeb, :controller

  def login(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :play))
  end

end
