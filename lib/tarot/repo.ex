defmodule Tarot.Repo do
  use Ecto.Repo,
    otp_app: :tarot,
    adapter: Ecto.Adapters.Postgres
end
