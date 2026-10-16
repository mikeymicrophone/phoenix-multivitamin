%{
  number: 14,
  slug: "14-uploads",
  title: "Uploads",
  summary:
    "allow_upload, live_file_input, progress, validation, consumption, and external transfers for flight crews.",
  official: "https://hexdocs.pm/phoenix_live_view/uploads.html",
  slots: [
    %{
      number: 1,
      slug: "01-centrair-tokoname-plate-scan",
      title: "Centrair Tokoname plate scan",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.CentrairTokonamePlateScanLive
    },
    %{
      number: 2,
      slug: "02-macau-taipa-logbook-upload",
      title: "Macau Taipa logbook upload",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.MacauTaipaLogbookUploadLive
    },
    %{
      number: 3,
      slug: "03-shenzhen-baoan-weight-scan",
      title: "Shenzhen Baoan weight scan",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.ShenzhenBaoanWeightScanLive
    },
    %{
      number: 4,
      slug: "04-chengdu-panda-chart-upload",
      title: "Chengdu panda chart upload",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.ChengduPandaChartUploadLive
    },
    %{
      number: 5,
      slug: "05-urumqi-silk-road-scan",
      title: "Ürümqi silk-road scan",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.UrumqiSilkRoadScanLive
    },
    %{
      number: 6,
      slug: "06-harbin-ice-city-upload",
      title: "Harbin ice-city upload",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.HarbinIceCityUploadLive
    },
    %{
      number: 7,
      slug: "07-kai-tak-checkerboard-scan",
      title: "Kai Tak checkerboard scan",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.KaiTakCheckerboardScanLive
    },
    %{
      number: 8,
      slug: "08-almaty-tien-shan-upload",
      title: "Almaty Tian Shan upload",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.AlmatyTienShanUploadLive
    },
    %{
      number: 9,
      slug: "09-tashkent-registan-scan",
      title: "Tashkent Registan scan",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.TashkentRegistanScanLive
    },
    %{
      number: 10,
      slug: "10-samarkand-silk-upload",
      title: "Samarkand silk upload",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.SamarkandSilkUploadLive
    },
    %{
      number: 11,
      slug: "11-bishkek-ala-too-scan",
      title: "Bishkek Ala-Too scan",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.BishkekAlaTooScanLive
    },
    %{
      number: 12,
      slug: "12-dushanbe-pamir-upload",
      title: "Dushanbe Pamir upload",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.DushanbePamirUploadLive
    },
    %{
      number: 13,
      slug: "13-ashgabat-karakum-scan",
      title: "Ashgabat Karakum scan",
      bottled: true,
      live_module: PhoenixMultivitaminWeb.AshgabatKarakumScanLive
    }
  ]
}
