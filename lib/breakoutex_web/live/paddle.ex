defmodule BreakoutexWeb.Live.Paddle do
  import Phoenix.LiveView, only: [assign: 3]

  alias BreakoutexWeb.Live.{Helpers, GameSettings}

  @spec initial_state() :: map()
  def initial_state() do
    %{
      width: Helpers.coordinate(GameSettings.paddle().length),
      height: Helpers.coordinate(GameSettings.paddle().height),
      # Coordinates of the box surrounding the paddle
      left: Helpers.coordinate(GameSettings.paddle_initial_position().left),
      top: Helpers.coordinate(GameSettings.paddle_initial_position().top),
      right:
        Helpers.coordinate(
          GameSettings.paddle_initial_position().left + GameSettings.paddle().length
        ),
      bottom:
        Helpers.coordinate(
          GameSettings.paddle_initial_position().top + GameSettings.paddle().height
        ),
      # Misc
      direction: :stationary,
      speed: GameSettings.paddle().speed,
      length: GameSettings.paddle().length
    }
  end

  # Move & stop Paddle
  @spec move(Socket.t(), :left | :right) :: Socket.t()
  def move(%{assigns: %{paddle: paddle}} = socket, direction) do
    if paddle.direction == direction do
      socket
    else
      assign(socket, :paddle, %{paddle | direction: direction})
    end
  end

  @spec stop(Socket.t(), :left | :right) :: Socket.t()
  def stop(%{assigns: %{paddle: paddle}} = socket, direction) do
    if paddle.direction == direction do
      assign(socket, :paddle, %{paddle | direction: :stationary})
    else
      socket
    end
  end

  @spec advance(Socket.t()) :: Socket.t()
  def advance(%{assigns: %{paddle: paddle, unit: unit}} = socket) do
    case paddle.direction do
      :left -> assign(socket, :paddle, move_paddle(:left, paddle, unit))
      :right -> assign(socket, :paddle, move_paddle(:right, paddle, unit))
      :stationary -> socket
    end
  end

  # Move Paddle left & right
  @spec move_paddle(:left | :right, map(), number()) :: map()
  defp move_paddle(:left, paddle, unit) do
    new_left = max(unit, paddle.left - paddle.speed)
    new_right = paddle.right - (paddle.left - new_left)

    %{paddle | left: new_left, right: new_right}
  end

  defp move_paddle(:right, paddle, unit) do
    new_left =
      min(paddle.left + paddle.speed, unit * (GameSettings.board().cols - paddle.length - 1))

    new_right = paddle.right + (new_left - paddle.left)

    %{paddle | left: new_left, right: new_right}
  end
end
