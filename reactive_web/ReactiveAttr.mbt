///|
struct ReactiveAttr[T] {
  attr : Attr
  signal : @reactive_core.Signal[T]
  effect : (Element, Attr, T) -> Unit
}

///|
pub impl[T] TJsValue for ReactiveAttr[T] with to_jv(_) -> JsValue {
  abort("ReactiveAttr cannot be converted to Jv")
}

///|
pub impl[T : Eq] TNode for ReactiveAttr[T]

///|
pub impl[T : Eq] TAttachableNode for ReactiveAttr[T] with attach(
  self : ReactiveAttr[T],
  parent : Element,
) -> Unit {
  set_attribute_node_ffi(parent.to_jv(), self.attr.to_jv())
  self.signal.subscribe_permanent(value => (self.effect)(
    parent,
    self.attr,
    value,
  ))
}

///|
pub impl[T : Eq] TEventTarget for ReactiveAttr[T]

///|
pub fn[A] ReactiveAttr::new(
  name : String,
  signal : @reactive_core.Signal[A],
  effect : (Element, Attr, A) -> Unit,
) -> ReactiveAttr[A] {
  let attr = document.create_attribute(name)
  ReactiveAttr::{ attr, signal, effect }
}

///|
pub fn ReactiveAttr::disabled(
  signal : @reactive_core.Signal[Bool],
) -> ReactiveAttr[Bool] {
  ReactiveAttr::new("disabled", signal, (el, attr, disable) => if disable {
    el.set_attribute_node(attr)
  } else {
    el.remove_attribute_node(attr)
  })
}

///|
pub fn ReactiveAttr::style(
  signal : @reactive_core.Signal[String],
) -> ReactiveAttr[String] {
  ReactiveAttr::new("style", signal, (_el, attr, style) => attr.set_value(style))
}
