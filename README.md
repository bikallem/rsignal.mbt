# rsignal 
status - (alpha/experimental)

NOTE: previously known as **reactive**

`rsignal` is a reactive programming library for Moonbit. It is built with both web and terminal cli applications in mind. `rsignal` is short for `Reactive Signal`.

At the core of the library is a type called `Rsignal`. Any changes/updates to a `Rsignal` can be observed by observers. Observers register to observe changes to `Rsignal`. Once registered, the observers are notified whenever a `Rsignal` is updated or modified. Observers can then initiate a change operation called `effect` based on these changes. A `Rsignal` can have many observers.

A simple **counter** app in `rsignal`:
```moonbit
///|
fnalias @rweb.(div, button, on, h, attr, onclick, style, disabled)

///|
typealias @rweb.Styles

///|
typealias @rsignal.Rsignal

///|
fn counter(initial_count : Int) -> @web_sys.HTMLDivElement {
  let count_rs : Rsignal[Int] = @rsignal.new(initial_count) // count rsignal keeps track of the count value.
  let count_style_rs : Rsignal[Styles] = { // Derived - mapped -  signal from `count_rs`
    let styles = Styles::new({})
    count_rs.map(fn(count) {
      let color = if count > 5 {
        "green"
      } else if count == 0 {
        "red"
      } else {
        ""
      }
      styles.add("color", color)
    })
  }
  let show_hide_reset = count_rs.map(fn(count) {
    let display = if count == initial_count { "none" } else { "inherit" }
    "display: \{display}"
  })

  // Different ways to create event handlers
  let decrement = on("click", fn(_ : @web_sys.PointerEvent) {
    count_rs.update(count_rs.val() - 1)
  })
  let increment = _ => count_rs.update(count_rs.val() + 1)
  let reset = onclick(_ => count_rs.update(initial_count))
  div([
    style("display: flex; flex-direction: column; align-items: center;"),
    h("h2", ["The Greatest Counter Ever!"]),
    div([
      attr("style", "display: flex; flex-direction: row; column-gap: 1em;"),
      button("-", [disabled(rs=count_rs.map(count => count == 0)), decrement]),
      h("span", [style(count_style_rs), count_rs]), // Display the current count with dynamic color
      button("+", [onclick(increment)]),
      button("Reset", [style(show_hide_reset), reset]),
    ]),
  ])
}

///|
fn main {
  let el = counter(0)
  @rweb.mount_to_body(el)
}

```

## Add to your project
``` moon add bikallem/rsignal```

## API Documentation
https://mooncakes.io/docs/bikallem/rsignal

## Status
Early and experimental. API may be changed/removed without deprecation/warning.

## NOTE
This library used to be known as `reactive` in the past. It has been renamed and restructured and henceforth will be known as `rsignal`.
