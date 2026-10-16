%{
  number: 10,
  slug: "10-streams",
  title: "Streams",
  summary:
    "stream/4, stream_insert, stream_delete, stream_reset, and rendering collections that grow without holding every row in assigns.",
  official: "https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#stream/4",
  slots: [
    %{
      number: 1,
      slug: "01-resolute-departure-stream",
      title: "Resolute departure stream",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.ResoluteDepartureStreamLive
    },
    %{
      number: 2,
      slug: "02-luderitz-stand-stream",
      title: "Lüderitz stand stream",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.LuderitzStandStreamLive
    },
    %{
      number: 3,
      slug: "03-batumi-front-stream",
      title: "Batumi front stream",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.BatumiFrontStreamLive
    },
    %{
      number: 4,
      slug: "04-jomsom-delete-stream",
      title: "Jomsom delete stream",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.JomsomDeleteStreamLive
    },
    %{
      number: 5,
      slug: "05-nadi-stream-container",
      title: "Nadi stream container",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.NadiStreamContainerLive
    },
    %{
      number: 6,
      slug: "06-inuvik-map-rows",
      title: "Inuvik map rows",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.InuvikMapRowsLive
    },
    %{
      number: 7,
      slug: "07-osh-filter-reset",
      title: "Osh filter reset",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.OshFilterResetLive
    },
    %{
      number: 8,
      slug: "08-mohe-limit-tape",
      title: "Mohe limit tape",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.MoheLimitTapeLive
    },
    %{
      number: 9,
      slug: "09-siargao-empty-apron",
      title: "Siargao empty apron",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.SiargaoEmptyApronLive
    },
    %{
      number: 10,
      slug: "10-tiksi-component-stream",
      title: "Tiksi component stream",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.TiksiComponentStreamLive
    },
    %{
      number: 11,
      slug: "11-calama-insert-after",
      title: "Calama insert after",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.CalamaInsertAfterLive
    },
    %{
      number: 12,
      slug: "12-funafuti-once-stream",
      title: "Funafuti once stream",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.FunafutiOnceStreamLive
    },
    %{
      number: 13,
      slug: "13-alert-capstone-stream",
      title: "Alert capstone stream",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.AlertCapstoneStreamLive
    }
  ]
}
