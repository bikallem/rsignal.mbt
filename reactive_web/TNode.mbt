///|
pub const ELEMENT_NODE = 1

///|
pub const ATTRIBUTE_NODE = 2

///|
pub const TEXT_NODE = 3

///|
pub const DOCUMENT_NODE = 9

///|
pub(open) trait TNode: TEventTarget {
  node_name(self : Self) -> String = _
  node_type(self : Self) -> Int = _
  text_content(self : Self) -> String = _
  set_text_content(self : Self, text : &Show) -> Unit = _
  append_child(self : Self, child : &TNode) -> Unit = _
}

///|
extern "js" fn node_name_ffi(js : JsValue) -> String = "(jv) => jv.nodeName"

///|
impl TNode with node_name(self : Self) -> String {
  node_name_ffi(self.to_jv())
}

///|
extern "js" fn node_type_ffi(js : JsValue) -> Int = "(jv) => jv.nodeType"

///|
impl TNode with node_type(self : Self) -> Int {
  node_type_ffi(self.to_jv())
}

///|
extern "js" fn text_content_ffi(js : JsValue) -> String = "(jv) => jv.textContent"

///|
impl TNode with text_content(self : Self) -> String {
  text_content_ffi(self.to_jv())
}

///|
extern "js" fn set_text_content_ffi(js : JsValue, text : String) -> Unit = "(jv, text) => jv.textContent = text"

///|
impl TNode with set_text_content(self : Self, text : &Show) -> Unit {
  set_text_content_ffi(self.to_jv(), text.to_string())
}

///|
extern "js" fn append_child_ffi(node : JsValue, child : JsValue) -> Unit = "(self, child) => self.appendChild(child)"

///|
impl TNode with append_child(self : Self, child : &TNode) -> Unit {
  append_child_ffi(self.to_jv(), child.to_jv())
}
