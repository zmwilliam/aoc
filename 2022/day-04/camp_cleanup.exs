defmodule CampCleanup do
  defp section_to_range_list(section) do
    section
    |> String.split("-")
    |> then(fn [first, last] ->
      range = Range.new(String.to_integer(first), String.to_integer(last))
      Enum.to_list(range)
    end)
  end

  def part_one do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [first_sections, second_section] ->
      [
        section_to_range_list(first_sections),
        section_to_range_list(second_section)
      ]
    end)
    |> Enum.count(fn [s1, s2] ->
      Enum.empty?(s1 -- s2) or Enum.empty?(s2 -- s1)
    end)
  end
end

CampCleanup.part_one() |> IO.inspect(label: "Part one")
