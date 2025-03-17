defmodule MoonUI do
  @moduledoc false
  def component do
    quote do
      use Phoenix.Component

      import MoonUI.Helpers

      # alias OrangeCmsWeb.Components.LadUI.LadJS
      alias Phoenix.LiveView.JS

      defp classes(input) do
        TwMerge.merge(input)
      end
    end
  end

  @doc """
  When used, dispatch to the appropriate macro.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__(_) do
    quote do
      import MoonUI.Accordion
      import MoonUI.Alert
      import MoonUI.AlertDialog
      import MoonUI.Authenticator
      import MoonUI.Avatar
      import MoonUI.Badge
      import MoonUI.Breadcrumb
      import MoonUI.Button
      import MoonUI.Card
      import MoonUI.Chart
      import MoonUI.Checkbox
      import MoonUI.Chip
      import MoonUI.Collapsible
      import MoonUI.Dialog
      import MoonUI.Dropdown
      import MoonUI.Form
      import MoonUI.Helpers
      import MoonUI.HoverCard
      import MoonUI.Icon
      import MoonUI.Input
      import MoonUI.Label
      import MoonUI.Loader
      import MoonUI.Menu
      import MoonUI.Pagination
      import MoonUI.Placeholder
      import MoonUI.Popover
      import MoonUI.Progress
      import MoonUI.Radio
      import MoonUI.RadioGroup
      import MoonUI.ScrollArea
      import MoonUI.SegmentedControl
      import MoonUI.Select
      import MoonUI.Separator
      import MoonUI.Drower
      import MoonUI.BottomSheet
      import MoonUI.Sidebar
      import MoonUI.Skeleton
      import MoonUI.Slider
      import MoonUI.Switch
      import MoonUI.Table
      import MoonUI.Tabs
      import MoonUI.Tag
      import MoonUI.Textarea
      import MoonUI.Toggle
      import MoonUI.ToggleGroup
      import MoonUI.Tooltip
      import MoonUI.IconButton
      import MoonUI.List
      import MoonUI.CircularProgress
      import MoonUI.Snackbar
    end
  end
end
