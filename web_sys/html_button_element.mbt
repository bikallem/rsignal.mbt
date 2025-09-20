///|
#external
type HTMLButtonElement

///|
pub impl TJsValue for HTMLButtonElement with to_jv(_) -> JsValue = "%identity"

///|
pub impl TNode for HTMLButtonElement

///|
pub impl TElement for HTMLButtonElement

///|
pub impl TEventTarget for HTMLButtonElement

///|
pub extern "js" fn HTMLButtonElement::disabled(
  self : HTMLButtonElement,
) -> Bool = "(self) => self.disabled"

///|
pub extern "js" fn HTMLButtonElement::set_disabled(
  self : HTMLButtonElement,
  disabled : Bool,
) -> Unit = "(self, disabled) => self.disabled = disabled"

///|
pub extern "js" fn HTMLButtonElement::name(self : HTMLButtonElement) -> String = "(self) => self.name"

///|
pub extern "js" fn HTMLButtonElement::set_name(
  self : HTMLButtonElement,
  name : String,
) -> Unit = "(self, name) => self.name = name"

///|
pub extern "js" fn HTMLButtonElement::value(self : HTMLButtonElement) -> String = "(self) => self.value"

///|
pub extern "js" fn HTMLButtonElement::set_value(
  self : HTMLButtonElement,
  value : String,
) -> Unit = "(self, value) => self.value = value"
