///|
using @web_sys {
  type Attr,
  type Element,
  type PointerEvent,
  type Event,
  type HTMLButtonElement,
  type HTMLCanvasElement,
  type HTMLDivElement,
  type HTMLInputElement,
  type HTMLImageElement,
}

///|
let document = @web_sys.document

///|
using @web_sys {trait TJsValue, trait TNode, trait TEventTarget}

///|
using @js_sys {type JsValue}

///|
using @immut/hashmap {type HashMap}
