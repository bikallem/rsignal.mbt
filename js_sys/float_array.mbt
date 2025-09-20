///|
#external
pub type Float64Array

///|
pub impl TTypedArray for Float64Array with buffer(self : Float64Array) -> ArrayBuffer {
  buffer_ffi(JsValue::to_jv(self))
}

///|
pub extern "js" fn Float64Array::op_get(
  self : Float64Array,
  index : Int,
) -> Double = "(self, index) => self[index]"

///|
pub extern "js" fn Float64Array::new(
  buffer : ArrayBuffer,
  byte_offset : Int,
  length : Int,
) -> Float64Array = "(buffer, byte_offset, length) => new Float64Array(buffer, byte_offset, length)"

///|
pub fn Float64Array::to_jv(self : Float64Array) -> JsValue = "%identity"
