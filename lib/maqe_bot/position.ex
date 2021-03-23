defmodule MaqeBot.Position do
  defstruct x: 0,
            y: 0,
            direction: :north

  @type direction :: :north | :east | :south | :west

  @type t :: %__MODULE__{
          x: non_neg_integer(),
          y: non_neg_integer(),
          direction: direction()
        }

  @spec change(t(), MaqeBot.Command.t()) :: t()
  def change(%__MODULE__{direction: :north} = position, :turn_right), do: %{position | direction: :east}
  def change(%__MODULE__{direction: :east} = position, :turn_right), do: %{position | direction: :south}
  def change(%__MODULE__{direction: :south} = position, :turn_right), do: %{position | direction: :west}
  def change(%__MODULE__{direction: :west} = position, :turn_right), do: %{position | direction: :north}

  def change(%__MODULE__{direction: :north} = position, :turn_left), do: %{position | direction: :west}
  def change(%__MODULE__{direction: :east} = position, :turn_left), do: %{position | direction: :north}
  def change(%__MODULE__{direction: :south} = position, :turn_left), do: %{position | direction: :east}
  def change(%__MODULE__{direction: :west} = position, :turn_left), do: %{position | direction: :south}

  def change(%__MODULE__{y: y, direction: :north} = position, {:walk, num}), do: %{position | y: y + num}
  def change(%__MODULE__{x: x, direction: :east} = position, {:walk, num}), do: %{position | x: x + num}
  def change(%__MODULE__{y: y, direction: :south} = position, {:walk, num}), do: %{position | y: y - num}
  def change(%__MODULE__{x: x, direction: :west} = position, {:walk, num}), do: %{position | x: x - num}
end
