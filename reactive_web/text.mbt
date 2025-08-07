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

///| Create a new text node with the given content
pub fn[T : TTextValue] text(content : T) -> Text {
  let text = document.create_text_node("")
  content.set_value(text)
  text
}
