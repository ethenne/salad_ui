defmodule MoonUI.Radio do
  @moduledoc false
  use MoonUI, :component

  @doc """
  radio component with customizable slots for label and input.

  ## Examples:
      <.radio>
        <:label>Accept terms</:label>
        <:radio id="custom-radio"/>
      </.radio>

      <.radio>
        <:radio id="custom-radio"/>
        <:label>Accept terms</:label>
      </.radio>
  """
  attr :name, :string, default: nil
  attr :value, :any, default: nil
  attr :class, :string, default: nil
  attr :id, :string, default: "moon-radio"
  attr :label, :string, default: nil
  attr :label_position, :string, default: "right", values: ~w(left right), doc: "Position of the label"
  attr :rest, :global

  slot :inner_block, required: false

  def radio(assigns) do
    assigns =
      assign_new(assigns, :checked, fn ->
        Phoenix.HTML.Form.normalize_value("radio", assigns.value)
      end)

    ~H"""
    <input type="hidden" name={@name} value="false" />

    <%= if @label do %>
      <div class="moon-radio-wrapper">
        <%= if @label && @label_position in ["left"] do %>
          <label for={@id}>
            {@label}
          </label>
        <% end %>
        <input
          id={@id}
          type="radio"
          class={classes(["moon-radio", @class])}
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
        type="radio"
        class={classes(["moon-radio", @class])}
        name={@name}
        value="true"
        checked={if @checked, do: "checked", else: nil}
        {@rest}
      />
    <% end %>
    """
  end
end
