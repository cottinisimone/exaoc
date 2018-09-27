import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 15
# iex -S mix  

defmodule Ingredient do
  defstruct name: "", capacity: 0, durability: 0, flavor: 0, texture: 0, calories: 0
end

# Part 1
# iex> AdventOfCode.Level15Part1.start
# iex> 18965440
defmodule AdventOfCode.Level15Part1 do
  def start do
    puzzle_input("2015", "15") |> get_ingredients() |> mix(&calculate/1) |> Enum.max()
  end

  def get_ingredients(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn x ->
      x |> String.replace(":", "") |> String.replace(",", "") |> String.split(" ") |> _to_ingredient()
    end)
  end

  defp _to_ingredient([name, "capacity", cap, "durability", d, "flavor", f, "texture", t, "calories", cal]) do
    %{
      name: name,
      capacity: String.to_integer(cap),
      durability: String.to_integer(d),
      flavor: String.to_integer(f),
      texture: String.to_integer(t),
      calories: String.to_integer(cal)
    }
  end

  # Tried to do it using HOF but is sensibly slower
  def mix(ingredients, fun) do
    for w <- 0..100, x <- 0..100, y <- 0..100, z <- 0..100, w + x + y + z == 100 do
      fun.(Enum.zip(ingredients, [w, x, y, z]))
    end
  end

  def calculate(zip) do
    _sum(zip, & &1.capacity) * _sum(zip, & &1.durability) * _sum(zip, & &1.flavor) * _sum(zip, & &1.texture)
  end

  defp _sum(zip, fun) do
    sum = Enum.reduce(zip, 0, fn {ingr, qnty}, acc -> fun.(ingr) * qnty + acc end)
    if sum < 0, do: 0, else: sum
  end
end

# Part 2
# iex> AdventOfCode.Level15Part2.start
# iex> 15862900
defmodule AdventOfCode.Level15Part2 do
  import AdventOfCode.Level15Part1, only: [get_ingredients: 1, mix: 2, calculate: 1]

  def start do
    puzzle_input("2015", "15") |> get_ingredients() |> mix(&_count_calories/1) |> Enum.max()
  end

  defp _count_calories(zip),
    do: _calculate(zip, Enum.reduce(zip, 0, fn {ingr, qnty}, acc -> ingr.calories * qnty + acc end))

  def _calculate(_, calories) when calories != 500, do: 0
  def _calculate(zip, _), do: calculate(zip)
end
