defmodule BlogProjectWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BlogProjectWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_resp_content_type("application/json")
    |> put_status(:unprocessable_entity)
    |> put_view(BlogProjectWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, nil) do
    conn
    |> put_resp_content_type("application/json")
    |> put_status(:not_found)
    |> put_view(BlogProjectWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, true) do
    conn
    |> put_resp_content_type("application/json")
    |> put_status(:bad_request)
    |> put_view(BlogProjectWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, :error) do
    conn
    |> put_resp_content_type("application/json")
    |> put_status(:not_found)
    |> put_view(BlogProjectWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_resp_content_type("application/json")
    |> put_status(:not_found)
    |> put_view(BlogProjectWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(
      401,
      %{error: "unauthorized"}
      |> Jason.encode!()
    )
  end
end
