// -- Boolean Attribute Value --

///|
pub impl TAttrValue for Bool with set_value(self : Bool, attr : Attr) -> Unit {
  attr.set_value(self)
}

// -- Boolean Text Value --

///|
pub impl TTextValue for Bool with set_value(self : Bool, node : Text) -> Unit {
  node.set_text_content(self)
}

// -- Boolean as Text Node --

///|
pub impl TJsValue for Bool with to_jv(self : Bool) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
pub impl TNode for Bool

///|
pub impl TEventTarget for Bool

///|
pub impl TAttachableNode for Bool
