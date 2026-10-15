defmodule PhoenixMultivitaminWeb.EdmondsRampKiosk do
  @moduledoc false
  use Phoenix.Router, helpers: false

  get "/lane/:lane", PhoenixMultivitaminWeb.EdmondsRampLaneController, :show
end
