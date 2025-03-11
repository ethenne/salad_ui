defmodule MoonUI.Loader do
  @moduledoc false
  use MoonUI, :component

  @doc """
  Renders loader spin.

  ## Examples

  """

  attr :class, :string, default: nil
  attr :size, :string, default: "md", values: ~w(2xs xs sm md lg)

  attr :name, :string, default: nil
  attr :rest, :global

  def loader(assigns) do
    ~H"""
    <div
      name={@name}
      class={
        classes([
          "moon-loader",
          "moon-loader-#{@size}",
          @class
        ])
      }
      {@rest}
    >
    </div>
    """
  end
end
