defmodule BlogProjectWeb.Router do
  use BlogProjectWeb, :router
  alias BlogProjectWeb.Utils.CORS

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BlogProjectWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end
  
  pipeline :cors do
    plug(CORSPlug,
      origin: &CORS.origins/0,
      max_age: 86_400,
      methods: ["GET", "POST", "PUT"],
      send_preflight_response?: false
    )
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", BlogProjectWeb do
  #   pipe_through :browser

  #   get "/", PageController, :home
  # end

  scope "/api", BlogProjectWeb do
    pipe_through([:api,:cors])
    resources "/users", UserController, only: [:create]
    
    resources "/posts", PostController, only: [:index, :create, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogProjectWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:blog_project, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BlogProjectWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end