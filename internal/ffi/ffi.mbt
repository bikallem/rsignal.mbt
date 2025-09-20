///|
pub extern "js" fn set_attribute_node(
  element : JsValue,
  attr : JsValue,
) -> Unit = "(self, attr) => self.setAttributeNode(attr)"

///|
pub extern "js" fn add_event_listener(
  target : JsValue,
  event : String,
  listener : JsValue,
  use_capture : Bool,
) -> Unit = "(target, event, listener, useCapture) => target.addEventListener(event, listener, useCapture)"
