///|
#external
type ProgressEvent

///|
pub impl TJsValue for ProgressEvent with to_jv(self : ProgressEvent) -> JsValue = "%identity"

///|
pub impl TEvent for ProgressEvent
