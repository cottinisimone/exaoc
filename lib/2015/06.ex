import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 6
# iex -S mix  

# Part 1
# iex> AdventOfCode.Level06Part1.start
# iex> 543903

defmodule AdventOfCode.Level06Part1 do
  @regex ~r/(toggle|turn off|turn on)\s+([0-9]{1,}),([0-9]{1,})\s+through\s+([0-9]{1,}),([0-9]{1,})/

  def start do
    puzzle_input("2015", "06")
    |> String.split("\n")
    |> Enum.map(&(Regex.scan(@regex, &1) |> List.first()))
    |> process(MapSet.new())
    |> Enum.count()
  end

  def process([cmd | cmds], lights), do: process(cmds, handle(cmd, lights))
  def process([], lights), do: lights

  def handle([_, "toggle", x1, y1, x2, y2], lights), do: toggle(int(x1), int(y1), int(x2), int(y2), lights)
  def handle([_, "turn on", x1, y1, x2, y2], lights), do: turn_on(int(x1), int(y1), int(x2), int(y2), lights)
  def handle([_, "turn off", x1, y1, x2, y2], lights), do: turn_off(int(x1), int(y1), int(x2), int(y2), lights)
  def handle(_), do: raise("Unknown command")

  def toggle(x1, y1, x2, y2, lights) do
    Enum.reduce(x1..x2, lights, fn x, xacc ->
      Enum.reduce(y1..y2, xacc, fn y, yacc ->
        coords = "#{x};#{y}"
        if MapSet.member?(yacc, coords), do: MapSet.delete(yacc, coords), else: MapSet.put(yacc, coords)
      end)
    end)
  end

  def turn_on(x1, y1, x2, y2, lights) do
    Enum.reduce(x1..x2, lights, fn x, xacc ->
      Enum.reduce(y1..y2, xacc, fn y, yacc ->
        coords = "#{x};#{y}"
        if !MapSet.member?(yacc, coords), do: MapSet.put(yacc, coords), else: yacc
      end)
    end)
  end

  def turn_off(x1, y1, x2, y2, lights) do
    Enum.reduce(x1..x2, lights, fn x, xacc ->
      Enum.reduce(y1..y2, xacc, fn y, yacc ->
        coords = "#{x};#{y}"
        if MapSet.member?(yacc, coords), do: MapSet.delete(yacc, coords), else: yacc
      end)
    end)
  end

  def int(v), do: String.to_integer(v)
end

# Part 2
# iex> AdventOfCode.Level06Part2.start
# iex> 
defmodule AdventOfCode.Level06Part2 do
  def start, do: puzzle_input("2015", "06")
end
