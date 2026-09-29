///|
/// https://developer.mozilla.org/en-US/docs/Web/API/Blob
#external
type Blob

///|
pub extern "js" fn Blob::new_ffi(
  parts : FixedArray[JsValue],
  options : JsObject,
) -> Blob = "(parts, options) => new Blob(parts, options)"

pub fn Blob::new(
  parts : Array[JsValue],
  options : JsObject,
) -> Blob {
  Blob::new_ffi(FixedArray::from_array(parts), options)
}

///|
pub impl TJsValue for Blob with to_jv(self : Blob) -> JsValue = "%identity"

///|
pub impl TBlob for Blob
