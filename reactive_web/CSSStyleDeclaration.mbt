///|
#external
type CSSStyleDeclaration

///|
pub extern "js" fn CSSStyleDeclaration::set_property(
  self : CSSStyleDeclaration,
  property_name : String,
  value : String,
  priority~ : String = "",
) -> Unit = "(self, property_name, value, priority) => self.setProperty(property_name, value, priority)"
