defmodule SaladUI.Button do
  @moduledoc false
  use SaladUI, :component

  @doc """
  Renders a button.

  ## Examples

      <.button>Send!</.button>
      <.button phx-click="go" class="ml-2">Send!</.button>
  """
  attr :label, :string, default: nil, doc: "If set, will change button text"
  attr :type, :string, default: "button", doc: "Type for button, submit | reset | button."
  attr :class, :string, default: nil, doc: "Tailwind class for the button"
  attr :disabled, :boolean, default: false

  attr :size, :string,
    values: ~w(xs sm md lg xl),
    default: "md",
    doc: "The button size style"

  attr :variant, :string,
    values: ~w(fill tonal destructive outline ghost),
    default: "fill",
    doc: "The button variant style"

  attr :icon_button, :boolean, default: false, doc: "Set the button as an icon button"
  attr :start_icon, :boolean, default: false, doc: "Set start button icon"
  attr :end_icon, :boolean, default: false, doc: "Set end button icon"

  attr :rest, :global, include: ~w(disabled form name value)

  slot :inner_block, required: true
  slot :svg, required: false

  def button(assigns) do
    assigns = assign(assigns, :variant_class, button_variant(assigns))

    ~H"""
    <button
      type={@type}
      class={
        classes([
          "moon-button",
          @variant_class,
          @class
        ])
      }
      disabled={@disabled}
      {@rest}
    >
      {render_button_content(assigns)}
    </button>
    """
  end

  defp render_button_content(%{icon_button: true, svg: svg} = assigns) when is_list(svg) and length(svg) > 0 do
    ~H"{render_slot(@svg)}"
  end

  defp render_button_content(%{icon_button: true} = assigns) do
    ~H"""
    <span class="hero-moonui" />
    """
  end

  defp render_button_content(%{label: label, start_icon: start_icon, end_icon: end_icon} = assigns)
       when not is_nil(label) and not start_icon and not end_icon do
    ~H"""
    <span>{@label}</span>
    """
  end

  defp render_button_content(%{start_icon: true, svg: svg, inner_block: inner_block, label: label} = assigns)
       when is_list(svg) and length(svg) > 0 do
    ~H"""
    <%= if is_list(@svg) and length(@svg) > 0 do %>
      {render_slot(@svg)}
    <% end %>

    <%= if label do %>
      {@label}
    <% else %>
      {render_slot(inner_block)}
    <% end %>
    """
  end

  defp render_button_content(%{start_icon: true, inner_block: inner_block} = assigns) do
    ~H"""
    <span class="hero-moonui" />
    {render_slot(inner_block)}
    """
  end

  defp render_button_content(%{end_icon: true, svg: svg, inner_block: inner_block, label: label} = assigns)
       when is_list(svg) and length(svg) > 0 do
    ~H"""
    <%= if label do %>
      {@label}
    <% else %>
      {render_slot(inner_block)}
    <% end %>
    <%= if is_list(@svg) and length(@svg) > 0 do %>
      {render_slot(@svg)}
    <% end %>
    """
  end

  defp render_button_content(%{end_icon: true, inner_block: inner_block} = assigns) do
    ~H"""
    {render_slot(inner_block)}
    <span class="hero-moonui" />
    """
  end

  defp render_button_content(%{inner_block: inner_block} = assigns) do
    ~H"{render_slot(inner_block)}"
  end
end
