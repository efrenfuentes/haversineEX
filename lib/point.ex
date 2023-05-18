defmodule HaversineEx.Point do
  @moduledoc """
  Provides Point struct to be used on HaversineEx. It also provides some helper
  functions to convert from degrees to radians and viceversa.
  """
  alias HaversineEx.Point

  defstruct [:lat, :lng]

  @type t(lat, lng) :: %Point{lat: lat, lng: lng}

  @type t :: %Point{lat: number(), lng: number()}

  @doc """
  Converts a point from degrees to radians.

  ## Examples

      iex> HaversineEx.Point.deg2rad(%HaversineEx.Point{lat: 40.771209, lng: -73.9673991})
      %HaversineEx.Point{lat: 0.7115918, lng: -1.290975}
  """
  @spec deg2rad(Point.t()) :: %Point{}
  def deg2rad(%Point{} = point) do
    %Point{
      lat: point.lat * :math.pi / 180,
      lng: point.lng * :math.pi / 180
    }
  end

  @doc """
  Converts a point from radians to degrees.

  ## Examples

      iex> HaversineEx.Point.rad2deg(%HaversineEx.Point{lat: 0.7115918, lng: -1.290975})
      %HaversineEx.Point{lat: 40.771209, lng: -73.9673991}
  """
  @spec rad2deg(Point.t()) :: %Point{}
  def rad2deg(%Point{} = point) do
    %Point{
      lat: point.lat * 180 / :math.pi,
      lng: point.lng * 180 / :math.pi
    }
  end
end
