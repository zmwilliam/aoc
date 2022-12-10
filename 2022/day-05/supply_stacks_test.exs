Code.require_file("supply_stacks.exs")

ExUnit.start()

defmodule SupplyStacksTest do
  use ExUnit.Case

  test "parse_stacks/1" do
    stacks = "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 "

    expected = %{
      1 => ["N", "Z"],
      2 => ["D", "C", "M"],
      3 => ["P"]
    }

    assert ^expected = SupplyStacks.parse_stacks(stacks)
  end

  test "parse_instructions/1" do
    instructions = "move 1 from 2 to 1\nmove 3 from 1 to 3\nmove 17 from 8 to 7\n"

    assert [
             %{"move" => 1, "from" => 2, "to" => 1},
             %{"move" => 3, "from" => 1, "to" => 3},
             %{"move" => 17, "from" => 8, "to" => 7}
           ] == SupplyStacks.parse_instructions(instructions)
  end

  test "execute_instruction/2" do
    initial_stacks = %{
      1 => ["N", "Z"],
      2 => ["D", "C", "M"],
      3 => ["P"]
    }

    instruction = %{"move" => 1, "from" => 2, "to" => 1}

    expected_stacks = %{
      1 => ["D", "N", "Z"],
      2 => ["C", "M"],
      3 => ["P"]
    }

    assert expected_stacks == SupplyStacks.execute_instruction(initial_stacks, instruction)
  end

  test "execute_all_instructions/2" do
    initial_stacks = %{
      1 => ["N", "Z"],
      2 => ["D", "C", "M"],
      3 => ["P"]
    }

    instructions = [
      %{"from" => 2, "move" => 1, "to" => 1},
      %{"from" => 1, "move" => 3, "to" => 3},
      %{"from" => 2, "move" => 2, "to" => 1},
      %{"from" => 1, "move" => 1, "to" => 2}
    ]

    expected_stacks = %{
      1 => ["C"],
      2 => ["M"],
      3 => ["Z", "N", "D", "P"]
    }

    assert expected_stacks ==
             SupplyStacks.execute_all_instructions(%{
               stacks: initial_stacks,
               instructions: instructions
             })
  end
end
