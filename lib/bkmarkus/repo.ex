defmodule Bkmarkus.Repo do
  use Ecto.Repo,
    otp_app: :bkmarkus,
    adapter: Ecto.Adapters.Postgres
end
