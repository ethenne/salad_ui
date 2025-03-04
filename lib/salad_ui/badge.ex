defmodule SaladUI.Badge do
  @moduledoc false
  use SaladUI, :component

  @doc """
  Renders a badge component

  ## Examples

      <.badge>Badge</.badge>
      <.badge variant="destructive">Badge</.badge>
  """
  attr :class, :string, default: nil

  attr :variant, :string,
    values: ~w(positive negative info outline),
    default: "positive",
    doc: "the badge variant style"

  attr :rest, :global
  slot :inner_block, required: true

  def badge(assigns) do
    assigns = assign(assigns, :variant_class, variant(assigns))

    ~H"""
    <div
      class={
        classes([
          "moon-badge",
          @variant_class,
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  @variants %{
    variant: %{
      "positive" => "bg-positive hover:bg-primary/80",
      "negative" => "bg-negative hover:bg-secondary/80",
      "info" => "bg-info hover:bg-destructive/80",
      "outline" => "bg-transparent text-primary border border-primary"
    }
  }

  @default_variants %{
    variant: "primary"
  }

  defp variant(props) do
    variants = Map.merge(@default_variants, props)

    Enum.map_join(variants, " ", fn {key, value} -> @variants[key][value] end)
  end
end
