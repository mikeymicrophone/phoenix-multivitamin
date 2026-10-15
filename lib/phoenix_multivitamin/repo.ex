defmodule PhoenixMultivitamin.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_multivitamin,
    adapter: Ecto.Adapters.SQLite3
end
