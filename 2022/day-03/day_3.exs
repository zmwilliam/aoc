defmodule Day03 do
  def item_priority(<<c::utf8>>) when c in ?a..?z, do: c - 96
  def item_priority(<<c::utf8>>) when c in ?A..?Z, do: c - 38

  def compartment_items(rucksack_items) do
    mid = rucksack_items |> String.length() |> div(2)

    rucksack_items
    |> String.codepoints()
    |> Enum.split(mid)
  end

  def shared_items({comp_one, comp_two}) do
    diff = List.myers_difference(comp_one, comp_two)
    Keyword.get(diff, :eq)
  end

  def part_one() do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&compartment_items/1)
    |> Enum.map(&shared_items/1)
    |> List.flatten()
    |> Enum.map(&item_priority/1)
    |> Enum.sum()
  end
end

Day03.part_one() |> IO.inspect(label: "Part one")
