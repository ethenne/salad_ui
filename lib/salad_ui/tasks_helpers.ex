defmodule MoonUi.TasksHelpers do
  @moduledoc """
  Helper functions for the MoonUI mix tasks.
  """

  @doc """
  Retrieves the base path for MoonUI library source files.

  Returns the appropriate path based on the current environment:
  - In test: Uses the local `lib/Moon_ui` directory.
  - In development: Locates the path within project dependencies.

  Raises an error if MoonUI cannot be found in the dependencies.
  """
  def get_base_path do
    if Mix.env() == :test, do: test_path(), else: development_path()
  end

  defp test_path, do: __DIR__

  defp development_path do
    case find_Moon_ui_dep() do
      {:ok, path} -> Path.expand(Path.join(path, "lib/Moon_ui"))
      {:error, reason} -> raise "Failed to find MoonUI: #{reason}"
    end
  end

  defp find_Moon_ui_dep do
    Mix.Dep.load_and_cache()
    |> Enum.find(&(&1.app == :Moon_ui))
    |> case do
      %Mix.Dep{opts: opts} = dep ->
        {:ok, opts[:path] || default_dep_path(dep)}

      nil ->
        {:error, "MoonUI not found in dependencies"}
    end
  end

  defp default_dep_path(dep) do
    Path.join([File.cwd!(), "deps", Atom.to_string(dep.app)])
  end
end
