defmodule Deathrow.MixProject do
  use Mix.Project

  def project do
    [
      app: :deathrow,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Compile to binary
  defp escript do
    [main_module: Deathrow.CLI]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "~> 0.33.0"},
      {:httpoison, "~> 1.8"}
    ]
  end
end
