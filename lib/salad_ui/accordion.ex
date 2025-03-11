defmodule MoonUI.Accordion do
  @moduledoc """
  Accordion component for displaying collapsible content.

  ## Example

  <.accordion>
    <.accordion_item>
      <.accordion_trigger group="exclusive">
        Is it accessible?
      </.accordion_trigger>
      <.accordion_content>
        Yes. It adheres to the WAI-ARIA design pattern.
      </.accordion_content>
    </.accordion_item>
    <.accordion_item>
      <.accordion_trigger group="exclusive">
        Is it styled?
      </.accordion_trigger>
      <.accordion_content>
        Yes. It comes with default styles that matches the other components' aesthetic.
      </.accordion_content>
    </.accordion_item>
    <.accordion_item>
      <.accordion_trigger group="exclusive">
        Is it animated?
      </.accordion_trigger>
      <.accordion_content>
        Yes. It's animated by default, but you can disable it if you prefer.
      </.accordion_content>
    </.accordion_item>
  </.accordion>
  """
  use MoonUI, :component

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def accordion(assigns) do
    ~H"""
    <div class={classes(["moon-accordion", @class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def accordion_item(assigns) do
    ~H"""
    <div class={classes(["moon-accordion-item item", @class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :group, :string, default: nil
  attr :class, :string, default: nil
  attr :open, :boolean, default: false
  slot :inner_block, required: true

  def accordion_trigger(assigns) do
    ~H"""
    <details name={@group} class="group/accordion peer/accordion item" open={@open}>
      <summary class={
        classes([
          "moon-accordion-title list-none cursor-pointer",
          @class
        ])
      }>
        <p class="font-medium">
          {render_slot(@inner_block)}
        </p>
      </summary>
    </details>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def accordion_content(assigns) do
    ~H"""
    <div class="moon-accordion-content">
      <div class="overflow-hidden">
        <div class={classes(["pb-4 pt-0", @class])}>
          {render_slot(@inner_block)}
        </div>
      </div>
    </div>
    """
  end
end
