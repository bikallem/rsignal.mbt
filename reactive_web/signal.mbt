// -- Signal Attribute Value --

///|
pub impl[T : Show] TAttrValue for @reactive_core.Signal[T] with set_value(
  self : @reactive_core.Signal[T],
  attr : Attr,
) -> Unit {
  self.subscribe_permanent(value => attr.set_value(value))
}

// -- Signal Text Value --

///|
pub impl[T : Show] TTextValue for @reactive_core.Signal[T] with set_value(
  self : @reactive_core.Signal[T],
  node : Text,
) -> Unit {
  self.subscribe_permanent(value => node.set_text_content(value))
}

// -- Signal as Text Node --

///|
pub impl[T : Show] TJsValue for @reactive_core.Signal[T] with to_jv(
  self : @reactive_core.Signal[T],
) -> JsValue {
  let text = document.create_text_node("")
  self.subscribe_permanent(value => text.set_text_content(value))
  text.to_jv()
}

///|
pub impl[T : Show] TNode for @reactive_core.Signal[T]

///|
pub impl[T : Show] TEventTarget for @reactive_core.Signal[T]

///|
pub impl[T : Show] TAttachableNode for @reactive_core.Signal[T]
