defmodule TrainSimulator.TrainStations do
  use Ecto.Schema
  import Ecto.Changeset

  schema "train_stations" do
    field :train_station_code, :integer
    field :name, :string
    field :fronton_name, :string
    field :postal_code, :integer
    field :city_code, :integer
    field :city_name, :string
    field :county_code, :integer
    field :county_name, :string
    field :uic_code, :integer
    field :longitude, :decimal
    field :latitude, :decimal
    field :sncf_region, :string
    field :unity_gare, :string
    field :drg_segment, :string
    field :plateform_code, :string
    field :plateform_name, :string
    field :rg, :string
    field :plateform_count, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(train_stations, attrs) do
    train_stations
    |> cast(attrs, [:train_station_code, :name, :fronton_name, :postal_code, :city_code, :city_name, :county_code, :county_name, :uic_code, :longitude, :latitude, :sncf_region, :unity_gare, :drg_segment, :plateform_code, :plateform_name, :rg, :plateform_count])
    |> validate_required([:train_station_code, :name, :fronton_name, :postal_code, :city_code, :city_name, :county_code, :county_name, :uic_code, :longitude, :latitude, :sncf_region, :unity_gare, :drg_segment, :plateform_code, :plateform_name, :rg, :plateform_count])
  end
end
