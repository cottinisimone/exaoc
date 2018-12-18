defmodule Permutations do
  def of([]), do: [[]]
  def of(list), do: for(elem <- list, rest <- of(list -- [elem]), do: [elem | rest])

  def uniq(list), do: Enum.uniq(of(list))
end
