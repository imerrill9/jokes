defmodule JokesWeb.JokeController do
  use JokesWeb, :controller

  alias Jokes.ApiController
  alias Jokes.ApiController.Joke

  def index(conn, _params) do
    jokes = ApiController.list_jokes()
    render(conn, :index, jokes: jokes)
  end

  def new(conn, _params) do
    changeset = ApiController.change_joke(%Joke{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"joke" => joke_params}) do
    case ApiController.create_joke(joke_params) do
      {:ok, joke} ->
        conn
        |> put_flash(:info, "Joke created successfully.")
        |> redirect(to: ~p"/jokes/#{joke}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    joke = ApiController.get_joke!(id)
    render(conn, :show, joke: joke)
  end

  def edit(conn, %{"id" => id}) do
    joke = ApiController.get_joke!(id)
    changeset = ApiController.change_joke(joke)
    render(conn, :edit, joke: joke, changeset: changeset)
  end

  def update(conn, %{"id" => id, "joke" => joke_params}) do
    joke = ApiController.get_joke!(id)

    case ApiController.update_joke(joke, joke_params) do
      {:ok, joke} ->
        conn
        |> put_flash(:info, "Joke updated successfully.")
        |> redirect(to: ~p"/jokes/#{joke}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, joke: joke, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    joke = ApiController.get_joke!(id)
    {:ok, _joke} = ApiController.delete_joke(joke)

    conn
    |> put_flash(:info, "Joke deleted successfully.")
    |> redirect(to: ~p"/jokes")
  end
end
