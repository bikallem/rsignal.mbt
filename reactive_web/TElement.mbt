///|
pub(open) trait TElement: TNode {
  tag_name(self : Self) -> String = _
  set_attribute(self : Self, name : String, value : String) -> Unit = _
  set_attribute_node(self : Self, attr : Attr) -> Unit = _
  get_bounding_client_rect(self : Self) -> DOMRect = _
  remove_attribute_node(self : Self, attr : Attr) -> Unit = _
  toggle_attribute(self : Self, name : String, force : Bool) -> Unit = _

  // Events
  onclick(self : Self, f : (PointerEvent) -> Unit) -> Unit = _
  onmousedown(self : Self, f : (MouseEvent) -> Unit) -> Unit = _
  onmousemove(self : Self, f : (MouseEvent) -> Unit) -> Unit = _
  onmouseup(self : Self, f : (MouseEvent) -> Unit) -> Unit = _
  onkeydown(self : Self, f : (KeyboardEvent) -> Unit) -> Unit = _
  onkeyup(self : Self, f : (KeyboardEvent) -> Unit) -> Unit = _
}

///|
extern "js" fn tag_name_ffi(element : JsValue) -> String =
  #| (self) => self.tagName

///|
impl TElement with tag_name(self : Self) -> String {
  tag_name_ffi(self.to_jv())
}

///| Set an attribute on the element
extern "js" fn set_attribute_ffi(
  element : JsValue,
  name : String,
  value : String
) -> Unit = "(self, name, v) => self.setAttribute(name, v)"

///|
impl TElement with set_attribute(self : Self, name : String, value : String) -> Unit {
  set_attribute_ffi(self.to_jv(), name, value)
}

///|
extern "js" fn set_attribute_node_ffi(
  element : JsValue,
  attr : JsValue
) -> Unit = "(self, attr) => self.setAttributeNode(attr)"

///|
impl TElement with set_attribute_node(self : Self, attr : Attr) -> Unit {
  set_attribute_node_ffi(self.to_jv(), attr.to_jv())
}

///|
extern "js" fn get_bounding_client_rect_ffi(element : JsValue) -> DOMRect = "(self) => self.getBoundingClientRect()"

///|
impl TElement with get_bounding_client_rect(self : Self) -> DOMRect {
  get_bounding_client_rect_ffi(self.to_jv())
}

///|
extern "js" fn remove_attribute_node_ffi(
  element : JsValue,
  attr : Attr
) -> Unit = "(self, attr) => self.removeAttributeNode(attr)"

///|
impl TElement with remove_attribute_node(self : Self, attr : Attr) -> Unit {
  remove_attribute_node_ffi(self.to_jv(), attr)
}

///|
extern "js" fn toggle_attribute_ffi(
  element : JsValue,
  name : String,
  force : Bool
) -> Unit = "(self, name, force) => self.toggleAttribute(name, force)"

///|
impl TElement with toggle_attribute(self : Self, name : String, force : Bool) -> Unit {
  toggle_attribute_ffi(self.to_jv(), name, force)
}

///|
impl TElement with onclick(self : Self, f : (PointerEvent) -> Unit) -> Unit {
  add_event_listener(self, "click", f)
}

///|
impl TElement with onmousedown(self : Self, f : (MouseEvent) -> Unit) -> Unit {
  add_event_listener(self, "mousedown", f)
}

///|
impl TElement with onmousemove(self : Self, f : (MouseEvent) -> Unit) -> Unit {
  add_event_listener(self, "mousemove", f)
}

///|
impl TElement with onmouseup(self : Self, f : (MouseEvent) -> Unit) -> Unit {
  add_event_listener(self, "mouseup", f)
}

///|
impl TElement with onkeydown(self : Self, f : (KeyboardEvent) -> Unit) -> Unit {
  add_event_listener(self, "keydown", f)
}

///|
impl TElement with onkeyup(self : Self, f : (KeyboardEvent) -> Unit) -> Unit {
  add_event_listener(self, "keyup", f)
}
