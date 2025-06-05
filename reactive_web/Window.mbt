///|
extern type Window

///|
extern "js" fn window_ffi() -> Window = "() => window"

///|
pub let window : Window = window_ffi()

///|
pub impl TJsValue for Window with to_jv(self : Window) -> JsValue = "%identity"

///|
pub impl TEventTarget for Window with nop(_ : Window) -> Unit {

}

///|
pub extern "js" fn Window::device_pixel_ratio(self : Window) -> Double = "(self) => self.devicePixelRatio"

///|
extern "js" fn beforeunload_ffi(window : Window, f : JsValue) -> Unit = "(self) => self.onbeforeunload"

///|
pub fn Window::beforeunload(
  self : Window,
  handler : (BeforeUnloadEvent) -> Unit
) -> Unit {
  let f = JsValue::to_jv(handler)
  beforeunload_ffi(self, f)
}
