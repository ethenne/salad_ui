defmodule MoonUI.List do
  @moduledoc """
  Implement list components
  """
  use MoonUI, :component

  @doc """
  Render list


  ## Examples:


      <.list>
        <.list_label>Account</.list_label>
        <.list_separator />

        <.list_group>
          <.list_item>
              Profile
            <.list_shortcut>⌘P</.list_shortcut>
          </.list_item>

          <.list_item>
              Billing
            <.list_shortcut>⌘B</.list_shortcut>
          </.list_item>

          <.list_item>
              Settings
            <.list_shortcut>⌘S</.list_shortcut>
          </.list_item>
        </.list_group>
      </.list>
  """

  attr :class, :string, default: "top-0 left-full"
  slot :inner_block, required: true
  attr :rest, :global

  def list(assigns) do
    ~H"""
    <div
      class={[
        "moon-list",
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :disabled, :boolean, default: false
  slot :inner_block, required: true
  attr :rest, :global

  def list_item(assigns) do
    ~H"""
    <div
      class={
        classes([
          "hover:bg-accent",
          "relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
          @class
        ])
      }
      {%{"data-disabled" => @disabled}}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :inset, :boolean, default: false
  slot :inner_block, required: true
  attr :rest, :global

  def list_label(assigns) do
    ~H"""
    <div class={classes(["px-2 py-1.5 text-sm font-semibold", @inset && "pl-8", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block

  def list_separator(assigns) do
    ~H"""
    <div role="separator" class={classes(["-mx-1 my-1 h-px bg-muted", @class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true
  attr :rest, :global

  def list_shortcut(assigns) do
    ~H"""
    <span class={classes(["ml-auto text-xs tracking-widest opacity-60", @class])} {@rest}>
      {render_slot(@inner_block)}
    </span>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true
  attr :rest, :global

  def list_group(assigns) do
    ~H"""
    <div class={classes([@class])} role="group" {@rest}>{render_slot(@inner_block)}</div>
    """
  end
end
