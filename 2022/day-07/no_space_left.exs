defmodule NoSpaceLeft do
  def stack_dir_sizes("$ cd ..", [_]) do
    {:halt, nil}
  end

  def stack_dir_sizes("$ cd ..", [cwd_size, parent_size | stack]) do
    {[cwd_size], [parent_size + cwd_size | stack]}
  end

  def stack_dir_sizes("$ cd" <> _, stack) do
    {[], [0 | stack]}
  end

  def stack_dir_sizes(file_info, [cwd_size | stack]) do
    [file_size | _name] = String.split(file_info, " ")
    {[], [cwd_size + String.to_integer(file_size) | stack]}
  end

  defp calculate_dir_sizes do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.reject(&(&1 == "$ ls" || match?("dir " <> _, &1)))
    |> Stream.concat(Stream.repeatedly(fn -> "$ cd .." end))
    |> Stream.transform([0], &stack_dir_sizes/2)
    |> Enum.to_list()
  end

  def part_one do
    calculate_dir_sizes()
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def part_two do
    disk_size = 70_000_000
    update_size = 30_000_000

    dir_sizes = calculate_dir_sizes()
    need_to_free = update_size + List.last(dir_sizes) - disk_size

    dir_sizes
    |> Enum.filter(&(&1 > need_to_free))
    |> Enum.min()
  end
end

NoSpaceLeft.part_one() |> IO.inspect(label: "Part one")
NoSpaceLeft.part_two() |> IO.inspect(label: "Part two")
