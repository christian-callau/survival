defmodule Survival.Repo do
  use Ecto.Repo,
    otp_app: :survival,
    adapter: Ecto.Adapters.Postgres
end
