import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 12

defmodule AdventOfCode.Level12Part1 do
  @doc """
  iex> AdventOfCode.Level12Part1.start
  111754
  """
  def start, do: puzzle_input("2015", "12") |> String.to_charlist() |> collect() |> Enum.sum()

  def collect(arr), do: _collect(arr, [], [])

  defp _collect([], nums, _), do: nums
  defp _collect([head | tail], nums, num) when head in '-0123456789', do: _collect(tail, nums, [head | num])
  defp _collect([_ | tail], nums, []), do: _collect(tail, nums, [])
  defp _collect([_ | tail], nums, num), do: _collect(tail, [to_integer(num) | nums], [])

  defp to_integer(num), do: num |> Enum.reverse() |> to_string() |> String.to_integer()
end

defmodule AdventOfCode.Level12Part2 do
  @doc """
  iex> AdventOfCode.Level12Part2.start
  65402
  """
  def start, do: puzzle_input("2015", "12") |> Poison.Parser.parse!(%{}) |> sum()

  def sum(some), do: _sum(some, 0)

  defp _sum(some, tot) when is_map(some) do
    if !has_red?(some), do: Enum.map(some, fn {_, v} -> _sum(v, tot) end) |> Enum.sum(), else: 0
  end

  defp _sum(some, tot) when is_list(some), do: Enum.map(some, fn v -> _sum(v, tot) end) |> Enum.sum()
  defp _sum(some, tot) when is_integer(some), do: some + tot
  defp _sum(_, _), do: 0

  defp has_red?(map), do: Enum.any?(map, fn {_, v} -> v == "red" end)
end
