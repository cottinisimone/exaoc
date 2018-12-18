defmodule Equip do
  defstruct cost: 0, damage: 0, armor: 0

  defp equip(cost, damage, armor), do: %Equip{cost: cost, damage: damage, armor: armor}

  def equipments do
    %{
      weapons: [equip(8, 4, 0), equip(10, 5, 0), equip(25, 6, 0), equip(40, 7, 0), equip(74, 8, 0)],
      armors: [equip(0, 0, 0), equip(13, 0, 1), equip(31, 0, 2), equip(53, 0, 3), equip(75, 0, 4), equip(102, 0, 5)],
      rings: [
        equip(0, 0, 0),
        equip(0, 0, 0),
        equip(25, 1, 0),
        equip(50, 2, 0),
        equip(100, 3, 0),
        equip(20, 0, 1),
        equip(40, 0, 2),
        equip(80, 0, 3)
      ]
    }
  end

  def map_equip(function), do: map(equipments(), function)

  defp map(equipments, function) do
    for(
      weapon <- Map.get(equipments, :weapons),
      armor <- Map.get(equipments, :armors),
      rings <- equipments |> Map.get(:rings) |> Combinations.combs(2) |> Enum.map(&List.to_tuple/1),
      do: function.(weapon, armor, rings)
    )
    |> Enum.count()
  end
end
