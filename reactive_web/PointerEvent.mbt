///|
extern type PointerEvent

///|
pub impl TMouseEvent for PointerEvent with nop(_ : PointerEvent) -> Unit {

}

///|
pub impl TJsValue for PointerEvent with to_jv(self : PointerEvent) -> JsValue = "%identity"

///|
pub impl TEvent for PointerEvent with nop(_ : PointerEvent) -> Unit {

}

///|
pub fn PointerEvent::from_event(ev : &TEvent) -> PointerEvent = "%identity"
