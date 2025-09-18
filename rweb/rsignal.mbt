// -- Signal Attribute Value --

///|
pub impl[T : Show] TAttrValue for @rsignal.Rsignal[T] with set_attr(
  self : @rsignal.Rsignal[T],
  attr : Attr,
) -> Unit {
  self.observe(value => attr.set_value(value))
}

// -- Signal as Text Node --

///|
pub impl[T : Show] TJsValue for @rsignal.Rsignal[T] with to_jv(
  self : @rsignal.Rsignal[T],
) -> JsValue {
  let text = document.create_text_node("")
  self.observe(value => text.set_text_content(value))
  text.to_jv()
}

///|
pub impl[T : Show] TNode for @rsignal.Rsignal[T]

///|
pub impl[T : Show] TEventTarget for @rsignal.Rsignal[T]

///|
pub impl[T : Show] TAttachableNode for @rsignal.Rsignal[T]
