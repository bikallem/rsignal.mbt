///| Javascript DOM Element
#external
type Element

///|
pub impl TJsValue for Element with to_jv(self) -> JsValue = "%identity"

///|
pub impl TElement for Element

///|
pub impl TNode for Element

///|
pub impl TAttachableNode for Element

///|
pub impl TEventTarget for Element

///|
pub fn[T : TElement] Element::into(self : Element) -> T = "%identity"

///| Create a new HTML element representing the given tag name
pub fn h(tag : String, nodes : Array[&TAttachableNode]) -> Element {
  let el = document.create_element(tag)
  nodes.each(fn(node) { node.attach(el) })
  el
}

///|
pub let span : (Array[&TAttachableNode]) -> Element = h("span", _)
