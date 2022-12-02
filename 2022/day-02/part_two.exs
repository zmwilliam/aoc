# A = Rock
# B = Paper
# C = Scissors
# Rock > Scissors > Paper > Rock
# 
# X lose
# Y draw
# Z win

score = %{
  "X" => 0,
  "Y" => 3,
  "Z" => 6
}

shape_score = %{
  "A" => 1,
  "B" => 2,
  "C" => 3
}

win_condition = [
  {"A", "C"},
  {"B", "A"},
  {"C", "B"}
]

"input.txt"
|> File.stream!()
|> Enum.map(&String.split/1)
|> Enum.map(fn [opponent, expected_result] ->
  mine =
    case expected_result do
      "X" ->
        win_condition
        |> Enum.find(fn {w, _l} -> w == opponent end)
        |> Kernel.elem(1)

      "Y" ->
        opponent

      "Z" ->
        win_condition
        |> Enum.find(fn {_, l} -> l == opponent end)
        |> Kernel.elem(0)
    end

  score[expected_result] + shape_score[mine]
end)
|> Enum.sum()
|> IO.inspect(label: "Part two")
