///|
#external
type HTMLInputElement

///|
pub impl TJsValue for HTMLInputElement with to_jv(self : HTMLInputElement) -> JsValue = "%identity"

///|
pub impl TElement for HTMLInputElement

///|
pub impl TNode for HTMLInputElement

///|
pub impl TEventTarget for HTMLInputElement

///|
pub impl THTMLelement for HTMLInputElement

///|
pub impl TAttachableNode for HTMLInputElement

///|
pub extern "js" fn HTMLInputElement::files(self : HTMLInputElement) -> FileList = "(self) => self.files"

///|
pub fn input(
  type_ : String,
  nodes : Array[&TAttachableNode]
) -> HTMLInputElement {
  h("input", [a("type", type_)] + nodes).into()
}
