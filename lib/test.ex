defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end

defmodule Test do
  def time() do
    :timer.tc(&ciao/0)
  end

  def ciao() do
    Enum.map(1..1_000, fn x ->
      Enum.map(1..1_000, fn y ->
        nil
      end)
    end)

    nil
  end
end
