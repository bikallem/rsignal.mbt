///|
pub(open) trait TMouseEvent: TEvent {
  nop(Self) -> Unit
  client_x(self : Self) -> Double = _
  client_y(self : Self) -> Double = _
}

///|
extern "js" fn client_x_ffi(js : JsValue) -> Double = "(jv) => jv.clientX"

///|
impl TMouseEvent with client_x(self : Self) -> Double {
  client_x_ffi(self.to_jv())
}

///|
extern "js" fn client_y_ffi(js : JsValue) -> Double = "(jv) => jv.clientY"

///|
impl TMouseEvent with client_y(self : Self) -> Double {
  client_y_ffi(self.to_jv())
}

///| MouseEvent - https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
extern type MouseEvent

///|
pub impl TJsValue for MouseEvent with to_jv(self : MouseEvent) -> JsValue = "%identity"

///|
pub impl TMouseEvent for MouseEvent with nop(_ : MouseEvent) -> Unit {

}

///|
pub impl TEvent for MouseEvent with nop(_ : MouseEvent) -> Unit {

}

///|
pub fn MouseEvent::from_event(event : &TEvent) -> MouseEvent = "%identity"
