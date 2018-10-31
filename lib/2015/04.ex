import AdventOfCode
# Year 2015, Level 4

defmodule AdventOfCode.Level04Part1 do
  @doc """
  iex> AdventOfCode.Level04Part1.start
  117946
  """
  def start, do: find(puzzle_input("2015", "04"), "00000", 0)

  def find(input, zeroes, acc) do
    if md5("#{input}#{acc}") |> String.starts_with?(zeroes),
      do: acc,
      else: find(input, zeroes, acc + 1)
  end
end

defmodule AdventOfCode.Level04Part2 do
  import AdventOfCode.Level04Part1, only: [find: 3]

  @doc """
  iex> AdventOfCode.Level04Part2.start
  3938038
  """
  def start, do: find(puzzle_input("2015", "04"), "000000", 0)
end
