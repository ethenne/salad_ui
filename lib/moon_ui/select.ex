defmodule MoonUI.Select do
  @moduledoc """
  A form input designed for value selection: in its collapsed state, it reveals the presently chosen option, and upon expansion, it presents a scrollable list of predetermined choices for the user's selection.

  In a collapsed state, it reveals the currently selected option, and upon expansion, it displays a scrollable list of predefined choices for the user's selection.
  """
  use MoonUI, :component

  attr(:id, :any, default: nil)
  attr(:field, Phoenix.HTML.FormField, doc: "a form field struct retrieved from the form, for example: @form[:email]")
  attr(:label, :string, default: nil, doc: "The label for the select")
  attr(:name, :any, default: nil)
  attr(:error, :boolean, default: false, doc: "Set error state for select")
  attr(:disabled, :boolean, default: false, doc: "Set disabled state")
  attr(:readonly, :boolean, default: false, doc: "Set readonly state")
  attr(:multiple, :boolean, default: false, doc: "Allow multiple selections")
  attr(:rest, :global, doc: "Other attributes of the Select")
  attr(:size, :string, default: "md", values: ~w(sm md lg), doc: "Size for select")
  attr(:class, :string, default: "", doc: "CSS class for the hint element")

  slot(:inner_block, required: false)

  slot(:hint, required: false, doc: "Information or Error massage") do
    attr(:class, :any, doc: "CSS class for the hint element")
  end

  def select(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(
      field: nil,
      id: field.id,
      name: field.name
    )
    |> select()
  end

  def select(assigns) do
    ~H"""
    <div class={classes(["moon-form-group", @error && "moon-form-group-error"])}>
      <label :if={@label} for={@id}>
        {@label}
      </label>
      <span>
        <select
          id={@id}
          name={@name}
          disabled={@disabled || @readonly}
          multiple={@multiple}
          aria-label={@label}
          class={classes(["moon-select", @error && "moon-select-error"])}
          {@rest}
        >
          {render_slot(@inner_block)}
        </select>
      </span>
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
