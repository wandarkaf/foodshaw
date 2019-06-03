defmodule Foodies.Repo do
  use Ecto.Repo,
    otp_app: :foodies,
    adapter: Ecto.Adapters.Postgres
end
