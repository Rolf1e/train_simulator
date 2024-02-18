defmodule TrainSimulatorWeb.TrainsHTML do
  use TrainSimulatorWeb, :html

  def index(assigns) do
    ~H"""
    Trains !!

    <svg id="train_stations_map_canvas" width="1000" height="1000">
      <%= for {name, lg, lat } <- @train_stations do %>
        <circle id={name} 
          cx={at_scale(lg, 0)} 
          cy={at_scale(lat, 1)} 
          r="1" 
          stroke="black" 
          stroke-width="1" 
          fill="red"
        />
      <% end %>
    </svg>

    """
  end

  def at_scale(nil, _dir) do 
    0
  end

  @factor 40

  def at_scale(x, dir) do
    if dir == 0 do
      Decimal.add(5 * @factor, Decimal.mult(x, @factor))
    else 
      Decimal.sub(60 * @factor, Decimal.mult(x, @factor))
    end
  end
  
end
