///|
pub impl TAttachableNode for Attr with attach(self : Attr, parent : Element) -> Unit {
  @ffi.set_attribute_node(parent.to_jv(), self.to_jv())
}

///|
pub fn[T : TAttrValue] attr(name : String, v : T) -> Attr {
  let at = document.create_attribute(name)
  v.set_attr(at)
  at
}

///|
/// id attribute
pub fn id(id : String) -> Attr {
  attr("id", id)
}

///|
/// class attribute
pub fn class(class : String) -> Attr {
  attr("class", class)
}

///|
/// style attribute
pub fn style(style : String) -> Attr {
  attr("style", style)
}
