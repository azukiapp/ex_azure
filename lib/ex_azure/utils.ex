defmodule ExAzure.Utils do
  def normalize_to_charlist({k, v}) do
    {normalize_to_charlist(k), normalize_to_charlist(v)}
  end
  def normalize_to_charlist([h | t]) do
    [normalize_to_charlist(h) | normalize_to_charlist(t)]
  end

  def normalize_to_charlist(term) do
    if String.valid?(term), do: to_charlist(term), else: term
  end
end
