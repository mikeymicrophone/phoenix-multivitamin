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

  pipeline :admiralty_inlet_tide do
    plug PhoenixMultivitaminWeb.AdmiraltyInletTidePlug
  end

  pipeline :port_townsend_hoist do
    plug PhoenixMultivitaminWeb.PortTownsendHoistPlug
  end

  pipeline :friday_harbor_arrivals do
    plug PhoenixMultivitaminWeb.FridayHarborInspectorPlug, lane: :arrivals
  end

  pipeline :friday_harbor_departures do
    plug PhoenixMultivitaminWeb.FridayHarborInspectorPlug, lane: :departures
  end

  pipeline :kalama_elevator do
    plug PhoenixMultivitaminWeb.KalamaElevatorPlug
  end

  pipeline :la_push_skiff do
    plug PhoenixMultivitaminWeb.LaPushSkiffPlug
  end

  pipeline :rosario_strait do
    plug PhoenixMultivitaminWeb.RosarioStraitPlug
  end

  pipeline :rosario_watch do
    plug PhoenixMultivitaminWeb.RosarioWatchPlug
  end

  pipeline :cape_flattery do
    plug PhoenixMultivitaminWeb.CapeFlatteryCapePlug
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

  # Feature 01 — Routing and plugs. Path slugs live here; domain copy and
  # plug options live in each scenario folder.
  scope "/features/01-routing-and-plugs" do
    pipe_through :browser

    scope "/01-admiralty-inlet-tide-gate" do
      pipe_through :admiralty_inlet_tide
      get "/inlet", PhoenixMultivitaminWeb.AdmiraltyInletTideGateController, :show
    end

    scope "/02-port-townsend-hoist-dispatch" do
      pipe_through :port_townsend_hoist
      get "/yard", PhoenixMultivitaminWeb.PortTownsendHoistDispatchController, :dispatch
    end

    scope "/03-friday-harbor-customs-shed" do
      scope "/arrivals" do
        pipe_through :friday_harbor_arrivals

        resources "/declarations", PhoenixMultivitaminWeb.FridayHarborDeclarationsController,
          only: [:index, :show]
      end

      scope "/departures" do
        pipe_through :friday_harbor_departures

        resources "/declarations", PhoenixMultivitaminWeb.FridayHarborDeclarationsController,
          only: [:index, :show]
      end
    end

    get "/05-willapa-seed-barge-office/office",
        PhoenixMultivitaminWeb.WillapaSeedBargeController,
        :show

    scope "/06-kalama-elevator-tape" do
      pipe_through :kalama_elevator
      get "/tape", PhoenixMultivitaminWeb.KalamaElevatorTapeController, :show
      live "/silo", PhoenixMultivitaminWeb.KalamaElevatorTapeLive
    end

    get "/07-colman-dock-shed/shed", PhoenixMultivitaminWeb.ColmanDockShedController, :show

    get "/08-anacortes-retort-floor/floor/cooks",
        PhoenixMultivitaminWeb.AnacortesRetortFloorController,
        :index

    get "/08-anacortes-retort-floor/floor/cooks/:cook_id",
        PhoenixMultivitaminWeb.AnacortesRetortFloorController,
        :show

    scope "/09-la-push-skiff-line" do
      pipe_through :la_push_skiff
      get "/line", PhoenixMultivitaminWeb.LaPushSkiffLineController, :show
    end

    get "/10-ballard-lock-house/locks", PhoenixMultivitaminWeb.BallardLockHouseController, :show

    get "/11-quillayute-chart-desk/roster",
        PhoenixMultivitaminWeb.QuillayuteChartDeskController,
        :roster

    get "/11-quillayute-chart-desk/desk",
        PhoenixMultivitaminWeb.QuillayuteChartDeskController,
        :desk

    get "/11-quillayute-chart-desk/leaky-desk",
        PhoenixMultivitaminWeb.QuillayuteChartDeskController,
        :leaky_desk

    scope "/12-rosario-watch-floor" do
      pipe_through :rosario_strait

      scope "/station/:station" do
        pipe_through :rosario_watch

        scope "/watch/:watch" do
          get "/floor", PhoenixMultivitaminWeb.RosarioWatchFloorController, :show
        end
      end
    end

    scope "/12-rosario-watch-floor/relief" do
      pipe_through :rosario_watch
      get "/floor", PhoenixMultivitaminWeb.RosarioWatchFloorController, :relief
    end

    scope "/13-cape-flattery-pipeline" do
      pipe_through :cape_flattery
      get "/cape", PhoenixMultivitaminWeb.CapeFlatteryPipelineController, :cape
      forward "/lookout", PhoenixMultivitaminWeb.CapeFlatteryLookoutRouter
    end

    forward "/04-neah-bay-entrance-log/entrance", PhoenixMultivitaminWeb.NeahBayEntranceLogRouter
  end

  scope "/features/01-routing-and-plugs/08-anacortes-retort-floor/api" do
    pipe_through :api

    get "/cooks", PhoenixMultivitaminWeb.AnacortesRetortFloorController, :index
    get "/cooks/:cook_id", PhoenixMultivitaminWeb.AnacortesRetortFloorController, :show
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
