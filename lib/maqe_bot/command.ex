defmodule MaqeBot.Command do
  @type t :: :turn_left | :turn_right | {:walk, non_neg_integer()}
end
