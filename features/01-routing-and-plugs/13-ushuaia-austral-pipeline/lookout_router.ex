defmodule PhoenixMultivitaminWeb.UshuaiaLookoutRouter do
  @moduledoc false
  use PhoenixMultivitaminWeb, :router

  pipeline :lookout do
    plug PhoenixMultivitaminWeb.UshuaiaLookoutPlug
  end

  scope "/", PhoenixMultivitaminWeb do
    pipe_through :lookout

    get "/", UshuaiaLookoutController, :desk
    get "/clerks/pilar/watches/icing", UshuaiaLookoutController, :icing

    scope "/clerks/:clerk" do
      resources "/watches", UshuaiaWatchController, only: [:index, :show]
    end
  end
end
