import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 5
# iex -S mix  

# Part 1
# iex> AdventOfCode.Level05Part1.start
# iex> 258
defmodule AdventOfCode.Level05Part1 do
  def start, do: puzzle_input("2015", "05") |> String.split("\n") |> count_nice()

  def count_nice(rows), do: Enum.filter(rows, &is_nice?/1) |> Enum.count()

  defp is_nice?(string) do
    charlist = String.to_charlist(string)
    chunks = String.codepoints(string) |> Enum.chunk_every(2, 1)
    has_three_vowels?(charlist) && has_twice_letters?(chunks) && only_valid_pairs?(chunks)
  end

  # Vowels check
  defp has_three_vowels?(charlist), do: Enum.filter(charlist, &is_vowel?/1) |> Enum.count() >= 3
  defp is_vowel?(char) when char in 'aeiou', do: true
  defp is_vowel?(_), do: false

  # Twice letters check
  defp has_twice_letters?(chunks) do
    chunks
    |> Enum.filter(&is_double?/1)
    |> Enum.count() > 0
  end

  defp is_double?([a, b]), do: a == b
  defp is_double?(_), do: false

  # If contains one of invalid char pairs
  defp only_valid_pairs?(chunks) do
    chunks
    |> Enum.map(&Enum.join/1)
    |> Enum.filter(&(&1 == "ab" || &1 == "cd" || &1 == "pq" || &1 == "xy"))
    |> Enum.count() == 0
  end
end

# Part 2
# iex> AdventOfCode.Level05Part2.start
# iex> 53
defmodule AdventOfCode.Level05Part2 do
  def start,
    do:
      puzzle_input("2015", "05") |> String.split("\n") |> Enum.filter(&is_nice/1) |> Enum.count()

  def is_nice(str) do
    has_couple_twice?(String.codepoints(str)) && has_palindrome?(String.to_charlist(str))
  end

  # Checking if a string of 2 elements ('xy' or 'aa') is repeated at least 2 times in provided string
  def has_couple_twice?(codepoints) do
    codepoints
    |> Enum.chunk_every(2, 1)
    |> Enum.dedup()
    |> Enum.map(&Enum.join/1)
    |> filter
    |> Enum.count() > 0
  end

  defp filter(collection), do: Enum.filter(collection, &(count(collection, &1) > 1))
  defp count(collection, value), do: collection |> Enum.filter(&(&1 == value)) |> Enum.count()

  # Checking if provided string contains at least one 3-char string formatted as 'xyx' or 'aba'
  def has_palindrome?(charlist) do
    charlist |> Enum.chunk_every(3, 1) |> Enum.filter(&is_palindrome?/1) |> Enum.count() > 0
  end

  defp is_palindrome?([a, b, a]) when a != b, do: true
  defp is_palindrome?(_), do: false
end
