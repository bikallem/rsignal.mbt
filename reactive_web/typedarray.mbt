///| JavaScript ArrayBuffer
#external
type ArrayBuffer

///|
pub(open) trait TTypedArray {
  buffer(self : Self) -> ArrayBuffer
}

///|
pub fn ArrayBuffer::to_jv(self : ArrayBuffer) -> JsValue = "%identity"

///| https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/TypedArray/set
#external
pub type Uint8Array

///|
extern "js" fn buffer_ffi(jv : JsValue) -> ArrayBuffer = "(self) => self.buffer"

///|
pub impl TTypedArray for Uint8Array with buffer(self : Uint8Array) -> ArrayBuffer {
  buffer_ffi(JsValue::to_jv(self))
}

///|
pub extern "js" fn Uint8Array::op_get(self : Uint8Array, index : Int) -> Int = "(self, index) => self[index]"

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
  index : Int
) -> Double = "(self, index) => self[index]"

///|
pub extern "js" fn Float64Array::new(
  buffer : ArrayBuffer,
  byte_offset : Int,
  length : Int
) -> Float64Array = "(buffer, byte_offset, length) => new Float64Array(buffer, byte_offset, length)"

///|
pub fn Float64Array::to_jv(self : Float64Array) -> JsValue = "%identity"

///|
pub extern "js" fn Uint8Array::new(buffer : ArrayBuffer) -> Uint8Array = "(buffer) => new Uint8Array(buffer)"

///|
pub extern "js" fn Uint8Array::byte_length(self : Uint8Array) -> Int = "(self) => self.byteLength"

///|
pub extern "js" fn Uint8Array::set(
  self : Uint8Array,
  buffer : Uint8Array,
  offset : Int
) -> Unit = "(self, buffer, offset) => self.set(buffer, offset)"

///|
pub extern "js" fn Uint8Array::subarray(
  self : Uint8Array,
  start_offset : Int,
  end_offset : Int
) -> Uint8Array = "(self, start_offset, end_offset) => self.subarray(start_offset, end_offset)"

///|
pub fn Uint8Array::to_jv(self : Uint8Array) -> JsValue = "%identity"

///|
#external
pub type Uint8ClampedArray

///|
pub extern "js" fn Uint8ClampedArray::new(
  buffer : Uint8Array
) -> Uint8ClampedArray = "(buffer) => new Uint8ClampedArray(buffer)"

///|
pub fn Uint8ClampedArray::to_jv(self : Uint8ClampedArray) -> JsValue = "%identity"
