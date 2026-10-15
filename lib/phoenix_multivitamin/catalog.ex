defmodule PhoenixMultivitamin.Catalog do
  @moduledoc """
  Discovers the 25 feature folders and their 13 slots.

  Slot titles, slugs, and live modules live in each feature's `feature.exs`,
  never here, so a future `quirked` branch can reskin names without touching
  this file.
  """

  @features_root Path.expand("../../features", __DIR__)

  feature_files =
    @features_root
    |> File.ls!()
    |> Enum.filter(&File.dir?(Path.join(@features_root, &1)))
    |> Enum.sort()
    |> Enum.map(&Path.join([@features_root, &1, "feature.exs"]))

  for file <- feature_files do
    @external_resource file
  end

  @features Enum.map(feature_files, fn file ->
              {spec, _binding} = Code.eval_file(file)

              Map.update!(spec, :slots, fn slots ->
                Enum.map(slots, fn slot ->
                  path = "/features/#{spec.slug}/#{slot.slug}"
                  Map.put(slot, :path, path)
                end)
              end)
            end)

  @slot_count Enum.reduce(@features, 0, fn feature, acc -> acc + length(feature.slots) end)

  def features, do: @features

  def feature_count, do: length(@features)

  def slot_count, do: @slot_count

  def bottled_count do
    Enum.reduce(@features, 0, fn feature, acc ->
      acc + Enum.count(feature.slots, & &1.bottled)
    end)
  end

  def bottled_slots do
    Enum.flat_map(@features, fn feature ->
      Enum.filter(feature.slots, & &1.bottled)
    end)
  end

  def fetch_slot(feature_slug, example_slug) do
    Enum.find_value(@features, fn feature ->
      if feature.slug == feature_slug do
        Enum.find(feature.slots, &(&1.slug == example_slug))
        |> case do
          nil -> nil
          slot -> %{feature: feature, slot: slot}
        end
      end
    end)
  end

  defmacro draw_live_routes do
    routes =
      for slot <- bottled_slots() do
        quote do
          live unquote(slot.path), unquote(slot.live_module)
        end
      end

    quote do
      unquote(routes)
    end
  end
end
