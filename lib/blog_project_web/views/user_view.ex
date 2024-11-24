defmodule BlogProjectWeb.UserView do
  use BlogProjectWeb, :view

  @doc """
  Renders a single user as JSON.
  """
  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  def render("ack.json", %{jwt: jwt, success: success, message: message}),
    do: %{jwt: jwt, success: success, message: message}
end
