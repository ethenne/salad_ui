defmodule SaladUI.Alert do
  @moduledoc false
  use SaladUI, :component

  @doc """
  Render alert

  ## Examples

      <.alert>
        <.alert_title>Alert title</.alert_title>
        <.alert_description>Alert description</.alert_description>
      </.alert>
  """

  attr :variant, :string,
    values: ~w(positive negative neutral caution info discovery),
    default: "neutral",
    doc: "the alert variant style"

  attr :class, :string, default: nil
  slot :inner_block, required: true
  slot :action, required: false
  attr :rest, :global, default: %{}

  def alert(assigns) do
    assigns = assign(assigns, :variant_class, variant(assigns))

    ~H"""
    <div
      class={
        classes([
          "moon-alert items-start justify-between",
          @variant_class,
          @class
        ])
      }
      {@rest}
    >
      <div>{render_slot(@inner_block)}</div>
      <div class="moon-alert-action flex gap-2 !h-5">{render_slot(@action)}</div>
    </div>
    """
  end

  @doc """
  Render alert title
  """
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(disabled form name value)
  slot :inner_block, required: true

  def alert_title(assigns) do
    render_title_comnponent(assigns)
  end

  defp render_title_comnponent(assigns) do
    ~H"""
    <h5
      class={
        classes([
          "moon-alert-title",
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
  Render alert description
  """
  attr :class, :string, default: nil
  attr :variant, :string, default: "neutral", values: ~w(positive negative neutral caution info discovery)
  attr :rest, :global, include: ~w(disabled form name value)
  slot :title, required: true
  slot :content, required: true

  def alert_description(assigns) do
    ~H"""
    <p
      class={
        classes([
          "moon-alert-content",
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
      "positive" => "moon-alert-positive",
      "negative" => "moon-alert-negative",
      "info" => "moon-alert-info",
      "caution" => "moon-alert-caution",
      "neutral" => "moon-alert-neutral",
      "discovery" => "moon-alert-discovery"
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
