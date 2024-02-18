defmodule TrainSimulator.Repo.Migrations.CreateTrainStations do
  use Ecto.Migration

  def change do
    create table(:train_stations) do
      add :train_station_code, :integer
      add :name, :string
      add :fronton_name, :string
      add :postal_code, :integer
      add :city_code, :integer
      add :city_name, :string
      add :county_code, :integer
      add :county_name, :string
      add :uic_code, :integer
      add :longitude, :decimal
      add :latitude, :decimal
      add :sncf_region, :string
      add :unity_gare, :string
      add :drg_segment, :string
      add :plateform_code, :string
      add :plateform_name, :string
      add :rg, :string
      add :plateform_count, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
