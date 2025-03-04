defmodule SaladUI.Avatar do
  @moduledoc false
  use SaladUI, :component

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: false

  def avatar(assigns) do
    ~H"""
    <span class={classes(["moon-avatar", @class])} {@rest}>
      {render_slot(@inner_block)}
    </span>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(alt src)

  def avatar_image(assigns) do
    ~H"""
    <img
      class={classes(["", @class])}
      {@rest}
      phx-update="ignore"
      style="display:none"
      onload="this.style.display=''"
    />
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: false

  def avatar_fallback(assigns) do
    ~H"""
    <span class={classes(["", @class])} {@rest}>
      {render_slot(@inner_block)}
    </span>
    """
  end
end
