///| JavaScript Response
#external
type Response

///|
pub extern "js" fn Response::array_buffer(
  self : Response
) -> Promise[ArrayBuffer] = "(self) => self.arrayBuffer()"

///|
pub extern "js" fn Response::ok(self : Response) -> Bool = "(self) => self.ok"

///|
pub extern "js" fn Response::status(self : Response) -> Int = "(self) => self.status"

///|
pub extern "js" fn Response::status_text(self : Response) -> String = "(self) => self.statusText"

///|
pub extern "js" fn Response::text(self : Response) -> Promise[String] = "(self) => self.text()"
