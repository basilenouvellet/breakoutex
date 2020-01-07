defmodule BreakoutexWeb.Live.Blocks do
  @moduledoc """
  Module that contains the definitions of all the block types,
  as well as functions to init the board
  """

  alias BreakoutexWeb.Live.{Helpers, GameSettings}

  @spec build_board(list(list(String.t()))) :: [map()]
  def build_board(grid) do
    grid
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y_idx} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn
        {"X", x_idx} ->
          block(:wall, x_idx, y_idx)

        {"0", x_idx} ->
          block(:empty, x_idx, y_idx)

        {"D", x_idx} ->
          block(:floor, x_idx, y_idx)

        {c, x_idx} ->
          brick(c, GameSettings.brick().length, GameSettings.brick().height, x_idx, y_idx)
      end)
    end)
  end

  @spec block(:wall | :empty | :floor, number(), number()) :: map()
  defp block(type, x_idx, y_idx) do
    %{
      type: type,
      left: Helpers.coordinate(x_idx),
      top: Helpers.coordinate(y_idx),
      width: GameSettings.unit(),
      height: GameSettings.unit()
    }
  end

  @spec brick(String.t(), number(), number(), number(), number()) :: map()
  defp brick(color, brick_length, brick_height, x_idx, y_idx) do
    %{
      type: :brick,
      left: Helpers.coordinate(x_idx),
      top: Helpers.coordinate(y_idx),
      width: Helpers.coordinate(brick_length),
      height: Helpers.coordinate(brick_height),
      id: UUID.uuid4(),
      visible: true,
      color: get_color(color)
    }
  end

  @spec get_color(String.t()) :: String.t()
  defp get_color("r"), do: "red"
  defp get_color("b"), do: "blue"
  defp get_color("g"), do: "green"
  defp get_color("y"), do: "yellow"
  defp get_color("o"), do: "orange"
  defp get_color("p"), do: "purple"
  defp get_color("t"), do: "turquoise"
  defp get_color("w"), do: "white"
end
