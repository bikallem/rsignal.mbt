///|
extern type HTMLInputElement

///|
pub impl TJsValue for HTMLInputElement with to_jv(self : HTMLInputElement) -> JsValue = "%identity"

///|
pub impl TElement for HTMLInputElement with nop(_) -> Unit {

}

///|
pub impl TNode for HTMLInputElement with nop(_) -> Unit {

}

///|
pub impl TEventTarget for HTMLInputElement with nop(_) -> Unit {

}

///|
pub impl THTMLelement for HTMLInputElement with nop(_) -> Unit {

}

///|
pub impl TAttachableNode for HTMLInputElement with nop(_) -> Unit {

}

///|
pub extern "js" fn HTMLInputElement::files(self : HTMLInputElement) -> FileList = "(self) => self.files"

///|
pub fn input(
  type_ : String,
  nodes : Array[&TAttachableNode]
) -> HTMLInputElement {
  h("input", [a("type", type_)] + nodes).into()
}
