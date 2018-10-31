import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 9

defmodule AdventOfCode.Level09Part1 do
  @doc """
  iex> AdventOfCode.Level09Part1.start
  207
  """
  def start do
    puzzle_input("2015", "09")
    |> String.split("\n")
    |> calculate()
    |> Enum.min()
  end

  def calculate(input) do
    input
    |> Enum.map(&String.split(&1, " "))
    # Filtering out "to" and "=". Useless
    |> Enum.map(fn road -> Enum.filter(road, &(&1 != "to" && &1 != "=")) end)
    # Casting distance from string to int
    |> Enum.map(fn [dep, arr, distance] -> [dep, arr, String.to_integer(distance)] end)
    |> zip_with_set()
    |> connections()
  end

  defp zip_with_set(roads), do: {roads, unique(MapSet.new(), roads)}

  defp unique(set, []), do: set

  defp unique(set, [[dep, arr, _] | roads]),
    do: set |> MapSet.put(dep) |> MapSet.put(arr) |> unique(roads)

  defp connections({roads, cities}) do
    cities
    |> MapSet.to_list()
    |> Permutations.of()
    |> Enum.map(fn perms ->
      perms
      |> Enum.chunk_every(2, 1)
      # Removing last element (chunk leaves last element as single..)
      |> Enum.drop(-1)
      |> Enum.map(&get_distance(roads, &1))
    end)
    |> Enum.filter(&(!Enum.member?(&1, nil)))
    |> Enum.map(&Enum.sum(&1))
  end

  defp get_distance([[dep, arr, dist] | roads], [from, to]) do
    if (dep == from && arr == to) || (dep == to && arr == from),
      do: dist,
      else: get_distance(roads, [from, to])
  end

  defp get_distance([], _), do: nil
end

defmodule AdventOfCode.Level09Part2 do
  import AdventOfCode.Level09Part1, only: [calculate: 1]

  @doc """
  iex> AdventOfCode.Level09Part2.start
  804
  """
  def start do
    puzzle_input("2015", "09")
    |> String.split("\n")
    |> calculate()
    |> Enum.max()
  end
end

defmodule Permutations do
  def of([]), do: [[]]
  def of(list), do: for(elem <- list, rest <- of(list -- [elem]), do: [elem | rest])
end
