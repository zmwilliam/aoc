defmodule CampCleanup do
  defp section_to_range(section) do
    section
    |> String.split("-")
    |> then(fn [first, last] ->
      Range.new(String.to_integer(first), String.to_integer(last))
    end)
  end

  defp read_file_and_parse() do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
  end

  def part_one do
    read_file_and_parse()
    |> Enum.map(fn sections ->
      sections
      |> Enum.map(&section_to_range/1)
      |> Enum.map(&Enum.to_list/1)
    end)
    |> Enum.count(fn [s1, s2] ->
      Enum.empty?(s1 -- s2) or Enum.empty?(s2 -- s1)
    end)
  end

  def part_two do
    read_file_and_parse()
    |> Enum.map(fn sections ->
      Enum.map(sections, &section_to_range/1)
    end)
    |> Enum.count(fn [r1, r2] ->
      !Range.disjoint?(r1, r2)
    end)
  end
end

CampCleanup.part_one() |> IO.inspect(label: "Part one")
CampCleanup.part_two() |> IO.inspect(label: "Part two")
