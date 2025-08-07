///| JavaScript Attr Object - https://developer.mozilla.org/en-US/docs/Web/API/Attr
#external
type Attr

///|
pub extern "js" fn Attr::name(self : Attr) -> String = "(self) => self.name"

///|
pub extern "js" fn Attr::value(self : Attr) -> String = "(self) => self.value"

///|
extern "js" fn Attr::set_value_ffi(self : Attr, value : String) -> Unit = "(self, value) => self.value = value"

///| Set the value of an attribute
pub fn[T : Show] Attr::set_value(self : Attr, value : T) -> Unit {
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
pub impl TAttachableNode for Attr with attach(self : Attr, parent : Element) -> Unit {
  set_attribute_node_ffi(parent.to_jv(), self.to_jv())
}

///|
pub impl TEventTarget for Attr

///|
pub(open) trait TAttrValue {
  init_value(self : Self, attr : Attr) -> Unit
}

///|
pub impl TAttrValue for String with init_value(self : String, attr : Attr) -> Unit {
  attr.set_value(self)
}

///|
pub impl TAttrValue for Int with init_value(self : Int, attr : Attr) -> Unit {
  attr.set_value(self.to_string())
}

///|
pub impl TAttrValue for Bool with init_value(self : Bool, attr : Attr) -> Unit {
  attr.set_value(self.to_string())
}

///|
pub impl[T : Show] TAttrValue for @reactive_core.Signal[T] with init_value(
  self : @reactive_core.Signal[T],
  attr : Attr,
) -> Unit {
  self.subscribe_permanent(value => attr.set_value(value))
}

///|
pub fn[T : TAttrValue] attr(name : String, v : T) -> Attr {
  let at = document.create_attribute(name)
  v.init_value(at)
  at
}

///|
pub fn bool_attr(name : String) -> Attr {
  let at = document.create_attribute(name)
  at
}

///| id attribute
pub fn id(id : String) -> Attr {
  attr("id", id)
}

///| class attribute
pub fn class(class : String) -> Attr {
  attr("class", class)
}

///| style attribute
pub fn style(style : String) -> Attr {
  attr("style", style)
}

///|
pub fnalias attr as a
