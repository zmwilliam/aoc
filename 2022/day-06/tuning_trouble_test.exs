Code.require_file("tuning_trouble.exs")

ExUnit.start()

defmodule TuningTroubleTest do
  use ExUnit.Case

  test "find_marker/1" do
    # bvwbjplbgvbhsrlpgdmjqwftvncz: first marker after character 5
    # nppdvjthqldpwncqszvftbrmjlhg: first marker after character 6
    # nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg: first marker after character 10
    # zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw: first marker after character 11

    assert 5 == TuningTrouble.find_marker("bvwbjplbgvbhsrlpgdmjqwftvncz", 4)
    assert 6 == TuningTrouble.find_marker("nppdvjthqldpwncqszvftbrmjlhg", 4)
    assert 10 == TuningTrouble.find_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 4)
    assert 11 == TuningTrouble.find_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 4)

    # mjqjpqmgbljsphdztnvjfqwrcgsmlb:     first marker after character 19
    # bvwbjplbgvbhsrlpgdmjqwftvncz:       first marker after character 23
    # nppdvjthqldpwncqszvftbrmjlhg:       first marker after character 23
    # nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg:  first marker after character 29
    # zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw:   first marker after character 26
    assert 19 == TuningTrouble.find_marker("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 14)
    assert 23 == TuningTrouble.find_marker("bvwbjplbgvbhsrlpgdmjqwftvncz", 14)
    assert 23 == TuningTrouble.find_marker("nppdvjthqldpwncqszvftbrmjlhg", 14)
    assert 29 == TuningTrouble.find_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 14)
    assert 26 == TuningTrouble.find_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 14)
  end
end
