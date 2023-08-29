# lib/your_project_web/live/joke_live.ex

defmodule JokesWeb.JokeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, fetch_new_joke(socket)}
  end

  def handle_event("fetch_joke", _, socket) do
    {:noreply, fetch_new_joke(socket)}
  end

  defp fetch_new_joke(socket) do
    {:ok, joke} = make_api_call()
    assign(socket, joke: joke)
  end

  defp make_api_call() do
    url = "https://icanhazdadjoke.com/"
    headers = [{"Accept", "application/json"}]

    response = HTTPoison.get!(url, headers)
    json_response = Jason.decode!(response.body)

    joke = Map.get(json_response, "joke")
    {:ok, joke}
  end
end
