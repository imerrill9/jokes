defmodule Jokes.ApiControllerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jokes.ApiController` context.
  """

  @doc """
  Generate a joke.
  """
  def joke_fixture(attrs \\ %{}) do
    {:ok, joke} =
      attrs
      |> Enum.into(%{
        response: "some response"
      })
      |> Jokes.ApiController.create_joke()

    joke
  end
end
