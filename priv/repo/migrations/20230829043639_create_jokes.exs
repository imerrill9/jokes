defmodule Jokes.Repo.Migrations.CreateJokes do
  use Ecto.Migration

  def change do
    create table(:jokes) do
      add :response, :string

      timestamps()
    end
  end
end
