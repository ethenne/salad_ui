defmodule MoonUI.Progress do
  @moduledoc false
  use MoonUI, :component

  @doc """
  Render progress bar

  ## Example


      <.progress class="w-[60%]" value={20}/>

  """
  attr :class, :string, default: nil, doc: "Class for the progress bar"
  attr :id, :string, default: "moon-linear-progress"

  attr :value, :integer, default: 0, doc: "The value of progress bar"
  attr :max, :integer, default: 100, doc: "The maximum value of progress bar"
  attr :size, :string, default: "2xs", values: ~w(2xs 3xs), doc: "Size of the progress bar"
  attr :label, :string, default: nil, doc: "Label for the progress bar"

  attr :label_position, :string,
    default: "bottom",
    values: ~w(top bottom),
    doc: "Position of the label"

  attr :rest, :global

  def progress(assigns) do
    assigns = assign(assigns, :value, normalize_integer(assigns[:value]))

    ~H"""
    <%= if @label do %>
      <div class="moon-linear-progress-wrapper">
        <%= if @label && @label_position in ["top"] do %>
          <label for={@id}>
            {@label}
          </label>
        <% end %>

        <div class={classes(["moon-linear-progress", if(@size == "3xs", do: "moon-linear-progress-3xs", else: nil), @class])} style={"--progress-value: #{@value}%;"} {@rest}>
            <div
              class="moon-linear-progress-bar"
            >
            </div>
        </div>

        <%= if @label && @label_position in ["bottom"] do %>
          <label for={@id}>
            {@label}
          </label>
        <% end %>
      </div>
    <% else %>
      <div class={classes(["moon-linear-progress", if(@size == "3xs", do: "moon-linear-progress-3xs", else: nil), @class])} style={"--progress-value: #{@value}%;"} {@rest}>
        <div
          class="moon-linear-progress-bar"
        >
        </div>
      </div>
    <% end %>
    """
  end
end
