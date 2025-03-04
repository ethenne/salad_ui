defmodule SaladUI.Switch do
  @moduledoc false
  use SaladUI, :component

  @doc """
  Implement checkbox input component

  ## Examples:

  """
  attr :id, :string, required: true
  attr :name, :string, default: nil
  attr :value, :boolean, default: nil
  attr :field, Phoenix.HTML.FormField, doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :"default-value", :any, values: [true, false, "true", "false"], default: false
  attr :class, :string, default: nil
  attr :disabled, :boolean, default: false
  attr :rest, :global

  def switch(assigns) do
    assigns =
      prepare_assign(assigns)

    assigns =
      assign_new(assigns, :checked, fn -> Phoenix.HTML.Form.normalize_value("checkbox", assigns.value) end)

    ~H"""
    <input
      id={@id}
      type="checkbox"
      class="moon-switch"
      name={@name}
      value="true"
      checked={@checked}
      disabled={@disabled}
      {@rest}
    />
    """
  end
end
