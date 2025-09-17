///|
#external
type Event

///|
pub impl TJsValue for Event with to_jv(self : Event) -> JsValue = "%identity"

///|
pub impl TEvent for Event

///|
pub fn[T : TEvent] Event::into(self : Event) -> T = "%identity"
