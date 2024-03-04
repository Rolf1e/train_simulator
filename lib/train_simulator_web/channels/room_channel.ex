defmodule TrainSimulatorWeb.RoomChannel do
  use Phoenix.Channel

  def join("train:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("train:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
end
