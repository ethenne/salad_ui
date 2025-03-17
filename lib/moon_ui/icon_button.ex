defmodule MoonUI.IconButton do
  @moduledoc false
  use MoonUI, :component

  @doc """
  Renders a button.

  ## Examples

      <.button><.icon name="star"></.button>
      <.button phx-click="go" class="ml-2"><.icon name="star"></.button>
  """
  attr :id, :string, default: nil, doc: "An id for the button element"
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

  attr :rest, :global, include: ~w(disabled form name value)

  slot :inner_block, required: true

  def icon_button(assigns) do
    assigns = assign(assigns, :variant_class, icon_button_variant(assigns))

    ~H"""
    <button
      class={
        classes([
          "moon-icon-button",
          @variant_class,
          @class
        ])
      }
      disabled={@disabled}
      {@rest}
    >
       {render_slot(@inner_block)}
    </button>
    """
  end

  @variants %{
    variant: %{
      "fill" => "",
      "tonal" => "moon-icon-button-tonal",
      "destructive" => "moon-icon-button-destructive",
      "outline" => "moon-icon-button-outline",
      "ghost" => "moon-icon-button-ghost"
    },
    size: %{
      "xs" => "moon-icon-button-xs",
      "sm" => "moon-icon-button-sm",
      "md" => "moon-icon-button-md",
      "lg" => "moon-icon-button-lg",
      "xl" => "moon-icon-button-xl"
    }
  }

  @default_variants %{
    variant: "fill",
    size: "md"
  }

  def icon_button_variant(props \\ %{}) do
    variants = Map.take(props, ~w(variant size)a)
    variants = Map.merge(@default_variants, variants)

    variation_classes = Enum.map_join(variants, " ", fn {key, value} -> @variants[key][value] end)

    "#{variation_classes}"
  end
end
