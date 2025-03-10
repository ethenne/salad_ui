defmodule SaladUI.Placeholder do
  @moduledoc false
  use SaladUI, :component

  @doc """
  Renders placeholder.

  ## Examples

    <div class="w-space-160 h-space-80">
      <.placeholder/>
    </div>

    or

    <.placeholder class="w-space-160 h-space-80"/>

  """

  attr :class, :string, default: nil, doc: "The class of the placeholder, defines it's width and height"
  attr :rest, :global
  attr :name, :string, default: nil, doc: "The name of the placeholder"

  def placeholder(assigns) do
    ~H"""
    <div class={classes(["moon-placeholder w-full h-full", @class])} name={@name} {@rest}></div>
    """
  end
end
