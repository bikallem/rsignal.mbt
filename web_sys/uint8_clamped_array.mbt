///|
#external
pub type Uint8ClampedArray

///|
pub extern "js" fn Uint8ClampedArray::new(
  buffer : Uint8Array,
) -> Uint8ClampedArray = "(buffer) => new Uint8ClampedArray(buffer)"

///|
pub fn Uint8ClampedArray::to_jv(self : Uint8ClampedArray) -> JsValue = "%identity"
