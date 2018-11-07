import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 18

defmodule AdventOfCode.Level18Part1 do
  @doc """
  iex> AdventOfCode.Level18Part1.start
  814
  """
  def start do
    puzzle_input("2015", "18")
    |> parse()
    |> transform(100, 100, &get/3)
    |> Enum.count(fn {_, v} -> v == 1 end)
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} -> to_coords(line, y) end)
    |> Enum.into(%{})
  end

  def to_coords(line, y) do
    line
    |> String.to_charlist()
    |> Enum.with_index()
    |> Enum.map(fn {char, x} -> {{x, y}, _parse(char)} end)
  end

  defp _parse(?#), do: 1
  defp _parse(?.), do: 0

  def transform(map, iterations, length, get_fn) do
    Enum.reduce(0..(iterations - 1), map, fn _, orig ->
      Enum.reduce(0..(length - 1), orig, fn y, yacc ->
        Enum.reduce(0..(length - 1), yacc, fn x, acc -> mutate(orig, acc, x, y, get_fn) end)
      end)
    end)
  end

  def mutate(orig, acc, x, y, get_fn) do
    case {get_fn.(orig, x, y), sum(orig, x, y, get_fn)} do
      {1, 2} -> %{acc | {x, y} => 1}
      {1, 3} -> %{acc | {x, y} => 1}
      {0, 3} -> %{acc | {x, y} => 1}
      _ -> %{acc | {x, y} => 0}
    end
  end

  def get(map, x, y) do
    value = map[{x, y}]
    if value == nil, do: 0, else: value
  end

  def sum(map, x, y, get) do
    get.(map, x - 1, y - 1) + get.(map, x, y - 1) + get.(map, x + 1, y - 1) + get.(map, x - 1, y) + get.(map, x + 1, y) +
      get.(map, x - 1, y + 1) + get.(map, x, y + 1) + get.(map, x + 1, y + 1)
  end
end

defmodule AdventOfCode.Level18Part2 do
  import AdventOfCode.Level18Part1, only: [parse: 1, transform: 4]

  @doc """
  iex> AdventOfCode.Level18Part2.start
  924
  """
  def start do
    puzzle_input("2015", "18")
    |> parse()
    |> transform(100, 100, &get/3)
    |> corners()
    |> Enum.count(fn {_, v} -> v == 1 end)
  end

  defp corners(map) do
    m1 = %{map | {0, 0} => 1}
    m2 = %{m1 | {99, 0} => 1}
    m3 = %{m2 | {0, 99} => 1}
    %{m3 | {99, 99} => 1}
  end

  defp get(_, 0, 0), do: 1
  defp get(_, 99, 0), do: 1
  defp get(_, 0, 99), do: 1
  defp get(_, 99, 99), do: 1

  defp get(map, x, y) do
    value = map[{x, y}]
    if value == nil, do: 0, else: value
  end
end
