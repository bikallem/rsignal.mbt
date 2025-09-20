///|
pub impl TAttachableNode for Element

///|
/// Create a new HTML element representing the given tag name
pub fn h(tag : String, nodes : Array[&TAttachableNode]) -> Element {
  let el = document.create_element(tag)
  nodes.each(node => node.attach(el))
  el
}

///|
pub let span : (Array[&TAttachableNode]) -> Element = h("span", _)
