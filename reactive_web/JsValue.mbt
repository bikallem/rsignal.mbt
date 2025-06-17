///| JavaScript value
#external
type JsValue

///|
pub fn[T] JsValue::to_jv(value : T) -> JsValue = "%identity"

///|
pub fn[T] JsValue::of_jv(value : JsValue) -> T = "%identity"

///|
pub extern "js" fn JsValue::define_property(
  self : JsValue,
  key : String,
  value : JsValue
) -> Unit =
  #| (self, key, value) => self[key] = value

///|
pub extern "js" fn JsValue::is_null(self : JsValue) -> Bool =
  #| (self) => Object.is(self, null)

///|
pub extern "js" fn JsValue::is_undefined(self : JsValue) -> Bool =
  #| (self) => Object.is(self, undefined)

///| Returns true if the value is `null` or `undefined`
pub fn JsValue::is_none(self : JsValue) -> Bool {
  self.is_null() || self.is_undefined()
}

///|
pub fn[T] JsValue::to_option(self : JsValue) -> T? {
  if self.is_none() {
    None
  } else {
    Some(JsValue::of_jv(self))
  }
}

///|
pub fn[T] JsValue::unwrap(self : JsValue) -> T {
  if self.is_none() {
    panic()
  } else {
    JsValue::of_jv(self)
  }
}
