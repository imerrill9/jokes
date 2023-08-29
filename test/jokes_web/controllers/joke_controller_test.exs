defmodule JokesWeb.JokeControllerTest do
  use JokesWeb.ConnCase

  import Jokes.ApiControllerFixtures

  @create_attrs %{response: "some response"}
  @update_attrs %{response: "some updated response"}
  @invalid_attrs %{response: nil}

  describe "index" do
    test "lists all jokes", %{conn: conn} do
      conn = get(conn, ~p"/jokes")
      assert html_response(conn, 200) =~ "Listing Jokes"
    end
  end

  describe "new joke" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/jokes/new")
      assert html_response(conn, 200) =~ "New Joke"
    end
  end

  describe "create joke" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/jokes", joke: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/jokes/#{id}"

      conn = get(conn, ~p"/jokes/#{id}")
      assert html_response(conn, 200) =~ "Joke #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/jokes", joke: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Joke"
    end
  end

  describe "edit joke" do
    setup [:create_joke]

    test "renders form for editing chosen joke", %{conn: conn, joke: joke} do
      conn = get(conn, ~p"/jokes/#{joke}/edit")
      assert html_response(conn, 200) =~ "Edit Joke"
    end
  end

  describe "update joke" do
    setup [:create_joke]

    test "redirects when data is valid", %{conn: conn, joke: joke} do
      conn = put(conn, ~p"/jokes/#{joke}", joke: @update_attrs)
      assert redirected_to(conn) == ~p"/jokes/#{joke}"

      conn = get(conn, ~p"/jokes/#{joke}")
      assert html_response(conn, 200) =~ "some updated response"
    end

    test "renders errors when data is invalid", %{conn: conn, joke: joke} do
      conn = put(conn, ~p"/jokes/#{joke}", joke: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Joke"
    end
  end

  describe "delete joke" do
    setup [:create_joke]

    test "deletes chosen joke", %{conn: conn, joke: joke} do
      conn = delete(conn, ~p"/jokes/#{joke}")
      assert redirected_to(conn) == ~p"/jokes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/jokes/#{joke}")
      end
    end
  end

  defp create_joke(_) do
    joke = joke_fixture()
    %{joke: joke}
  end
end
