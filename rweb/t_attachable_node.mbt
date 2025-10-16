///|
/// Represents a node that can be attached to another node in the DOM.
/// Examples include elements, text nodes, attributes and event handlers 
/// attributes. 
/// Not all nodes can be attached. For example, a document node cannot 
/// be attached to another node. A text node can only be attached to an
/// element node, and an attribute can only be attached to an element node.
pub(open) trait TAttachableNode: TNode {
  attach(self : Self, parent : Element) -> Unit = _
}

///|
impl TAttachableNode with attach(self : Self, parent : Element) -> Unit {
  parent.append_child(self)
}

///|
pub impl TAttachableNode for Element

///|
pub impl TAttachableNode for HTMLButtonElement

///|
pub impl TAttachableNode for HTMLCanvasElement

///|
pub impl TAttachableNode for HTMLInputElement

///|
pub impl TAttachableNode for HTMLDivElement

///|
pub impl TAttachableNode for HTMLImageElement
