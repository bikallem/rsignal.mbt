///| FileReader - https://developer.mozilla.org/en-US/docs/Web/API/FileReader
#external
type FileReader

///|
pub impl TJsValue for FileReader with to_jv(self : FileReader) -> JsValue = "%identity"

///|
pub impl TEventTarget for FileReader

///|
pub extern "js" fn FileReader::new() -> FileReader = "() => new FileReader()"

///|
pub extern "js" fn read_as_array_buffer_ffi(
  file_reader : FileReader,
  blob : JsValue
) -> Unit = "(fileReader, blob) => fileReader.readAsArrayBuffer(blob)"

///|
pub fn FileReader::read_as_array_buffer(
  self : FileReader,
  blob : &TBlob
) -> Unit {
  read_as_array_buffer_ffi(self, blob.to_jv())
}

///|
extern "js" fn read_as_text_ffi(
  file_reader : FileReader,
  blob : JsValue,
  encoding : String
) -> Unit = "(fileReader, blob, encoding) => fileReader.readAsText(blob, encoding)"

///|
pub fn FileReader::read_as_text(
  self : FileReader,
  blob : &TBlob,
  encoding~ : String = "utf-8"
) -> Unit {
  read_as_text_ffi(self, blob.to_jv(), encoding)
}

///|
extern "js" fn read_as_data_url_ffi(
  file_reader : FileReader,
  blob : JsValue
) -> Unit = "(fileReader, blob) => fileReader.readAsDataURL(blob)"

///|
pub fn FileReader::read_as_data_url(self : FileReader, blob : &TBlob) -> Unit {
  read_as_data_url_ffi(self, blob.to_jv())
}

///|
pub fn FileReader::onload(
  self : FileReader,
  handler : (ProgressEvent) -> Unit
) -> Unit {
  add_event_listener(self, "load", handler)
}

///|
pub fn FileReader::onerror(
  self : FileReader,
  handler : (ProgressEvent) -> Unit
) -> Unit {
  add_event_listener(self, "error", handler)
}

///|
#external
type FileReaderResult

///|
pub fn FileReaderResult::to_array_buffer(
  self : FileReaderResult
) -> ArrayBuffer = "%identity"

///|
pub extern "js" fn FileReader::result(self : FileReader) -> FileReaderResult = "(self) => self.result"
