defmodule MoonUI.Snackbar do
  @moduledoc false
  use MoonUI, :component

  @doc """
  Render snackbar

  ## Examples

      <.snackbar>
        <.snackbar_title>snackbar title</.snackbar_title>
        <.snackbar_description>snackbar description</.snackbar_description>
      </.snackbar>
  """

  attr :variant, :string,
    values: ~w(positive negative neutral caution info discovery),
    default: "neutral",
    doc: "the snackbar variant style"

  attr :class, :string, default: nil
  slot :inner_block, required: true
  slot :action, required: false
  attr :rest, :global, default: %{}

  def snackbar(assigns) do
    assigns = assign(assigns, :variant_class, variant(assigns))

    ~H"""
    <div
      class={
        classes([
          "moon-snackbar items-start justify-between",
          @variant_class,
          @class
        ])
      }
      {@rest}
    >
      <div>{render_slot(@inner_block)}</div>
      <%= if @action && !Enum.empty?(@action) do %>
      <div class="moon-snackbar-action flex gap-2 !h-5">
        {render_slot(@action)}
      </div>
      <% end %>
    </div>
    """
  end

  @doc """
  Render snackbar title
  """
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(disabled form name value)
  slot :inner_block, required: true

  def snackbar_title(assigns) do
    render_title_comnponent(assigns)
  end

  defp render_title_comnponent(assigns) do
    ~H"""
    <h5
      class={
        classes([
          "moon-snackbar-title",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </h5>
    """
  end

  @doc """
  Render snackbar description
  """
  attr :class, :string, default: nil

  attr :variant, :string,
    default: "neutral",
    values: ~w(positive negative neutral caution info discovery)

  attr :rest, :global, include: ~w(disabled form name value)
  slot :title, required: true
  slot :content, required: true

  def snackbar_description(assigns) do
    ~H"""
    <p
      class={
        classes([
          "moon-snackbar-content",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </p>
    """
  end

  @variants %{
    variant: %{
      "positive" => "moon-snackbar-positive",
      "negative" => "moon-snackbar-negative",
      "info" => "moon-snackbar-info",
      "caution" => "moon-snackbar-caution",
      "neutral" => "moon-snackbar-neutral",
      "discovery" => "moon-snackbar-discovery"
    }
  }

  @default_variants %{
    variant: "neutral"
  }

  defp variant(props) do
    variants = Map.merge(@default_variants, props)

    Enum.map_join(variants, " ", fn {key, value} -> @variants[key][value] end)
  end
end
