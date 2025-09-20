///|
extern "js" fn globalThis_ffi() -> JsValue = "() => globalThis"

///|
pub let globalThis : JsValue = globalThis_ffi()

///|
pub extern "js" fn dynamic_import(url : String) -> Promise[JsValue] = "(url) => { return import(/* @vite-ignore */url).then((mod) => mod.default())}"

///|
pub extern "js" fn fetch(url : String) -> Promise[Response] = "(url) => fetch(url)"

///|
pub fnalias JsValue::to_jv

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

///|
pub fn mount_to_body(element : &TAttachableNode) -> Unit {
  document.body().append_child(element)
}

///|
pub fn button(
  label : String,
  nodes : Array[&TAttachableNode],
) -> HTMLButtonElement {
  h("button", [label] + nodes).into()
}

///|
pub fn canvas(nodes : Array[&TAttachableNode]) -> HTMLCanvasElement {
  h("canvas", nodes).into()
}

///|
pub impl TAttachableNode for HTMLButtonElement

///|
pub impl TAttachableNode for HTMLCanvasElement

///|
pub fn div(nodes : Array[&TAttachableNode]) -> HTMLDivElement {
  h("div", nodes).into()
}

///|
pub impl TAttachableNode for HTMLInputElement

///|
pub impl TAttachableNode for HTMLDivElement

///|
pub impl TAttachableNode for HTMLImageElement

///|
pub fn input(
  type_ : String,
  nodes : Array[&TAttachableNode],
) -> HTMLInputElement {
  h("input", [attr("type", type_)] + nodes).into()
}
