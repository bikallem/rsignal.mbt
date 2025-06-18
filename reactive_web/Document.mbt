///| Javascript DOM Document
#external
type Document

///|
pub impl TNode for Document

///|
pub impl TJsValue for Document with to_jv(self : Document) -> JsValue = "%identity"

///|
pub impl TEventTarget for Document

///|
extern "js" fn document_ffi() -> Document = "() => document"

///| Global document instance
pub let document : Document = document_ffi()

///|
extern "js" fn get_element_by_id_ffi(doc : Document, id : String) -> JsValue = "(doc, id) => doc.getElementById(id)"

///|
pub fn Document::get_element_by_id(self : Document, id : String) -> Element? {
  JsValue::to_option(get_element_by_id_ffi(self, id))
}

///| Create a new attribute with the given name and value
pub extern "js" fn Document::create_attribute(
  self : Document,
  name : String
) -> Attr = "(document, name) => document.createAttribute(name)"

///| Create a new element with the given tag name
pub extern "js" fn Document::create_element(
  self : Document,
  tag_name : String
) -> Element = "(document, tag_name) => document.createElement(tag_name)"

///|
extern "js" fn body_ffi() -> Element = "() => document.body"

///|
pub fn Document::body(_ : Document) -> Element {
  body_ffi()
}

///| Create a new text node with the given content
pub extern "js" fn Document::create_text_node(
  self : Document,
  content : String
) -> Text = "(document, content) => document.createTextNode(content)"
