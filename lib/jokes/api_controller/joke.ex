defmodule Jokes.ApiController.Joke do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jokes" do
    field :response, :string

    timestamps()
  end

  @doc false
  def changeset(joke, attrs) do
    joke
    |> cast(attrs, [:response])
    |> validate_required([:response])
  end
end
