defmodule BlogProjectWeb.Plug.DisallowOptions do
  @moduledoc """
  This plug disallows the OPTIONS method http request.
  """
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.method == "OPTIONS" do
      conn
      # Adjust as needed
      |> put_resp_header("Access-Control-Allow-Origin", "*")
      # Allowed methods
      |> put_resp_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
      # Allowed headers
      |> put_resp_header("Access-Control-Allow-Headers", "Content-Type, Authorization")
      # Send 200 OK response for OPTIONS
      |> send_resp(:ok, "")
      |> halt()
    else
      conn
    end
  end
end
