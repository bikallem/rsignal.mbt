///|
pub impl TAttachableNode for String

// -- String Attribute Value --

///|
pub impl TAttrValue for String with set_attr(self : String, attr : Attr) -> Unit {
  attr.set_value(self)
}
