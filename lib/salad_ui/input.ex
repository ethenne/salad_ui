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
  attr :id, :string, default: nil, doc: "The id for the input field"
  attr :name, :string, default: nil, doc: "The name for the input field"
  attr :value, :string, default: nil, doc: "The value of the input field"
  attr :label, :string, doc: "The label for the input field"
  attr :error, :boolean, default: false, doc: "Set error state for input"
  attr :disabled, :boolean, default: false, doc: "Set disabled state"

  attr :type, :string,
    default: "text",
    values: ~w(date datetime-local email file hidden month number password tel text time url week),
    doc:
      "The type for the input field. Available list of types: date, datetime-local, email, file, hidden, month, number, password, tel, text, time, url, week. Default is text."

  attr :"default-value", :string, doc: "The default value for the input field"

  attr :field, Phoenix.HTML.FormField, doc: "A form field struct retrieved from the form, for example: @form[:email]"

  attr :class, :string, default: ""

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step options),
    doc: """
    Additional attributes for the input field from
    [MDN Input Attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#attributes)
    """

  slot(:hint, required: false, doc: "Information or Error massage") do
    attr(:class, :any, doc: "CSS class for the hint element")
  end

  def input(assigns) do
    assigns = prepare_assign(assigns)

    rest =
      Map.merge(assigns.rest, Map.take(assigns, [:id, :name, :value, :type]))

    assigns = assign(assigns, :rest, rest)

    ~H"""
    <div class={classes(["moon-form-group", @error && "text-destructive"])}>
      <label :if={@label} for={@id}>
        {@label}
      </label>
      <input class={classes(["moon-input", @class])} {@rest} disabled={@disabled} />
      <.hint hint={@hint} error={@error} disabled={@disabled} />
    </div>
    """
  end

  defp hint(assigns) do
    ~H"""
    <%= for hint <- @hint do %>
      <p role="alert" class="moon-form-hint">
        {render_slot(hint)}
      </p>
    <% end %>
    """
  end
end
