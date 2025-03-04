defmodule SaladUI.Checkbox do
  @moduledoc false
  use SaladUI, :component

  @doc """
  Implement checkbox input component

  ## Examples:
      <.checkbox name="agree" value={true} />
  """
  attr :name, :any, default: nil
  attr :value, :any, default: nil
  attr :"default-value", :any, values: [true, false, "true", "false"], default: false
  attr :field, Phoenix.HTML.FormField
  attr :class, :string, default: nil
  attr :rest, :global

  def checkbox(assigns) do
    assigns =
      prepare_assign(assigns)

    assigns =
      assign_new(assigns, :checked, fn -> Phoenix.HTML.Form.normalize_value("checkbox", assigns.value) end)

    ~H"""
    <input type="hidden" name={@name} value="false" />
    <input
      id="moon-checkbox"
      type="checkbox"
      class={
        classes([
          "moon-checkbox",
          @class
        ])
      }
      name={@name}
      value="true"
      checked={@checked}
      {@rest}
    />
    """
  end
end
