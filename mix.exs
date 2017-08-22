defmodule Debug.Mixfile do
  use Mix.Project

  def project do
    [
      app: :debug,
      version: "0.1.0",
      description: "flexible debugging messages",
      start_permanent: Mix.env == :prod,
      package: package(),
      deps: deps(),
    ]
  end

  def package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Michael Vanasse"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/mndvns/debug"},
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
