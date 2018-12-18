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
    |> generate()
  end

  def parse(input) do
    lines = input |> String.split("\n") |> Enum.filter(&(&1 != ""))

    {List.last(lines),
     lines
     |> Enum.drop(-1)
     |> Enum.map(&String.split(&1, " => "))
     |> Enum.map(fn [from, to] -> {from, to} end)}
  end

  def generate({molecula, replacements}) do
    replacements
    |> Enum.flat_map(fn {old, new} ->
      _generate(String.split(molecula, old), old, new)
    end)
    |> Enum.reject(&(&1 == molecula))
    |> Enum.uniq()
    |> Enum.count()
  end

  defp _generate([head], _, _), do: [head]

  defp _generate(split, old, new) do
    1..(Enum.count(split) - 1)
    |> Enum.reduce([], fn x, acc ->
      [append_at(split, old, new, x) | acc]
    end)
  end

  def append_at(array, old, new, index) do
    array
    |> Enum.take(index)
    |> Enum.join(old)
    |> Kernel.<>(new)
    |> Kernel.<>(_get_reverse(array, index) |> Enum.join(old))
  end

  defp _get_reverse(array, index) do
    array
    |> Enum.reverse()
    |> Enum.take(Enum.count(array) - index)
    |> Enum.reverse()
  end
end

defmodule AdventOfCode.Level19Part2 do
  @doc """
  iex> AdventOfCode.Level19Part2.start
  1
  """
  def start do
    puzzle_input("2015", "19")
    0
  end
end
