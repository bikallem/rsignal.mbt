///|
/// `TAttrValue` is a trait that specifies types that can be used as attribute values of HTML elements.
pub(open) trait TAttrValue {
  set_attr(self : Self, attr : Attr) -> Unit
}
