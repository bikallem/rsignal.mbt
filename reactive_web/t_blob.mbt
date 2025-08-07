///|
pub(open) trait TBlob: TJsValue {
  type_(self : Self) -> String = _
  size(self : Self) -> Int = _
  slice(self : Self, start : Int, end : Int, content_type : String) -> Blob = _
  array_buffer(self : Self) -> Promise[ArrayBuffer] = _
  text(self : Self) -> Promise[String] = _
}

///|
extern "js" fn blob_type_ffi(blob : JsValue) -> String = "(blob) => blob.type"

///|
impl TBlob with type_(self) -> String {
  blob_type_ffi(self.to_jv())
}

///|
extern "js" fn blob_size_ffi(blob : JsValue) -> Int = "(blob) => blob.size"

///|
impl TBlob with size(self) -> Int {
  blob_size_ffi(self.to_jv())
}

///|
extern "js" fn blob_slice_ffi(
  blob : JsValue,
  start : Int,
  end : Int,
  content_type : String,
) -> Blob = "(blob, start, end, contentType) => blob.slice(start, end, contentType)"

///|
impl TBlob with slice(
  self : Self,
  start : Int,
  end : Int,
  content_type : String,
) -> Blob {
  blob_slice_ffi(self.to_jv(), start, end, content_type)
}

///|
extern "js" fn blob_array_buffer_ffi(blob : JsValue) -> Promise[ArrayBuffer] = "(blob) => blob.arrayBuffer()"

///|
impl TBlob with array_buffer(self : Self) -> Promise[ArrayBuffer] {
  blob_array_buffer_ffi(self.to_jv())
}

///|
extern "js" fn blob_text_ffi(blob : JsValue) -> Promise[String] = "(blob) => blob.text()"

///|
impl TBlob with text(self : Self) -> Promise[String] {
  blob_text_ffi(self.to_jv())
}
