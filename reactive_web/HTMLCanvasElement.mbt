///|
extern type HTMLCanvasElement

///|
pub impl TJsValue for HTMLCanvasElement with to_jv(self : HTMLCanvasElement) -> JsValue = "%identity"

///|
pub impl TNode for HTMLCanvasElement with nop(_) -> Unit {

}

///|
pub impl TElement for HTMLCanvasElement with nop(_) -> Unit {

}

///|
pub impl TEventTarget for HTMLCanvasElement with nop(_) -> Unit {

}

///|
pub impl TAttachableNode for HTMLCanvasElement with nop(_) -> Unit {

}

///|
pub impl THTMLelement for HTMLCanvasElement with nop(_) -> Unit {

}

///|
pub extern "js" fn HTMLCanvasElement::width(self : HTMLCanvasElement) -> Int = "(self) => self.width"

///|
pub extern "js" fn HTMLCanvasElement::height(self : HTMLCanvasElement) -> Int = "(self) => self.height"

///|
pub extern "js" fn HTMLCanvasElement::set_width(
  self : HTMLCanvasElement,
  width : Int
) -> Unit = "(self, width) => self.width = width"

///|
pub extern "js" fn HTMLCanvasElement::set_height(
  self : HTMLCanvasElement,
  height : Int
) -> Unit = "(self, height) => self.height = height"

///|
pub fn canvas(nodes : Array[&TAttachableNode]) -> HTMLCanvasElement {
  h("canvas", nodes).into()
}
