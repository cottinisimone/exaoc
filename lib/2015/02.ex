import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 2

defmodule AdventOfCode.Level02Part1 do
  @doc """
  iex> AdventOfCode.Level02Part1.start
  1588178
  """
  def start do
    puzzle_input("2015", "02")
    |> to_dimensions
    |> List.foldl(0, &reduce(&1, &2))
  end

  # lxwxh
  def to_dimensions(input) do
    input
    |> String.split("\n")
    |> parse_lines
  end

  defp parse_lines(lines) do
    Enum.map(lines, fn str ->
      str
      |> String.split("x")
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()
    end)
  end

  defp reduce([l, w, h], acc) do
    acc + l * w + 2 * l * w + 2 * w * h + 2 * l * h
  end
end

# Part 2
#
defmodule AdventOfCode.Level02Part2 do
  import AdventOfCode.Level02Part1, only: [to_dimensions: 1]

  @doc """
  iex> AdventOfCode.Level02Part2.start
  3783758
  """
  def start do
    puzzle_input("2015", "02")
    |> to_dimensions()
    |> List.foldl(0, &reduce(&1, &2))
  end

  defp reduce([l, w, h], acc) do
    acc + (l + l + w + w) + l * w * h
  end
end
