defmodule HaversineEx do
  @moduledoc """
  Provides some helpers functions to calculate the distance between two points
  on Earth using the Haversine formula. Also can find the bearing between two
  points, and get a point at a given distance and bearing from a given point.
  """

  alias HaversineEx.Point

  @units [:km, :miles, :meters]

  defmacrop is_unit(unit) do
    quote do
      unquote(unit) in unquote(@units)
    end
  end


  @spec haversine(number) :: number
  defp haversine(value) when is_number(value) do
    :math.sin(value / 2)**2
  end

  @doc """
  Calculates the distance between two points on Earth using the Haversine
  formula. The result is returned in the given unit (miles, meters, km).

  ## Examples

      iex> HaversineEx.distance(%HaversineEx.Point{lat: 40.7767644, lng: -73.9761399}, %HaversineEx.Point{lat: 40.771209, lng: -73.9673991}, :miles)
      0.5971169354600706

  """
  @spec distance(Point.t(), Point.t(), atom()) :: number
  def distance(%Point{} = pointA, %Point{} = pointB, unit) when is_unit(unit) do
    r = earth_radious(unit)

    pointA_rad = Point.deg2rad(pointA)
    pointB_rad = Point.deg2rad(pointB)

    dLat = pointB_rad.lat - pointA_rad.lat
    dLng = pointB_rad.lng - pointA_rad.lng

    a = haversine(dLat) +
        :math.cos(pointA_rad.lat) * :math.cos(pointB_rad.lat) *
        haversine(dLng)

    2 * r * :math.asin(:math.sqrt(a))
  end

  @doc """
  Calculates the distance between all the points in the given list. The result
  is returned in the given unit (miles, meters, km).

  ## Examples

      iex> HaversineEx.distance([
      ...>   %HaversineEx.Point{lat: 40.7767644, lng: -73.9761399},
      ...>   %HaversineEx.Point{lat: 40.773987, lng: -73.971769},
      ...>   %HaversineEx.Point{lat: 40.771209, lng: -73.9673991}
      ...> ], :miles)
      0.597116937109039

  """
  def distance([], _), do: 0.0
  def distance([_], _), do: 0.0

  @spec distance([Point.t()], atom()) :: number
  def distance([pointA, pointB | tail], unit) when is_unit(unit) do
    case tail do
      [] -> distance(pointA, pointB, unit)
      _ -> distance(pointA, pointB, unit) + distance([pointB | tail], unit)
    end
  end

  @doc """
  Calculates the bearing between two points.

  ## Examples

      iex> HaversineEx.find_bearing(%HaversineEx.Point{lat: 40.7767644, lng: -73.9761399}, %HaversineEx.Point{lat: 40.771209, lng: -73.9673991})
      130.0028272356484
  """
  @spec find_bearing(Point.t(), Point.t()) :: number
  def find_bearing(%Point{} = pointA, %Point{} = pointB) do
    pointA_rad = Point.deg2rad(pointA)
    pointB_rad = Point.deg2rad(pointB)

    dLng = pointB_rad.lng - pointA_rad.lng

    y = :math.sin(dLng) * :math.cos(pointB_rad.lat)
    x = :math.cos(pointA_rad.lat) * :math.sin(pointB_rad.lat) -
        :math.sin(pointA_rad.lat) * :math.cos(pointB_rad.lat) * :math.cos(dLng)

    :math.atan2(y, x) * 180 / :math.pi
  end

  @doc """
  Calculates a point at a given distance and bearing from a given point. The distance is given in the given unit (miles, meters, km).

  ## Examples

      iex> HaversineEx.find_point(%HaversineEx.Point{lat: 40.7767644, lng: -73.9761399}, 0.597117, 130.002827, :miles)
      %HaversineEx.Point{lat: 40.77120899942672, lng: -73.96739909902514}
  """
  @spec find_point(Point.t(), number(), number(), atom()) :: %Point{}
  def find_point(%Point{} = origin, distance, bearing, unit) when is_unit(unit) and is_number(distance) and is_number(bearing) do
    r = earth_radious(unit)

    point_rad = Point.deg2rad(origin)
    bearing_rad = bearing * :math.pi / 180

    c = distance / r

    lat2 = :math.asin(
      :math.sin(point_rad.lat) * :math.cos(c) +
      :math.cos(point_rad.lat) * :math.sin(c) * :math.cos(bearing_rad)
    )

    lng2 = point_rad.lng + :math.atan2(
      :math.sin(bearing_rad) * :math.sin(c) * :math.cos(point_rad.lat),
      :math.cos(c) - :math.sin(point_rad.lat) * :math.sin(lat2)
    )

    %Point{lat: lat2, lng: lng2} |> Point.rad2deg()
  end

  @spec earth_radious(atom()) :: number()
  defp earth_radious(unit) when is_unit(unit) do
    case unit do
      :km -> 6_371.0
      :meters -> 6_371_000.0
      :miles -> 3_959.0
    end
  end
end
