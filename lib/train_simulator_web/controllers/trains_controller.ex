defmodule TrainSimulatorWeb.TrainsController do
  use TrainSimulatorWeb, :controller

  import Ecto.Query

  def svg(conn, _params) do
    train_stations =
      TrainSimulator.Repo.all(
        from(t in TrainSimulator.TrainStations, select: {t.name, t.longitude, t.latitude})
      )

    render(conn, :svg, layout: false, train_stations: train_stations)
  end

  def map_train_station_to_json(train_station) do
    {n, lg, lat} = train_station
    %{name: n, longitude: lg, latitude: lat}
  end

  def show_trains(conn, _params) do
    train_stations =
      TrainSimulator.Repo.all(
        from(t in TrainSimulator.TrainStations, select: {t.name, t.longitude, t.latitude})
      )

    json_train_stations =
      Enum.map(train_stations, fn train_station ->
        map_train_station_to_json(train_station)
      end)

    json(conn, json_train_stations)
  end
end
