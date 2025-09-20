///|
#external
type EventTarget

///|
pub impl TJsValue for EventTarget with to_jv(self : EventTarget) -> JsValue = "%identity"

///|
pub impl TEventTarget for EventTarget

///|
pub fn[T : TEventTarget] EventTarget::into(self : EventTarget) -> T = "%identity"
