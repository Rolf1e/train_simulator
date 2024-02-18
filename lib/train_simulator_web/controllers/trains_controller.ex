defmodule TrainSimulatorWeb.TrainsController do
  use TrainSimulatorWeb, :controller

  import Ecto.Query

  def index(conn, _params) do
    train_stations = TrainSimulator.Repo.all(from t in TrainSimulator.TrainStations, select: {t.name, t.longitude, t.latitude } )
    render(conn, :index, layout: false, train_stations: train_stations)
  end
end
