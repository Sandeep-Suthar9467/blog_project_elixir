defmodule BlogProjectWeb.UserController do
  use BlogProjectWeb, :controller
  import Ecto.Query, warn: false
  import Plug.Conn
  alias BlogProject.Users
  # alias BlogProjectWeb.Utils
  alias BlogProject.Users.User
  alias BlogProjectWeb.JWTToken
  alias BlogProject.AuthTokens.AuthToken
  alias BlogProject.Repo
  action_fallback(BlogProjectWeb.FallbackController)

  @spec ping(Plug.Conn.t(), any) :: Plug.Conn.t()
  def ping(conn, _params) do
    conn
    |> render("ack.json", %{jwt: "", success: true, message: "Pong"})
  end

  def register(conn, params) do
    case Users.create_user(params) do
      {:ok, user} ->
        signer =
          Joken.Signer.create(
            "HS256",
            "zrhYVRfAP4uNwYVPxrngiqhrlJhB/Wd2REcf9W870RL2O+Mq/bfVVZl0rJWT2WFz"
          )

        extra_claims = %{user_id: user.id}
        {:ok, token, _claims} = JWTToken.generate_and_sign(extra_claims, signer)

        conn
        |> render("ack.json", %{jwt: token, success: true, message: "Registration Successful"})

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}

      _ ->
        {:error, :unauthorized}
    end
  end

  def login(conn, %{"name" => name, "password_hash" => password_hash}) do
    with %User{} = user <- Users.get_user_by_username(name),
         true <- Pbkdf2.verify_pass(password_hash, user.password_hash) do
      signer =
        Joken.Signer.create(
          "HS256",
          "zrhYVRfAP4uNwYVPxrngiqhrlJhB/Wd2REcf9W870RL2O+Mq/bfVVZl0rJWT2WFz"
        )

      extra_claims = %{user_id: user.id, name: user.name}
      {:ok, token, _claims} = JWTToken.generate_and_sign(extra_claims, signer)

      conn
      |> render("ack.json", %{
        jwt: token,
        success: true,
        message: "Login Successful",
        token: token
      })
    else
      _ ->
        {:error, :unauthorized}
    end
  end

  def get(conn, _params) do
    conn |> render("data.json", %{data: conn.assigns.current_user})
  end

  def delete(conn, _params) do
    case Ecto.build_assoc(conn.assigns.current_user, :auth_tokens, %{token: get_token(conn)})
         |> Repo.insert!() do
      %AuthToken{} -> conn |> render("ack.json", %{success: true, message: "Logged Out"})
      _ -> {:error, "reason"}
    end
  end

  defp get_token(conn) do
    bearer = get_req_header(conn, "authorization") |> List.first()

    if bearer == nil do
      ""
    else
      bearer |> String.split(" ") |> List.last()
    end
  end
end
