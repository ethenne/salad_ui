defmodule SaladUI.Breadcrumb do
  @moduledoc false
  use SaladUI, :component

  import SaladUI.Icon

  @doc """
  Renders a breadcrumb.

  ## Examples

        <.breadcrumb>
          <.breadcrumb_list>
            <.breadcrumb_item>
              <.breadcrumb_link href="/">Home</.breadcrumb_link>
            </.breadcrumb_item>
            <.breadcrumb_separator />
            <.breadcrumb_item>
              <.breadcrumb_link href="">Components</.breadcrumb_link>
            </.breadcrumb_item>
            <.breadcrumb_separator />
            <.breadcrumb_item>
              <.breadcrumb_page>Breadcrumb</.breadcrumb_page>
            </.breadcrumb_item>
          </.breadcrumb_list>
        </.breadcrumb>

  """
  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def breadcrumb(assigns) do
    ~H"""
    <nav
      arial-label="breadcrumb"
      class={
        classes([
          "flex flex-wrap items-center gap-1.5 break-words text-sm sm:gap-2.5",
          @class
        ])
      }
      {@rest}
      }
    >
      {render_slot(@inner_block)}
    </nav>
    """
  end

  @doc """
  Render breadcrumb list
  """
  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def breadcrumb_list(assigns) do
    ~H"""
    <ol
      class={
        classes([
          "moon-breadcrumb",
          @class
        ])
      }
      {@rest}
      }
    >
      {render_slot(@inner_block)}
    </ol>
    """
  end

  @doc """
  Render breadcrumb item
  """
  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def breadcrumb_item(assigns) do
    ~H"""
    <li
      class={
        classes([
          "moon-breadcrumb-item",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </li>
    """
  end

  @doc """
  Render breadcrumb link
  """
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(download href hreflang ping referrerpolicy rel target type)
  slot :inner_block, required: true

  def breadcrumb_link(assigns) do
    ~H"""
    <.link
      class={
        classes([
          "transition-colors hover:text-foreground",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  @doc """
  Render breadcrumb page number
  """
  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def breadcrumb_page(assigns) do
    ~H"""
    <span
      aria-disabled="true"
      aria-current="page"
      role="link"
      class={
        classes([
          "font-normal text-foreground",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </span>
    """
  end

  @doc """
  Render a separator
  """
  attr :class, :string, default: nil
  attr :rest, :global

  def breadcrumb_separator(assigns) do
    ~H"""
    <li
      role="presentation"
      aria-hidden="true"
      class={
        classes([
          "flex h-9 w-auto items-center justify-center",
          @class
        ])
      }
      {@rest}
    >
      <.icon name="chevron-right" />
    </li>
    """
  end

  @doc """
  Render ellipsis
  """
  attr :class, :string, default: nil
  attr :rest, :global

  def breadcrumb_ellipsis(assigns) do
    ~H"""
    <div
      class={
        classes([
          "flex h-9 w-9 items-center justify-center",
          @class
        ])
      }
      {@rest}
    >
      <.icon name="dots-horizontal" />

      <span class="sr-only">More</span>
    </div>
    """
  end
end
