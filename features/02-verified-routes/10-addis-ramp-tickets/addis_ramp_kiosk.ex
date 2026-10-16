defmodule PhoenixMultivitaminWeb.AddisRampKiosk do
  @moduledoc false
  use Phoenix.Router, helpers: false

  get "/lane/:lane", PhoenixMultivitaminWeb.AddisRampLaneController, :show
end
