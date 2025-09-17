///|
#external
type HTMLDivElement

///|
pub impl TJsValue for HTMLDivElement with to_jv(self : HTMLDivElement) -> JsValue = "%identity"

///|
pub impl TEventTarget for HTMLDivElement

///|
pub impl TNode for HTMLDivElement

///|
pub impl TElement for HTMLDivElement

///|
pub impl THTMLelement for HTMLDivElement

///|
pub impl TAttachableNode for HTMLDivElement

///|
pub fn div(nodes : Array[&TAttachableNode]) -> HTMLDivElement {
  h("div", nodes).into()
}
