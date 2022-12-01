sum_elf_cals = fn cals_string ->
  cals_string
  |> String.split()
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum()
end

sum_by_elf =
  File.read!("input.txt")
  |> String.split("\n\n")
  |> Enum.map(sum_elf_cals)

sum_by_elf
|> Enum.max()
|> IO.inspect(label: "part one")

sum_by_elf
|> Enum.sort()
|> Enum.take(-3)
|> Enum.sum()
|> IO.inspect(label: "part two")
