///|
extern "js" fn globalThis_ffi() -> JsValue = "() => globalThis"

///|
pub let globalThis : JsValue = globalThis_ffi()

///|
pub extern "js" fn dynamic_import(url : String) -> Promise[JsValue] = "(url) => { return import(/* @vite-ignore */url).then((mod) => mod.default())}"

///|
pub extern "js" fn fetch(url : String) -> Promise[Response] = "(url) => fetch(url)"

///|
extern "js" fn log_ffi(s : JsValue) -> Unit = "(v) => console.log(v)"

///|
pub fn log_js_value(obj : &TJsValue) -> Unit {
  let js_obj = obj.to_jv()
  log_ffi(js_obj)
}

///|
pub fn log_str(s : String) -> Unit {
  log_ffi(JsValue::to_jv(s))
}
