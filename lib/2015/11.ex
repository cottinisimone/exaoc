import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 11
# iex -S mix  

# Part 1
# iex> AdventOfCode.Level11Part1.start
# iex> cqjxxyzz
defmodule AdventOfCode.Level11Part1 do
  def start, do: puzzle_input("2015", "11") |> find()

  def find(input) do
    input
    |> String.to_charlist()
    |> Enum.reverse()
    |> _increment()
    |> _find()
    |> Enum.reverse()
    |> List.to_string()
  end

  defp _find(password), do: if(_conform?(password), do: password, else: _find(_increment(password)))

  defp _increment([last | init]) when last == ?z, do: [?a | _increment(init)]
  defp _increment([last | init]), do: [last + 1 | init]

  defp _conform?(password) do
    has_n_doubles(password, 2) && !_contains_confusing_letters?(password) && _contains_threesome_letters?(password)
  end

  defp _contains_threesome_letters?([c1 | [c2 | [c3 | _]]]) when c1 == c2 + 1 and c2 == c3 + 1, do: true
  defp _contains_threesome_letters?([_ | [c2 | [c3 | last]]]), do: _contains_threesome_letters?([c2 | [c3 | last]])
  defp _contains_threesome_letters?(_), do: false

  defp _contains_confusing_letters?([init | _]) when init in 'iol', do: true
  defp _contains_confusing_letters?([_ | last]), do: _contains_confusing_letters?(last)
  defp _contains_confusing_letters?([]), do: false

  defp has_n_doubles(codepoints, n), do: _has_n_doubles(codepoints, -1, n, 0)
  defp _has_n_doubles([_ | _], _, n, c) when n == c, do: true
  defp _has_n_doubles([head | tail], prev, n, c) when prev == head, do: _has_n_doubles(tail, -1, n, c + 1)
  defp _has_n_doubles([head | tail], _, n, c), do: _has_n_doubles(tail, head, n, c)
  defp _has_n_doubles([], _, _, _), do: false
end

# Part 2
# iex> AdventOfCode.Level11Part2.start
# iex> cqkaabcc
defmodule AdventOfCode.Level11Part2 do
  import AdventOfCode.Level11Part1, only: [find: 1]

  def start, do: puzzle_input("2015", "11") |> find() |> find()
end
