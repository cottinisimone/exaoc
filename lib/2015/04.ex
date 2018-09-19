import AdventOfCode
# Year 2015, Level 4
# iex -S mix  

# Part 1
# iex> AdventOfCode.Level04Part1.start
# iex> 117946
defmodule AdventOfCode.Level04Part1 do
  def start, do: find(puzzle_input("2015", "04"), "00000", 0)

  def find(input, zeroes, acc) do
    if md5("#{input}#{acc}") |> String.starts_with?(zeroes),
      do: acc,
      else: find(input, zeroes, acc + 1)
  end
end

# Part 2
# iex> AdventOfCode.Level04Part2.start
# iex> 3938038
defmodule AdventOfCode.Level04Part2 do
  import AdventOfCode.Level04Part1, only: [find: 3]

  def start, do: find(puzzle_input("2015", "04"), "000000", 0)
end
