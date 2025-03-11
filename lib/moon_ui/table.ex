defmodule MoonUI.Table do
  @moduledoc """
  Implement of table components from https://ui.shadcn.com/docs/components/table
  """
  use MoonUI, :component

  @doc """
  Table component

  ## Examples:

    <.table>
       <.table_caption>A list of your recent invoices.</.table_caption>
       <.table_header>
         <.table_row>
           <.table_head class="w-[100px]">id</.table_head>
           <.table_head>Title</.table_head>
           <.table_head>Status</.table_head>
           <.table_head class="text-right">action</.table_head>
         </.table_row>
       </.table_header>
       <.table_body>
         <.table_row :for={{id, entry} <- @streams.content_entries} id={id}>
           <.table_cell class="font-medium"><%= id %></.table_cell>
           <.table_cell><%= entry.title %></.table_cell>
           <.table_cell><%= entry.project_id %></.table_cell>
           <.table_cell class="text-right">
             <.link
               navigate={scoped_path(assigns, "/content/\#{@content_type.key}/\#{entry.id}")}
               class="btn-action"
             >
               <Heroicons.pencil_square class="w-4 h-4" /> Edit
             </.link>

             <.link
               phx-click={JS.push("delete", value: %{id: entry.id})}
               data-confirm="Are you sure?"
               class="btn-action"
             >
               <Heroicons.x_mark class="w-4 h-4 text-error" /> Delete
             </.link>
           </.table_cell>
         </.table_row>
       </.table_body>
      </.table>
  """
  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def table(assigns) do
    ~H"""
    <table class={classes(["moon-table", @class])} {@rest}>
      {render_slot(@inner_block)}
    </table>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def table_header(assigns) do
    ~H"""
    <thead class={classes(["", @class])} {@rest}>
      {render_slot(@inner_block)}
    </thead>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def table_row(assigns) do
    ~H"""
    <tr
      class={
        classes([
          "",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </tr>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def table_head(assigns) do
    ~H"""
    <th
      class={
        classes([
          "",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </th>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def table_body(assigns) do
    ~H"""
    <tbody class={classes(["", @class])} {@rest}>
      {render_slot(@inner_block)}
    </tbody>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def table_cell(assigns) do
    ~H"""
    <td class={classes(["", @class])} {@rest}>
      {render_slot(@inner_block)}
    </td>
    """
  end

  @doc """
  Render table footer
  """
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(disabled form name value)
  slot :inner_block, required: true

  def table_footer(assigns) do
    ~H"""
    <div
      class={
        classes([
          "",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def table_caption(assigns) do
    ~H"""
    <caption class={classes(["", @class])} {@rest}>
      {render_slot(@inner_block)}
    </caption>
    """
  end
end
