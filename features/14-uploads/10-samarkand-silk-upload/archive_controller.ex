# Uploads · 10 · Samarkand signed archive endpoint
#
# Teaches:
# - An external upload endpoint verifies its capability and limits the request body
# - A one-use archive key refuses overwrites independently of LiveView progress

defmodule PhoenixMultivitaminWeb.SamarkandArchiveController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  alias PhoenixMultivitamin.SamarkandArchive, as: Archive

  def create(conn, %{"token" => token}) do
    case Archive.verify(token) do
      {:ok, %{key: key, bytes: bytes}} -> receive_inventory(conn, key, bytes)
      {:error, _reason} -> send_resp(conn, :forbidden, "The archive link expired or is invalid.")
    end
  end

  defp receive_inventory(conn, key, bytes) do
    case read_body(conn, length: 20_001) do
      {:ok, contents, conn} ->
        with true <- byte_size(contents) == bytes,
             :ok <- Archive.store(key, contents) do
          send_resp(conn, :created, "Inventory archived")
        else
          false -> send_resp(conn, :unprocessable_entity, "Inventory size does not match the signed size.")
          {:error, :eexist} -> send_resp(conn, :conflict, "Inventory already archived")
          {:error, _reason} -> send_resp(conn, :service_unavailable, "The archive is unavailable.")
        end

      {:more, _contents, conn} ->
        send_resp(conn, :request_entity_too_large, "Inventory exceeds the archive limit.")

      {:error, _reason} ->
        send_resp(conn, :bad_request, "Inventory could not be read.")
    end
  end
end
