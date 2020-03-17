defmodule TarotWeb.Router do
  use TarotWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TarotWeb do
    pipe_through :browser

    get "/", PageController, :login
    get "/login", PageController, :login
    get "/play", PageController, :play

    get "/process_login", SessionController, :login
    post "/process_login", SessionController, :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", TarotWeb do
  #   pipe_through :api
  # end
end
