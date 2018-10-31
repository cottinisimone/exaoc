import AdventOfCode, only: [puzzle_input: 2]
# Year 2015, Level 14

defmodule Reindeer do
  defstruct name: "", speed: 0, sprint: 0, rest: 0, distance: 0, points: 0
end

defmodule AdventOfCode.Level14Part1 do
  @doc """
  iex> AdventOfCode.Level14Part1.start
  2640
  """
  def start do
    puzzle_input("2015", "14")
    |> String.split("\n")
    |> Enum.map(fn line -> line |> String.split(" ") |> to_reindeer() end)
    |> challenge(2503)
    |> get_winner()
  end

  def to_reindeer([name, _, _, speed, _, _, sprint, _, _, _, _, _, _, rest, _]) do
    %Reindeer{name: name, speed: as_int(speed), sprint: as_int(sprint), rest: as_int(rest)}
  end

  def challenge(reindeers, seconds) do
    Enum.reduce(1..seconds, reindeers, fn sec, deers ->
      Enum.map(deers, fn deer -> fly_or_rest(deer, sec) end)
    end)
  end

  def get_winner(reindeers), do: Enum.max_by(reindeers, fn deer -> deer.distance end).distance

  def fly_or_rest(reindeer, sec), do: _fly_or_rest(reindeer, sec, 0, true)

  defp _fly_or_rest(deer, sec, acc, sign) when sign do
    if deer.sprint + acc < sec,
      do: _fly_or_rest(deer, sec, deer.sprint + acc, false),
      else: %{deer | distance: deer.distance + deer.speed}
  end

  defp _fly_or_rest(deer, sec, acc, _) do
    if deer.rest + acc < sec,
      do: _fly_or_rest(deer, sec, deer.rest + acc, true),
      else: deer
  end

  defp as_int(str), do: String.to_integer(str)
end

defmodule AdventOfCode.Level14Part2 do
  import AdventOfCode.Level14Part1, only: [to_reindeer: 1, fly_or_rest: 2]

  @doc """
  iex> AdventOfCode.Level14Part2.start
  1102
  """
  def start do
    puzzle_input("2015", "14")
    |> String.split("\n")
    |> Enum.map(fn line -> line |> String.split(" ") |> to_reindeer() end)
    |> challenge(2503)
    |> get_winner()
  end

  def challenge(reindeers, seconds) do
    Enum.reduce(1..seconds, reindeers, fn sec, deers ->
      deers
      |> Enum.map(fn deer -> fly_or_rest(deer, sec) end)
      |> (fn deers -> {deers, Enum.max_by(deers, & &1.distance).distance} end).()
      |> reward_leaders()
    end)
  end

  def reward_leaders({reindeers, max}) do
    Enum.map(reindeers, fn deer ->
      if deer.distance == max, do: %{deer | points: deer.points + 1}, else: deer
    end)
  end

  def get_winner(reindeers) do
    Enum.max_by(reindeers, fn deer -> deer.points end).points
  end
end
