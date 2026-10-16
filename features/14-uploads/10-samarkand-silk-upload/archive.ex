defmodule PhoenixMultivitamin.SamarkandArchive do
  @moduledoc false

  alias PhoenixMultivitaminWeb.Endpoint

  @salt "samarkand-inventory"

  def sign(key, bytes) when is_binary(key) and is_integer(bytes) and bytes >= 0 and bytes <= 20_000 do
    Phoenix.Token.sign(Endpoint, @salt, %{key: key, bytes: bytes})
  end

  def verify(token), do: Phoenix.Token.verify(Endpoint, @salt, token, max_age: 60)

  def path(key) do
    Path.join([System.tmp_dir!(), "phoenix_multivitamin_samarkand", key])
  end

  def store(key, contents) do
    destination = path(key)

    with :ok <- File.mkdir_p(Path.dirname(destination)),
         :ok <- File.write(destination, contents, [:binary, :exclusive]) do
      :ok
    end
  end
end
