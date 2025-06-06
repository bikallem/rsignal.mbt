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
pub extern "js" fn CanvasRenderingContext2D::draw_image(
  self : CanvasRenderingContext2D,
  image : JsValue,
  sx : Int,
  sy : Int,
  swidth : Int,
  sheight : Int,
  dx : Int,
  dy : Int,
  dwidth : Int,
  dheight : Int
) -> Unit =
  #| (self, image, sx, sy, swidth, sheight, dx, dy, dwidth, dheight) => self.drawImage(image, sx, sy, swidth, sheight, dx, dy, dwidth, dheight)

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

///|
pub extern "js" fn CanvasRenderingContext2D::image_smoothing_enabled(
  self : CanvasRenderingContext2D
) -> Bool = "(self) => self.imageSmoothingEnabled"

///|
pub extern "js" fn CanvasRenderingContext2D::set_image_smoothing_enabled(
  self : CanvasRenderingContext2D,
  enabled : Bool
) -> Unit = "(self, enabled) => self.imageSmoothingEnabled = enabled"

///|
pub extern "js" fn CanvasRenderingContext2D::image_smoothing_quality(
  self : CanvasRenderingContext2D
) -> String = "(self) => self.imageSmoothingQuality"

///|
pub extern "js" fn CanvasRenderingContext2D::set_image_smoothing_quality(
  self : CanvasRenderingContext2D,
  quality : String
) -> Unit = "(self, quality) => self.imageSmoothingQuality = quality"
