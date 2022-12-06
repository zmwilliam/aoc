defmodule Day03 do
  defp item_priority(<<c::utf8>>) when c in ?a..?z, do: c - 96
  defp item_priority(<<c::utf8>>) when c in ?A..?Z, do: c - 38

  defp compartment_items(rucksack_items) do
    mid = rucksack_items |> String.length() |> div(2)

    rucksack_items
    |> String.codepoints()
    |> Enum.split(mid)
  end

  defp shared_items({comp_one, comp_two}) do
    diff = List.myers_difference(comp_one, comp_two)
    Keyword.get(diff, :eq)
  end

  defp read_file_lines(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def part_one() do
    "input_example.txt"
    |> read_file_lines()
    |> Enum.map(&compartment_items/1)
    |> Enum.map(&shared_items/1)
    |> List.flatten()
    |> Enum.map(&item_priority/1)
    |> Enum.sum()
  end

  def part_two() do
    "input.txt"
    |> read_file_lines()
    |> Enum.map(&String.codepoints/1)
    |> Enum.chunk_every(3)
    |> Enum.map(fn [a, b, c] ->
      ab = a -- a -- b
      ac = a -- a -- c
      Enum.uniq(ab -- ab -- ac)
    end)
    |> List.flatten()
    |> Enum.map(&item_priority/1)
    |> Enum.sum()
  end
end

Day03.part_one() |> IO.inspect(label: "Part one")
Day03.part_two() |> IO.inspect(label: "Part two")
