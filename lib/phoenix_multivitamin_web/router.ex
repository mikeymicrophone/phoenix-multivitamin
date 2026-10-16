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

  pipeline :html_or_json do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhoenixMultivitaminWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :lukla_shear do
    plug PhoenixMultivitaminWeb.LuklaShearPlug
  end

  pipeline :tromso_sar_hoist do
    plug PhoenixMultivitaminWeb.TromsoSarHoistPlug
  end

  pipeline :incheon_arrivals do
    plug PhoenixMultivitaminWeb.IncheonInspectorPlug, lane: :arrivals
  end

  pipeline :incheon_departures do
    plug PhoenixMultivitaminWeb.IncheonInspectorPlug, lane: :departures
  end

  pipeline :changi_hydrant do
    plug PhoenixMultivitaminWeb.ChangiHydrantPlug
  end

  pipeline :oostwold_balloon do
    plug PhoenixMultivitaminWeb.OostwoldBalloonPlug
  end

  pipeline :santa_maria_oceanic do
    plug PhoenixMultivitaminWeb.SantaMariaOceanicPlug
  end

  pipeline :santa_maria_watch do
    plug PhoenixMultivitaminWeb.SantaMariaWatchPlug
  end

  pipeline :ushuaia_austral do
    plug PhoenixMultivitaminWeb.UshuaiaAustralPlug
  end

  # Bottled LiveViews are drawn first so their static paths win over the
  # planned catch-all. They use full module names so the web-namespace alias
  # does not wrap them. Put `live_module` on the slot in that feature's
  # `feature.exs`; Catalog.draw_live_routes/0 picks it up.
  scope "/" do
    pipe_through :browser

    require PhoenixMultivitamin.Catalog
    PhoenixMultivitamin.Catalog.draw_live_routes()

    # Extra URL shapes for verified-routes examples (interpolated segments,
    # controller redirects, forwarded kiosks, sibling LiveView paths). Domain
    # copy stays in each scenario folder; these entries only name the paths
    # ~p has to check.
    live "/features/02-verified-routes/01-la-ferte-alais-signal-flags/night",
         PhoenixMultivitaminWeb.LaFerteAlaisSignalFlagsLive,
         :night

    live "/features/02-verified-routes/03-ilulissat-ice-logger/watches/:watch",
         PhoenixMultivitaminWeb.IlulissatIceLoggerLive

    get "/features/02-verified-routes/05-funchal-wind-card/drift",
        PhoenixMultivitaminWeb.FunchalWindCardController,
        :drift

    live "/features/02-verified-routes/06-courchevel-altimeter-desk/altimeter-cabinet",
         PhoenixMultivitaminWeb.CourchevelAltimeterDeskLive,
         :cabinet

    get "/features/02-verified-routes/08-mataveri-metar-drum/island-host",
        PhoenixMultivitaminWeb.MataveriMetarDrumController,
        :island_host

    forward "/features/02-verified-routes/10-addis-ramp-tickets/kiosk",
            PhoenixMultivitaminWeb.AddisRampKiosk

    live "/features/02-verified-routes/11-nairobi-wilson-fare-banner/lanes/:lane",
         PhoenixMultivitaminWeb.NairobiWilsonFareBannerLive,
         :lane

    get "/features/02-verified-routes/13-luqa-qra-guard-house/gate",
        PhoenixMultivitaminWeb.LuqaQraGuardHouseController,
        :gate

    live "/features/02-verified-routes/13-luqa-qra-guard-house/relief",
         PhoenixMultivitaminWeb.LuqaQraGuardHouseLive,
         :relief

    live "/features/02-verified-routes/13-luqa-qra-guard-house/passes/:pass",
         PhoenixMultivitaminWeb.LuqaQraGuardHouseLive,
         :pass

    live "/features/05-core-components-and-layouts/01-duxford-hangar-board/hangar",
         PhoenixMultivitaminWeb.DuxfordHangarBoardLive,
         :app

    live "/features/05-core-components-and-layouts/11-schiphol-print-ticket/print",
         PhoenixMultivitaminWeb.SchipholPrintTicketLive,
         :print

    live "/features/07-liveview-navigation/02-rovaniemi-aurora-desk/cabin",
         PhoenixMultivitaminWeb.RovaniemiAuroraCabinLive

    live "/features/07-liveview-navigation/04-iqaluit-medevac-navigate/hold",
         PhoenixMultivitaminWeb.IqaluitMedevacHoldLive

    live "/features/07-liveview-navigation/08-banjul-hold-navigate/stack",
         PhoenixMultivitaminWeb.BanjulHoldStackLive

    live "/features/07-liveview-navigation/10-narsarsuaq-parent-patch/pads/:pad",
         PhoenixMultivitaminWeb.NarsarsuaqParentPatchLive,
         :pad

    live "/features/07-liveview-navigation/13-rio-grande-fuegian-watch/relief",
         PhoenixMultivitaminWeb.RioGrandeReliefBoardLive

    get "/features/09-forms-and-changesets/08-dili-controller-slip/slips/new",
        PhoenixMultivitaminWeb.DiliControllerSlipController,
        :new

    post "/features/09-forms-and-changesets/08-dili-controller-slip/slips",
         PhoenixMultivitaminWeb.DiliControllerSlipController,
         :create

    get "/features/09-forms-and-changesets/08-dili-controller-slip/slips/:destination",
        PhoenixMultivitaminWeb.DiliControllerSlipController,
        :show
  end

  # The external uploader uses a short-lived signed capability instead of a
  # browser session. Octet-stream bodies bypass the endpoint's JSON parser.
  scope "/features/14-uploads/10-samarkand-silk-upload" do
    put "/archive/:token", PhoenixMultivitaminWeb.SamarkandArchiveController, :create
  end

  # Feature 03 — Controllers and JSON. Path slugs live here; domain copy
  # lives in each scenario folder.
  scope "/features/03-controllers-and-json" do
    pipe_through :browser

    get "/01-queenstown-metar-desk/metar",
        PhoenixMultivitaminWeb.QueenstownMetarDeskController,
        :show

    get "/03-marrakech-atis-feed/atis",
        PhoenixMultivitaminWeb.MarrakechAtisFeedController,
        :show

    get "/05-bariloche-chinook-brief/brief",
        PhoenixMultivitaminWeb.BarilocheChinookBriefController,
        :show

    get "/07-entebbe-cargo-manifest/manifests/new",
        PhoenixMultivitaminWeb.EntebbeCargoManifestController,
        :new

    post "/07-entebbe-cargo-manifest/manifests",
         PhoenixMultivitaminWeb.EntebbeCargoManifestController,
         :create

    get "/07-entebbe-cargo-manifest/manifests/:id",
        PhoenixMultivitaminWeb.EntebbeCargoManifestController,
        :show

    get "/10-leh-density-altitude-card/card",
        PhoenixMultivitaminWeb.LehDensityAltitudeCardController,
        :show

    get "/12-baltra-biosecurity-pass/passes/:kind",
        PhoenixMultivitaminWeb.BaltraBiosecurityPassController,
        :show

    get "/13-punta-arenas-austral-load/loads/:id",
        PhoenixMultivitaminWeb.PuntaArenasAustralLoadController,
        :show
  end

  scope "/features/03-controllers-and-json" do
    pipe_through :html_or_json

    get "/06-dakar-harmattan-metar/metar",
        PhoenixMultivitaminWeb.DakarHarmattanMetarController,
        :show
  end

  scope "/features/03-controllers-and-json" do
    pipe_through :api

    get "/01-queenstown-metar-desk/metar/export",
        PhoenixMultivitaminWeb.QueenstownMetarDeskController,
        :export

    get "/02-cusco-load-sheet/sheet",
        PhoenixMultivitaminWeb.CuscoLoadSheetController,
        :show

    post "/03-marrakech-atis-feed/atis",
         PhoenixMultivitaminWeb.MarrakechAtisFeedController,
         :create

    get "/04-ulaanbaatar-winter-notam/notams/:notam",
        PhoenixMultivitaminWeb.UlaanbaatarWinterNotamController,
        :show

    get "/04-ulaanbaatar-winter-notam/explode",
        PhoenixMultivitaminWeb.UlaanbaatarWinterNotamController,
        :explode

    get "/08-zanzibar-spice-run-ticket/tickets",
        PhoenixMultivitaminWeb.ZanzibarSpiceRunTicketController,
        :index

    get "/09-male-atoll-slot-list/slots/:id",
        PhoenixMultivitaminWeb.MaleAtollSlotListController,
        :show

    post "/10-leh-density-altitude-card/card",
         PhoenixMultivitaminWeb.LehDensityAltitudeCardController,
         :create

    get "/11-lhasa-oxygen-plan/ticket",
        PhoenixMultivitaminWeb.LhasaOxygenPlanController,
        :show

    get "/13-punta-arenas-austral-load/loads",
        PhoenixMultivitaminWeb.PuntaArenasAustralLoadController,
        :index

    post "/13-punta-arenas-austral-load/loads",
         PhoenixMultivitaminWeb.PuntaArenasAustralLoadController,
         :create
  end

  # Feature 01 — Routing and plugs. Path slugs live here; domain copy and
  # plug options live in each scenario folder.
  scope "/features/01-routing-and-plugs" do
    pipe_through :browser

    scope "/01-lukla-shear-gate" do
      pipe_through :lukla_shear
      get "/approach", PhoenixMultivitaminWeb.LuklaShearGateController, :show
    end

    scope "/02-tromso-sar-hoist" do
      pipe_through :tromso_sar_hoist
      get "/pad", PhoenixMultivitaminWeb.TromsoSarHoistController, :dispatch
    end

    scope "/03-incheon-bonded-shed" do
      scope "/arrivals" do
        pipe_through :incheon_arrivals

        resources "/declarations", PhoenixMultivitaminWeb.IncheonDeclarationsController,
          only: [:index, :show]
      end

      scope "/departures" do
        pipe_through :incheon_departures

        resources "/declarations", PhoenixMultivitaminWeb.IncheonDeclarationsController,
          only: [:index, :show]
      end
    end

    get "/05-shannon-avgas-office/bowser",
        PhoenixMultivitaminWeb.ShannonAvgasController,
        :show

    scope "/06-changi-hydrant-tape" do
      pipe_through :changi_hydrant
      get "/tape", PhoenixMultivitaminWeb.ChangiHydrantTapeController, :show
      live "/hydrant", PhoenixMultivitaminWeb.ChangiHydrantTapeLive
    end

    get "/07-barra-beach-shed/shed", PhoenixMultivitaminWeb.BarraBeachShedController, :show

    get "/08-finkenwerder-jig-floor/floor/jigs",
        PhoenixMultivitaminWeb.FinkenwerderJigFloorController,
        :index

    get "/08-finkenwerder-jig-floor/floor/jigs/:jig_id",
        PhoenixMultivitaminWeb.FinkenwerderJigFloorController,
        :show

    scope "/09-oostwold-balloon-line" do
      pipe_through :oostwold_balloon
      get "/line", PhoenixMultivitaminWeb.OostwoldBalloonLineController, :show
    end

    get "/10-kiruna-deice-pad/pads", PhoenixMultivitaminWeb.KirunaDeicePadController, :show

    get "/11-bergen-briefing-desk/roster",
        PhoenixMultivitaminWeb.BergenBriefingDeskController,
        :roster

    get "/11-bergen-briefing-desk/desk",
        PhoenixMultivitaminWeb.BergenBriefingDeskController,
        :desk

    get "/11-bergen-briefing-desk/leaky-desk",
        PhoenixMultivitaminWeb.BergenBriefingDeskController,
        :leaky_desk

    scope "/12-santa-maria-oceanic-floor" do
      pipe_through :santa_maria_oceanic

      scope "/station/:station" do
        pipe_through :santa_maria_watch

        scope "/watch/:watch" do
          get "/floor", PhoenixMultivitaminWeb.SantaMariaOceanicFloorController, :show
        end
      end
    end

    scope "/12-santa-maria-oceanic-floor/relief" do
      pipe_through :santa_maria_watch
      get "/floor", PhoenixMultivitaminWeb.SantaMariaOceanicFloorController, :relief
    end

    scope "/13-ushuaia-austral-pipeline" do
      pipe_through :ushuaia_austral
      get "/austral", PhoenixMultivitaminWeb.UshuaiaAustralPipelineController, :austral
      forward "/lookout", PhoenixMultivitaminWeb.UshuaiaLookoutRouter
    end

    forward "/04-paro-inbound-log/valley", PhoenixMultivitaminWeb.ParoInboundLogRouter
  end

  scope "/features/01-routing-and-plugs/08-finkenwerder-jig-floor/api" do
    pipe_through :api

    get "/jigs", PhoenixMultivitaminWeb.FinkenwerderJigFloorController, :index
    get "/jigs/:jig_id", PhoenixMultivitaminWeb.FinkenwerderJigFloorController, :show
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
