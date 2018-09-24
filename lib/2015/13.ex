import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 13
# iex -S mix  

# Part 1
# iex> AdventOfCode.Level13Part1.start
# iex> 709
defmodule AdventOfCode.Level13Part1 do
  def start, do: puzzle_input("2015", "13") |> to_command() |> logic()

  def to_command(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn x -> x |> String.slice(0..-2) |> String.split(" ") end)
    |> _to_command()
  end

  # Better to be more or less strict?
  defp _to_command([[sub, _, "gain", points, _, _, _, _, _, _, who] | next]) do
    [{sub, ?+, String.to_integer(points), who} | _to_command(next)]
  end

  defp _to_command([[sub, _, "lose", points, _, _, _, _, _, _, who] | next]) do
    [{sub, ?-, String.to_integer(points), who} | _to_command(next)]
  end

  defp _to_command([]), do: []

  def logic(commands) do
    Enum.map(commands, fn {a, _, _, _} -> a end)
    |> Enum.uniq()
    |> Permutations.of()
    |> Enum.map(&Chunk.circular/1)
    |> Enum.map(fn perm -> to_points(perm, commands) |> Enum.sum() end)
    |> Enum.max()
  end

  defp to_points(array, commands) do
    Enum.flat_map(array, fn [sub, who] -> get_points(commands, sub, who) end)
  end

  defp get_points(commands, sub1, sub2) do 
    commands 
    |> Enum.filter(fn {subject, _, _, neighbor} -> 
      (subject == sub1 && neighbor == sub2) || (subject == sub2 && neighbor == sub1)
    end) 
    |> Enum.map(fn {_, sign, points, _} -> if sign == ?+, do: points, else: (points * -1) end)
  end
end

# Part 2
# iex> AdventOfCode.Level13Part2.start
# iex> 668
defmodule AdventOfCode.Level13Part2 do
  import AdventOfCode.Level13Part1, only: [to_command: 1, logic: 1]

  # After "Me" it's a bit slow..
  def start, do: puzzle_input("2015", "13") |> to_command() |> add_myself() |> logic()

  def add_myself(commands) do
    Enum.map(commands, fn {a, _, _, _} -> a end)
    |> Enum.uniq()
    |> Enum.reduce(commands, fn who, cmds -> [{"Me", ?+, 0, who} | cmds] end)
  end

end

defmodule Chunk do
  def circular([head | tail]), do: _circular(tail, head, head)
  defp _circular([head | tail], next, first), do: [[next, head] | _circular(tail, head, first)]
  defp _circular([], next, first), do: [[next, first]]
end
