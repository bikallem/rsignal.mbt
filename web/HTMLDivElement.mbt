///|
extern type HTMLDivElement

///|
pub impl TJsValue for HTMLDivElement with to_jv(self : HTMLDivElement) -> JsValue = "%identity"

///|
pub impl TElement for HTMLDivElement with nop(_) -> Unit {

}

///|
pub impl TNode for HTMLDivElement with nop(_) -> Unit {

}

///|
pub impl TEventTarget for HTMLDivElement with nop(_) -> Unit {

}

///|
pub impl THTMLelement for HTMLDivElement with nop(_) -> Unit {

}

///|
pub impl TAttachableNode for HTMLDivElement with nop(_) -> Unit {

}

///|
pub fn div(nodes : Array[&TAttachableNode]) -> HTMLDivElement {
  h("div", nodes).into()
}
