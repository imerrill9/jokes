defmodule JokesWeb.JokeHTML do
  use JokesWeb, :html

  embed_templates "joke_html/*"

  @doc """
  Renders a joke form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def joke_form(assigns)
end
