defmodule BlogProjectWeb.UserController do
  use BlogProjectWeb, :controller

  alias BlogProject.Users
  alias BlogProject.Users.User
  action_fallback(BlogProjectWeb.FallbackController)

  @doc """
  Creates a new user.
  """
  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}
    end
  end
end
