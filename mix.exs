defmodule Groq.MixProject do
  use Mix.Project

  def project do
    [
      app: :groq,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:exsync, ">= 0.0.0", only: :dev},
      {:req, "~> 0.4.0"}
    ]
  end
end
