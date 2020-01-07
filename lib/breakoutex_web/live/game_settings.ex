defmodule BreakoutexWeb.Live.GameSettings do
  # Time in ms that schedules the game loop
  @tick 16

  # Width in pixels, used as the base for every type of block: bricks, paddle, walls, etc.
  # Every length param is expressed as an integer multiple of the basic unit
  @unit 35

  @board %{
    cols: 35,
    rows: 21
  }

  # Paddle characteristics expressed in basic units
  @paddle %{
    length: 5,
    height: 1,
    # distance the paddle can move between 2 ticks
    speed: 8
  }

  @paddle_initial_position %{
    left: (@board.cols - @paddle.length) / 2,
    top: @board.rows - 3
  }

  # Expressed in multiple of basic units
  @brick %{
    length: 3,
    height: 1
  }

  @level [
    ~w(X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X r 0 0 r 0 0 r 0 0 r 0 0 r 0 0 r 0 0 r 0 0 r 0 0 r 0 0 r 0 0 r 0 0 X),
    ~w(X b 0 0 b 0 0 b 0 0 b 0 0 b 0 0 b 0 0 b 0 0 b 0 0 b 0 0 b 0 0 b 0 0 X),
    ~w(X g 0 0 g 0 0 g 0 0 g 0 0 g 0 0 g 0 0 g 0 0 g 0 0 g 0 0 g 0 0 g 0 0 X),
    ~w(X o 0 0 o 0 0 o 0 0 o 0 0 o 0 0 o 0 0 o 0 0 o 0 0 o 0 0 o 0 0 o 0 0 X),
    ~w(X p 0 0 p 0 0 p 0 0 p 0 0 p 0 0 p 0 0 p 0 0 p 0 0 p 0 0 p 0 0 p 0 0 X),
    ~w(X y 0 0 y 0 0 y 0 0 y 0 0 y 0 0 y 0 0 y 0 0 y 0 0 y 0 0 y 0 0 y 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(X 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X),
    ~w(D D D D D D D D D D D D D D D D D D D D D D D D D D D D D D D D D D D)
  ]

  # Getters
  def tick(), do: @tick
  def unit(), do: @unit
  def board(), do: @board
  def paddle(), do: @paddle
  def paddle_initial_position(), do: @paddle_initial_position
  def brick(), do: @brick
  def level(), do: @level
end
