# A X = Rock
# B Y = Paper
# C Z = Scissors
# Rock > Scissors > Paper > Rock

win_score = 6
draw_score = 3
lose_score = 0

shape_score = %{
  "X" => 1,
  "Y" => 2,
  "Z" => 3
}

win_condition = [
  {"X", "C"},
  {"Y", "A"},
  {"Z", "B"},
  {"A", "Z"},
  {"B", "X"},
  {"C", "Y"}
]

"input.txt"
|> File.stream!()
|> Enum.map(&String.split/1)
|> Enum.map(fn [opponent, mine] ->
  game_score =
    cond do
      Enum.member?(win_condition, {mine, opponent}) -> win_score
      Enum.member?(win_condition, {opponent, mine}) -> lose_score
      true -> draw_score
    end

  game_score + shape_score[mine]
end)
|> Enum.sum()
|> IO.inspect(label: "Part one")
