defmodule SteelEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :steel_ex,
      version: "0.0.1",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "SteelEx allows you to work with embedded Steel Scheme in Elixir.",
      source_url: "https://github.com/sele-dev/steel_ex",
      package: [
        maintainers: ["Caleb Currie"],
        licenses: ["MPL-2.0"],
        links: %{
                  "GitHub" => "https://github.com/sele-dev/steel_ex",
        },
        files: ~w(lib native priv mix.exs README* LICENSE*)
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
      {:ex_doc, "~> 0.34", only: :dev, runtime: false, warn_if_outdated: true},
      {:rustler, "~> 0.36.2"}
    ]
  end
end
