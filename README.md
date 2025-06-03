# Reactive
`reactive` is a reactive programming library for Moonbit. It is built with both web and terminal cli applications in mind. 

At the core of the library is a type called `Signal`. Any changes/updates to the `signal` can be observed by subscribers. Once subscribed, the observers are notified whenever a `signal` is updated or modified. Observers can then initiate changes based on 
these signal updates. A signal can have many subscribers.

A simple **counter** app in `reactive`:
```moonbit
///|
fnalias @web.(div, button, style, onclick)

///|
typealias @web.(HTMLDivElement, ReactiveElement as RE, ReactiveAttr as RA)

///|
fn counter(initial_count : Int) -> HTMLDivElement {
  let state = @core.new(initial_count) // root signal
  div([
    style("display: flex; flex-direction: column; align-items: center;"),
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
```

## `reactive` vs `react`
For web apps, `reactive` offers a fine-grained selection mechanisms to update UI views. This is in contrast to other JavaScript library like `React` where the whole virtual DOM is iterated on to find DOM updates/diffs. The fine-grained updates by `reactive`
ensures that only dom node that needs updating are accessed and updated. 

## How to use
``` moon add bikallem/reactive```

## API Documentation
https://mooncakes.io/docs/bikallem/reactive

## Status
Early and experimental. API may be changed/removed without deprecation/warning.
