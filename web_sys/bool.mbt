// -- Boolean as Text Node --

///|
pub impl TJsValue for Bool with to_jv(self : Bool) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
pub impl TNode for Bool

///|
pub impl TEventTarget for Bool
