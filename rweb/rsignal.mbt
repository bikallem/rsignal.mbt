// -- Signal Attribute Value --

///|
pub impl[T : Show] TAttrValue for @rsignal.Rsignal[T] with set_attr(
  self : @rsignal.Rsignal[T],
  attr : Attr,
) -> Unit {
  self.observe(value => attr.set_value(value))
}

///|
pub impl[T : Show] TAttachableNode for @rsignal.Rsignal[T]
