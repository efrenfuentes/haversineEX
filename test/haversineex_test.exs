defmodule HaversineExTest do
  use ExUnit.Case
  doctest HaversineEx

  def round_number(number) do
    number * 1_000_000 |> round() |> Kernel./(1_000_000)
  end

  test "distance between two points" do
    distance = HaversineEx.distance(%HaversineEx.Point{lat: 40.7767644, lng: -73.9761399}, %HaversineEx.Point{lat: 40.771209, lng: -73.9673991}, :miles)

    assert round_number(distance) == 0.597117
  end

  test "get bearing between two points" do
    bearing = HaversineEx.find_bearing(%HaversineEx.Point{lat: 40.7767644, lng: -73.9761399}, %HaversineEx.Point{lat: 40.771209, lng: -73.9673991})

    assert round_number(bearing) == 130.002827
  end

  test "find a point with having an origin, bearing and distance" do
    point = HaversineEx.find_point(%HaversineEx.Point{lat: 40.7767644, lng: -73.9761399}, 0.597117, 130.002827, :miles)

    assert round_number(point.lat) == 40.771209
    assert round_number(point.lng) == -73.967399
  end

  test "find the distance for a list of points" do
    points = [
      %HaversineEx.Point{lat: 40.7767644, lng: -73.9761399},
      %HaversineEx.Point{lat: 40.773987, lng: -73.971769},
      %HaversineEx.Point{lat: 40.771209, lng: -73.9673991}
    ]

    distance = HaversineEx.distance(points, :miles)

    assert round_number(distance) == 0.597117
  end
end
