defmodule BreakoutexWeb.Live.Ball do
  import Phoenix.LiveView, only: [assign: 3]

  alias BreakoutexWeb.Live.{Helpers, GameSettings}

  @spec initial_state() :: map()
  def initial_state() do
    %{
      width: Helpers.coordinate(GameSettings.ball().length),
      height: Helpers.coordinate(GameSettings.ball().height),
      # Coordinates of the box surrounding the ball
      left: Helpers.coordinate(GameSettings.ball_initial_position().left),
      top: Helpers.coordinate(GameSettings.ball_initial_position().top),
      right:
        Helpers.coordinate(GameSettings.ball_initial_position().left + GameSettings.ball().length),
      bottom:
        Helpers.coordinate(GameSettings.ball_initial_position().top + GameSettings.ball().height),
      # Misc
      speed: GameSettings.ball_initial_speed(),
      length: GameSettings.ball().length
    }
  end

  @spec advance(Socket.t()) :: Socket.t()
  def advance(%{assigns: %{ball: ball, unit: unit}} = socket) do
    new_ball =
      ball
      |> move_ball_vertical(unit)
      |> move_ball_horizontal(unit)

    assign(socket, :ball, new_ball)
  end

  def move_ball_vertical(ball, unit) do
    new_top = ball.top - ball.speed.vertical
    new_bottom = ball.bottom - (ball.top - new_top)

    top_limit = unit * 1
    bottom_limit = unit * (GameSettings.board().rows - 1)

    cond do
      # bounce top
      new_top <= top_limit ->
        %{
          ball
          | top: top_limit,
            bottom: top_limit + unit * GameSettings.ball().height,
            speed: %{ball.speed | vertical: -1 * ball.speed.vertical}
        }

      # bounce bottom
      new_bottom >= bottom_limit ->
        %{
          ball
          | top: bottom_limit - unit * GameSettings.ball().height,
            bottom: bottom_limit,
            speed: %{ball.speed | vertical: -1 * ball.speed.vertical}
        }

      # does not bounce
      true ->
        %{ball | top: new_top, bottom: new_bottom}
    end
  end

  def move_ball_horizontal(ball, unit) do
    new_left = ball.left - ball.speed.horizontal
    new_right = ball.right - (ball.left - new_left)

    left_limit = unit * 1
    right_limit = unit * (GameSettings.board().cols - 1)

    cond do
      # bounce left
      new_left <= left_limit ->
        %{
          ball
          | left: left_limit,
            right: left_limit + unit * GameSettings.ball().length,
            speed: %{ball.speed | horizontal: -1 * ball.speed.horizontal}
        }

      # bounce right
      new_right >= right_limit ->
        %{
          ball
          | left: right_limit - unit * GameSettings.ball().length,
            right: right_limit,
            speed: %{ball.speed | horizontal: -1 * ball.speed.horizontal}
        }

      # does not bounce
      true ->
        %{ball | left: new_left, right: new_right}
    end
  end
end
