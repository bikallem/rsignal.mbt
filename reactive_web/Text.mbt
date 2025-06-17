///| Javascript DOM Text Node - https://developer.mozilla.org/en-US/docs/Web/API/Text
#external
type Text

///|
pub extern "js" fn whole_text(self : Text) -> String = "(self) => self.wholeText"

///|
pub impl TNode for Text

///|
pub impl TJsValue for Text with to_jv(self : Text) -> JsValue = "%identity"

///|
pub impl TEventTarget for Text

///|
pub impl TNode for String

///|
pub impl TEventTarget for String

///|
pub impl TAttachableNode for String

///|
pub impl TJsValue for String with to_jv(self : String) -> JsValue {
  JsValue::to_jv(document.create_text_node(self))
}

///| Create a new text node with the given content
pub fn text(content : String) -> Text {
  document.create_text_node(content)
}
