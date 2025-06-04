///|
pub(open) trait TMouseEvent: TEvent {
  nop(Self) -> Unit
  client_x(self : Self) -> Double = _
  client_y(self : Self) -> Double = _
  alt_key(self : Self) -> Bool = _
  ctrl_key(self : Self) -> Bool = _
  meta_key(self : Self) -> Bool = _
  shift_key(self : Self) -> Bool = _
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

///|
extern "js" fn alt_key_ffi(js : JsValue) -> Bool = "(jv) => jv.altKey"

///|
impl TMouseEvent with alt_key(self : Self) -> Bool {
  alt_key_ffi(self.to_jv())
}

///|
extern "js" fn ctrl_key_ffi(js : JsValue) -> Bool = "(jv) => jv.ctrlKey"

///|
impl TMouseEvent with ctrl_key(self : Self) -> Bool {
  ctrl_key_ffi(self.to_jv())
}

///|
extern "js" fn meta_key_ffi(js : JsValue) -> Bool = "(jv) => jv.metaKey"

///|
impl TMouseEvent with meta_key(self : Self) -> Bool {
  meta_key_ffi(self.to_jv())
}

///|
extern "js" fn shift_key_ffi(js : JsValue) -> Bool = "(jv) => jv.shiftKey"

///|
impl TMouseEvent with shift_key(self : Self) -> Bool {
  shift_key_ffi(self.to_jv())
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
