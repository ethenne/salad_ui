defmodule SaladUI.Authenticator do
  @moduledoc false
  use SaladUI, :component

  @doc """
    The authenticator component is used to display a tag.

  """

  attr :class, :string, default: nil, doc: "The class of the authenticator."
  attr :label, :string, default: nil, doc: "The label for the authenticator field"
  attr :disabled, :boolean, default: false, doc: "Set disabled state"
  attr :error, :boolean, default: false, doc: "Set error state for authenticator"

  slot :inner_block, required: true, doc: "The slot for authenticator items."

  slot(:hint, required: false, doc: "Information or Error massage") do
    attr(:class, :any, doc: "CSS class for the hint element")
  end

  def authenticator(assigns) do
    ~H"""
    <label :if={@label} for={@id}>
      {@label}
    </label>
    <div class={
      classes(["moon-authenticator border-transparent", @error && "moon-authenticator-error", @class])
    }>
      {render_slot(@inner_block)}
    </div>
    <.hint hint={@hint} error={@error} disabled={@disabled} />
    """
  end

  attr :disabled, :boolean, default: false, doc: "Set disabled state"

  def authenticator_item(assigns) do
    ~H"""
    <input type="text" maxlength="1" disabled={@disabled} />
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
