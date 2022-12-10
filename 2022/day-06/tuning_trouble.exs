defmodule TuningTrouble do
  def find_marker(input, marker_size) do
    input
    |> String.graphemes()
    |> Enum.with_index(1)
    |> Enum.chunk_every(marker_size, 1, :discard)
    |> Enum.find(fn quad ->
      uniq = Enum.uniq_by(quad, &elem(&1, 0))
      Enum.count(uniq) == marker_size
    end)
    |> List.last()
    |> elem(1)
  end

  def run(marker_size) do
    "input.txt"
    |> File.read!()
    |> find_marker(marker_size)
  end
end

TuningTrouble.run(4) |> IO.inspect(label: "Part one")
TuningTrouble.run(14) |> IO.inspect(label: "Part two")
