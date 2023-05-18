defmodule HaversineEx.Point do
  alias HaversineEx.Point

  defstruct [:lat, :lng]

  @type t(lat, lng) :: %Point{lat: lat, lng: lng}

  @type t :: %Point{lat: number(), lng: number()}

  @spec deg2rad(Point.t()) :: %Point{}
  def deg2rad(%Point{} = point) do
    %Point{
      lat: point.lat * :math.pi / 180,
      lng: point.lng * :math.pi / 180
    }
  end

  @spec rad2deg(Point.t()) :: %Point{}
  def rad2deg(%Point{} = point) do
    %Point{
      lat: point.lat * 180 / :math.pi,
      lng: point.lng * 180 / :math.pi
    }
  end
end
