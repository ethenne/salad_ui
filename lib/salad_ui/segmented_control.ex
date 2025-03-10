defmodule SaladUI.SegmentedControl do
  @moduledoc false
  use SaladUI, :component

  @doc """
  A set of two-state buttons that can be toggled on or off.


  ## Example:

    <.segmented_control name="style" type="single" value="bold">
      <.segmented_control_item value="bold" builder={builder} aria-label="Toggle bold">
        <.icon name="hero-bold" class="h-4 w-4" />
      </.segmented_control_item>
      <.segmented_control_item value="italic" builder={builder} aria-label="Toggle italic">
        <.icon name="hero-italic" class="h-4 w-4" />
      </.segmented_control_item>
      <.segmented_control_item value="underline" builder={builder} aria-label="Toggle underline">
        <.icon name="hero-underline" class="h-4 w-4" />
      </.segmented_control_item>
    </.segmented_control>
  """
  attr :name, :string, default: nil
  attr :multiple, :any, values: [true, false, "true", "false"], default: false

  attr :field, Phoenix.HTML.FormField, doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :"default-value", :any, values: [true, false, "true", "false"]

  attr :value, :string,
    default: nil,
    doc: "The value of the toggle group. It's a single value for single type and a list of values for multiple type."

  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil
  attr :variant, :string, default: "default"
  attr :size, :string, default: "default"
  attr :rest, :global
  slot :inner_block

  def segmented_control(assigns) do
    assigns = prepare_assign(assigns)

    assigns =
      assign_new(assigns, :checked, fn -> Phoenix.HTML.Form.normalize_value("checkbox", assigns.multiple) end)

    ensure_valid_value_type!(assigns)

    ~H"""
    <div role="segmentlist" class="moon-segmented-control">
      {render_slot(@inner_block, assigns)}
    </div>
    """
  end

  defp ensure_valid_value_type!(%{value: value, multiple: multiple} = _assigns) do
    cond do
      multiple and not is_list(value) ->
        raise ArgumentError, "The value of the segmented control must be a list for multiple type."

      not multiple and not (is_nil(value) or is_binary(value)) ->
        raise ArgumentError, "The value of the segmented control must be a single value for single type."

      true ->
        nil
    end
  end

  attr :class, :string, default: nil
  attr :disabled, :boolean, default: false
  attr :value, :string, default: nil
  attr :builder, :map, required: true, doc: "The builder context of segmented control."
  attr :rest, :global
  slot :inner_block

  def segmented_control_item(%{builder: %{multiple: true}} = assigns) do
    assigns =
      assign(assigns, :checked, assigns.value in assigns.builder.value)

    ~H"""
    <button
      onclick="this.querySelector('.toggle-input').click()"
      type="button"
      role="segment"
      disabled={@disabled || @builder.disabled}
      class={
        classes([
          "moon-segment has-[:checked]:active",
          @class
        ])
      }
    >
      <input
        type="checkbox"
        class="toggle-input hidden"
        name={@builder.name}
        value={@value}
        checked={@checked}
        {@rest}
      />
      {render_slot(@inner_block)}
    </button>
    """
  end

  # single type
  def segmented_control_item(assigns) do
    assigns =
      assign(assigns, :checked, assigns.value == assigns.builder.value)

    ~H"""
    <button
      onclick="this.querySelector('.toggle-input').click()"
      role="segment"
      disabled={@disabled || @builder.disabled}
      class={
        classes([
          "moon-segment has-[:checked]:active",
          @class
        ])
      }
    >
      <input
        type="radio"
        class="toggle-input hidden"
        name={@builder.name}
        value={@value}
        checked={@checked}
        {@rest}
      />
      {render_slot(@inner_block)}
    </button>
    """
  end
end
