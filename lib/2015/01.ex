import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 1
# iex -S mix  

# Part 1
# iex> AdventOfCode.Level01Part1.start
# iex> 232
defmodule AdventOfCode.Level01Part1 do
  def start do
    puzzle_input("2015", "01")
    |> String.to_charlist()
    |> List.foldl(0, fn
      ?(, acc -> acc + 1
      ?), acc -> acc - 1
      c, _ -> raise "Illegal character '#{c}'"
    end)
  end
end

# Part 2
# iex> AdventOfCode.Level01Part2.start
# iex> 1783
defmodule AdventOfCode.Level01Part2 do
  def start do
    puzzle_input("2015", "01")
    |> String.to_charlist()
    |> Enum.with_index(0)
    |> Enum.reduce_while(0, fn
      {_, idx}, -1 -> {:halt, idx}
      {?(, _}, acc -> {:cont, acc + 1}
      {?), _}, acc -> {:cont, acc - 1}
      c, _ -> raise "Illegal character '#{c}'"
    end)
  end
end
