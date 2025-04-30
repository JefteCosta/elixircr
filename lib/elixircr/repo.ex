defmodule Elixircr.Repo do
  use Ecto.Repo,
    otp_app: :elixircr,
    adapter: Ecto.Adapters.Postgres
end
