defmodule Octobase.CLI.Mixfile do
  use Mix.Project

  def project do
    [app: :cli,
     version: "0.0.1",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.0.0",
     escript: escript,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :octobase_client]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:client, in_umbrella: true}, {:server, in_umbrella: true}]
  end

  def escript do
    [main_module: Octobase.CLI, name: "octo", path: "../../bin/octo"]
  end
end
