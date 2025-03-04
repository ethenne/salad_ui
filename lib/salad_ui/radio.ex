defmodule SaladUI.Radio do
  @moduledoc false

  use SaladUI, :component

  @doc """
  Implement radio input component
  """
  attr :name, :any, default: nil
  attr :value, :any, default: nil
  attr :"default-value", :any, values: [true, false, "true", "false"], default: false
  attr :field, Phoenix.HTML.FormField
  attr :class, :string, default: nil
  attr :rest, :global

  def radio(assigns) do
    assigns =
      prepare_assign(assigns)

    assigns =
      assign_new(assigns, :checked, fn -> Phoenix.HTML.Form.normalize_value("radio", assigns.value) end)

    ~H"""
    <input
      type="radio"
      id="moon-radio"
      class="moon-radio"
      name={@name}
      value={@value}
      checked={normalize_boolean(@checked)}
      {@rest}
    />
    """
  end
end
