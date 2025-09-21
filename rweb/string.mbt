///|
/// String as Attachable Node - It is converted to a text node when attached.
pub impl TAttachableNode for String

///|
/// String Attribute Value - It is set as the value of the attribute.
pub impl TAttrValue for String with set_attr(self : String, attr : Attr) -> Unit {
  attr.set_value(self)
}
