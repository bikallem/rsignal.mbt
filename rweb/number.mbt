// Implements Moonbit numeric types as text nodes, allowing them to be used as element children in the DOM.

///|
pub impl TAttachableNode for Int

///|
pub impl TAttachableNode for Int16

///|
pub impl TAttachableNode for Int64

///|
pub impl TAttachableNode for UInt16

///|
pub impl TAttachableNode for UInt

///|
pub impl TAttachableNode for UInt64

///|
pub impl TAttachableNode for Double

///|
pub impl TAttachableNode for Float

///|
pub impl TAttachableNode for BigInt

// --- Number Attribute Values --

///|
pub impl TAttrValue for Int with set_attr(self : Int, attr : Attr) -> Unit {
  attr.set_value(self)
}

///|
pub impl TAttrValue for Int16 with set_attr(self : Int16, attr : Attr) -> Unit {
  attr.set_value(self)
}

///|
pub impl TAttrValue for Int64 with set_attr(self : Int64, attr : Attr) -> Unit {
  attr.set_value(self)
}

///|
pub impl TAttrValue for UInt with set_attr(self : UInt, attr : Attr) -> Unit {
  attr.set_value(self)
}

///|
pub impl TAttrValue for UInt16 with set_attr(self : UInt16, attr : Attr) -> Unit {
  attr.set_value(self)
}

///|
pub impl TAttrValue for UInt64 with set_attr(self : UInt64, attr : Attr) -> Unit {
  attr.set_value(self)
}

///|
pub impl TAttrValue for Double with set_attr(self : Double, attr : Attr) -> Unit {
  attr.set_value(self)
}

///|
pub impl TAttrValue for Float with set_attr(self : Float, attr : Attr) -> Unit {
  attr.set_value(self)
}

///|
pub impl TAttrValue for BigInt with set_attr(self : BigInt, attr : Attr) -> Unit {
  attr.set_value(self)
}
