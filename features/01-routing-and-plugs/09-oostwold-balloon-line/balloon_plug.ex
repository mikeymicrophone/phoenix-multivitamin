defmodule PhoenixMultivitaminWeb.OostwoldBalloonPlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:field, "Oostwold balloon meadow")
    |> assign(:balloon, "Cameron balloon Polder Groen")
    |> assign(:crew_chief, "Bram")
    |> put_private(:launch_code, "polder-green")
    |> put_private(:radio_channel, "Eelde balloon net")
  end
end
