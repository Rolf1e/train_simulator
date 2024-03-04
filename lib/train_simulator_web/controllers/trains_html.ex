defmodule TrainSimulatorWeb.TrainsHTML do
  use TrainSimulatorWeb, :html

  # <svg id="train_stations_map_svg" width="1000" height="1000">
  # <%= for {name, lg, lat } <- @train_stations do %>
  # <circle id={name} 
  # cx={at_scale(lg, 0)} 
  # cy={at_scale(lat, 1)} 
  # r="1" 
  # stroke="black" 
  # stroke-width="1" 
  # fill="red"
  # />
  # <% end %>
  # </svg>
  def svg(assigns) do
    ~H"""
    Trains !!

    <div>
      <canvas id="train_stations_map_canvas" width="1000" height="1000"> </canvas>
      <script type="application/javascript">
        function draw() {
          console.log("Loading map ...")

          fetch("http://localhost:4000/trains")
            .then(async response =>  {
              const trainStations = await response.json()
              const canvas = document.querySelector("#train_stations_map_canvas")
              if (canvas.getContext === null) {
                throw new Error('Failed to find target canvas')
              }

              const ctx = canvas.getContext("2d")

              ctx.beginPath()
              const a = trainStations
                .filter(station => station.longitude != null && station.latitude != null)
              const station = a[0]
              console.log(station)
                a.forEach(station => {
              ctx.moveTo(station.longitude * 50, station.latitude * 20)
              ctx.arc(station.longitude * 50, station.latitude *20, 5, 0, Math.PI * 2, true)
                })
              ctx.stroke()
            })
            .catch(e => console.error(e))
        }
        window.addEventListener("load", draw)
      </script>
    </div>
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
