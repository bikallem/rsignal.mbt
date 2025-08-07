///|
pub(open) trait THTMLelement: TElement {
  onchange(self : Self, listener : (Event) -> Unit) -> Unit = _
  style(self : Self) -> CSSStyleDeclaration = _
}

///|
impl THTMLelement with onchange(self : Self, listener : (Event) -> Unit) -> Unit {
  add_event_listener(self, "change", listener)
}

///|
extern "js" fn style_ffi(element : JsValue) -> CSSStyleDeclaration = "(element) => element.style"

///|
impl THTMLelement with style(self : Self) -> CSSStyleDeclaration {
  style_ffi(self.to_jv())
}
