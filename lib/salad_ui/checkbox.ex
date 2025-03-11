defmodule MoonUI.Checkbox do
  @moduledoc false
  use MoonUI, :component

  @doc """
  Checkbox component with customizable slots for label and input.

  ## Examples:
      <.checkbox>
        <:label>Accept terms</:label>
        <:checkbox id="custom-checkbox"/>
      </.checkbox>

      <.checkbox>
        <:checkbox id="custom-checkbox"/>
        <:label>Accept terms</:label>
      </.checkbox>
  """
  attr :name, :string, default: nil
  attr :value, :any, default: nil
  attr :class, :string, default: nil
  attr :id, :string, default: "moon-checkbox"
  attr :label, :string, default: nil
  attr :label_position, :string, default: "right", values: ~w(left right), doc: "Position of the label"
  attr :rest, :global

  slot :inner_block, required: false

  def checkbox(assigns) do
    assigns =
      assign_new(assigns, :checked, fn ->
        Phoenix.HTML.Form.normalize_value("checkbox", assigns.value)
      end)

    ~H"""
    <input type="hidden" name={@name} value="false" />

    <%= if @label do %>
      <div class="moon-checkbox-wrapper">
        <%= if @label && @label_position in ["left"] do %>
          <label for={@id}>
            {@label}
          </label>
        <% end %>
        <input
          id={@id}
          type="checkbox"
          class={classes(["moon-checkbox", @class])}
          name={@name}
          value="true"
          checked={if @checked, do: "checked", else: nil}
          {@rest}
        />
        <%= if @label && @label_position in ["right"] do %>
          <label for={@id}>
            {@label}
          </label>
        <% end %>
      </div>
    <% else %>
      <input
        id={@id}
        type="checkbox"
        class={classes(["moon-checkbox", @class])}
        name={@name}
        value="true"
        checked={if @checked, do: "checked", else: nil}
        {@rest}
      />
    <% end %>
    """
  end
end
