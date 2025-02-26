defmodule SaladUI.Input do
  @moduledoc false
  use SaladUI, :component

  @doc """
  Displays a form input field or a component that looks like an input field.

  ## Examples

      <.input type="text" placeholder="Enter your name" />
      <.input type="email" placeholder="Enter your email" />
      <.input type="password" placeholder="Enter your password" />
  """
  attr :id, :any, default: nil
  attr :name, :any, default: nil
  attr :value, :any

  attr :type, :string,
    default: "text",
    values: ~w(date datetime-local email file hidden month number password tel text time url week)

  attr :"default-value", :any

  attr :field, Phoenix.HTML.FormField, doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :class, :string, default: "moon-input"
  attr :rest, :global, include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step options)

  def input(assigns) do
    assigns = prepare_assign(assigns)

    rest =
      Map.merge(assigns.rest, Map.take(assigns, [:id, :name, :value, :type]))

    assigns = assign(assigns, :rest, rest)

    ~H"""
    <input class={classes(@class)} {@rest} />
    """
  end
end
