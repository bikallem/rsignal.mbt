///| EventHandlerAttr - represents an event handler attribute such as onclick, onmouseover, etc.
/// These can be used as `h([onclick(fun(ev){..})])` when specifying element attributes.
struct EventHandlerAttr[E] {
  event_name : String
  handler : (E) -> Unit
}

///|
pub fn[E] EventHandlerAttr::new(
  event : String,
  handler : (E) -> Unit,
) -> EventHandlerAttr[E] {
  EventHandlerAttr::{ event_name: event, handler }
}

///|
pub fn[E] EventHandlerAttr::event_name(self : EventHandlerAttr[E]) -> String {
  self.event_name
}

///|
pub fn[E] EventHandlerAttr::handler(self : EventHandlerAttr[E]) -> (E) -> Unit {
  self.handler
}

///|
pub impl[T] TJsValue for EventHandlerAttr[T] with to_jv(_) -> JsValue {
  abort("EventHandlerAttr cannot be converted to Jv")
}

///|
pub impl[T] TNode for EventHandlerAttr[T] with node_type(_) -> Int {
  abort("EventHandlerAttr does not have a node type")
}

///|
pub impl[T] TAttachableNode for EventHandlerAttr[T] with attach(
  self : EventHandlerAttr[T],
  parent : Element,
) -> Unit {
  add_event_listener(parent, self.event_name, self.handler)
}

///|
pub impl[T] TEventTarget for EventHandlerAttr[T]

///| onclick attribute
pub fn onclick(
  handler : (PointerEvent) -> Unit,
) -> EventHandlerAttr[PointerEvent] {
  EventHandlerAttr::new("click", handler)
}

///|
pub fn onchange(handler : (Event) -> Unit) -> EventHandlerAttr[Event] {
  EventHandlerAttr::new("change", handler)
}
