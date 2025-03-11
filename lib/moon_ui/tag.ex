defmodule MoonUI.Tag do
  @moduledoc false
  use MoonUI, :component

  @doc """
    The tag component is used to display a tag.

  """

  attr :class, :string, default: nil, doc: "The class of the tag."

  attr :size, :string, values: ~w(2xs xs), default: "xs", doc: "The tag size style"

  slot :inner_block, required: true, doc: "The tags text."

  def tag(assigns) do
    ~H"""
    <div class={classes(["moon-tag", if(@size == "2xs", do: "moon-tag-2xs", else: nil), @class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end
end
