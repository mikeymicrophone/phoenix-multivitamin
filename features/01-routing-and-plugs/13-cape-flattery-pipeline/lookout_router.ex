defmodule PhoenixMultivitaminWeb.CapeFlatteryLookoutRouter do
  @moduledoc false
  use PhoenixMultivitaminWeb, :router

  pipeline :lookout do
    plug PhoenixMultivitaminWeb.CapeFlatteryLookoutPlug
  end

  scope "/", PhoenixMultivitaminWeb do
    pipe_through :lookout

    get "/", CapeFlatteryLookoutController, :desk
    get "/keepers/nessa/watches/fog", CapeFlatteryLookoutController, :fog

    scope "/keepers/:keeper" do
      resources "/watches", CapeFlatteryWatchController, only: [:index, :show]
    end
  end
end
