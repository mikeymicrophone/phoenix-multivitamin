defmodule PhoenixMultivitaminWeb.ErrorJSONTest do
  use PhoenixMultivitaminWeb.ConnCase, async: true

  test "renders 404" do
    assert PhoenixMultivitaminWeb.ErrorJSON.render("404.json", %{}) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "renders 500" do
    assert PhoenixMultivitaminWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
