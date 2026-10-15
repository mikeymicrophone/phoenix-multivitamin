defmodule PhoenixMultivitamin.CatalogTest do
  use ExUnit.Case, async: true

  alias PhoenixMultivitamin.Catalog

  test "the bottle holds 25 features, 13 slots each, and one bottled scenario" do
    features = Catalog.features()

    assert Catalog.feature_count() == 25
    assert Catalog.slot_count() == 325
    assert length(features) == 25
    assert Enum.all?(features, &(length(&1.slots) == 13))
    assert Catalog.bottled_count() == 1

    [slot] = Catalog.bottled_slots()
    assert slot.bottled
    assert is_atom(slot.live_module)
    assert String.starts_with?(slot.path, "/features/")
  end
end
