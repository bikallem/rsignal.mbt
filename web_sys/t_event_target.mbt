///|
/// EventTarget - https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
pub(open) trait TEventTarget: TJsValue {
  add_event_listener(
    self : Self,
    event : String,
    listener : (Event) -> Unit,
    use_capture : Bool,
  ) -> Unit = _
  // remove_event_listener(self : Self, event : String, f : Listener) -> Unit = _
  // dispatch_event(self : Self, event : Listener) -> Unit = _
}

///|
impl TEventTarget with add_event_listener(
  self : Self,
  event : String,
  listener : (Event) -> Unit,
  use_capture : Bool,
) -> Unit {
  @ffi.add_event_listener(
    self.to_jv(),
    event,
    JsValue::to_jv(listener),
    use_capture,
  )
}

///|
pub fn[T] add_event_listener(
  target : &TJsValue,
  event : String,
  listener : (T) -> Unit,
  use_capture? : Bool = false,
) -> Unit {
  @ffi.add_event_listener(
    target.to_jv(),
    event,
    JsValue::to_jv(listener),
    use_capture,
  )
}
