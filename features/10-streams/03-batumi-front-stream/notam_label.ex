defimpl String.Chars, for: PhoenixMultivitamin.BatumiNotam do
  def to_string(%{body: body}), do: body
end
