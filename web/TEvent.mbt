///|
pub(open) trait TEvent: TJsValue {
  nop(Self) -> Unit
  type_(Self) -> String = _
  target(Self) -> EventTarget = _
  current_target(Self) -> EventTarget = _
  stop_propagation(self : Self) -> Unit = _
  prevent_default(self : Self) -> Unit = _
  stop_immediate_propagation(self : Self) -> Unit = _
}

///|
extern "js" fn target_ffi(ev : JsValue) -> EventTarget = "(ev) => ev.target"

///|
impl TEvent with target(self : Self) -> EventTarget {
  target_ffi(self.to_jv())
}

///|
extern "js" fn current_target_ffi(ev : JsValue) -> EventTarget = "(ev) => ev.currentTarget"

///|
impl TEvent with current_target(self : Self) -> EventTarget {
  current_target_ffi(self.to_jv())
}

///|
extern "js" fn stop_propagation_ffi(ev : JsValue) -> Unit = "(ev) => ev.stopPropagation()"

///|
impl TEvent with stop_propagation(self : Self) -> Unit {
  stop_propagation_ffi(self.to_jv())
}

///|
extern "js" fn prevent_default_ffi(ev : JsValue) -> Unit = "(ev) => ev.preventDefault()"

///|
impl TEvent with prevent_default(self : Self) -> Unit {
  prevent_default_ffi(self.to_jv())
}

///|
extern "js" fn stop_immediate_propagation_ffi(ev : JsValue) -> Unit = "(ev) => ev.stopImmediatePropagation()"

///|
impl TEvent with stop_immediate_propagation(self : Self) -> Unit {
  stop_immediate_propagation_ffi(self.to_jv())
}

///| Get event type
extern "js" fn event_type_ffi(ev : JsValue) -> String = "(ev) => ev.type"

///|
impl TEvent with type_(self : Self) -> String {
  event_type_ffi(self.to_jv())
}
