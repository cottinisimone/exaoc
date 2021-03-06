defmodule AdventOfCode do
  def puzzle_input(year, day), do: File.read!("data/#{year}/#{day}.txt")

  def md5(text), do: :crypto.hash(:md5, text) |> Base.encode16()

  def now(), do: :os.system_time(:micro_seconds)
end
