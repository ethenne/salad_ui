<p align="center">
    <a href="https://Moon-storybook.fly.dev/" alt="MoonUI Logo">
    <img src="https://github.com/bluzky/Moon_ui/blob/main/docs/images/MoonUI_logo.png?raw=true" height="120"/></a>
</p>
<h4 align="center">
    A collection of Live View components inspired by shadcn
</h4>

<div align="center">
    <a href="https://moon-storybook.fly.dev/">Demo</a> |
    <a href="https://hexdocs.pm/moon_ui/readme.html">Documentation</a> |
    <a href="https://ko-fi.com/bluzky">Support project</a>
</div>
<br></br>

<div align="center">
<img src="https://github.com/bluzky/moon_ui/actions/workflows/tests.yml/badge.svg" alt="Tests">
<a href="https://hex.pm/packages/moon_ui"><img src="https://img.shields.io/hexpm/v/moon_ui.svg" alt="Module Version"></a>
<a href="https://hexdocs.pm/moon_ui/"><img src="https://img.shields.io/badge/hex-docs-lightgreen.svg" alt="Hex Docs"></a>
<a href="https://hex.pm/packages/moon_ui"><img src="https://img.shields.io/hexpm/dt/moon_ui.svg" alt="Total Download"></a>
<a href="https://github.com/bluzky/moon_ui/commits/main"><img src="https://img.shields.io/github/last-commit/bluzky/moon_ui.svg" alt="Last Updated"></a>
</div>

## Installation

1. Add `moon_ui` to your `mix.exs`

```elixir
def deps do
  [
    {:moon_ui, "~> 0.14"},
  ]
end
```

2. Add `TwMerge.Cache` to `application.ex`

```elixir
children = [
    ...,
    TwMerge.Cache
]
```

3. Setup `moon_ui`

3.1 **Using `moon_ui` as part of your project:**

> This way you can install only components that you want to use or you want to edit MoonUI's component source code to fit your need.
> If you just want to use MoonUI's components, see **Using as library** below.

- Init Moon UI in your project

```
#> cd your_project
#> mix moon.init

# install some components
#> mix moon.add label button
```

3.2 **Using `Moon_ui` as a library:**

- Init Moon UI in your project with option `--as-lib`

```
#> cd your_project
#> mix moon.init --as-lib
```

- Using in your project

```elixir
defmodule MyModule do
    # import any component you need
    import MoonUI.Button

    def render(_) do
      ~H"""
      <.button>Click me</.button>
      """
    end
end
```

## More configuration

1. Custom error translate function

```elixir
config :moon_ui, :error_translator_function, {MyAppWeb.CoreComponents, :translate_error}
```

## 🛠️ Development

Here is how to start develop MoonUI on local machine.

1. Clone this repo
2. Clone `https://github.com/bluzky/moon_storybook` in the same directory with **Moon UI**
3. Start storybook

```
cd moon_storybook
mix phx.server
```

## Unit Testing

In your project folder make sure the dependencies are installed by running `mix deps.get`, then once completed you can run:

- `mix test` to run tests once or,
- `mix test.watch` to watch file and run tests on file changes.

To run the failing tests only, just run `mix test.watch --stale`.

It's also important to note that you must format your code with `mix format` before sending a pull request, otherwise the build in github will fail.

## List of components

- ✅ Accordion
- ✅ Alert
- ✅ Alert Dialog
- ✅ Avatar
- ✅ Badge
- ✅ Breadcrumb
- ✅ Button
- ✅ Card
- [ ] Carousel
- ✅ Chart
- ✅ Checkbox
- ✅ Collapsible
- [ ] Combobox
- [ ] Command
- [ ] Context Menu
- ✅ Dialog
- [ ] Drawer
- ✅ Dropdown Menu
- ✅ Form
- ✅ Hover Card
- ✅ Icon
- ✅ Input
- [ ] Input OTP
- ✅ Label
- ✅ Menu
- ✅ Pagination
- ✅ Popover
- ✅ Progress
- ✅ Radio Group
- ✅ Scroll Area
- ✅ Select
- ✅ Separator
- ✅ Sheet
- ✅ Sidebar
- ✅ Skeleton
- ✅ Slider
- ✅ Switch
- ✅ Table
- ✅ Tabs
- ✅ Textarea
- ✅ Toggle
- ✅ Toggle Group
- ✅ Tooltip

## 🌟 Contributors

<p align="center">
    <a href="https://github.com/bluzky/moon_ui/graphs/contributors">
        <img src="https://contrib.rocks/image?repo=bluzky/moon_ui&max=300&columns=14" width="600"/></a>
</p>

## 😘 Credits

This project could not be available without these awesome works:

- `tailwind css` an awesome css utility project
- `turboprop` I borrow code from here for merging tailwinds classes
- `shadcn/ui` which this project is inspired from
- `Phoenix Framework` of course
