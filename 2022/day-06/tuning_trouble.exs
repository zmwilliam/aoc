defmodule TuningTrouble do
  def find_marker(input) do
    input
    |> String.graphemes()
    |> Enum.with_index(1)
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.find(fn quad ->
      uniq = Enum.uniq_by(quad, &elem(&1, 0))
      Enum.count(uniq) == 4
    end)
    |> List.last()
    |> elem(1)
  end

  def part_one do
    "input.txt"
    |> File.read!()
    |> find_marker()
  end
end

TuningTrouble.part_one() |> IO.inspect(label: "Part one")
