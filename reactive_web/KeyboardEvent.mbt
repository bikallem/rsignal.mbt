///| KeyboardEvent - https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
#external
type KeyboardEvent

///|
pub impl TJsValue for KeyboardEvent with to_jv(self : KeyboardEvent) -> JsValue = "%identity"

///|
pub impl TEvent for KeyboardEvent

///| key property - https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key
pub extern "js" fn KeyboardEvent::key(self : KeyboardEvent) -> String = "(self) => self.key"

///|
pub extern "js" fn KeyboardEvent::code(self : KeyboardEvent) -> String = "(self) => self.code"

///|
pub extern "js" fn KeyboardEvent::ctrl_key(self : KeyboardEvent) -> Bool = "(self) => self.ctrlKey"

///|
pub extern "js" fn KeyboardEvent::shift_key(self : KeyboardEvent) -> Bool = "(self) => self.shiftKey"

///|
pub extern "js" fn KeyboardEvent::alt_key(self : KeyboardEvent) -> Bool = "(self) => self.altKey"

///|
pub extern "js" fn KeyboardEvent::meta_key(self : KeyboardEvent) -> Bool = "(self) => self.metaKey"

///|
pub extern "js" fn KeyboardEvent::repeat(self : KeyboardEvent) -> Bool = "(self) => self.repeat"
