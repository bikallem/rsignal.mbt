# Reactive
`reactive` is a reactive programming library for Moonbit. It is built with both web and terminal cli applications in mind. 

At the core of the library is a type called `Signal`. Any changes/updates to the `signal` can be observed by subscribers. Once subscribed, the observers are notified whenever a `signal` is updated or modified. Observers can then initiate changes based on 
these signal updates. A signal can have many subscribers.

Example:
```moonbit
test "signal_update" {
  let values = []
  let s = new(0)
  s.subscribe_permanent(fn(v) { values.push(v) })
  assert_eq!(s.val(), 0)
  s.update(5) // This will notify subscribers with the new value.
  assert_eq!(s.val(), 5)
  assert_eq!(values, [0, 5])
  s.update(10) // This will notify subscribers with the new value.
  assert_eq!(s.val(), 10)
  assert_eq!(values, [0, 5, 10])
}
```

## `reactive` vs `react`
For web apps, `reactive` offers a fine-grained selection mechanisms to update UI views. This is in contrast to other JavaScript library like `React` where the whole virtual DOM is iterated on to find DOM updates/diffs. The fine-grained updates by `reactive`
ensures that only dom node that needs updating are accessed and updated. 

## How to use
``` moon add bikallem/reactive```

## API Documentation
https://mooncakes.io/docs/bikallem/reactive
