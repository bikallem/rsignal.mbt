///|
/// JavaScript Object
#external
type JsObject

///|
pub extern "js" fn JsObject::new() -> JsObject = "() => {}"

///|
extern "js" fn get_ffi(jv : JsObject, key : String) -> JsValue = "(self, key) => self[key]"

///|
pub fn[T] JsObject::get(self : JsObject, key : String) -> T {
  let jv = get_ffi(self, key)
  JsValue::of_jv(jv)
}

///|
pub extern "js" fn JsObject::set(
  self : JsObject,
  key : String,
  value : JsValue,
) -> Unit = "(self, key, value) => self[key] = value"

///|
pub fn JsObject::to_jv(self : JsObject) -> JsValue = "%identity"
