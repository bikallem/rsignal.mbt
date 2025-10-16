///|
/// Create a new HTML element representing the given tag name
pub fn h(tag : String, nodes : Array[&TAttachableNode]) -> Element {
  let el = document.create_element(tag)
  nodes.each(node => node.attach(el))
  el
}

///|
pub fn mount_to_body(element : &TAttachableNode) -> Unit {
  document.body().append_child(element)
}

///|
pub fn button(
  label : &TAttachableNode,
  nodes : Array[&TAttachableNode],
) -> HTMLButtonElement {
  h("button", [label] + nodes).into()
}

///|
pub fn canvas(nodes : Array[&TAttachableNode]) -> HTMLCanvasElement {
  h("canvas", nodes).into()
}

///|
pub fn div(nodes : Array[&TAttachableNode]) -> HTMLDivElement {
  h("div", nodes).into()
}

///|
pub fn input(
  type_ : String,
  nodes : Array[&TAttachableNode],
) -> HTMLInputElement {
  h("input", [attr("type", type_)] + nodes).into()
}

///|
pub let span : (Array[&TAttachableNode]) -> Element = h("span", _)

///|
pub let h1 : (Array[&TAttachableNode]) -> Element = h("h1", _)

///|
pub let h2 : (Array[&TAttachableNode]) -> Element = h("h2", _)

///|
pub let h3 : (Array[&TAttachableNode]) -> Element = h("h3", _)

///|
pub let h4 : (Array[&TAttachableNode]) -> Element = h("h4", _)

///|
pub let h5 : (Array[&TAttachableNode]) -> Element = h("h5", _)

///|
pub let h6 : (Array[&TAttachableNode]) -> Element = h("h6", _)

///|
pub let p : (Array[&TAttachableNode]) -> Element = h("p", _)

///|
pub fn img(nodes : Array[&TAttachableNode]) -> HTMLImageElement {
  h("img", nodes).into()
}
