import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 20

defmodule AdventOfCode.Level20Part1 do
  @doc """
  iex> AdventOfCode.Level20Part1.start
  776160
  """
  def start do
    puzzle_input("2015", "20") |> parse() |> deliver_presents()
  end

  def parse(str), do: str |> String.replace("\n", "") |> String.to_integer()

  def deliver_presents(max_presents), do: deliver(div(max_presents, 10), 1)

  defp deliver(max_presents, index) do
    if sum_presents(index) < max_presents, do: deliver(max_presents, index + 1), else: index
  end

  defp sum_presents(house_number), do: house_number |> Divisors.of() |> Enum.sum()
end

defmodule AdventOfCode.Level20Part2 do
  @doc """
  iex> AdventOfCode.Level20Part2.start
  786240
  """
  def start do
    puzzle_input("2015", "20") |> parse() |> deliver_presents()
  end

  def parse(str), do: str |> String.replace("\n", "") |> String.to_integer()

  def deliver_presents(max_presents), do: deliver(max_presents, 1)

  defp deliver(max_presents, index) do
    if sum_presents(index) < max_presents, do: deliver(max_presents, index + 1), else: index
  end

  defp sum_presents(house_number),
    do:
      house_number
      |> Divisors.of()
      |> Enum.filter(&(house_number / &1 <= 50))
      |> Enum.map(&(&1 * 11))
      |> Enum.sum()
end
