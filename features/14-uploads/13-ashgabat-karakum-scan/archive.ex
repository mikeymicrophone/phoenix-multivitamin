defmodule PhoenixMultivitamin.AshgabatArchive do
  @moduledoc false

  def root do
    Application.app_dir(:phoenix_multivitamin, "priv/uploads/karakum")
  end

  def store(batch, uuid, source) do
    directory = Path.join(root(), batch)
    destination = Path.join(directory, uuid)

    with :ok <- File.mkdir_p(directory),
         :ok <- File.cp(source, destination) do
      {:ok, destination}
    end
  end
end
