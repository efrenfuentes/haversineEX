# haversineEX

[![Hex.pm](https://img.shields.io/hexpm/v/haversineEx.svg)](https://hex.pm/packages/haversineEx)


Provides some helpers functions to calculate the distance between two points on Earth using the Haversine formula. Also can find the bearing between two points, and get a point at a given distance and bearing from a given point.

## Installation

```elixir
def deps do
  [
    {:haversineEx, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
iex> PointA = %HaversineEx.Point{lat: 40.7767644, lng: -73.9761399}

iex> PointB = %HaversineEx.Point{lat: 40.771209, lng: -73.9673991}

iex> HaversineEx.distance(PointA, PointB, :miles)
0.597117

iex> HaversineEx.bearing(PointA, PointB)
130.002827

iex> HaversineEx.find_point(PointA, 0.597117, 130.002827, :miles)
%HaversineEx.Point{lat: 40.771209, lng: -73.9673991}

iex> route = [
  %HaversineEx.Point{lat: 40.7767644, lng: -73.9761399},
  %HaversineEx.Point{lat: 40.773987, lng: -73.971769},
  %HaversineEx.Point{lat: 40.771209, lng: -73.9673991}
]

iex> HaversineEx.distance(route, :miles)
0.597117
```

## Running tests

```bash
mix test
```
