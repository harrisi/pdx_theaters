defmodule PdxTheaters.Repo do
  use Ecto.Repo,
    otp_app: :pdx_theaters,
    adapter: Ecto.Adapters.Postgres
end
