///| JavaScript Attr Object - https://developer.mozilla.org/en-US/docs/Web/API/Attr
#external
type Attr

///|
pub extern "js" fn Attr::name(self : Attr) -> String = "(self) => self.name"

///|
pub extern "js" fn Attr::value(self : Attr) -> String = "(self) => self.value"

///|
extern "js" fn Attr::set_value_ffi(self : Attr, value : String) -> Unit =
  #| (self, value) => self.value = value

///| Set the value of an attribute
pub fn Attr::set_value(self : Attr, value : &Show) -> Unit {
  self.set_value_ffi(value.to_string())
}

///|
extern "js" fn owner_element_ffi(attr : Attr) -> JsValue = "(attr) => attr.ownerElement"

///|
pub fn Attr::owner_element(self : Attr) -> Element? {
  JsValue::to_option(owner_element_ffi(self))
}

///|
pub impl TJsValue for Attr with to_jv(self : Attr) -> JsValue = "%identity"

///|
pub impl TNode for Attr

///|
pub impl TAttachableNode for Attr

///|
pub impl TAttachableNode for Attr with attach(self : Attr, parent : Element) -> Unit {
  set_attribute_node_ffi(parent.to_jv(), self.to_jv())
}

///|
pub impl TEventTarget for Attr

///|
pub fn[T : Show] attr(name : String, value : T) -> Attr {
  let at = document.create_attribute(name)
  at.set_value(value)
  at
}

///| id attribute
pub fn id(id : String) -> Attr {
  attr("id", id)
}

///| class attribute
pub fn clasz(clasz : String) -> Attr {
  attr("class", clasz)
}

///| style attribute
pub fn style(style : String) -> Attr {
  attr("style", style)
}

///|
pub fnalias attr as a
