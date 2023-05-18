defmodule HaversineEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :HaversineEx,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "HaversineEx",
      source_url: "https://github.com/efrenfuentes/haversineEX",
      homepage_url: "https://github.com/efrenfuentes/haversineEX",
      docs: [
        main: "HaversineEx"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
    ]
  end

  defp description() do
    "Provides some helpers functions to calculate the distance between two points on Earth using the Haversine formula. Also can find the bearing between two points, and get a point at a given distance and bearing from a given point."
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "haversineEx",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/efrenfuentes/haversineEX"},
    ]
  end
end
