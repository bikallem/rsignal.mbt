///| https://developer.mozilla.org/en-US/docs/Web/API/BeforeUnloadEvent
extern type BeforeUnloadEvent

///|
pub impl TJsValue for BeforeUnloadEvent with to_jv(self : BeforeUnloadEvent) -> JsValue = "%identity"

///|
pub impl TEvent for BeforeUnloadEvent with nop(_ : BeforeUnloadEvent) -> Unit {

}
