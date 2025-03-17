defmodule MoonUI.Dropdown do
  @moduledoc false
  use MoonUI, :component

  alias Phoenix.LiveView.JS

  @doc """
  Render dropdown menu


  ## Examples:

      <.dropdown>
        <.dropdown_trigger>
          <.button variant="outline">Open</.button>
        </.dropdown_trigger>

        <.dropdown_content>
          <.dropdown_label>Account</.dropdown_label>
          <.dropdown_separator />

          <.dropdown_group>
            <.dropdown_item>
              Profile
              <.dropdown_shortcut>⌘P</.dropdown_shortcut>
            </.dropdown_item>
            <.dropdown_item>
              Billing
              <.dropdown_shortcut>⌘B</.dropdown_shortcut>
            </.dropdown_item>
            <.dropdown_item>
              Settings
              <.dropdown_shortcut>⌘S</.dropdown_shortcut>
            </.dropdown_item>
          </.dropdown_group>
        </.dropdown_content>
      </.dropdown>
  """

  attr :class, :string, default: nil
  attr :size, :string, values: ~w(sm md lg xl), default: "md"
  attr :error, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :value, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def dropdown(assigns) do
    ~H"""
    <div class={classes(["relative group inline-block", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :as_tag, :any, default: "div"
  slot :inner_block, required: true

  attr :rest, :global

  def dropdown_trigger(assigns) do
    ~H"""
    <.dynamic
      tag={@as_tag}
      class={classes(["dropdown-menu-trigger peer", @class])}
      data-state="closed"
      {@rest}
      phx-click={toggle()}
      phx-click-away={hide()}
    >
      {render_slot(@inner_block)}
    </.dynamic>
    """
  end

  attr :class, :string, default: nil

  attr :position, :string,
    values: ~w(top-start top-end bottom-start bottom-end top bottom right left),
    default: "left"

  attr :multiple, :boolean, default: false

  slot :inner_block, required: true
  attr :rest, :global

  def dropdown_content(assigns) do
    variant_class =
      case assigns.position do
        "top-start" -> "bottom-full mb-2 right-full mr-2"
        "top-end" -> "bottom-full mb-2 left-full ml-2"
        "bottom-start" -> "top-full mt-2 right-full mr-2"
        "bottom-end" -> "top-full mt-2 left-full mr-2"
        "top" -> "bottom-full mb-2"
        "bottom" -> "top-full mt-2"
        "right" -> "left-full ml-2"
        "left" -> "right-full mr-2"
      end

    assigns = assign(assigns, :variant_class, variant_class)

    ~H"""
    <div
      class={[
        "z-50 animate-in peer-data-[state=closed]:fade-out-0 peer-data-[state=open]:fade-in-0 peer-data-[state=closed]:zoom-out-95 peer-data-[state=open]:zoom-in-95 peer-data-[side=bottom]:slide-in-from-top-2 peer-data-[side=left]:slide-in-from-right-2 peer-data-[side=right]:slide-in-from-left-2 peer-data-[side=top]:slide-in-from-bottom-2",
        "absolute peer-data-[state=closed]:hidden",
        @variant_class,
        @class
      ]}
      {@rest}
    >
      <div class="">
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  @doc """
  Render
  """
  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def dropdown_shortcut(assigns) do
    ~H"""
    <span
      class={
        classes([
          "ml-auto text-xs tracking-widest opacity-60",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </span>
    """
  end

  defp toggle(js \\ %JS{}) do
    JS.toggle_attribute(js, {"data-state", "open", "closed"})
  end

  defp hide(js \\ %JS{}) do
    JS.set_attribute(js, {"data-state", "closed"})
  end
end
