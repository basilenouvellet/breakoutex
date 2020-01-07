defmodule BreakoutexWeb.Live.Helpers do
  # Multiply an integer coordinate for a length, giving
  # the actual coordinate on a continuous plane
  @spec coordinate(number(), number()) :: number()
  def coordinate(x, l), do: x * l
end
