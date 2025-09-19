///|
/// A reactive signal. Its changes/updates can be observed by its registered observers.
struct Rsignal[T] {
  id : String // unique ID for this signal
  sub_id : () -> Int // for generating unique observer IDs
  mut value : T // any changes to this value will notify observers
  observers : @hashmap.HashMap[ObserverId, Observer[T]] // observers of this signal
}

///|
fn id_generator() -> () -> Int {
  let mut id : Int = -1
  fn() -> Int {
    id += 1
    id
  }
}

///|
/// Creates a new unique ID for signals
let signal_id : () -> Int = id_generator()

///|
/// Creates a new signal with the given initial value.
pub fn[T] new(value : T, label? : String = "signal") -> Rsignal[T] {
  let sub_id = id_generator()
  let id = "\{label}#\{signal_id()}"
  Rsignal::{ id, value, sub_id, observers: @hashmap.new() }
}

///|
/// Returns the unique ID of the signal
///
/// Parameters:
/// - `self`: The signal to get the ID from.
///
/// Returns:
/// - The unique ID of the signal.
///
/// Example:
/// ```moonbit
/// let s = new(0)
/// assert_eq(s.id(), "signal#0")  
/// let s2 = new(1, label="my_signal")
/// assert_eq(s2.id(), "my_signal#1")
/// ```
pub fn[T] Rsignal::id(self : Rsignal[T]) -> String {
  self.id
}

///|
/// Returns the current value of the signal `s`
/// 
/// Parameters:
/// - `s`: The signal to get the value from.
/// 
/// Returns:
/// - The current value of the signal.
/// 
/// Example:
/// ```moonbit
/// let s = new(0)
/// assert_eq(s.val(), 0)
/// s.update(5)
/// assert_eq(s.val(), 5)
/// ```
pub fn[T] Rsignal::val(s : Rsignal[T]) -> T {
  s.value
}

///|
/// Returns a new and unique observer ID.
fn[T] Rsignal::new_observer_id(self : Rsignal[T]) -> ObserverId {
  (self.sub_id)()
}

///|
/// Creates an observer for the signal that will call the provided effect function
/// whenever the signal's value changes. The observer can be removed later using
/// the returned `Observer` object.
/// 
/// Parameters:
///
/// * `self` : The signal to observe.
/// * `effect` : A function that will be called with the signal's value whenever
///   it changes.
/// * `exec_immediate` : Whether to immediately execute `effect` function with
///   the current signal value. Defaults to `true`.
///
/// Returns an `Observer[T]` that can be used to unsubscribe from the signal
/// later.
///
/// Example:
///
/// ```moonbit
/// let values = []
/// let signal = @rsignal.new(42)
/// let observer = signal.observer(fn(v) { values.push(v) })
/// signal.update(100)
/// inspect(values, content="[42, 100]")
/// inspect(observer.id(), content="ObserverId(0)")
/// ```
///
pub fn[T] Rsignal::observer(
  self : Rsignal[T],
  effect : (T) -> Unit,
  exec_immediate? : Bool = true,
) -> Observer[T] {
  let observer = Observer::{ id: self.new_observer_id(), effect }
  self.observers[observer.id] = observer
  if exec_immediate {
    observer.effect(self.value)
  }
  observer
}

///|
/// Observe a signal with an `effect` function that gets called whenever the
/// signal's value changes. 
/// 
/// If you want the observer to be removable later, use `observe` instead.
///
/// Parameters:
///
/// * `self` : The signal to observe.
/// * `effect` : A function that will be called with the signal's current value whenever
///   it changes.
/// * `exec_immediate` : Whether to immediately execute `effect` function with
///   the current signal value. Defaults to `true`.
///
/// Example:
///
/// ```moonbit
/// let values = []
/// let signal = @rsignal.new(42)
/// signal.observe(fn(v) { values.push(v) })
/// signal.update(100)
/// inspect(values, content="[42, 100]")
/// ```
///
pub fn[T] Rsignal::observe(
  self : Rsignal[T],
  effect : (T) -> Unit,
  exec_immediate? : Bool = true,
) -> Unit {
  self.observer(effect, exec_immediate~) |> ignore
}

///|
/// Updates the value of the signal. If `notify` is `true`, notifies all of its observers
/// of the change.
/// 
/// Parameters:
/// - `self`: The signal to update.
/// - `new_value`: The new value to set.
/// - `notify` : If `true` notifies all observers of this signal - default is `true`.
///
/// Example:
/// ```moonbit
/// let values = []
/// let s = new(0)
/// s.observe(fn(v) { values.push(v) })
/// assert_eq(s.val(), 0)
/// s.update(5) // This will notify observers of the new value.
/// assert_eq(s.val(), 5)
/// assert_eq(values, [0, 5])
/// s.update(10) // This will notify observers of the new value.
/// assert_eq(s.val(), 10)
/// assert_eq(values, [0, 5, 10])
/// ```
pub fn[T : Eq] Rsignal::update(
  self : Rsignal[T],
  new_value : T,
  notify? : Bool = true,
) -> Unit {
  if self.value != new_value {
    self.value = new_value
    if notify {
      for _, observer in self.observers {
        observer.effect(self.value)
      }
    }
  }
}

///|
/// Removes an observer from observing a signal.
/// 
/// Parameters:
/// - `self`: The signal to remove from.
/// - `observer`: The observer to remove.
///
/// Example:
/// ```moonbit
/// let values = []
/// let s = new(0)
/// let ob = s.observer(fn(v) { values.push(v) })
/// assert_eq(s.val(), 0)
/// s.update(5) // This will notify observers with the new value.
/// assert_eq(s.val(), 5)
/// assert_eq(values, [0, 5])
/// s.remove_observer(ob) // This will remove the observer.
/// assert_eq(s.val(), 5)
/// s.update(10) // This will not notify the removed observer.
/// assert_eq(s.val(), 10)
/// assert_eq(values, [0, 5])
/// ```
pub fn[T] Rsignal::remove_observer(
  self : Rsignal[T],
  observer : Observer[T],
) -> Unit {
  self.observers.remove(observer.id)
}

///|
/// Creates a new signal that maps the value of `self` using the function `f`.
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
/// let values = []
/// let s = new(0)
/// let s2 = s.map(fn(v) { v + 1 })
/// s2.observe(fn(v) { values.push(v) })
/// s.update(5) // This will trigger the observer effect with value 6.
/// s.update(10) // This will trigger the observer effect with value 11.
/// s.update(20) // This will trigger the observer effect with value 21.
/// inspect(values, content="[1, 6, 11, 21]")
/// ```
pub fn[T, U : Eq] Rsignal::map(self : Rsignal[T], f : (T) -> U) -> Rsignal[U] {
  let s = new(f(self.value))
  self.observe(v => s.update(f(v)))
  s
}

///|
/// Creates a new signal that maps the values of two signals using the function `f`.
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
/// let values: Array[Int] = []
/// let s1 = new(1)
/// let s2 = new(2)
/// let s3 = map2(s1, s2, fn(a, b) { a + b })
/// s3.observe(fn(v) { values.push(v) })
/// s1.update(3) // This will trigger the observer effect with value 5.
/// s2.update(4) // This will trigger the observer effect with value 7.
/// s1.update(5) // This will trigger the observer effect with value 9.
/// inspect(values, content="[3, 5, 7, 9]")
/// ```
pub fn[T, U, V : Eq] map2(
  s1 : Rsignal[T],
  s2 : Rsignal[U],
  f : (T, U) -> V,
) -> Rsignal[V] {
  let s = new(f(s1.value, s2.value))
  s1.observe(v => s.update(f(v, s2.value)))
  s2.observe(v => s.update(f(s1.value, v)))
  s
}

///|
/// Creates a new signal that receives values from `self` where `f(new_value)` is `true`.
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
/// let filtered_values: Array[Int] = []
/// let s = new(1)
/// let s2 = s.filter(fn(v) { v > 5 }, 0)
/// s2.observe(fn(v) { filtered_values.push(v) }, exec_immediate=false)
/// s.update(10) // This will trigger the observer effect with value 10.
/// s.update(7) // This will trigger the observer effect with value 7.
/// s.update(3) // This will not trigger the observer effect.
/// inspect(filtered_values, content="[10, 7]")
/// ```
pub fn[T : Eq] Rsignal::filter(
  self : Rsignal[T],
  f : (T) -> Bool,
  seed : T,
) -> Rsignal[T] {
  let v = if f(self.value) { self.value } else { seed }
  let s = new(v)
  self.observe(v => if f(v) { s.update(v) })
  s
}

///|
/// Creates a new signal that maps the values of `self` iff `f(self.get()) == Some(v)`.
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
/// let mapped_values = []
/// let s = new(1)
/// let s2 = s.filter_map(fn(v) { if v > 5 { Some(v+2) } else { None } }, 0)
/// s2.observe(fn(v) { mapped_values.push(v) }, exec_immediate=false)
/// s.update(10) // This will trigger the observer effect with value 12.
/// s.update(7) // This will trigger the observer effect with value 9.
/// s.update(3) // This will not trigger the observer effect.
/// inspect(mapped_values, content="[12, 9]")
/// ```
pub fn[T, U : Eq] Rsignal::filter_map(
  self : Rsignal[T],
  f : (T) -> U?,
  seed : U,
) -> Rsignal[U] {
  let v = f(self.value).unwrap_or_else(() => seed)
  let s = new(v)
  self.observe(v => match f(v) {
    Some(v) => s.update(v)
    None => ()
  })
  s
}

// -- Combinators ---

///|
/// Creates a new signal which re-emits the latest signal from one of the 
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
/// let values = []
/// let s1 = new(1)
/// let s2 = new(2)
/// let s3 = new(3)
/// let combined_signal = select_one([s1, s2, s3])
/// combined_signal.observe(fn(v) { values.push(v) }, exec_immediate=false)
/// s1.update(4) // This will trigger the observer effect with value 4.
/// s2.update(5) // This will trigger the observer effect with value 5.
/// s3.update(6) // This will trigger the observer effect with value 6.
/// inspect(values, content="[4, 5, 6]")
/// ```
pub fn[T : Default + Eq] select_one(signals : Array[Rsignal[T]]) -> Rsignal[T] {
  let s = new(T::default())
  for signal in signals {
    signal.observe(v => s.update(v), exec_immediate=false)
  }
  s
}

///|
/// Creates a new signal that emits a tuple of the latest values from both signals.
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
/// let values = []
/// let s1 = new(1)
/// let s2 = new(2)
/// let s3 = pair(s1, s2)
/// s3.observe(fn(v) { values.push(v) })
/// s1.update(3) // This will trigger the observer effect with value (3, 2).
/// s2.update(4) // This will trigger the observer effect with value (3, 4).
/// s1.update(5) // This will trigger the observer effect with value (5, 4).
/// inspect(values, content="[(1, 2), (3, 2), (3, 4), (5, 4)]")
/// ```
pub fn[T : Eq, U : Eq] pair(
  s1 : Rsignal[T],
  s2 : Rsignal[U],
) -> Rsignal[(T, U)] {
  let s = new((s1.value, s2.value))
  s1.observe(v => s.update((v, s2.value)), exec_immediate=false)
  s2.observe(v => s.update((s1.value, v)), exec_immediate=false)
  s
}

///|
/// Creates a new signal that emits a tuple of the latest values from three signals.
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
/// let values = []
/// let s1 = new(1)
/// let s2 = new(2)
/// let s3 = new(3)
/// let s4 = triple(s1, s2, s3)
/// s4.observe(fn(v) { values.push(v) })
/// s1.update(4) // This will trigger the observer effect with value (4, 2, 3).
/// s2.update(5) // This will trigger the observer effect with value (4, 5, 3).
/// s3.update(6) // This will trigger the observer effect with value (4, 5, 6).
/// s1.update(7) // This will trigger the observer effect with value (7, 5, 6).
/// inspect(values, content="[(1, 2, 3), (4, 2, 3), (4, 5, 3), (4, 5, 6), (7, 5, 6)]")
/// ```
pub fn[T : Eq, U : Eq, V : Eq] triple(
  s1 : Rsignal[T],
  s2 : Rsignal[U],
  s3 : Rsignal[V],
) -> Rsignal[(T, U, V)] {
  let s = new((s1.value, s2.value, s3.value))
  s1.observe(v => s.update((v, s2.value, s3.value)), exec_immediate=false)
  s2.observe(v => s.update((s1.value, v, s3.value)), exec_immediate=false)
  s3.observe(v => s.update((s1.value, s2.value, v)), exec_immediate=false)
  s
}

///|
/// Combines all signals in `signals` into a single signal `s`. If any of the signals
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
/// let values = []
/// let s1 = new(1)
/// let s2 = new(2)
/// let s3 = new(3)
/// let s4 = new(4)
/// let combined_signal = all([s1, s2, s3, s4])
/// combined_signal.observe(fn(v) { values.push(v) })
/// s1.update(5) // This will trigger the observer effect with value [5, 2, 3, 4].
/// s2.update(6) // This will trigger the observer effect with value [5, 6, 3, 4].
/// s3.update(7) // This will trigger the observer effect with value [5, 6, 7, 4].
/// s4.update(8) // This will trigger the observer effect with value [5, 6, 7, 8].
/// inspect(values, content="[[1, 2, 3, 4], [5, 2, 3, 4], [5, 6, 3, 4], [5, 6, 7, 4], [5, 6, 7, 8]]")
/// ```
pub fn[T : Eq] all(signals : Array[Rsignal[T]]) -> Rsignal[Array[T]] {
  let latest_values = []
  for signal in signals {
    latest_values.push(signal.value)
  }
  let s = new(latest_values)
  for signal in signals {
    signal.observe(
      new_val => {
        let vals = []
        for s in signals {
          if s.id == signal.id {
            vals.push(new_val)
          } else {
            vals.push(s.value)
          }
        }
        s.update(vals)
      },
      exec_immediate=false,
    )
  }
  s
}
