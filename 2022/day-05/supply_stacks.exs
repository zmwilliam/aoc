defmodule SupplyStacks do
  def parse_instructions(raw_instructions) do
    raw_instructions
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(~r{\d+}, include_captures: true, trim: true)
      |> Enum.chunk_every(2)
      |> Enum.into(%{}, fn [a, b] -> {String.trim(a), String.to_integer(b)} end)
    end)
  end

  def parse_stacks(raw_stacks) do
    raw_stacks
    |> String.split("\n")
    |> Enum.reverse()
    |> tl()
    |> Enum.flat_map(fn line ->
      line
      |> String.split([" ", "    "])
      |> Enum.with_index(1)
    end)
    |> Enum.reduce(%{}, fn
      {<<"[", crane::binary-size(1), "]">>, idx}, acc ->
        Map.update(acc, idx, [crane], &[crane | &1])

      _, acc ->
        acc
    end)
  end

  def parse_input([stacks, instructions]) do
    %{
      stacks: parse_stacks(stacks),
      instructions: parse_instructions(instructions)
    }
  end

  def execute_all_instructions(
        %{stacks: initial_stacks, instructions: instructions},
        crate_mover_model
      ) do
    Enum.reduce(instructions, initial_stacks, fn instruction, stack ->
      %{"move" => move, "from" => from, "to" => to} = instruction
      {crates_to_move, stack} = pop_in(stack, [from, Access.slice(0..(move - 1))])
      crate_mover = &move_crates(crate_mover_model, crates_to_move, &1)
      Map.update(stack, to, crates_to_move, crate_mover)
    end)
  end

  defp move_crates(9000, crates, stack), do: Enum.reverse(crates) ++ stack
  defp move_crates(9001, crates, stack), do: crates ++ stack

  defp top_crates(stacks) do
    stacks
    |> Map.values()
    |> Enum.map_join(&List.first/1)
  end

  defp read_file_and_parse_inputs do
    "input.txt"
    |> File.read!()
    |> String.split("\n\n")
    |> parse_input()
  end

  def part_one do
    read_file_and_parse_inputs()
    |> execute_all_instructions(9000)
    |> top_crates()
  end

  def part_two do
    read_file_and_parse_inputs()
    |> execute_all_instructions(9001)
    |> top_crates()
  end
end

SupplyStacks.part_one() |> IO.inspect(label: "Part One")
SupplyStacks.part_two() |> IO.inspect(label: "Part Two")
