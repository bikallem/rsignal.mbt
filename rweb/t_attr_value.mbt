///|
/// `TAttrValue` is a trait that specifies types that can be used as attribute values of HTML elements.
pub(open) trait TAttrValue {
  #deprecated("Use `set_attr` instead")
  set_value(self : Self, attr : Attr) -> Unit = _
  set_attr(self : Self, attr : Attr) -> Unit
}

///|
impl TAttrValue with set_value(self : Self, attr : Attr) -> Unit {
  self.set_attr(attr)
}
