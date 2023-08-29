defmodule JokesWeb.JokeController do
  use JokesWeb, :controller

  def index(conn, _params) do
    joke = make_api_call()
    render(conn, :index, joke: joke)
  end

  defp make_api_call() do
    url = "https://icanhazdadjoke.com/"
    headers = [{"Accept", "application/json"}]

    response = HTTPoison.get!(url, headers)
    json_response = Jason.decode!(response.body)

    joke = Map.get(json_response, "joke")
    joke
  end
end
