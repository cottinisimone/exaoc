import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 10

defmodule AdventOfCode.Level10Part1 do
  @doc """
  iex> AdventOfCode.Level10Part1.start
  329356
  """
  def start do
    puzzle_input("2015", "10")
    |> String.codepoints()
    |> Enum.map(&String.to_integer(&1))
    |> look_and_say(40)
  end

  def look_and_say(array, times) do
    1..times |> Enum.reduce(array, fn _, acc = [h | _] -> _say(acc, [], h, 0) end) |> Enum.count()
  end

  defp _say([head | tail], acc, last, n) when head == last, do: _say(tail, acc, head, n + 1)
  defp _say(array = [head | _], acc, last, n), do: _say(array, [last | [n | acc]], head, 0)
  defp _say([], acc, last, n), do: Enum.reverse([last | [n | acc]])
end

defmodule AdventOfCode.Level10Part2 do
  import AdventOfCode.Level10Part1, only: [look_and_say: 2]

  @doc """
  iex> AdventOfCode.Level10Part2.start
  4666278
  """
  def start do
    puzzle_input("2015", "10")
    |> String.codepoints()
    |> Enum.map(&String.to_integer(&1))
    |> look_and_say(50)
  end
end
