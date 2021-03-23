defmodule MaqeBot.CLI do
  def main(args) do
    walking_code = List.first(args)
    %MaqeBot.Position{x: x, y: y, direction: direction} = MaqeBot.run(walking_code)
    normalized_direction = direction |> to_string() |> String.capitalize()

    IO.puts("X: #{x} Y: #{y} Direction: #{normalized_direction}")
  end
end
