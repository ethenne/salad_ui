# defmodule SaladUI._Select() do
#   @moduledoc """
#   Implement of select components from https://ui.shadcn.com/docs/components/select

#   ## Examples:

#       <form>
#          <.select default="banana" id="fruit-select">
#             <.select_trigger class="w-[180px]">
#               <.select_value placeholder=".select a fruit"/>
#             </.select_trigger>
#             <.select_content>
#               <.select_group>
#                 <.select_label>Fruits</.select_label>
#                 <.select_item name="fruit" value="apple">Apple</.select_item>
#                 <.select_item name="fruit" value="banana">Banana</.select_item>
#                 <.select_item name="fruit" value="blueberry">Blueberry</.select_item>
#                 <.select_separator />
#                 <.select_item  name="fruit" disabled value="grapes">Grapes</.select_item>
#                 <.select_item  name="fruit" value="pineapple">Pineapple</.select_item>
#               </.select_group>
#         </.select_content>
#           </.select>

#         <.button type="submit">Submit</.button>
#       </form>
#   """
#   use SaladUI, :component

#   @doc """
#   Ready to use select component with all required parts.
#   """

#   attr :id, :string, default: nil
#   attr :name, :any, default: nil
#   attr :value, :any, default: nil, doc: "The value of the select"
#   attr :"default-value", :any, default: nil, doc: "The default value of the select"

#   attr :field, Phoenix.HTML.FormField, doc: "a form field struct retrieved from the form, for example: @form[:email]"

#   attr :label, :string,
#     default: nil,
#     doc: "The display label of the select value. If not provided, the value will be used."

#   attr :placeholder, :string, default: nil, doc: "The placeholder text when no value is selected."

#   attr :class, :string, default: "moon-select relative"
#   slot :inner_block, required: true
#   attr :rest, :global

#   def _select(assigns) do
#     assigns = prepare_assign(assigns)

#     assigns =
#       assign(assigns, :builder, %{
#         id: assigns.id,
#         name: assigns.name,
#         value: assigns.value,
#         label: assigns.label,
#         placeholder: assigns.placeholder
#       })

#     ~H"""
#     <div
#       id={@id}
#       class={classes(@class)}
#       data-state="closed"
#       {@rest}
#       x-hide-select={hide_select(@id)}
#       x-show-select={show_select(@id)}
#       x-toggle-select={toggle_select(@id)}
#       phx-click-away={JS.exec("x-hide-select")}
#     >
#       {render_slot(@inner_block, @builder)}
#     </div>
#     """
#   end

#   attr :builder, :map, required: true, doc: "The builder of the select component"
#   attr :class, :string, default: nil
#   attr :rest, :global

#   def select_trigger(assigns) do
#     ~H"""
#     <button
#       type="button"
#       class="moon-button moon-button-xs moon-button-ghost"
#       phx-click={toggle_select(@builder.id)}
#       {@rest}
#     >
#       <span
#         class="select-value pointer-events-none before:content-[attr(data-content)]"
#         data-content={@builder.label || @builder.value || @builder.placeholder}
#       >
#       </span>
#       <span class="h-4 w-4 opacity-50" />
#     </button>
#     """
#   end

#   attr :builder, :map, required: true, doc: "The builder of the select component"

#   attr :class, :string, default: nil
#   attr :side, :string, values: ~w(top bottom), default: "bottom"
#   slot :inner_block, required: true

#   attr :rest, :global

#   def select_content(assigns) do
#     position_class =
#       case assigns.side do
#         "top" -> "bottom-full mb-1"
#         "bottom" -> "top-full mt-1"
#       end

#     assigns =
#       assigns
#       |> assign(:position_class, position_class)
#       |> assign(:id, assigns.builder.id <> "-content")

#     ~H"""
#     <.focus_wrap
#       id={@id}
#       data-side={@side}
#       class={
#         classes([
#           "select-content absolute hidden",
#           "z-50 max-h-96 min-w-[8rem] overflow-hidden rounded-md border bg-white text-popover-slate-500 shadow-md group-data-[state=open]:animate-in group-data-[state=closed]:animate-out group-data-[state=closed]:fade-out-0 group-data-[state=open]:fade-in-0 group-data-[state=closed]:zoom-out-95 group-data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2",
#           @position_class,
#           @class
#         ])
#       }
#       {@rest}
#     >
#       <div class="relative w-full p-1">
#         {render_slot(@inner_block)}
#       </div>
#     </.focus_wrap>
#     """
#   end

#   attr :class, :string, default: nil
#   slot :inner_block, required: true
#   attr :rest, :global

#   def select_group(assigns) do
#     ~H"""
#     <div role="group" class={classes([@class])} {@rest}>
#       {render_slot(@inner_block)}
#     </div>
#     """
#   end

#   attr :class, :string, default: nil
#   slot :inner_block, required: true
#   attr :rest, :global

#   def select_label(assigns) do
#     ~H"""
#     <div class={classes(["py-1.5 pl-8 pr-2 text-sm font-semibold", @class])} {@rest}>
#       {render_slot(@inner_block)}
#     </div>
#     """
#   end

#   attr :builder, :map, required: true, doc: "The builder of the select component"

#   attr :value, :string, required: true
#   attr :label, :string, default: nil
#   attr :disabled, :boolean, default: false
#   attr :class, :string, default: nil
#   slot :inner_block, required: true

#   attr :rest, :global

#   def select_item(assigns) do
#     assigns = assign(assigns, :label, assigns.label || assigns.value)

#     ~H"""
#     <div class="moon-form-group">
#       <label
#         role="option"
#         class={
#           classes([
#             @class
#           ])
#         }
#         {%{"data-disabled": @disabled}}
#         phx-click={select_value(@builder.id, @label)}
#         {@rest}
#       >
#         <input
#           type="radio"
#           name={@builder.name}
#           value={@value}
#           checked={@builder.value == @value}
#           disabled={@disabled}
#           phx-key="Escape"
#           phx-keydown={JS.exec("x-hide-select", to: "##{@builder.id}")}
#         />
#         <span>
#           <span aria-hidden="true">
#             <svg
#               xmlns="http://www.w3.org/2000/svg"
#               width="20"
#               height="20"
#               viewBox="0 0 20 20"
#               fill="none"
#               stroke="currentColor"
#               stroke-width="2"
#               stroke-linecap="round"
#               stroke-linejoin="round"
#             >
#               <path d="M5.50316 8.1294C5.60473 8.26388 5.90799 8.66534 6.08859 8.89676C6.45032 9.36027 6.94458 9.97618 7.47775 10.5903C8.01362 11.2074 8.57654 11.8085 9.07664 12.2504C9.3274 12.472 9.54768 12.6403 9.72945 12.7499C9.90041 12.853 10.0014 12.8744 10.0014 12.8744C10.0014 12.8744 10.0994 12.853 10.2704 12.7499C10.4521 12.6403 10.6724 12.472 10.9232 12.2504C11.4233 11.8085 11.9862 11.2074 12.5221 10.5902C13.0552 9.97616 13.5495 9.36025 13.9112 8.89673C14.0918 8.66531 14.3947 8.26442 14.4962 8.12994C14.7009 7.852 15.0926 7.79206 15.3705 7.99675C15.6485 8.20145 15.7079 8.59269 15.5032 8.87063L15.5016 8.8727C15.3951 9.01371 15.081 9.42961 14.8967 9.66577C14.5268 10.1398 14.0181 10.7738 13.4659 11.4098C12.9165 12.0426 12.3118 12.6915 11.7509 13.1871C11.4711 13.4343 11.1875 13.6566 10.9157 13.8204C10.6611 13.9739 10.3387 14.125 9.99991 14.125C9.66115 14.125 9.33874 13.9739 9.0841 13.8204C8.81229 13.6566 8.52872 13.4343 8.24897 13.1871C7.68804 12.6915 7.08331 12.0426 6.53388 11.4098C5.98175 10.7739 5.47306 10.1398 5.10316 9.6658C4.91873 9.42947 4.60456 9.01352 4.49829 8.87283L4.49696 8.87107C4.29227 8.59314 4.35134 8.20149 4.62928 7.99679C4.9072 7.79211 5.29846 7.85149 5.50316 8.1294Z">
#               </path>
#             </svg>
#           </span>
#         </span>
#         <span>{@label}</span>
#       </label>
#     </div>
#     """
#   end

#   def select_separator(assigns) do
#     ~H"""
#     <div class={classes(["-mx-1 my-1 h-px bg-muted"])}></div>
#     """
#   end

#   defp hide_select(id) do
#     %JS{}
#     |> JS.pop_focus()
#     |> JS.add_class("hidden",
#       transition: "ease-out",
#       to: "##{id}[data-state=open] .select-content",
#       time: 150
#     )
#     |> JS.set_attribute({"data-state", "closed"}, to: "##{id}")
#   end

#   # show select and focus first selected item or first item if no selected item
#   defp show_select(id) do
#     %JS{}
#     # show if closed
#     |> JS.focus_first(to: "##{id}[data-state=closed] .select-content")
#     |> JS.set_attribute({"data-state", "open"}, to: "##{id}")
#     |> JS.focus_first(to: "##{id}[data-state=open] .select-content")
#     |> JS.focus_first(to: "##{id}[data-state=open] .select-content label:has(input:checked)")
#   end

#   # show or hide select
#   defp toggle_select(id) do
#     %JS{}
#     |> JS.add_class("hidden",
#       transition: "ease-out",
#       to: "##{id}[data-state=open] .select-content",
#       time: 150
#     )
#     # show if closed
#     |> JS.remove_class("hidden", to: "##{id}[data-state=closed] .select-content")
#     |> JS.toggle_attribute({"data-state", "open", "closed"}, to: "##{id}")
#     |> JS.focus_first(to: "##{id}[data-state=open] .select-content")
#     |> JS.focus_first(to: "##{id}[data-state=open] .select-content label:has(input:checked)")
#   end

#   # set value to select and hide select
#   defp select_value(root_id, value) do
#     %JS{}
#     |> JS.set_attribute({"data-content", value}, to: "##{root_id} .select-value")
#     |> JS.exec("x-hide-select", to: "##{root_id}")
#   end
# end
