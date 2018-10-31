import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 17

defmodule AdventOfCode.Level17Part1 do
  @doc """
  iex> AdventOfCode.Level17Part1.start
  654
  """
  def start do
    puzzle_input("2015", "17")
    |> parse()
    |> combinations()
    |> Enum.count(fn comb -> Enum.sum(comb) == 150 end)
  end

  def parse(input), do: input |> String.split("\n") |> Enum.map(&String.to_integer(&1))

  def combinations(containers), do: Combinations.of(containers)
end

defmodule AdventOfCode.Level17Part2 do
  import AdventOfCode.Level17Part1, only: [parse: 1]

  @doc """
  iex> AdventOfCode.Level17Part2.start
  57
  """
  def start do
    puzzle_input("2015", "17")
    |> parse()
    |> Combinations.of()
    |> Enum.filter(fn comb -> Enum.sum(comb) == 150 end)
    |> (fn combs -> count(combs, min(combs)) end).()
  end

  def min(combinations), do: Enum.count(Enum.min_by(combinations, &Enum.count(&1)))

  def count(combinations, min), do: Enum.count(combinations, &(Enum.count(&1) == min))
end
