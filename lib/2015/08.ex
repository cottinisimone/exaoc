import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 8

defmodule AdventOfCode.Level08Part1 do
  @doc """
  iex> AdventOfCode.Level08Part1.start
  1350
  """
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

defmodule AdventOfCode.Level08Part2 do
  @doc """
  iex> AdventOfCode.Level08Part2.start
  2085
  """
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
