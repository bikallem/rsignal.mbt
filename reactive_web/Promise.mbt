///| JavaScript Promise
#external
type Promise[T]

///|
extern "js" fn then_ffi(p : JsValue, f : JsValue) -> JsValue =
  #| (p, f) => p.then(f)

///| 
async fn[T, E : Error] suspend(
  f : ((T) -> Unit, (E) -> Unit) -> Unit
) -> T raise E = "%async.suspend"

///|
pub fn async_run(f : async () -> Unit) -> Unit = "%async.run"

///|
extern "js" fn promise_then_ffi(
  promise : JsValue,
  on_ok : (JsValue) -> Unit,
  on_err : (Error) -> Unit
) -> Unit = "(self, on_ok, on_err) => self.then((t) => on_ok(t), (e) => on_err(e))"

///|
pub async fn[T] Promise::wait(self : Promise[T]) -> T raise {
  let promise : JsValue = JsValue::to_jv(self)
  let v = suspend(fn(resolve, reject) {
    promise_then_ffi(promise, resolve, fn(e) { reject(e) })
  })
  JsValue::of_jv(v)
}

///|
pub fn[A, B] Promise::then(p : Promise[A], f : (A) -> Promise[B]) -> Promise[B] {
  let js_p = JsValue::to_jv(p)
  let js_f = JsValue::to_jv(f)
  let js_result = then_ffi(js_p, js_f)
  JsValue::of_jv(js_result)
}

///|
pub fn[A, B] Promise::map(p : Promise[A], f : (A) -> B) -> Promise[B] {
  let js_p = JsValue::to_jv(p)
  let js_f = JsValue::to_jv(f)
  let js_result = then_ffi(js_p, js_f)
  JsValue::of_jv(js_result)
}

///|
extern "js" fn resolve_ffi(value : JsValue) -> JsValue = "(value) => Promise.resolve(value)"

///|
pub fn[A] Promise::resolve(value : A) -> Promise[A] {
  let js_value = JsValue::to_jv(value)
  let js_promise = resolve_ffi(js_value)
  JsValue::of_jv(js_promise)
}

///|
extern "js" fn new_promise_ffi(f : JsValue) -> JsValue = "(f) => new Promise(f)"

///|
pub fn[T] Promise::new(
  f : ((T) -> Unit, (Error) -> Unit) -> Unit
) -> Promise[T] {
  let js_f = JsValue::to_jv(f)
  JsValue::of_jv(new_promise_ffi(js_f))
}
