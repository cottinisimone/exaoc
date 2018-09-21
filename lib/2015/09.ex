import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 9
# iex -S mix  

# Part 1
# iex> AdventOfCode.Level09Part1.start
# iex> 207
defmodule AdventOfCode.Level09Part1 do
  def start do
    puzzle_input("2015", "09")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    # Filtering out "to" and "=". Useless
    |> Enum.map(fn road -> Enum.filter(road, &(&1 != "to" && &1 != "=")) end)
    # Casting distance from string to int
    |> Enum.map(fn [dep, arr, distance] -> [dep, arr, String.to_integer(distance)] end)
    |> zip_with_set()
    |> connections()
  end

  def zip_with_set(roads), do: {roads, unique(MapSet.new(), roads)}

  defp unique(set, [[dep, arr, _] | roads]), do: set |> MapSet.put(dep) |> MapSet.put(arr) |> unique(roads)

  defp unique(set, []), do: set

  defp connections({roads, cities}) do
    cities 
    |> MapSet.to_list() 
    |> Permutations.of()
    |> Enum.map(fn perms ->
      perms
      |> Enum.chunk_every(2, 1) 
      |> Enum.map(&(get_distance(roads, &1)))
    end)
    #|> Enum.filter(&(!Enum.member?(&1, nil)))
  end

  defp get_distance([[dep, arr, dist] | _], [from, to]) when dep == from and arr == to, do: dist
  defp get_distance([[_, _, _] | roads], trip), do: get_distance(roads, trip)
  defp get_distance([], _), do: nil
end

# Part 2
# iex> AdventOfCode.Level09Part2.start
# iex> 804
defmodule AdventOfCode.Level09Part2 do
  def start, do: puzzle_input("2015", "09")
end

defmodule Permutations do
  def of([]), do: [[]]
  def of(list), do: for elem <- list, rest <- of(list--[elem]), do: [elem|rest]
end

defmodule Factorial do
  def of(0), do: 1
  def of(n) when n > 0 do
    n * of(n - 1)
  end
end
