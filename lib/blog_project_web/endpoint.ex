defmodule BlogProjectWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :blog_project
  alias BlogProjectWeb.Utils.CORS

  plug BlogProjectWeb.Plug.DisallowOptions

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_blog_project_key",
    signing_salt: "GOJICwRD",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :blog_project,
    gzip: false,
    only: BlogProjectWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :blog_project
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug CORSPlug,
    origin: &CORS.origins/0,
    max_age: 86_400,
    methods: ["GET", "POST", "PUT"],
    send_preflight_response?: false

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug BlogProjectWeb.Router
end
