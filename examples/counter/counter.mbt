///|
fnalias @reactive_web.(div, button, onclick, on, h, a, bool_attr)

///|
typealias @reactive_web.(HTMLDivElement, HTMLButtonElement, MouseEvent)

///| Create a button that can be disabled based on a signal value.
/// If the signal is true, the button will be disabled otherwise it will be enabled.
fn disabled_button(
  label : String,
  state : @reactive_core.Signal[Bool],
  nodes : Array[&@reactive_web.TAttachableNode],
) -> HTMLButtonElement {
  let disabled_attr = bool_attr("disabled")
  let btn = button(label, nodes)
  state.subscribe_permanent(disable => if disable {
    btn.set_attribute_node(disabled_attr)
  } else {
    btn.remove_attribute_node(disabled_attr)
  })
  btn
}

///|
fn counter(initial_count : Int) -> HTMLDivElement {
  let count = @reactive_core.new(initial_count) // signal to keep track of the count
  // Update color based on the count value: a dynamic style attribute value
  let color = count.map(count => "color: " +
    (if count >= 5 { "green" } else if count == 0 { "red" } else { "" }))
  div([
    a("style", "display: flex; flex-direction: column; align-items: center;"),
    h("h2", ["The Greatest Counter Ever!"]),
    div([
      a("style", "display: flex; flex-direction: row; column-gap: 1em;"),
      disabled_button("Decrement", count.map(count => count <= 0), [
        on("click", (_ : MouseEvent) => count.update(count.val() - 1)),
      ]),
      h("span", [a("style", color), count]), // Display the current count with dynamic color
      button("Increment", [onclick(_ => count.update(count.val() + 1))]),
      disabled_button("Reset", count.map(count => count == initial_count), [
        onclick(_ => count.update(initial_count)),
      ]),
    ]),
  ])
}

///|
fn main {
  let el = counter(0)
  @reactive_web.mount_to_body(el)
}
