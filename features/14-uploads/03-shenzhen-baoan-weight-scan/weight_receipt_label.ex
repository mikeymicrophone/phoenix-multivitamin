defimpl String.Chars, for: PhoenixMultivitamin.ShenzhenWeightReceipt do
  def to_string(receipt), do: "#{receipt.filename} · #{receipt.kilograms} kg"
end
