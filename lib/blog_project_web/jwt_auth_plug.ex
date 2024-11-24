defmodule BlogProjectWeb.JWTAuthPlug do
  import Plug.Conn
  alias BlogProject.Users

  alias BlogProject.Users.User
  alias BlogProject.AuthTokens

  def init(opts), do: opts

  def call(conn, _) do
    bearer = get_req_header(conn, "authorization") |> List.first()

    if bearer == nil do
      conn |> put_status(401) |> halt
    else
      token = bearer |> String.split(" ") |> List.last()

      signer =
        Joken.Signer.create(
          "HS256",
          "zrhYVRfAP4uNwYVPxrngiqhrlJhB/Wd2REcf9W870RL2O+Mq/bfVVZl0rJWT2WFz"
        )

      with {:ok, %{"user_id" => user_id}} <-
             BlogProjectWeb.JWTToken.verify_and_validate(token, signer),
           %User{} = user <- Users.get_user_by_id(user_id) do
        if AuthTokens.get_auth_token_by_token(token) != nil do
          conn |> put_status(401) |> halt
        else
          conn |> assign(:current_user, user)
        end
      else
        {:error, _reason} -> conn |> put_status(401) |> halt
        _ -> conn |> put_status(401) |> halt
      end
    end
  end
end
