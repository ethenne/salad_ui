defmodule MoonUI.Chip do
  @moduledoc false
  use MoonUI, :component

  @doc """
  Chip component, A two-state button that can be either on or off.

  ## Example:

      <.chip value="true" size="sm" variant="outline">Bold</.chip>
  """
  attr :id, :string, default: nil, doc: "An id for chip element"
  attr :name, :string, default: nil, doc: "A name for chip element"

  attr :field, Phoenix.HTML.FormField,
    default: nil,
    doc: "A form field struct retrieved from the form, for example: @form[:email]"

  attr :value, :boolean, default: false
  attr :"default-value", :any, values: [true, false, "true", "false"], default: false

  attr :disabled, :boolean, default: false
  attr :variant, :string, values: ~w(ghost outline), default: "outline"
  attr :size, :string, values: ~w(sm md), default: "md"
  attr :class, :string, default: ""
  attr :rest, :global
  slot :inner_block, required: true

  def chip(assigns) do
    assigns =
      prepare_assign(assigns)

    assigns =
      assigns
      |> assign_new(:checked, fn -> Phoenix.HTML.Form.normalize_value("checkbox", assigns.value) end)
      |> assign(:variant_class, variant(assigns))

    ~H"""
    <button
      onclick="this.querySelector('.toggle-input').click()"
      disabled={@disabled}
      type="button"
      class={
        classes([
          "moon-chip has-[:checked]:moon-chip-selected",
          @variant_class,
          @class
        ])
      }
    >
      <input type="hidden" name={@name} value="false" />
      <input
        type="checkbox"
        class="toggle-input hidden"
        id={@id}
        name={@name}
        value="true"
        checked={@checked}
        {@rest}
      />
      {render_slot(@inner_block)}
    </button>
    """
  end

  @variants %{
    variant: %{
      "ghost" => "moon-chip-ghost",
      "outline" => ""
    },
    size: %{
      "sm" => "moon-chip-sm",
      "md" => ""
    }
  }

  @default_variants %{
    variant: "outline",
    size: "md"
  }

  defp variant(props) do
    variants = Map.take(props, ~w(variant size)a)
    variants = Map.merge(@default_variants, variants)

    Enum.map_join(variants, " ", fn {key, value} -> @variants[key][value] end)
  end
end
