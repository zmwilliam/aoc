Code.require_file("tuning_trouble.exs")

ExUnit.start()

defmodule TuningTroubleTest do
  use ExUnit.Case

  test "find_marker/1" do
    # bvwbjplbgvbhsrlpgdmjqwftvncz: first marker after character 5
    # nppdvjthqldpwncqszvftbrmjlhg: first marker after character 6
    # nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg: first marker after character 10
    # zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw: first marker after character 11

    assert 5 == TuningTrouble.find_marker("bvwbjplbgvbhsrlpgdmjqwftvncz")
    assert 6 == TuningTrouble.find_marker("nppdvjthqldpwncqszvftbrmjlhg")
    assert 10 == TuningTrouble.find_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
    assert 11 == TuningTrouble.find_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
  end
end
