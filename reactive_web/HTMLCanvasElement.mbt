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

///|
extern type CanvasRenderingContext2D

///|
pub extern "js" fn HTMLCanvasElement::get_2d_context(
  self : HTMLCanvasElement
) -> CanvasRenderingContext2D = "(self) => self.getContext('2d')"

///|
pub extern "js" fn CanvasRenderingContext2D::put_image_data(
  self : CanvasRenderingContext2D,
  image_data : ImageData,
  x : Int,
  y : Int
) -> Unit = "(self, image_data, x, y) => self.putImageData(image_data, x, y)"

///|
pub extern "js" fn CanvasRenderingContext2D::save(
  self : CanvasRenderingContext2D
) -> Unit = "(self) => self.save()"

///|
pub extern "js" fn CanvasRenderingContext2D::set_fill_style(
  self : CanvasRenderingContext2D,
  style : String
) -> Unit = "(self, style) => self.fillStyle = style"

///|
pub extern "js" fn CanvasRenderingContext2D::set_stroke_style(
  self : CanvasRenderingContext2D,
  style : String
) -> Unit = "(self, style) => self.strokeStyle = style"

///|
pub extern "js" fn CanvasRenderingContext2D::set_line_width(
  self : CanvasRenderingContext2D,
  width : Int
) -> Unit = "(self, width) => self.lineWidth = width"

///|
pub extern "js" fn CanvasRenderingContext2D::fill_rect(
  self : CanvasRenderingContext2D,
  x : Int,
  y : Int,
  width : Int,
  height : Int
) -> Unit = "(self, x, y, width, height) => self.fillRect(x, y, width, height)"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke_rect(
  self : CanvasRenderingContext2D,
  x : Int,
  y : Int,
  width : Int,
  height : Int
) -> Unit = "(self, x, y, width, height) => self.strokeRect(x, y, width, height)"

///|
pub extern "js" fn CanvasRenderingContext2D::restore(
  self : CanvasRenderingContext2D
) -> Unit = "(self) => self.restore()"

///|
pub extern "js" fn CanvasRenderingContext2D::clear_rect(
  self : CanvasRenderingContext2D,
  x : Int,
  y : Int,
  width : Int,
  height : Int
) -> Unit = "(self, x, y, width, height) => self.clearRect(x, y, width, height)"

///|
pub extern "js" fn CanvasRenderingContext2D::begin_path(
  self : CanvasRenderingContext2D
) -> Unit = "(self) => self.beginPath()"

///|
pub extern "js" fn CanvasRenderingContext2D::move_to(
  self : CanvasRenderingContext2D,
  x : Int,
  y : Int
) -> Unit = "(self, x, y) => self.moveTo(x, y)"

///|
pub extern "js" fn CanvasRenderingContext2D::line_to(
  self : CanvasRenderingContext2D,
  x : Int,
  y : Int
) -> Unit = "(self, x, y) => self.lineTo(x, y)"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke(
  self : CanvasRenderingContext2D
) -> Unit = "(self) => self.stroke()"
