///|
/// Javascript DOM Element
#external
type Element

///|
pub impl TJsValue for Element with to_jv(self) -> JsValue = "%identity"

///|
pub impl TElement for Element

///|
pub impl TNode for Element

///|
pub impl TEventTarget for Element

///|
pub fn[T : TElement] Element::into(self : Element) -> T = "%identity"
