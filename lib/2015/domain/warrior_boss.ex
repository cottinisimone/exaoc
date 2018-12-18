defmodule WarriorBoss do
  use GenServer

  def start_link(stats) do
    GenServer.start_link(
      __MODULE__,
      %{
        hp: Map.get(stats, :hit_points),
        ap: Map.get(stats, :damage),
        dp: Map.get(stats, :armor),
        opponent: nil
      }
    )
  end

  def init(state) do
    {:ok, state}
  end

  def opponent(self_p, pid) do
    GenServer.call(self_p, {:opponent, pid})
  end

  # GenServer methods
  def handle_call({:opponent, pid}, _, state) do
    {:reply, :ok, %{state | opponent: pid}}
  end

  def handle_cast(_, %{opponent: nil} = state) do
    {:noreply, state}
  end

  def handle_cast({:attack, ap}, %{opponent: pid} = state) do
    {:noreply, attacked(pid, ap, state)}
  end

  def attacked(opponent, ap, %{dp: dp} = state) when ap <= dp, do: suffer(opponent, 1, state)
  def attacked(opponent, ap, %{dp: dp} = state), do: suffer(opponent, ap - dp, state)

  def suffer(opponent, damage, %{hp: hp} = state) when hp - damage <= 0 do
    die(opponent, %{state | hp: 0})
  end

  def suffer(opponent, damage, %{hp: hp} = state) do
    attack(opponent, %{state | hp: hp - damage})
  end

  def attack(opponent, %{ap: ap} = state) do
    GenServer.cast(opponent, {:attack, ap})
    state
  end

  def die(opponent, state) do
    GenServer.cast(opponent, :died)
    state
  end
end
