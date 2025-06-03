///|
fnalias @web.(div, button, style, onclick, h)

///|
typealias @web.(HTMLDivElement, ReactiveElement as RE, ReactiveAttr as RA)

///|
fn counter(initial_count : Int) -> HTMLDivElement {
  let state = @core.new(initial_count) // root signal
  div([
    style("display: flex; flex-direction: column; align-items: center;"),

    h("h2", ["The Greatest Counter Ever!"]),
    div([
      style("display: flex; flex-direction: row; column-gap: 1em;"),
      button("Increment", [onclick(fn(_) { state.update(state.val() + 1) })]),
      RE::text(state, fn(txt, cur_count) { txt.set_text_content(cur_count) }),
      button("Decrement", [
        onclick(fn(_) { state.update(state.val() - 1) }),
        RA::disabled(state.map(fn(count) { count <= 0 })), // Disable button when count is 0
      ]),
    ]),
  ])
}

///|
fn main {
  let el = counter(0)
  @web.mount_to_body(el)
}
