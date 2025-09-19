# rsignal (alpha release)
`rsignal` is a reactive programming library for Moonbit. It is built with both web and terminal cli applications in mind. `rsignal` is short for `Reactive Signal`.

At the core of the library is a type called `Rsignal`. Any changes/updates to a `Rsignal` can be observed by observers. Observers register to observe changes to `Rsignal`. Once registered, the observers are notified whenever a `Rsignal` is updated or modified. Observers can then initiate a change operation called `effect` based on these changes. A `Rsignal` can have many observers.

A simple **counter** app in `rsignal`:
```moonbit
///|
fnalias @rweb.(div, button, on, h, attr, bool_attr, onclick)

///|
fn counter(initial_count : Int) -> @rweb.HTMLDivElement {
  // count keeps track of the count value.
  let count = @rsignal.new(initial_count)

  // Dynamic style attribute, i.e. element attributes which value is updated based on rsignal value.
  let dyn_style = count.map(count => "color: " +
    (if count >= 5 { "green" } else if count == 0 { "red" } else { "" }))

  // Different ways to create event handlers
  let decrement = on("click", fn(_ : @rweb.PointerEvent) {
    count.update(count.val() - 1)
  })
  let increment = _ => count.update(count.val() + 1)
  let reset = onclick(_ => count.update(initial_count))
  div([
    attr("style", "display: flex; flex-direction: column; align-items: center;"),
    h("h2", ["The Greatest Counter Ever!"]),
    div([
      attr("style", "display: flex; flex-direction: row; column-gap: 1em;"),
      button("-", [
        bool_attr("disabled", rs=count.map(count => count == 0)),
        decrement,
      ]),
      h("span", [attr("style", dyn_style), count]), // Display the current count with dynamic color
      button("+", [onclick(increment)]),
      button("Reset", [
        bool_attr("disabled", rs=count.map(count => count == initial_count)),
        reset,
      ]),
    ]),
  ])
}

///|
fn main {
  let el = counter(0)
  @rweb.mount_to_body(el)
}

```

## `rsignal` vs `react`
For web apps, `rsignal` offers a fine-grained selection mechanisms to update UI views. This is in contrast to other JavaScript library like `React` where the whole virtual DOM is iterated on to find DOM updates/diffs. These fine-grained updates ensures that only the specific dom node and/or attribute that needs updating are accessed and updated.

## How to use
``` moon add bikallem/rsignal```

## API Documentation
https://mooncakes.io/docs/bikallem/rsignal

## Status
Early and experimental. API may be changed/removed without deprecation/warning.

## NOTE
This library used to be known as `reactive` in the past. It has been renamed and restructured and henceforth will be known as `rsignal`.
