defmodule Warrior do
  use GenServer

  def start_link(equips) do
    GenServer.start_link(
      __MODULE__,
      %{hp: 100, ap: get_damage(equips), dp: get_armor(equips), equips: equips, opponent: nil, game: nil}
    )
  end

  def init(state) do
    {:ok, state}
  end

  # APIs

  def opponent(self_p, pid) do
    GenServer.call(self_p, {:opponent, pid})
  end

  def fight(pid) do
    GenServer.cast(pid, :fight)
  end

  # GenServer methods
  def handle_call({:opponent, pid}, {from_pid, _}, state) do
    {:reply, :ok, %{state | opponent: pid, game: from_pid}}
  end

  def handle_cast(_, %{opponent: nil} = state) do
    {:noreply, state}
  end

  def handle_cast(:fight, %{opponent: pid, equips: equips} = state) do
    GenServer.cast(pid, {:attack, get_damage(equips)})
    {:noreply, state}
  end

  def handle_cast({:attack, ap}, %{opponent: pid} = state) do
    {:noreply, attacked(pid, ap, state)}
  end

  def handle_cast(:died, %{equips: equips, game: pid} = state) do
    GenServer.cast(pid, {:warrior_wins, get_cost(equips)})
    {:noreply, state}
  end

  # Internals

  defp attacked(opponent, ap, %{dp: dp} = state) when ap <= dp, do: suffer(opponent, 1, state)
  defp attacked(opponent, ap, %{dp: dp} = state), do: suffer(opponent, ap - dp, state)

  defp suffer(opponent, damage, %{hp: hp} = state) when hp - damage <= 0 do
    die(opponent, %{state | hp: 0})
  end

  defp suffer(opponent, damage, %{hp: hp} = state) do
    attack(opponent, %{state | hp: hp - damage})
  end

  defp attack(opponent, %{ap: ap} = state) do
    GenServer.cast(opponent, {:attack, ap})
    state
  end

  defp die(_, %{game: pid, equips: equips} = state) do
    GenServer.cast(pid, {:boss_wins, get_cost(equips)})
    state
  end

  defp get_damage(equips), do: equips |> Enum.map(& &1.damage) |> Enum.sum()

  defp get_armor(equips), do: equips |> Enum.map(& &1.armor) |> Enum.sum()

  defp get_cost(equips), do: equips |> Enum.map(& &1.cost) |> Enum.sum()
end
