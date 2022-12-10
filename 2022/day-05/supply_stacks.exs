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

  def execute_instruction(stack, %{"move" => move, "from" => from, "to" => to}) do
    {crates_to_move, stack} = pop_in(stack, [from, Access.slice(0..(move - 1))])
    Map.update(stack, to, crates_to_move, &(Enum.reverse(crates_to_move) ++ &1))
  end

  def execute_all_instructions(%{stacks: initial_stacks, instructions: instructions}) do
    Enum.reduce(instructions, initial_stacks, fn instruction, stack ->
      SupplyStacks.execute_instruction(stack, instruction)
    end)
  end

  defp top_crates(stacks) do
    stacks
    |> Map.values()
    |> Enum.map_join(&List.first/1)
  end

  def part_one do
    "input.txt"
    |> File.read!()
    |> String.split("\n\n")
    |> parse_input()
    |> execute_all_instructions()
    |> top_crates()
  end
end

SupplyStacks.part_one() |> IO.inspect()
