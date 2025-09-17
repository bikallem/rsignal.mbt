///|
fnalias @rweb.(div, button, on, h, attr, bool_attr, onclick)

///|
typealias @rweb.(HTMLDivElement, PointerEvent)

///|
fn counter(initial_count : Int) -> HTMLDivElement {
  let count = @rsignal.new(initial_count) // rsignal to keep track of the count

  // Dynamic style attribute value: updates color based on the count value
  let color = count.map(count => "color: " +
    (if count >= 5 { "green" } else if count == 0 { "red" } else { "" }))

  // Decrement button click handler
  let decrement = fn(_ : PointerEvent) { count.update(count.val() - 1) }

  // Increment button click handler
  let increment = _ => count.update(count.val() + 1)

  // view
  div([
    attr("style", "display: flex; flex-direction: column; align-items: center;"),
    h("h2", ["The Greatest Counter Ever!"]),
    div([
      attr("style", "display: flex; flex-direction: row; column-gap: 1em;"),
      button("-", [
        bool_attr("disabled", rs=count.map(count => count == 0)),
        on("click", decrement),
      ]),
      h("span", [attr("style", color), count]), // Display the current count with dynamic color
      button("+", [onclick(increment)]),
      button("Reset", [
        bool_attr("disabled", rs=count.map(count => count == initial_count)),
        onclick(_ => count.update(initial_count)),
      ]),
    ]),
  ])
}

///|
fn main {
  let el = counter(0)
  @rweb.mount_to_body(el)
}
