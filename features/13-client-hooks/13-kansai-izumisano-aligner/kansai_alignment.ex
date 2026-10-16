defmodule PhoenixMultivitaminWeb.KansaiAlignment do
  @moduledoc false
  @enforce_keys [:stand, :tolerance_mm]
  defstruct [:stand, :tolerance_mm, left_mm: 0, right_mm: 0, offset_mm: 0, spread_mm: 0]

  def measure(%__MODULE__{} = alignment, %{"left_mm" => left, "right_mm" => right})
      when is_integer(left) and is_integer(right) do
    if left in -40..40 and right in -40..40 do
      {:ok,
       %{
         alignment
         | left_mm: left,
           right_mm: right,
           offset_mm: div(left + right, 2),
           spread_mm: abs(left - right)
       }}
    else
      {:error, :sensor_out_of_range}
    end
  end

  def measure(%__MODULE__{}, _sensors), do: {:error, :unreadable_sensors}

  def aligned?(%__MODULE__{offset_mm: offset, spread_mm: spread, tolerance_mm: tolerance}) do
    abs(offset) <= tolerance and spread <= tolerance
  end
end
