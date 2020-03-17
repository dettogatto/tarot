# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tarot,
  ecto_repos: [Tarot.Repo]

# Configures the endpoint
config :tarot, TarotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZAx/waoIn+HBYwP+TkAjCqZcPWpRvqA2t4IGYsdSZ8RguZLB3a2KQHYuO9GNap6h",
  render_errors: [view: TarotWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tarot.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "uctgq9fD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine
