defmodule SideSwipeWeb.Router do
  use SideSwipeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SideSwipeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SideSwipeWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/transformations", TransformationLive.Index, :index
    live "/transformations/new", TransformationLive.Index, :new
    live "/transformations/:id/edit", TransformationLive.Index, :edit

    live "/transformations/:id", TransformationLive.Show, :show
    live "/transformations/:id/show/edit", TransformationLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", SideSwipeWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:side_swipe, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SideSwipeWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
