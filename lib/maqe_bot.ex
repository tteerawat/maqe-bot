defmodule MaqeBot do
  alias MaqeBot.{CommandsBuilder, Position}

  @doc """
  Returns the last position of Maqe Bot from the given walking code.

  ## Examples

      iex> MaqeBot.run("RW15RW1")
      %MaqeBot.Position{x: 15, y: -1, direction: :south}

      iex> MaqeBot.run("W5RW5RW2RW1R")
      %MaqeBot.Position{x: 4, y: 3, direction: :north}

      iex> MaqeBot.run("RRW11RLLW19RRW12LW1")
      %MaqeBot.Position{x: 7, y: -12, direction: :south}

      iex> MaqeBot.run("LLW100W50RW200W10")
      %MaqeBot.Position{x: -210, y: -150, direction: :west}

      iex> MaqeBot.run("LLLLLW99RRRRRW88LLLRL")
      %MaqeBot.Position{x: -99, y: 88, direction: :east}

      iex> MaqeBot.run("W55555RW555555W444444W1")
      %MaqeBot.Position{x: 1_000_000, y: 55_555, direction: :east}

      iex> MaqeBot.run("MAQE")
      ** (RuntimeError) invalid command

  """
  @spec run(Position.t(), String.t()) :: Position.t()
  def run(initial_position \\ %Position{x: 0, y: 0, direction: :north}, walking_code) do
    walking_code
    |> CommandsBuilder.build()
    |> Enum.reduce(initial_position, fn command, position ->
      Position.change(position, command)
    end)
  end
end
