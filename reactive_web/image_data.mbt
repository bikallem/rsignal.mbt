///|
#external
type ImageData

///|
pub extern "js" fn ImageData::new(
  data : Uint8ClampedArray,
  width : Int,
  height : Int,
) -> ImageData = "(data, width, height) => new ImageData(data, width, height)"

///|
pub extern "js" fn ImageData::data(self : ImageData) -> Uint8ClampedArray = "(self) => self.data"

///|
pub extern "js" fn ImageData::width(self : ImageData) -> Int = "(self) => self.width"

///|
pub extern "js" fn ImageData::height(self : ImageData) -> Int = "(self) => self.height"
