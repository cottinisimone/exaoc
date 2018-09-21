import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 8
# iex -S mix

# Part 1
# iex> AdventOfCode.Level08Part1.start
# iex> 1350
defmodule AdventOfCode.Level08Part1 do
  def start do
    puzzle_input("2015", "08")
    |> String.split("\n")
    |> List.foldl({0, 0}, &count(&1, &2))
    |> (fn {x, y} -> x - y end).()
  end

  def count(str, {total, in_memory}), do: {total + String.length(str), in_memory + escape(str)}

  def escape(str) do
    str
    |> String.replace("\\\"", "\"")
    |> String.replace("\\\\", "\\")
    |> (fn x -> Regex.replace(~r/(\\x[0-9a-fA-F]{1,2})/, x, "_") end).()
    |> String.to_charlist()
    |> (fn [_ | tail] -> Enum.drop(tail, -1) end).()
    |> Enum.count()
  end
end

# Part 2
# iex> AdventOfCode.Level08Part2.start
# iex> 2085
defmodule AdventOfCode.Level08Part2 do
  def start do
    puzzle_input("2015", "08")
    |> String.split("\n")
    |> List.foldl({0, 0}, &count(&1, &2))
    |> (fn {x, y} -> y - x end).()
  end

  def count(str, {total, encoded}), do: {total + String.length(str), encoded + encode(str)}

  def encode(str) do
    str
    |> String.replace("\\", "\\\\")
    |> String.replace("\"", "\\\"")
    |> (fn x -> "\"#{x}\"" end).()
    |> String.length()
  end
end
