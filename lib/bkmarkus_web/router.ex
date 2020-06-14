defmodule BkmarkusWeb.Router do
  use BkmarkusWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BkmarkusWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  
  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", BkmarkusWeb do
    pipe_through [:browser, :protected]

    resources "/bookmarks", BookmarkController, except: [:index]
  end

  scope "/", BkmarkusWeb do
    pipe_through :browser

    live "/", PageLive, :index
    resources "/bookmarks", BookmarkController, only: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", BkmarkusWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:browser, :protected]
      live_dashboard "/dashboard", metrics: BkmarkusWeb.Telemetry
    end
  end
end
