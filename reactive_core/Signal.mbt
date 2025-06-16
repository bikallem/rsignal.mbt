///| Subscriber ID
priv type SubId Int derive(Eq, Hash)

///| A reactive signal that can be subscribed to and updated.
struct Signal[T] {
  id : String // unique ID for this signal
  sub_id : () -> Int // for generating unique subscriber IDs
  mut value : T // any changes to this value will trigger subscribers
  subscribers : @hashmap.T[SubId, Subscriber[T]] // subscribers to this signal
}

///|
struct Subscriber[T] {
  id : SubId // unique ID for this subscriber, used to subscribe/unsubscribe
  effect : (T) -> Unit // function to call when the signal changes
}

///|
fn[T] Subscriber::effect(self : Subscriber[T], value : T) -> Unit {
  (self.effect)(value)
}

///|
fn id_generator() -> () -> Int {
  let mut id : Int = -1
  fn() -> Int {
    id += 1
    id
  }
}

///| Creates a new unique ID for signals
let signal_id : () -> Int = id_generator()

///| Creates a new signal with the given initial value.
pub fn[T : Eq] new(value : T, label~ : String = "signal") -> Signal[T] {
  let sub_id = id_generator()
  let id = "\{label}#\{signal_id()}"
  Signal::{ id, value, sub_id, subscribers: @hashmap.new() }
}

///| Returns the unique ID of the signal
///
/// Parameters:
/// - `self`: The signal to get the ID from.
///
/// Returns:
/// - The unique ID of the signal.
///
/// Example:
/// ```moonbit
/// test "signal_id" {
///   let s = new(0)
///   assert_eq!(s.id(), "signal#0")  
///   let s2 = new(1, label="my_signal")
///   assert_eq!(s2.id(), "my_signal#1")
/// }
/// ```
pub fn[T] Signal::id(self : Signal[T]) -> String {
  self.id
}

///| Returns the current value of the signal `s`
/// 
/// Parameters:
/// - `s`: The signal to get the value from.
/// 
/// Returns:
/// - The current value of the signal.
/// 
/// Example:
/// ```moonbit
/// test "signal_val" {
///   let s = new(0)
///   assert_eq!(s.val(), 0)
///   s.update(5)
///   assert_eq!(s.val(), 5)
/// }
/// ```
pub fn[T] Signal::val(s : Signal[T]) -> T {
  s.value
}

///| Sets the value of the signal `s` to `value` without notifying subscribers
/// This is useful for cases where you want to set the value without triggering any side effects.
///
/// Parameters:
/// - `s`: The signal to set.
/// - `value`: The new value to set.
///
/// Example:
/// ```moonbit
/// test "signal_set" {
///   let values = []
///   let s = new(0)
///   s.subscribe_permanent(fn(v) { values.push(v) })
///   assert_eq!(s.val(), 0)
///   s.set(5) // This will set the signal to 5 without notifying subscribers.
///   assert_eq!(s.val(), 5)
///   s.update(10) // This will notify subscribers with the new value.
///   assert_eq!(s.val(), 10)
///   assert_eq!(values, [0, 10])
/// }
/// ```
pub fn[T] Signal::set(s : Signal[T], value : T) -> Unit {
  s.value = value
}

///| Returns the unique subscriber ID for this signal
fn[T] Signal::sub_id(self : Signal[T]) -> SubId {
  (self.sub_id)()
}

///| Subscribes to a signal and immediately calls the effect function with the current value
pub fn[T] Signal::subscribe(
  self : Signal[T],
  effect : (T) -> Unit
) -> Subscriber[T] {
  let subscriber = Subscriber::{ id: self.sub_id(), effect }
  self.subscribers[subscriber.id] = subscriber
  subscriber.effect(self.value)
  subscriber
}

///| Subscribes to a signal without immediately calling the effect function
/// This is useful for cases where you want to set up a subscription but don't want to
/// trigger the effect function until the signal changes.
pub fn[T] Signal::subscribe_only(
  self : Signal[T],
  effect : (T) -> Unit
) -> Subscriber[T] {
  let subscriber = Subscriber::{ id: self.sub_id(), effect }
  self.subscribers[subscriber.id] = subscriber
  subscriber
}

///| Subscribes to a signal permanently and immediately calls the effect function with the current value.
/// This is useful for cases where you want to set up a subscription that will not be removed
pub fn[T] Signal::subscribe_permanent(
  self : Signal[T],
  effect : (T) -> Unit
) -> Unit {
  self.subscribe(effect) |> ignore
}

///| Subscribes to a signal permanently without immediately calling the effect function.
pub fn[T] Signal::subscribe_permanent_only(
  self : Signal[T],
  effect : (T) -> Unit
) -> Unit {
  self.subscribe_only(effect) |> ignore
}

///| Updates the value of the signal and notifies all subscribers
/// 
/// Parameters:
/// - `self`: The signal to update.
/// - `new_value`: The new value to set.
///
/// Example:
/// ```moonbit
/// test "signal_update" {
///   let values = []
///   let s = new(0)
///   s.subscribe_permanent(fn(v) { values.push(v) })
///   assert_eq!(s.val(), 0)
///   s.update(5) // This will notify subscribers with the new value.
///   assert_eq!(s.val(), 5)
///   assert_eq!(values, [0, 5])
///   s.update(10) // This will notify subscribers with the new value.
///   assert_eq!(s.val(), 10)
///   assert_eq!(values, [0, 5, 10])
/// }
/// ```
pub fn[T : Eq] Signal::update(self : Signal[T], new_value : T) -> Unit {
  if self.value != new_value {
    self.value = new_value
    for _, subscriber in self.subscribers {
      subscriber.effect(self.value)
    }
  }
}

///| Unsubscribes a subscriber from a signal.
/// 
/// Parameters:
/// - `self`: The signal to unsubscribe from.
/// - `subscription`: The subscriber to unsubscribe.
///
/// Example:
/// ```moonbit
/// test "signal_unsubscribe" {
///   let values = []
///   let s = new(0)
///   let sub = s.subscribe(fn(v) { values.push(v) })
///   assert_eq!(s.val(), 0)
///   s.update(5) // This will notify subscribers with the new value.
///   assert_eq!(s.val(), 5)
///   assert_eq!(values, [0, 5])
///   s.unsubscribe(sub) // This will unsubscribe the subscriber.
///   assert_eq!(s.val(), 5)
///   s.update(10) // This will not notify the unsubscribed subscriber.
///   assert_eq!(s.val(), 10)
///   assert_eq!(values, [0, 5])
/// }
/// ```
pub fn[T] Signal::unsubscribe(
  self : Signal[T],
  subscription : Subscriber[T]
) -> Unit {
  self.subscribers.remove(subscription.id)
}

///| Creates a new signal that maps the value of `self` using the function `f`.
/// 
/// Parameters:
/// - `self`: The original signal.
/// - `f`: The mapping function that takes the value of `self` and returns a new value.
/// 
/// Returns:
/// - A new signal that emits the result of applying `f` to the value of `self`.
///
/// Example:
/// ```moonbit
/// test "signal_map" {
///   let values = []
///   let s = new(0)
///   let s2 = s.map(fn(v) { v + 1 })
///   s2.subscribe_permanent(fn(v) { values.push(v) })
///   s.update(5) // This will trigger the subscriber with value 6.
///   s.update(10) // This will trigger the subscriber with value 11.
///   s.update(20) // This will trigger the subscriber with value 21.
///   inspect!(values, content="[1, 6, 11, 21]")
/// }
/// ```
pub fn[T : Eq, U : Eq] Signal::map(self : Signal[T], f : (T) -> U) -> Signal[U] {
  let s = new(f(self.value))
  self.subscribe_permanent(fn(v) { s.update(f(v)) })
  s
}

///| Creates a new signal that maps the values of two signals using the function `f`.
/// 
/// Parameters:
/// - `s1`: The first signal.
/// - `s2`: The second signal.
/// - `f`: The mapping function that takes the values of both signals and returns a new value.
/// 
/// Returns:
/// - A new signal that emits the result of applying `f` to the values of `s1` and `s2`.
/// 
/// Example:
/// ```moonbit
/// test "signal_map2" {
///   let values = []
///   let s1 = new(1)
///   let s2 = new(2)
///   let s3 = map2(s1, s2, fn(a, b) { a + b })
///   s3.subscribe_permanent(fn(v) { values.push(v) })
///   s1.update(3) // This will trigger the subscriber with value 5.
///   s2.update(4) // This will trigger the subscriber with value 7.
///   s1.update(5) // This will trigger the subscriber with value 9.
///   inspect!(values, content="[3, 5, 7, 9]")
/// }
/// ```
pub fn[T : Eq, U : Eq, V : Eq] map2(
  s1 : Signal[T],
  s2 : Signal[U],
  f : (T, U) -> V
) -> Signal[V] {
  let s = new(f(s1.value, s2.value))
  s1.subscribe_permanent(fn(v) { s.update(f(v, s2.value)) })
  s2.subscribe_permanent(fn(v) { s.update(f(s1.value, v)) })
  s
}

///| Creates a new signal that receives values from `self` where `f(new_value)` is `true`.
/// If the initial value of `f(self.get()) == false`, the new signal will be 
/// initialized with the given `seed` value.
/// 
/// Parameters:
/// - `self`: The original signal.
/// - `f`: The filter function.
/// - `seed`: The initial value for the new signal if the filter function returns false during creation.
///
/// Returns:
/// - A new signal that emits only the values from `self` that pass the filter function `f`.
/// 
/// Example:
/// ```moonbit
/// test "signal_filter" {
///   let filtered_values = []
///   let s = new(1)
///   let s2 = s.filter(fn(v) { v > 5 }, 0)
///   s2.subscribe_permanent_only(fn(v) { filtered_values.push(v) })
///   s.update(10) // This will trigger the subscriber with value 10.
///   s.update(7) // This will trigger the subscriber with value 7.
///   s.update(3) // This will not trigger the subscriber.
///   inspect!(filtered_values, content="[10, 7]")
/// }
/// ```
pub fn[T : Eq] Signal::filter(
  self : Signal[T],
  f : (T) -> Bool,
  seed : T
) -> Signal[T] {
  let v = if f(self.value) { self.value } else { seed }
  let s = new(v)
  self.subscribe_permanent(fn(v) { if f(v) { s.update(v) } })
  s
}

///| Creates a new signal that maps the values of `self` iff `f(self.get()) == Some(v)`.
/// If `f(self.get())` returns `None`, the new signal will be initialized with the given `seed` value
/// 
/// This combines the functionality of `map` and `filter` into a single operation.
/// 
/// Parameters:
/// - `self`: The original signal.
/// - `f`: The mapping function.
/// - `seed`: The initial value for the new signal if the mapping function returns `None` during creation.
/// 
/// Returns:
/// - A new signal that emits the values from `self` that pass the mapping function `f`.
/// 
/// Example:
/// ```moonbit
/// test "signal_filter_map" {
///   let mapped_values = []
///   let s = new(1)
///   let s2 = s.filter_map(fn(v) { if v > 5 { Some(v+2) } else { None } }, 0)
///   s2.subscribe_permanent_only(fn(v) { mapped_values.push(v) })
///   s.update(10) // This will trigger the subscriber with value 12.
///   s.update(7) // This will trigger the subscriber with value 9.
///   s.update(3) // This will not trigger the subscriber.
///   inspect!(mapped_values, content="[12, 9]")
/// }
/// ```
pub fn[T, U : Eq] Signal::filter_map(
  self : Signal[T],
  f : (T) -> U?,
  seed : U
) -> Signal[U] {
  let v = f(self.value).or_else(fn() { seed })
  let s = new(v)
  self.subscribe_permanent(fn(v) {
    match f(v) {
      Some(v) => s.update(v)
      None => ()
    }
  })
  s
}

// -- Combinators ---

///| Creates a new signal which re-emits the latest signal from one of the 
/// signals in `signals` array.
/// 
/// This is useful for combining multiple signals into a single signal.
///
/// The initial value of the new signal will be the default value of `T`.
/// 
/// Parameters:
/// - `signals`: An array of signals to combine.
///
/// Returns:
/// - A new signal that emits the values from all signals in the array.
///
/// Example:
/// ```moonbit
/// test "select_one" {
///   let values = []
///   let s1 = new(1)
///   let s2 = new(2)
///   let s3 = new(3)
///   let combined_signal = select_one([s1, s2, s3])
///   combined_signal.subscribe_permanent_only(fn(v) { values.push(v) })
///   s1.update(4) // This will trigger the subscriber with value 4.
///   s2.update(5) // This will trigger the subscriber with value 5.
///   s3.update(6) // This will trigger the subscriber with value 6.
///   inspect!(values, content="[4, 5, 6]")
/// }
/// ```
pub fn[T : Default + Eq] select_one(signals : Array[Signal[T]]) -> Signal[T] {
  let s = new(T::default())
  for signal in signals {
    signal.subscribe_permanent_only(fn(v) { s.update(v) })
  }
  s
}

///| Creates a new signal that emits a tuple of the latest values from both signals.
/// 
/// Parameters:
/// - `s1`: The first signal.
/// - `s2`: The second signal.
/// 
/// Returns:
/// - A new signal that emits a tuple of the latest values from `s1` and `s2`.
///
/// Example:
/// ```moonbit
/// test "combine_pair" {
///   let values = []
///   let s1 = new(1)
///   let s2 = new(2)
///   let s3 = combine_pair(s1, s2)
///   s3.subscribe_permanent(fn(v) { values.push(v) })
///   s1.update(3) // This will trigger the subscriber with value (3, 2).
///   s2.update(4) // This will trigger the subscriber with value (3, 4).
///   s1.update(5) // This will trigger the subscriber with value (5, 4).
///   inspect!(values, content="[(1, 2), (3, 2), (3, 4), (5, 4)]")
/// }
/// ```
pub fn[T : Eq, U : Eq] combine_pair(
  s1 : Signal[T],
  s2 : Signal[U]
) -> Signal[(T, U)] {
  let s = new((s1.value, s2.value))
  s1.subscribe_permanent_only(fn(v) { s.update((v, s2.value)) })
  s2.subscribe_permanent_only(fn(v) { s.update((s1.value, v)) })
  s
}

///| Creates a new signal that emits a tuple of the latest values from three signals.
///
/// Parameters:
/// - `s1`: The first signal.
/// - `s2`: The second signal.
/// - `s3`: The third signal.
///
/// Returns:
/// - A new signal that emits a tuple of the latest values from `s1`, `s2`, and `s3`.
///
/// Example:
/// ```moonbit
/// test "combine_triple" {
///   let values = []
///   let s1 = new(1)
///   let s2 = new(2)
///   let s3 = new(3)
///   let s4 = combine_triple(s1, s2, s3)
///   s4.subscribe_permanent(fn(v) { values.push(v) })
///   s1.update(4) // This will trigger the subscriber with value (4, 2, 3).
///   s2.update(5) // This will trigger the subscriber with value (4, 5, 3).
///   s3.update(6) // This will trigger the subscriber with value (4, 5, 6).
///   s1.update(7) // This will trigger the subscriber with value (7, 5, 6).
///   inspect!(values, content="[(1, 2, 3), (4, 2, 3), (4, 5, 3), (4, 5, 6), (7, 5, 6)]")
/// }
/// ```
pub fn[T : Eq, U : Eq, V : Eq] combine_triple(
  s1 : Signal[T],
  s2 : Signal[U],
  s3 : Signal[V]
) -> Signal[(T, U, V)] {
  let s = new((s1.value, s2.value, s3.value))
  s1.subscribe_permanent_only(fn(v) { s.update((v, s2.value, s3.value)) })
  s2.subscribe_permanent_only(fn(v) { s.update((s1.value, v, s3.value)) })
  s3.subscribe_permanent_only(fn(v) { s.update((s1.value, s2.value, v)) })
  s
}

///| Combines all signals in `signals` into a single signal `s`. If any of the signals
/// change, `s` will emit an array of the latest values from all signals.
/// 
/// Parameters:
/// - `signals`: An array of signals to combine.
/// 
/// Returns:
/// - A new signal that emits an array of the latest values from all signals.
/// 
/// Example:
/// ```moonbit
/// test "combine_all" {
///   let values = []
///   let s1 = new(1)
///   let s2 = new(2)
///   let s3 = new(3)
///   let s4 = new(4)
///   let combined_signal = combine_all([s1, s2, s3, s4])
///   combined_signal.subscribe_permanent(fn(v) { values.push(v) })
///   s1.update(5) // This will trigger the subscriber with value [5, 2, 3, 4].
///   s2.update(6) // This will trigger the subscriber with value [5, 6, 3, 4].
///   s3.update(7) // This will trigger the subscriber with value [5, 6, 7, 4].
///   s4.update(8) // This will trigger the subscriber with value [5, 6, 7, 8].
///   inspect!(values, content="[[1, 2, 3, 4], [5, 2, 3, 4], [5, 6, 3, 4], [5, 6, 7, 4], [5, 6, 7, 8]]")
/// }
/// ```
pub fn[T : Eq] combine_all(signals : Array[Signal[T]]) -> Signal[Array[T]] {
  let latest_values = []
  for signal in signals {
    latest_values.push(signal.value)
  }
  let s = new(latest_values)
  for signal in signals {
    signal.subscribe_permanent_only(fn(new_val) {
      let vals = []
      for s in signals {
        if s.id == signal.id {
          vals.push(new_val)
        } else {
          vals.push(s.value)
        }
      }
      s.update(vals)
    })
  }
  s
}

///|
test "create_signal: get and set basic" {
  let s = new(0)
  assert_eq(Signal::val(s), 0)
  Signal::update(s, 5)
  assert_eq(Signal::val(s), 5)
  let s = new("hello")
  assert_eq(Signal::val(s), "hello")
  Signal::update(s, "world")
  assert_eq(Signal::val(s), "world")
}

///|
test "subscribe: basic" (t : @test.T) {
  let s = new(0)
  Signal::update(s, 5)
  let sub1 = Signal::subscribe(s, fn(v) { t.writeln("Sub1 updated to: \{v}") })
  let _ = Signal::subscribe(s, fn(v) { t.writeln("Sub2 updated to: \{v}") })
  Signal::unsubscribe(s, sub1)
  t.writeln("\nUnsubscribed sub1.\nSignal update to 10.\n")
  Signal::update(s, 10)
  Signal::update(s, 10)
  t.snapshot(filename="subscribe_basic")
}

///|
test "map: basic" (t : @test.T) {
  let s = new(0)
  let s2 = Signal::map(s, fn(v) { v + 1 })
  let sub = Signal::subscribe(s2, fn(v) { t.writeln("Sub updated to: \{v}") })
  s.update(5)
  s.update(10)
  s2.unsubscribe(sub)
  s.update(20)
  t.snapshot(filename="map_basic")
}
