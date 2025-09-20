// -- String as Text node --

///|
pub impl TJsValue for String with to_jv(self : String) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
pub impl TNode for String

///|
pub impl TEventTarget for String
