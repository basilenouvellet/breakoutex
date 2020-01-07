defmodule BreakoutexWeb.Live.Game do
  @moduledoc """
  Main module, contains the entry point for the live view socket
  and all the game logic
  """

  use Phoenix.LiveView

  alias Phoenix.LiveView.Socket
  alias BreakoutexWeb.GameView
  alias BreakoutexWeb.Live.{Paddle, Blocks, GameSettings}

  @left_keys ["ArrowLeft", "KeyA"]
  @right_keys ["ArrowRight", "KeyD"]

  def render(assigns) do
    GameView.render("index.html", assigns)
  end

  @spec mount(map(), Socket.t()) :: {:ok, Socket.t()}
  def mount(_session, socket) do
    state = %{
      unit: GameSettings.unit(),
      tick: GameSettings.tick(),
      paddle: Paddle.initial_state(),
      blocks: Blocks.build_board(GameSettings.level())
    }

    socket =
      socket
      |> assign(state)

    if connected?(socket) do
      {:ok, schedule_tick(socket)}
    else
      {:ok, socket}
    end
  end

  @spec schedule_tick(Socket.t()) :: Socket.t()
  defp schedule_tick(socket) do
    Process.send_after(self(), :tick, socket.assigns.tick)
    socket
  end

  @spec handle_info(atom(), Socket.t()) :: {:noreply, Socket.t()} | {:stop, Socket.t()}
  def handle_info(:tick, socket) do
    new_socket =
      socket
      |> game_loop()
      |> schedule_tick()

    {:noreply, new_socket}
  end

  @spec handle_event(String.t(), map(), Socket.t()) ::
          {:noreply, Socket.t()} | {:stop, Socket.t()}
  def handle_event("keydown", %{"code" => code}, socket) do
    {:noreply, on_input(socket, code)}
  end

  def handle_event("keyup", %{"code" => code}, socket) do
    {:noreply, on_stop_input(socket, code)}
  end

  @spec game_loop(Socket.t()) :: Socket.t()
  defp game_loop(socket) do
    socket
    |> Paddle.advance()
  end

  # Handle Keydown events
  @spec on_input(Socket.t(), String.t()) :: Socket.t()
  defp on_input(socket, key) when key in @left_keys,
    do: Paddle.move(socket, :left)

  defp on_input(socket, key) when key in @right_keys,
    do: Paddle.move(socket, :right)

  defp on_input(socket, _), do: socket

  # Handle Keyup events
  @spec on_stop_input(Socket.t(), String.t()) :: Socket.t()
  defp on_stop_input(socket, key) when key in @left_keys,
    do: Paddle.stop(socket, :left)

  defp on_stop_input(socket, key) when key in @right_keys,
    do: Paddle.stop(socket, :right)

  defp on_stop_input(socket, _), do: socket
end
