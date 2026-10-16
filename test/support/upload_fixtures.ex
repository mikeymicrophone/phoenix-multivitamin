defmodule PhoenixMultivitaminWeb.UploadFixtures do
  @moduledoc "Small, in-memory flight documents shared by the upload scaffolding."

  def flight_file(name, contents, type \\ "text/plain") do
    %{name: name, content: contents, size: byte_size(contents), type: type,
      last_modified: 1_700_000_000_000}
  end

  def wing_photo(name) do
    contents = Base.decode64!("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+a5uoAAAAASUVORK5CYII=")
    flight_file(name, contents, "image/png")
  end
end
