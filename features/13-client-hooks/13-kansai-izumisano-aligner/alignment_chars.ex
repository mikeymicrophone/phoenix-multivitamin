defimpl String.Chars, for: PhoenixMultivitaminWeb.KansaiAlignment do
  def to_string(alignment) do
    "Stand #{alignment.stand}: #{alignment.offset_mm} mm / spread #{alignment.spread_mm} mm"
  end
end
