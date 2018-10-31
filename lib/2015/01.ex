import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 1

defmodule AdventOfCode.Level01Part1 do
  @doc """
  iex> AdventOfCode.Level01Part1.start
  232
  """
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

defmodule AdventOfCode.Level01Part2 do
  @doc """
  iex> AdventOfCode.Level01Part2.start
  1783
  """
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
