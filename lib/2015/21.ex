import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 21

defmodule AdventOfCode.Level21Part1 do
  @doc """
  iex> AdventOfCode.Level21Part1.start
  121
  """
  def start do
    puzzle_input("2015", "21")
    |> parse()
    |> spawn_battles()
  end

  def parse(input), do: input |> String.split("\n", trim: true) |> Enum.reduce(%{}, &_parse/2)

  defp _parse("Hit Points: " <> num, acc), do: Map.put(acc, :hit_points, String.to_integer(num))
  defp _parse("Damage: " <> num, acc), do: Map.put(acc, :damage, String.to_integer(num))
  defp _parse("Armor: " <> num, acc), do: Map.put(acc, :armor, String.to_integer(num))

  defp spawn_battles(boss_stats) do
    size =
      Equip.map_equip(fn weapon, armor, {ring1, ring2} ->
        equips = [weapon, armor, ring1, ring2]

        {:ok, warrior} = Warrior.start_link(equips)
        {:ok, boss} = WarriorBoss.start_link(boss_stats)

        Warrior.opponent(warrior, boss)
        WarriorBoss.opponent(boss, warrior)

        Warrior.fight(warrior)
      end)

    listen([], size)
    |> Enum.filter(fn
      {:boss_wins, _} -> false
      {:warrior_wins, _} -> true
    end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.min()
  end

  def listen(acc, size) when length(acc) == size, do: acc

  def listen(acc, size) do
    receive do
      {:"$gen_cast", msg} -> listen([msg | acc], size)
    end
  end
end

defmodule AdventOfCode.Level21Part2 do
  import AdventOfCode.Level21Part1, only: [parse: 1, listen: 2]

  @doc """
  iex> AdventOfCode.Level21Part2.start
  201
  """
  def start do
    puzzle_input("2015", "21")
    |> parse()
    |> spawn_battles()
  end

  defp spawn_battles(boss_stats) do
    size =
      Equip.map_equip(fn weapon, armor, {ring1, ring2} ->
        equips = [weapon, armor, ring1, ring2]

        {:ok, warrior} = Warrior.start_link(equips)
        {:ok, boss} = WarriorBoss.start_link(boss_stats)

        Warrior.opponent(warrior, boss)
        WarriorBoss.opponent(boss, warrior)

        Warrior.fight(warrior)
      end)

    listen([], size)
    |> Enum.filter(fn
      {:boss_wins, _} -> true
      {:warrior_wins, _} -> false
    end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.max()
  end
end
