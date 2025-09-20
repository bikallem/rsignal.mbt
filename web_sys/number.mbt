// Implements Moonbit numeric types as text nodes, allowing them to be used as element children in the DOM.

///|
pub impl TJsValue for Int with to_jv(self : Int) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
/// Int literal as a text node
pub impl TNode for Int

///|
pub impl TEventTarget for Int

///|
pub impl TJsValue for Int16 with to_jv(self : Int16) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
/// Int16 literal as a text node
pub impl TNode for Int16

///|
pub impl TEventTarget for Int16

///|
pub impl TJsValue for Int64 with to_jv(self : Int64) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
/// Int64 literal as a text node
pub impl TNode for Int64

///|
pub impl TEventTarget for Int64

///|
pub impl TJsValue for UInt16 with to_jv(self : UInt16) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
/// UInt16 literal as a text node
pub impl TNode for UInt16

///|
pub impl TEventTarget for UInt16

///|
pub impl TJsValue for UInt with to_jv(self : UInt) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
/// UInt literal as a text node
pub impl TNode for UInt

///|
pub impl TEventTarget for UInt

///|
pub impl TJsValue for UInt64 with to_jv(self : UInt64) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
/// UInt64 literal as a text node
pub impl TNode for UInt64

///|
pub impl TEventTarget for UInt64

///|
pub impl TJsValue for Double with to_jv(self : Double) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
/// Double literal as a text node
pub impl TNode for Double

///|
pub impl TEventTarget for Double

///|
pub impl TJsValue for Float with to_jv(self : Float) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
/// Float literal as a text node
pub impl TNode for Float

///|
pub impl TEventTarget for Float

///|
pub impl TJsValue for BigInt with to_jv(self : BigInt) -> JsValue {
  document.create_text_node(self).to_jv()
}

///|
/// BigInt literal as a text node
pub impl TNode for BigInt

///|
pub impl TEventTarget for BigInt
