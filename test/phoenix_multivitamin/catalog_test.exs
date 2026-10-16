defmodule PhoenixMultivitamin.CatalogTest do
  use ExUnit.Case, async: true

  alias PhoenixMultivitamin.Catalog

  test "the bottle holds 25 features, 13 slots each, and the bottled scenarios" do
    features = Catalog.features()

    assert Catalog.feature_count() == 25
    assert Catalog.slot_count() == 325
    assert length(features) == 25
    assert Enum.all?(features, &(length(&1.slots) == 13))
    assert Catalog.bottled_count() == 104

    bottled = Catalog.bottled_slots()
    assert length(bottled) == 104
    assert Enum.all?(bottled, & &1.bottled)
    assert Enum.all?(bottled, &is_atom(&1.live_module))
    assert Enum.all?(bottled, &String.starts_with?(&1.path, "/features/"))
  end
end
