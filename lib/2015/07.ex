import AdventOfCode, only: [puzzle_input: 2]
use Bitwise, only_operators: true
# Year 2015, Level 7

defmodule AdventOfCode.Level07Part1 do
  @doc """
  iex> AdventOfCode.Level07Part1.start
  3176
  """
  def start do
    puzzle_input("2015", "07")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> circuit(%{}, [])
    |> Map.get("a")
  end

  def circuit([], ports, []), do: ports
  def circuit([], ports, acc), do: circuit(Enum.reverse(acc), ports, [])

  def circuit([cmd | commands], ports, acc) do
    case dispatch(ports, cmd) do
      {:done, ports} -> circuit(commands, ports, acc)
      {:nope, ports} -> circuit(commands, ports, [cmd | acc])
    end
  end

  # left &&& right
  defp dispatch(ports, [in1, "AND", in2, "->", out]) do
    apply(ports, in1, in2, out, &(&1 &&& &2))
  end

  # left ||| right
  defp dispatch(ports, [in1, "OR", in2, "->", out]) do
    apply(ports, in1, in2, out, &(&1 ||| &2))
  end

  # ~~~arg
  defp dispatch(ports, ["NOT", in_, "->", out]) do
    apply(ports, in_, out, &(~~~&1))
  end

  # left >>> right
  defp dispatch(ports, [in_, "RSHIFT", val, "->", out]) do
    apply(ports, in_, out, &(&1 >>> String.to_integer(val)))
  end

  # left <<< right
  defp dispatch(ports, [in_, "LSHIFT", val, "->", out]) do
    apply(ports, in_, out, &(&1 <<< String.to_integer(val)))
  end

  # Dispatch value to port
  defp dispatch(ports, [in_, "->", out]) do
    apply(ports, in_, out, & &1)
  end

  # Unknown
  defp dispatch(_, cmd), do: raise("Unknown command #{cmd}")

  defp apply(ports, in1, in2, out, fun) do
    {r1, r2} = {resolve(ports, in1), resolve(ports, in2)}

    if r1 == nil || r2 == nil,
      do: {:nope, ports},
      else: {:done, Map.put(ports, out, fun.(r1, r2))}
  end

  defp apply(ports, in1, out, fun) do
    r1 = resolve(ports, in1)
    if r1 == nil, do: {:nope, ports}, else: {:done, Map.put(ports, out, fun.(r1))}
  end

  defp resolve(ports, str) do
    case Integer.parse(str) do
      {x, ""} -> x
      _ -> Map.get(ports, str)
    end
  end
end

defmodule AdventOfCode.Level07Part2 do
  import AdventOfCode.Level07Part1, only: [circuit: 3]

  @doc """
  iex> AdventOfCode.Level07Part2.start
  14710
  """
  def start do
    puzzle_input("2015", "07")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    # Simplest solution. Just to avoid rewrite Part 1 methods..
    |> Enum.filter(&(List.last(&1) != "b"))
    |> circuit(%{"b" => 3176}, [])
    |> Map.get("a")
  end

  # Best solution (IMHO, to keep functional approach) is to add a twin method of this:
  #
  #   # Dispatch value to port
  #   defp dispatch(ports, [in_, "->", out]) do
  #     apply(ports, in_, out, &(&1))
  #   end
  #
  # Like this:
  #   defp dispatch(ports, [in_, "->", "b"]) do
  #     apply(ports, "3176", "b", &(&1))
  #   end
end
