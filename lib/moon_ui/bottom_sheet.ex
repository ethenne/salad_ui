defmodule MoonUI.BottomSheet do
  @moduledoc """
  Implement bottom sheet componet from https://ui.shadcn.com/docs/components/sheet

  ## Example:

      <.bottom_sheet show>
        <.bottom_sheet_trigger target="test">
          <.button variant="outline">open</.button>
        </.bottom_sheet_trigger>
        <.bottom_sheet_content id="test" side="start">
          <.bottom_sheet_header>
            <.bottom_sheet_title>Edit profile</.bottom_sheet_title>
            <.bottom_sheet_description>
              Make changes to your profile here. Click save when you're done.
            </.bottom_sheet_description>
          </.bottom_sheet_header>
          <div class="grid gap-4 py-4">
            <div class="grid grid-cols-4 items-center gap-4">
              <.label for="name" class="text-right">
                Name
              </.label>
              <Input.input id="name" name="name" value="pedro duarte" class="col-span-3" />
            </div>
            <div class="grid grid-cols-4 items-center gap-4">
              <.label for="username" class="text-right">
                Username
              </.label>
              <Input.input id="username" name="username" value="@peduarte" class="col-span-3" />
            </div>
          </div>
          <.bottom_sheet_footer>
            <.bottom_sheet_close target="test">
              <.button type="submit" phx-click="save">save changes</.button>
            </.bottom_sheet_close>
          </.bottom_sheet_footer>
        </.bottom_sheet_content>
      </.bottom_sheet>
  """
  use MoonUI, :component

  attr :class, :string, default: "inline-block"
  slot :inner_block, required: true

  def bottom_sheet(assigns) do
    ~H"""
    <div class={classes([@class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: "inner-block"
  attr :target, :string, required: true, doc: "The id of the bottom sheet to open"
  slot :inner_block, required: true

  def bottom_sheet_trigger(assigns) do
    ~H"""
    <div class={classes([@class])} phx-click={JS.exec("phx-show-bottom-sheet", to: "#" <> @target)}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil

  defp bottom_sheet_overlay(assigns) do
    ~H"""
    <div
      class={
        classes([
          "bottom-sheet-overlay fixed hidden inset-0 z-50 bg-black/80",
          @class
        ])
      }
      aria-hidden="true"
    >
    </div>
    """
  end

  attr :id, :string,
    default: nil,
    doc: "The id of the bottom sheet, this is the target of bottom_sheet_trigger"

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true
  slot :custom_close_btn, required: false

  def bottom_sheet_content(assigns) do
    ~H"""
    <div
      class="bottom-sheet-content relative z-50"
      id={@id}
      phx-show-bottom-sheet={@id && show_bottom_sheet(@id)}
      phx-hide-bottom-sheet={@id && hide_bottom_sheet(@id)}
      {@rest}
    >
      <.bottom_sheet_overlay />
      <.focus_wrap
        id={"bottom-sheet-#{@id}"}
        phx-window-keydown={@id && JS.exec("phx-hide-bottom-sheet", to: "#" <> @id)}
        phx-key="escape"
        phx-click-away={@id && JS.exec("phx-hide-bottom-sheet", to: "#" <> @id)}
        role="bottom-sheet"
        class={
          classes([
            "bottom-sheet-content-wrap hidden fixed z-50 bg-primary shadow-lg transition inset-x-0 bottom-0 border-t",
            @class
          ])
        }
      >
        <div class={classes(["relative h-full"])}>
          <div class={classes(["p-6 overflow-y-auto h-full", @class])}>
            {render_slot(@inner_block)}
          </div>

          <%= if close_btn = render_slot(@custom_close_btn) do %>
            {close_btn}
          <% else %>
            <button
              type="button"
              class="ring-offset-background absolute top-4 right-4 rounded-sm opacity-70 transition-opacity hover:opacity-100 focus:ring-ring focus:outline-none focus:ring-2 focus:ring-offset-2 disabled:pointer-events-none"
              phx-click={hide_bottom_sheet(@id)}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="size-6 no-collapse h-4 w-4"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
              </svg>

              <span class="sr-only">Close</span>
            </button>
          <% end %>
        </div>
      </.focus_wrap>
    </div>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def bottom_sheet_header(assigns) do
    ~H"""
    <div class={classes(["flex flex-col space-y-2 text-center sm:text-left", @class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def bottom_sheet_title(assigns) do
    ~H"""
    <h3 class={classes(["text-lg font-semibold text-foreground", @class])}>
      {render_slot(@inner_block)}
    </h3>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def bottom_sheet_description(assigns) do
    ~H"""
    <p class={classes(["text-sm text-muted-foreground", @class])}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def bottom_sheet_footer(assigns) do
    ~H"""
    <div class={classes(["flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2", @class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :target, :string, required: true, doc: "The id of the bottom sheet tag to close"
  slot :inner_block, required: true

  def bottom_sheet_close(assigns) do
    ~H"""
    <div class={classes(["", @class])} phx-click={JS.exec("phx-hide-bottom-sheet", to: "#" <> @target)}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  defp show_bottom_sheet(js \\ %JS{}, id) when is_binary(id) do
    js
    |> JS.show(
      to: "##{id} .bottom-sheet-overlay",
      transition: {"transition ease-in-out", "opacity-0", "opacity-100"},
      time: 600
    )
    |> JS.show(
      to: "##{id} .bottom-sheet-content-wrap",
      transition: {"transition ease-in-out", "translate-y-full", "translate-y-0"},
      time: 600
    )
    |> JS.add_class("overflow-hidden", to: "body")
    |> JS.focus_first(to: "##{id} .bottom-sheet-content-wrap")
  end

  defp hide_bottom_sheet(js \\ %JS{}, id) do
    js
    |> JS.hide(
      to: "##{id} .bottom-sheet-overlay",
      transition: {"transition ease-in-out", "opacity-100", "opacity-0"},
      time: 400
    )
    |> JS.hide(
      to: "##{id} .bottom-sheet-content-wrap",
      transition: {"transition ease-in-out", "translate-y-0", "translate-y-full"},
      time: 400
    )
    |> JS.remove_class("overflow-hidden", to: "body")
    |> JS.pop_focus()
  end
end
