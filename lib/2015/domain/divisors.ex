defmodule Divisors do
  def of(n), do: divisor(n, 1, [])

  defp divisor(n, i, factors) when n < i * i, do: factors
  defp divisor(n, i, factors) when n == i * i, do: [i | factors]
  defp divisor(n, i, factors) when rem(n, i) == 0, do: divisor(n, i + 1, [i, div(n, i) | factors])
  defp divisor(n, i, factors), do: divisor(n, i + 1, factors)
end
