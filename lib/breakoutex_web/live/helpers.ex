defmodule BreakoutexWeb.Live.Helpers do
  alias BreakoutexWeb.Live.GameSettings

  # Multiply an integer coordinate for a length, giving
  # the actual coordinate on a continuous plane
  @spec coordinate(number()) :: number()
  def coordinate(x), do: x * GameSettings.unit()
end
