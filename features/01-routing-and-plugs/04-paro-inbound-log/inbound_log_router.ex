defmodule PhoenixMultivitaminWeb.ParoInboundLogRouter do
  @moduledoc false
  use PhoenixMultivitaminWeb, :router

  pipeline :inbound_log do
    plug PhoenixMultivitaminWeb.ParoInboundPlug
  end

  scope "/", PhoenixMultivitaminWeb do
    pipe_through :inbound_log

    get "/", ParoInboundLogController, :show
    get "/a319/:reg", ParoInboundLogController, :a319
  end
end
