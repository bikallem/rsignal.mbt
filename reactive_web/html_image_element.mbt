///|
#external
type HTMLImageElement

///|
pub impl TJsValue for HTMLImageElement with to_jv(self : HTMLImageElement) -> JsValue = "%identity"

///|
pub impl TEventTarget for HTMLImageElement

///|
pub impl TNode for HTMLImageElement

///|
pub impl TElement for HTMLImageElement

///|
pub impl THTMLelement for HTMLImageElement

///|
pub impl TAttachableNode for HTMLImageElement

///|
extern "js" fn HTMLImageElement::image_ffi(
  width : JsValue,
  height : JsValue,
) -> HTMLImageElement = "(width, height) => new Image(width, height)"

///|
pub fn HTMLImageElement::image(
  width~ : Int?,
  height~ : Int?,
) -> HTMLImageElement {
  let width = match width {
    None => JsValue::null()
    Some(w) => JsValue::to_jv(w)
  }
  let height = match height {
    None => JsValue::null()
    Some(h) => JsValue::to_jv(h)
  }
  HTMLImageElement::image_ffi(width, height)
}

///|
pub extern "js" fn HTMLImageElement::set_src(
  self : HTMLImageElement,
  url : String,
) -> Unit = "(image, url) => image.src = url"
