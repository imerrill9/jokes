defmodule Jokes.ApiControllerTest do
  use Jokes.DataCase

  alias Jokes.ApiController

  describe "jokes" do
    alias Jokes.ApiController.Joke

    import Jokes.ApiControllerFixtures

    @invalid_attrs %{response: nil}

    test "list_jokes/0 returns all jokes" do
      joke = joke_fixture()
      assert ApiController.list_jokes() == [joke]
    end

    test "get_joke!/1 returns the joke with given id" do
      joke = joke_fixture()
      assert ApiController.get_joke!(joke.id) == joke
    end

    test "create_joke/1 with valid data creates a joke" do
      valid_attrs = %{response: "some response"}

      assert {:ok, %Joke{} = joke} = ApiController.create_joke(valid_attrs)
      assert joke.response == "some response"
    end

    test "create_joke/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ApiController.create_joke(@invalid_attrs)
    end

    test "update_joke/2 with valid data updates the joke" do
      joke = joke_fixture()
      update_attrs = %{response: "some updated response"}

      assert {:ok, %Joke{} = joke} = ApiController.update_joke(joke, update_attrs)
      assert joke.response == "some updated response"
    end

    test "update_joke/2 with invalid data returns error changeset" do
      joke = joke_fixture()
      assert {:error, %Ecto.Changeset{}} = ApiController.update_joke(joke, @invalid_attrs)
      assert joke == ApiController.get_joke!(joke.id)
    end

    test "delete_joke/1 deletes the joke" do
      joke = joke_fixture()
      assert {:ok, %Joke{}} = ApiController.delete_joke(joke)
      assert_raise Ecto.NoResultsError, fn -> ApiController.get_joke!(joke.id) end
    end

    test "change_joke/1 returns a joke changeset" do
      joke = joke_fixture()
      assert %Ecto.Changeset{} = ApiController.change_joke(joke)
    end
  end
end
