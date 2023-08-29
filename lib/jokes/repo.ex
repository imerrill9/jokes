defmodule Jokes.Repo do
  use Ecto.Repo,
    otp_app: :jokes,
    adapter: Ecto.Adapters.Postgres
end
