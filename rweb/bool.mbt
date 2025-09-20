// -- Boolean Attribute Value --

///|
pub impl TAttrValue for Bool with set_attr(self : Bool, attr : Attr) -> Unit {
  attr.set_value(self)
}
