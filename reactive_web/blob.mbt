///|
/// https://developer.mozilla.org/en-US/docs/Web/API/Blob
#external
type Blob

///|
pub extern "js" fn Blob::new(
  parts : Array[JsValue],
  options : JsObject,
) -> Blob = "(parts, options) => new Blob(parts, options)"

///|
pub impl TJsValue for Blob with to_jv(self : Blob) -> JsValue = "%identity"

///|
pub impl TBlob for Blob
