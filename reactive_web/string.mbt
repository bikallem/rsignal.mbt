///|
pub impl TJsValue for String with to_jv(self : String) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
pub impl TNode for String

///|
pub impl TEventTarget for String

///|
pub impl TAttachableNode for String

// -- String Attribute Value --

///|
pub impl TAttrValue for String with set_value(self : String, attr : Attr) -> Unit {
  attr.set_value(self)
}

// -- String as Text Value --

///|
pub impl TTextValue for String with set_value(self : String, node : Text) -> Unit {
  node.set_text_content(self)
}
