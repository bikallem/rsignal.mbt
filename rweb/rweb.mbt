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
pub impl TAttachableNode for HTMLButtonElement

///|
pub impl TAttachableNode for HTMLCanvasElement

///|
pub fn div(nodes : Array[&TAttachableNode]) -> HTMLDivElement {
  h("div", nodes).into()
}

///|
pub impl TAttachableNode for HTMLInputElement

///|
pub impl TAttachableNode for HTMLDivElement

///|
pub impl TAttachableNode for HTMLImageElement

///|
pub fn input(
  type_ : String,
  nodes : Array[&TAttachableNode],
) -> HTMLInputElement {
  h("input", [attr("type", type_)] + nodes).into()
}
