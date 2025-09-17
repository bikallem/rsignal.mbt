// -- Signal Attribute Value --

///|
pub impl[T : Show] TAttrValue for @rsignal.Signal[T] with set_value(
  self : @rsignal.Signal[T],
  attr : Attr,
) -> Unit {
  self.subscribe_permanent(value => attr.set_value(value))
}

// -- Signal as Text Node --

///|
pub impl[T : Show] TJsValue for @rsignal.Signal[T] with to_jv(
  self : @rsignal.Signal[T],
) -> JsValue {
  let text = document.create_text_node("")
  self.subscribe_permanent(value => text.set_text_content(value))
  text.to_jv()
}

///|
pub impl[T : Show] TNode for @rsignal.Signal[T]

///|
pub impl[T : Show] TEventTarget for @rsignal.Signal[T]

///|
pub impl[T : Show] TAttachableNode for @rsignal.Signal[T]
