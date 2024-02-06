defmodule TrainSimulator.Repo do
  use Ecto.Repo,
    otp_app: :train_simulator,
    adapter: Ecto.Adapters.Postgres
end
