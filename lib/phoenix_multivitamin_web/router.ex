defmodule PhoenixMultivitaminWeb.Router do
  use PhoenixMultivitaminWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhoenixMultivitaminWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Bottled LiveViews are drawn first so their static paths win over the
  # planned catch-all. They use full module names so the web-namespace alias
  # does not wrap them. Put `live_module` on the slot in that feature's
  # `feature.exs`; Catalog.draw_live_routes/0 picks it up.
  scope "/" do
    pipe_through :browser

    require PhoenixMultivitamin.Catalog
    PhoenixMultivitamin.Catalog.draw_live_routes()
  end

  scope "/", PhoenixMultivitaminWeb do
    pipe_through :browser

    live "/", CatalogLive
    live "/features/:feature/:example", PlannedLive
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phoenix_multivitamin, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhoenixMultivitaminWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
