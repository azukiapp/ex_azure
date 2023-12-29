defmodule ExAzure.Utils do
  def normalize_to_charlist({k, v}) do
    {normalize_to_charlist(k), normalize_to_charlist(v)}
  end

  def normalize_to_charlist([h | t]) do
    [normalize_to_charlist(h) | normalize_to_charlist(t)]
  end

  def normalize_to_charlist(term) when is_binary(term) do
    with true <- String.valid?(term),
         charlist <- Kernel.to_charlist(term),
         true <- ascii_printable?(charlist) do
      charlist
    else
      _ ->
        term
    end
  end

  def normalize_to_charlist(term) do
    term
  end

  defp ascii_printable?(list, counter \\ :infinity)

  defp ascii_printable?(_, 0) do
    true
  end

  defp ascii_printable?([char | rest], counter)
       when is_integer(char) and char >= 32 and char <= 126 do
    ascii_printable?(rest, decrement(counter))
  end

  defp ascii_printable?([?\n | rest], counter) do
    ascii_printable?(rest, decrement(counter))
  end

  defp ascii_printable?([?\r | rest], counter) do
    ascii_printable?(rest, decrement(counter))
  end

  defp ascii_printable?([?\t | rest], counter) do
    ascii_printable?(rest, decrement(counter))
  end

  defp ascii_printable?([?\v | rest], counter) do
    ascii_printable?(rest, decrement(counter))
  end

  defp ascii_printable?([?\b | rest], counter) do
    ascii_printable?(rest, decrement(counter))
  end

  defp ascii_printable?([?\f | rest], counter) do
    ascii_printable?(rest, decrement(counter))
  end

  defp ascii_printable?([?\e | rest], counter) do
    ascii_printable?(rest, decrement(counter))
  end

  defp ascii_printable?([?\a | rest], counter) do
    ascii_printable?(rest, decrement(counter))
  end

  defp ascii_printable?([], _counter), do: true
  defp ascii_printable?(_, _counter), do: false

  defp decrement(:infinity), do: :infinity
  defp decrement(counter), do: counter - 1
end
