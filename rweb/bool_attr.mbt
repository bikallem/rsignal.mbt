///|
/// Boolean Attribute - https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes#boolean_attributes
struct BoolAttr {
  name : String
  attr : Attr
  rsignal : @rsignal.Rsignal[Bool]?
}

///|
pub fn BoolAttr::name(self : BoolAttr) -> String {
  self.name
}

///|
#as_free_fn
pub fn BoolAttr::bool_attr(
  name : String,
  rs? : @rsignal.Rsignal[Bool],
) -> BoolAttr {
  let attr = document.create_attribute(name)
  BoolAttr::{ name, attr, rsignal: rs }
}

///|
pub impl TJsValue for BoolAttr with to_jv(self : BoolAttr) -> JsValue {
  self.attr.to_jv()
}

///|
pub impl TNode for BoolAttr

///|
pub impl TEventTarget for BoolAttr

///|
pub impl TAttachableNode for BoolAttr with attach(
  self : BoolAttr,
  parent : Element,
) -> Unit {
  set_attribute_node_ffi(parent.to_jv(), self.attr.to_jv())
  guard self.rsignal is Some(signal) else {  }
  signal.observer_forever(attach_attr => if attach_attr {
    parent.set_attribute_node(self.attr)
  } else {
    parent.remove_attribute_node(self.attr)
  })
}
