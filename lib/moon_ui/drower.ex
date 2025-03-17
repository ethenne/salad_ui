defmodule MoonUI.Drower do
  @moduledoc """
  Implement drower componet https://ui.shadcn.com/docs/components/sheet

  ## Example:

      <.drower show>
        <.drower_trigger target="test">
          <.button variant="outline">open</.button>
        </.drower_trigger>
        <.drower_content id="test" side="start">
          <.drower_header>
            <.drower_title>Edit profile</.drower_title>
            <.drower_description>
              Make changes to your profile here. Click save when you're done.
            </.drower_description>
          </.drower_header>
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
          <.drower_footer>
            <.drower_close target="test">
              <.button type="submit" phx-click="save">save changes</.button>
            </.drower_close>
          </.drower_footer>
        </.drower_content>
      </.drower>
  """
  use MoonUI, :component

  attr :class, :string, default: "inline-block"
  slot :inner_block, required: true

  def drower(assigns) do
    ~H"""
    <div class={classes([@class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: "inner-block"
  attr :target, :string, required: true, doc: "The id of the drower to open"
  slot :inner_block, required: true

  def drower_trigger(assigns) do
    ~H"""
    <div class={classes([@class])} phx-click={JS.exec("phx-show-drower", to: "#" <> @target)}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil

  defp drower_overlay(assigns) do
    ~H"""
    <div
      class={
        classes([
          "drower-overlay fixed hidden inset-0 z-50 bg-black/80",
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
    doc: "The id of the drower, this is the target of drower_trigger"

  attr :class, :string, default: nil
  attr :side, :string, default: "end", values: ~w(start end), doc: "The side of the drower"
  attr :rest, :global
  slot :inner_block, required: true
  slot :custom_close_btn, required: false

  def drower_content(assigns) do
    variant_class =
      case assigns.side do
        "start" -> "inset-y-0 left-0 h-full w-3/4 border-r sm:max-w-sm"
        "end" -> "inset-y-0 right-0 h-full w-3/4  border-l sm:max-w-sm"
      end

    assigns = assign(assigns, :variant_class, variant_class)

    ~H"""
    <div
      class="drower-content relative z-50"
      id={@id}
      phx-show-drower={@id && show_drower(@id, @side)}
      phx-hide-drower={@id && hide_drower(@id, @side)}
      {@rest}
    >
      <.drower_overlay />
      <.focus_wrap
        id={"drower-#{@id}"}
        phx-window-keydown={@id && JS.exec("phx-hide-drower", to: "#" <> @id)}
        phx-key="escape"
        phx-click-away={@id && JS.exec("phx-hide-drower", to: "#" <> @id)}
        role="drower"
        class={
          classes([
            "drower-content-wrap hidden fixed z-50 bg-primary shadow-lg transition",
            @variant_class,
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
              phx-click={hide_drower(@id, @side)}
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

  def drower_header(assigns) do
    ~H"""
    <div class={classes(["flex flex-col space-y-2 text-center sm:text-left", @class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def drower_title(assigns) do
    ~H"""
    <h3 class={classes(["text-lg font-semibold text-foreground", @class])}>
      {render_slot(@inner_block)}
    </h3>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def drower_description(assigns) do
    ~H"""
    <p class={classes(["text-sm text-muted-foreground", @class])}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true

  def drower_footer(assigns) do
    ~H"""
    <div class={classes(["flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2", @class])}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :target, :string, required: true, doc: "The id of the drower tag to close"
  slot :inner_block, required: true

  def drower_close(assigns) do
    ~H"""
    <div class={classes(["", @class])} phx-click={JS.exec("phx-hide-drower", to: "#" <> @target)}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  defp show_drower(js \\ %JS{}, id, side) when is_binary(id) do
    transition =
      case side do
        "start" -> {"transition ease-in-out", "-translate-x-full", "translate-x-0"}
        "end" -> {"transition ease-in-out", "translate-x-full", "translate-x-0"}
      end

    js
    |> JS.show(
      to: "##{id} .drower-overlay",
      transition: {"transition ease-in-out", "opacity-0", "opacity-100"},
      time: 600
    )
    |> JS.show(
      to: "##{id} .drower-content-wrap",
      transition: transition,
      time: 600
    )
    |> JS.add_class("overflow-hidden", to: "body")
    |> JS.focus_first(to: "##{id} .sheet-content-wrap")
  end

  defp hide_drower(js \\ %JS{}, id, side) do
    transition =
      case side do
        "start" -> {"transition ease-in-out", "translate-x-0", "-translate-x-full"}
        "end" -> {"transition ease-in-out", "translate-x-0", "translate-x-full"}
      end

    js
    |> JS.hide(
      to: "##{id} .drower-overlay",
      transition: {"transition ease-in-out", "opacity-100", "opacity-0"},
      time: 400
    )
    |> JS.hide(to: "##{id} .drower-content-wrap", transition: transition, time: 400)
    |> JS.remove_class("overflow-hidden", to: "body")
    |> JS.pop_focus()
  end
end
