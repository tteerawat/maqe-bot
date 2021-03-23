defmodule MaqeBot.CommandsBuilder do
  defguard is_num_str(number_str) when number_str in ~w(1 2 3 4 5 6 7 8 9 0)

  @doc """
  Builds a list of command from a given walking code.

  ## Examples

      iex> MaqeBot.CommandsBuilder.build("RW15RW1")
      [:turn_right, {:walk, 15}, :turn_right, {:walk, 1}]

      iex> MaqeBot.CommandsBuilder.build("W5RW5RW2RW1R")
      [{:walk, 5}, :turn_right, {:walk, 5}, :turn_right, {:walk, 2}, :turn_right, {:walk, 1}, :turn_right]

      iex> MaqeBot.CommandsBuilder.build("RRW11RLLW19RRW12LW1")
      [:turn_right, :turn_right, {:walk, 11}, :turn_right, :turn_left, :turn_left, {:walk, 19}, :turn_right, :turn_right, {:walk, 12}, :turn_left, {:walk, 1}]

      iex> MaqeBot.CommandsBuilder.build("LLW100W50RW200W10")
      [:turn_left, :turn_left, {:walk, 100}, {:walk, 50}, :turn_right, {:walk, 200}, {:walk, 10}]

      iex> MaqeBot.CommandsBuilder.build("LLLLLW99RRRRRW88LLLRL")
      [:turn_left, :turn_left, :turn_left, :turn_left, :turn_left, {:walk, 99}, :turn_right, :turn_right, :turn_right, :turn_right, :turn_right, {:walk, 88}, :turn_left, :turn_left, :turn_left, :turn_right, :turn_left]

      iex> MaqeBot.CommandsBuilder.build("W55555RW555555W444444W1")
      [{:walk, 55555}, :turn_right, {:walk, 555555}, {:walk, 444444}, {:walk, 1}]

      iex> MaqeBot.CommandsBuilder.build("RRW")
      [:turn_right, :turn_right, {:walk, 0}]

      iex> MaqeBot.CommandsBuilder.build("RL5")
      ** (RuntimeError) invalid command

      iex> MaqeBot.CommandsBuilder.build("MAQE")
      ** (RuntimeError) invalid command

  """
  @spec build(String.t()) :: [MaqeBot.Command.t()]
  def build(walking_code) when is_binary(walking_code) do
    walking_code
    |> String.split("", trim: true)
    |> Enum.reduce([], &accumulate_commands/2)
    |> Enum.map(&maybe_convert_num_str_to_integer/1)
    |> Enum.reverse()
  end

  defp accumulate_commands("L", acc), do: [:turn_left | acc]
  defp accumulate_commands("R", acc), do: [:turn_right | acc]
  defp accumulate_commands("W", acc), do: [{:walk, "0"} | acc]
  defp accumulate_commands(command, [{:walk, str} | tail]) when is_num_str(command), do: [{:walk, str <> command} | tail]
  defp accumulate_commands(_, _), do: raise("invalid command")

  defp maybe_convert_num_str_to_integer({:walk, num_str}), do: {:walk, String.to_integer(num_str)}
  defp maybe_convert_num_str_to_integer(command), do: command
end
