import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 19

defmodule AdventOfCode.Level19Part1 do
  @doc """
  iex> AdventOfCode.Level19Part1.start
  535
  """
  def start do
    puzzle_input("2015", "19")
    |> parse()

    # |> generate()
  end

  def parse(input) do
    lines = input |> String.split("\n") |> Enum.filter(&(&1 != ""))

    {List.last(lines),
     lines
     |> Enum.drop(-1)
     |> Enum.map(&String.split(&1, " => "))
     |> Enum.map(fn [from, to] -> {String.to_atom(from), to} end)}
  end
end

defmodule AdventOfCode.Level19Part2 do
  @doc """
  iex> AdventOfCode.Level19Part2.start
  212
  """
  def start do
    puzzle_input("2015", "19")
  end
end
