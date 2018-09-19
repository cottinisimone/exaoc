import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 3
# iex -S mix  

# Part 1
# iex> AdventOfCode.Level03Part1.start
# iex> 2565
defmodule AdventOfCode.Level03Part1 do
  def start do
    puzzle_input("2015", "03")
    |> String.to_charlist()
    |> Enum.scan({0, 0}, &take_step(&1, &2))
    |> Enum.uniq_by(fn {x, y} -> "#{x};#{y}" end)
    |> Enum.count()
  end

  def take_step(?^, {x, y}), do: {x, y + 1}
  def take_step(?>, {x, y}), do: {x + 1, y}
  def take_step(?v, {x, y}), do: {x, y - 1}
  def take_step(?<, {x, y}), do: {x - 1, y}
end

# Part 2
# iex> AdventOfCode.Level03Part2.start
# iex> 2639
defmodule AdventOfCode.Level03Part2 do
  import AdventOfCode.Level03Part1, only: [take_step: 2]

  def start do
    puzzle_input("2015", "03")
    |> String.to_charlist()
    |> Enum.with_index(0)
    |> Enum.split_with(fn {_, index} -> rem(index, 2) == 0 end)
    |> take_step_both()
    |> Enum.uniq_by(fn {x, y} -> "#{x};#{y}" end)
    |> Enum.count()
  end

  def take_step_both({robot, santa}) do
    Enum.concat(
      Enum.scan(robot, {0, 0}, fn {direction, _}, position -> take_step(direction, position) end),
      Enum.scan(santa, {0, 0}, fn {direction, _}, position -> take_step(direction, position) end)
    )
  end
end
