///|
fnalias @reactive_web.(div, button, on, h, attr, bool_attr)

///|
typealias @reactive_web.(HTMLDivElement, HTMLButtonElement, MouseEvent)

///|
traitalias @reactive_web.TAttachableNode

///| Create a button that can be disabled based on a signal value.
fn disabled_button(
  label : String,
  state : @reactive_core.Signal[Bool], // If the signal is true, the button will be disabled
  nodes : Array[&TAttachableNode],
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
  // Dynamic style attribute value: updates color based on the count value
  let color = count.map(count => "color: " +
    (if count >= 5 { "green" } else if count == 0 { "red" } else { "" }))
  div([
    attr("style", "display: flex; flex-direction: column; align-items: center;"),
    h("h2", ["The Greatest Counter Ever!"]),
    div([
      attr("style", "display: flex; flex-direction: row; column-gap: 1em;"),
      disabled_button("-", count.map(count => count <= 0), [
        on("click", (_ : MouseEvent) => count.update(count.val() - 1)),
      ]),
      h("span", [attr("style", color), count]), // Display the current count with dynamic color
      button("+", [
        on("click", (_ : MouseEvent) => count.update(count.val() + 1)),
      ]),
      disabled_button("Reset", count.map(count => count == initial_count), [
        on("click", (_ : MouseEvent) => count.update(initial_count)),
      ]),
    ]),
  ])
}

///|
fn main {
  let el = counter(0)
  @reactive_web.mount_to_body(el)
}
