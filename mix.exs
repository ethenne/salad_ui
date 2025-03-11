defmodule MoonUI.MixProject do
  use Mix.Project

  # TODO: add moon_ui repo and maintainers
  def project do
    [
      app: :moon_ui,
      version: "0.14.8",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "MoonUI",
      description: description(),
      source_url: "https://github.com/bluzky/salad_ui",
      docs: docs(),
      package: package(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # TODO: add moon_ui repo and maintainers
  defp package do
    [
      maintainers: ["Dung Nguyen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/bluzky/soon_ui"},
      files: ~w(lib assets/*.css priv .formatter.exs mix.exs README*)
    ]
  end

  defp description do
    "Phoenix UI components library inspired by shadcn ui"
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tw_merge, "~> 0.1"},
      {:phoenix_live_view, "~> 1.0", override: true},
      {:mix_test_watch, "~> 1.2", only: [:dev, :test]},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:styler, "~> 0.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: [:dev, :test], runtime: false},
      {:tailwind, "~> 0.2.4", only: [:dev], runtime: Mix.env() == :dev},
      {:moon_assets, "~> 0.9.0", organization: "coingaming"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      test: ["test  --color"],
      audit: ["format", "credo", "coveralls"]
    ]
  end
end
