sum_elf_cals = fn cals_string ->
  cals_string
  |> String.split()
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum()
end

File.read!("input.txt")
|> String.split("\n\n")
|> Enum.map(sum_elf_cals)
|> Enum.max()
|> IO.puts()
