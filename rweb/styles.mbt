///|
struct Styles(@immut/hashmap.HashMap[String, String])

///|
pub impl Show for Styles with output(self : Styles, logger : &Logger) {
  for k, v in self.0 {
    logger.write_string("\{k}:\{v};")
  }
}

///|
pub impl Eq for Styles with equal(self : Styles, other : Styles) -> Bool {
  self.0 == other.0
}

///|
pub fn Styles::new() -> Styles {
  Styles(@immut/hashmap.HashMap::new())
}

///|
/// Add or update a style key-value pair. If the key already exists, its value is updated.
pub fn Styles::add(self : Styles, key : String, value : String) -> Styles {
  self.0.add(key, value)
}

///|
/// Remove a style key-value pair. If the key does not exist, no action is taken.
pub fn Styles::remove(self : Styles, key : String) -> Styles {
  self.0.remove(key)
}

///|
pub impl TAttrValue for Styles with set_attr(self : Styles, attr : Attr) -> Unit {
  attr.set_value(self.0)
}
