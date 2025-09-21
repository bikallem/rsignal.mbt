///|
struct Styles {
  current_styles : String
  sb : StringBuilder
  styles : Map[String, String]
}

///|
pub impl Show for Styles with output(self : Styles, logger : &Logger) {
  logger.write_string(self.current_styles)
}

///|
pub impl Eq for Styles with equal(self : Styles, other : Styles) -> Bool {
  self.current_styles == other.current_styles
}

///|
fn styles_string(styles : Map[String, String], sb : StringBuilder) -> String {
  sb.reset()
  for k, v in styles {
    sb.write_string("\{k}:\{v};")
  }
  sb.to_string()
}

///|
pub fn Styles::new(styles : Map[String, String]) -> Styles {
  let sb = StringBuilder::new()
  let current_styles = styles_string(styles, sb)
  Styles::{ styles, current_styles, sb }
}

///|
/// Add or update a style key-value pair. If the key already exists, its value is updated.
pub fn Styles::add(self : Styles, key : String, value : String) -> Styles {
  self.styles.set(key, value)
  let current_styles = styles_string(self.styles, self.sb)
  { ..self, current_styles, }
}

///|
/// Remove a style key-value pair. If the key does not exist, no action is taken.
pub fn Styles::remove(self : Styles, key : String) -> Styles {
  self.styles.remove(key)
  let current_styles = styles_string(self.styles, self.sb)
  { ..self, current_styles, }
}

///|
pub impl TAttrValue for Styles with set_attr(self : Styles, attr : Attr) -> Unit {
  attr.set_value(self.current_styles)
}
