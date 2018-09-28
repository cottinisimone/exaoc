import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 18
# iex -S mix  

# Part 1
# iex> AdventOfCode.Level18Part1.start
# iex> 814
defmodule AdventOfCode.Level18Part1 do
  def start do
    puzzle_input("2015", "18") |> parse()
  end

  def parse(input) do
    input 
    |> String.replace("\n", "") 
    |> String.to_charlist() 
    |> Enum.reduce([], fn char, acc -> [_parse(char) | acc] end)
    |> Enum.reverse()
  end

  def _parse(?#), do: 1
  def _parse(?.), do: 0

  def turn(grid) do
    
  end

  defp get(grid, x, y), do: Enum.at(grid, id(x, y))
  defp id(x, y), do: (y - 1) * 100 + x
end

# Part 2
# iex> AdventOfCode.Level18Part2.start
# iex> 924
defmodule AdventOfCode.Level18Part2 do
  def start do
    puzzle_input("2015", "18")
  end
end
