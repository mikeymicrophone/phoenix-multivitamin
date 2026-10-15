defmodule PhoenixMultivitaminWeb.NeahBayEntranceLogRouter do
  @moduledoc false
  use PhoenixMultivitaminWeb, :router

  pipeline :entrance_log do
    plug PhoenixMultivitaminWeb.NeahBayEntrancePlug
  end

  scope "/", PhoenixMultivitaminWeb do
    pipe_through :entrance_log

    get "/", NeahBayEntranceLogController, :show
    get "/canoe/:hull", NeahBayEntranceLogController, :canoe
  end
end
