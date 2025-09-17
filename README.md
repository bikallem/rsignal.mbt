# rsignal
`rsignal` is a reactive programming library for Moonbit. It is built with both web and terminal cli applications in mind. `rsignal` is short for `Reactive Signal`.

At the core of the library is a type called `Rsignal`. Any changes/updates to a `Rsignal` can be observed by observers. Observers register to observe changes to `Rsignal`. Once registered, the observers are notified whenever a `Rsignal` is updated or modified. Observers can then initiate a change operation called `effect` based on these changes. A `Rsignal` can have many observers.

A simple **counter** app in `reactive`:
```moonbit

///|
fnalias @rsignal.(div, button, style, onclick, h)

///|
typealias @web.(HTMLDivElement, ReactiveElement as RE, ReactiveAttr as RA)

///|
fn counter(initial_count : Int) -> HTMLDivElement {
  let state = @reactive_core.new(initial_count) // root signal
  div([
    style("display: flex; flex-direction: column; align-items: center;"),
    h("h2", ["The Greatest Counter Ever!"]),
    div([
      style("display: flex; flex-direction: row; column-gap: 1em;"),
      button("Decrement", [
        onclick(_ => state.update(state.val() - 1)),
        RA::disabled(state.map(count => count <= 0)), // Disable button when count is 0
      ]),
      RE::text(state, (txt, cur_count) => txt.set_text_content(cur_count)),
      button("Increment", [onclick(_ => state.update(state.val() + 1))]),
    ]),
  ])
}

///|
fn main {
  let el = counter(0)
  @reactive_web.mount_to_body(el)
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
