defmodule Respawned.Repo do
  use Ecto.Repo,
    otp_app: :respawned,
    adapter: Ecto.Adapters.Postgres
end
