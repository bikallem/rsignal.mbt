///|
/// An observer observes changes to a signal and runs an effect function when the signal changes.
struct Observer[T] {
  id : ObserverId // unique ID for this observer, used to subscribe/unsubscribe
  effect : (T) -> Unit // function to call when the signal changes
}

///|
/// Observer ID
priv struct ObserverId(Int) derive(Eq, Hash, Show)

///|
fn[T] Observer::effect(self : Observer[T], value : T) -> Unit {
  (self.effect)(value)
}

///|
/// Returns the string representation of the observer's ID.
pub fn[T] Observer::id(self : Observer[T]) -> String {
  self.id.to_string()
}
