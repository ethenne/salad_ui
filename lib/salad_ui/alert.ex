defmodule SaladUI.Alert do
  @moduledoc false
  use SaladUI, :component

  @doc """
  Render alert

  ## Examples

      <.alert variant="destructive">
        <.alert_title>Alert title</.alert_title>
        <.alert_description>Alert description</.alert_description>
      </.alert>
  """

  attr :variant, :string, default: "default", values: ~w(default destructive)
  attr :class, :string, default: nil
  slot :inner_block, required: true
  attr :rest, :global, default: %{}

  def alert(assigns) do
    ~H"""
    <div
      class={
        classes([
          "relative w-full rounded-lg border p-4 [&>span~*]:pl-7 [&>span+div]:translate-y-[-3px] [&>span]:absolute [&>span]:left-4 [&>span]:top-4",
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

  @doc """
  Render alert title
  """
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(disabled form name value)
  slot :inner_block, required: true

  def alert_title(assigns) do
    ~H"""
    <h5
      class={
        classes([
          "mb-1 font-medium leading-none tracking-tight",
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
    <div
      class={
        classes([
          "moon-alert",
          @class
        ])
      }
      {@rest}
    >
      {render_alert_content(assigns)}
    </div>
    """
  end

  defp render_alert_content(%{content: content} = assigns) when not content do
    ~H"""
    <span class="title">{@title}</span>
    """
  end

  defp render_alert_content(assigns) do
    ~H"""
    <div>
      <div class="title-wrapper">
        <span class="title">{@title}</span>
      </div>
      <p class="tcontent">{@content}</p>
    </div>
    """
  end
end
