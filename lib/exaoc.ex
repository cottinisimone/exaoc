defmodule AdventOfCode do
  def puzzle_input(year, day), do: File.read!("data/#{year}/#{day}.txt")
  def md5(text), do: :crypto.hash(:md5, text) |> Base.encode16()
  def now(), do: :os.system_time(:micro_seconds)
end

defmodule Combinations do
  def of(enum), do: 0..Enum.count(enum) |> Stream.flat_map(&combs(enum, &1)) |> Enum.to_list()

  def uniq(enum), do: 0..Enum.count(enum) |> Stream.flat_map(&combs_unique(enum, &1)) |> Enum.to_list()

  def combs(enum, n), do: List.last(_combs(enum, [[[]] | List.duplicate([], n)]))

  def combs_unique(enum, n), do: combs(enum, n) |> Enum.uniq()

  defp _combs(enum, duplicate) do
    Enum.to_list(enum)
    |> List.foldr(duplicate, fn x, next ->
      :lists.zipwith(
        &:lists.append/2,
        [[] | for(l <- :lists.droplast(next), do: for(s <- l, do: [x | s]))],
        next
      )
    end)
  end
end
