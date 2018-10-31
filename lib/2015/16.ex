import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 16

defmodule Sue do
  defstruct number: 0, evidences: MapSet.new()
end

defmodule AdventOfCode.Level16Part1 do
  @evidences [
    {"children", 3},
    {"cats", 7},
    {"samoyeds", 2},
    {"pomeranians", 3},
    {"akitas", 0},
    {"vizslas", 0},
    {"goldfish", 5},
    {"trees", 3},
    {"cars", 2},
    {"perfumes", 1}
  ]

  @doc """
  iex> AdventOfCode.Level16Part1.start
  213
  """
  def start do
    puzzle_input("2015", "16")
    |> parse()
    |> to_sue()
    |> intersect(@evidences)
    |> Enum.max_by(fn {_, c} -> c end)
    |> (fn {nr, _} -> nr end).()
  end

  def parse(input) do
    input
    |> String.replace(~r/(Sue|,|:)/, "")
    |> String.split("\n")
    |> Enum.map(&(&1 |> String.trim() |> String.split(" ")))
  end

  def to_sue(sues), do: Enum.map(sues, &_to_sue/1)

  defp _to_sue([nr, ev1, evn1, ev2, evn2, ev3, evn3]) do
    %Sue{
      number: _int(nr),
      evidences: Enum.into([{ev1, _int(evn1)}, {ev2, _int(evn2)}, {ev3, _int(evn3)}], MapSet.new())
    }
  end

  defp _int(str), do: String.to_integer(str)

  def intersect(sues, evidences) do
    Enum.map(sues, fn sue ->
      {sue.number, Enum.count(evidences, &MapSet.member?(sue.evidences, &1))}
    end)
  end
end

defmodule AdventOfCode.Level16Part2 do
  import AdventOfCode.Level16Part1, only: [parse: 1, to_sue: 1]

  @doc """
  iex> AdventOfCode.Level16Part2.start
  323
  """
  def start do
    puzzle_input("2015", "16")
    |> parse()
    |> to_sue()
    |> intersect(evidences())
    |> Enum.max_by(fn {_, c} -> c end)
    |> (fn {nr, _} -> nr end).()
  end

  def intersect(sues, evds) do
    Enum.map(sues, fn sue ->
      {sue.number,
       Enum.count(sue.evidences, fn {sue_ev, evn} ->
         Enum.find(evds, fn {ev, fun} -> sue_ev == ev && fun.(evn) end) != nil
       end)}
    end)
  end

  def evidences,
    do: [
      {"children", &(&1 == 3)},
      {"cats", &(&1 > 7)},
      {"samoyeds", &(&1 == 2)},
      {"pomeranians", &(&1 < 3)},
      {"akitas", &(&1 == 0)},
      {"vizslas", &(&1 == 0)},
      {"goldfish", &(&1 < 5)},
      {"trees", &(&1 > 3)},
      {"cars", &(&1 == 2)},
      {"perfumes", &(&1 == 1)}
    ]
end
