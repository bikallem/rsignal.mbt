///|
#external
type FileList

///|
extern "js" fn file_list_item_ffi(file_list : FileList, index : Int) -> JsValue = "(self, index) => self.item(index)"

///|
pub fn FileList::item(self : FileList, index : Int) -> File? {
  file_list_item_ffi(self, index).to_option()
}

///|
pub extern "js" fn FileList::length(self : FileList) -> Int = "(self) => self.length"

///|
#external
type File

///|
pub impl TJsValue for File with to_jv(self : File) -> JsValue = "%identity"

///|
pub impl TBlob for File

///|
pub extern "js" fn File::name(self : File) -> String = "(self) => self.name"

///|
pub extern "js" fn File::size(self : File) -> Int = "(self) => self.size"

///|
pub extern "js" fn File::type_(self : File) -> String = "(self) => self.type"

///|
pub extern "js" fn File::last_modified(self : File) -> Int = "(self) => self.lastModified"

///|
pub extern "js" fn File::webkit_relative_path(self : File) -> String = "(self) => self.webkitRelativePath"
