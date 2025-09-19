///|
#external
type ImageBitmap

///|
pub extern "js" fn Window::create_image_bitmap(
  self : Window,
  image : ImageData,
) -> Promise[ImageBitmap] = "(self, image) => createImageBitmap(image)"
