# Core components and layouts · 08 · Kathmandu breadcrumb
#
# Teaches:
# - A local layout can expose a breadcrumb slot the page fills
# - The shared Layouts.catalog stays free of station names

defmodule PhoenixMultivitaminWeb.KathmanduBreadcrumbLayout do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  attr :flash, :map, required: true
  slot :inner_block, required: true
  slot :crumb, required: true

  def desk(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <nav id="station-crumb" class="breadcrumbs">
        {render_slot(@crumb)}
      </nav>
      {render_slot(@inner_block)}
    </Layouts.catalog>
    """
  end
end
