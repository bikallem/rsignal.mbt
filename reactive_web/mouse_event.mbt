///| MouseEvent - https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
#external
type MouseEvent

///|
pub impl TJsValue for MouseEvent with to_jv(self : MouseEvent) -> JsValue = "%identity"

///|
pub impl TMouseEvent for MouseEvent

///|
pub impl TEvent for MouseEvent
