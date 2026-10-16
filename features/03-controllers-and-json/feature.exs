%{
  number: 3,
  slug: "03-controllers-and-json",
  title: "Controllers and JSON",
  summary:
    "Controller actions, HTML and JSON formats, fallback controllers, status codes, and rendering maps without a view module getting in the way of the payload.",
  official: "https://hexdocs.pm/phoenix/controllers.html",
  slots: [
    %{
      number: 1,
      slug: "01-queenstown-metar-desk",
      title: "Queenstown METAR desk",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.QueenstownMetarDeskLive
    },
    %{
      number: 2,
      slug: "02-cusco-load-sheet",
      title: "Cusco load sheet",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.CuscoLoadSheetLive
    },
    %{
      number: 3,
      slug: "03-marrakech-atis-feed",
      title: "Marrakech ATIS feed",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.MarrakechAtisFeedLive
    },
    %{
      number: 4,
      slug: "04-ulaanbaatar-winter-notam",
      title: "Ulaanbaatar winter NOTAM",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.UlaanbaatarWinterNotamLive
    },
    %{
      number: 5,
      slug: "05-bariloche-chinook-brief",
      title: "Bariloche Chinook brief",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.BarilocheChinookBriefLive
    },
    %{
      number: 6,
      slug: "06-dakar-harmattan-metar",
      title: "Dakar harmattan METAR",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.DakarHarmattanMetarLive
    },
    %{
      number: 7,
      slug: "07-entebbe-cargo-manifest",
      title: "Entebbe cargo manifest",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.EntebbeCargoManifestLive
    },
    %{
      number: 8,
      slug: "08-zanzibar-spice-run-ticket",
      title: "Zanzibar spice-run ticket",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.ZanzibarSpiceRunTicketLive
    },
    %{
      number: 9,
      slug: "09-male-atoll-slot-list",
      title: "Malé atoll slot list",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.MaleAtollSlotListLive
    },
    %{
      number: 10,
      slug: "10-leh-density-altitude-card",
      title: "Leh density-altitude card",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.LehDensityAltitudeCardLive
    },
    %{
      number: 11,
      slug: "11-lhasa-oxygen-plan",
      title: "Lhasa oxygen plan",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.LhasaOxygenPlanLive
    },
    %{
      number: 12,
      slug: "12-baltra-biosecurity-pass",
      title: "Baltra biosecurity pass",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.BaltraBiosecurityPassLive
    },
    %{
      number: 13,
      slug: "13-punta-arenas-austral-load",
      title: "Punta Arenas austral load",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.PuntaArenasAustralLoadLive
    }
  ]
}
