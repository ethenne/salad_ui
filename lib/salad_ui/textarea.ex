defmodule SaladUI.Textarea do
  @moduledoc false
  use SaladUI, :component

  @doc """
  Displays a form textarea

  ## Example

  ```heex
      <.textarea field={f[:description]} placeholder="Type your message here" />
  ```


  """
  attr :id, :any, default: nil
  attr :name, :string, default: nil
  attr :value, :string
  attr :class, :any, default: nil
  attr :label, :string, default: nil, doc: "The label for the textarea"
  attr :error, :boolean, default: false, doc: "Set error state for textarea"
  attr :disabled, :boolean, default: false, doc: "Set disabled state"

  attr :rest, :global

  slot(:hint, required: false, doc: "Information or Error massage") do
    attr(:class, :any, doc: "CSS class for the hint element")
  end

  def textarea(assigns) do
    assigns = prepare_assign(assigns)

    rest =
      Map.merge(assigns.rest, Map.take(assigns, [:id, :name, :value, :type]))

    assigns = assign(assigns, :rest, rest)

    ~H"""
    <div class={classes(["moon-form-group", @error && "moon-form-group-error"])}>
      <label :if={@label} for={@id}>
        {@label}
      </label>

      <textarea
        class={
          classes([
            "moon-textarea",
            @class
          ])
        }
        {%{id: @id, name: @name, disabled: @disabled}}
        {@rest}
      ><%= Phoenix.HTML.Form.normalize_value("textarea", assigns[:value]) %></textarea>

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
