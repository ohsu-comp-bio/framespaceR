# Load proto files on load of library function
# //TODO look into .onUnload()

.onLoad <- function(libname, pkgname){
  require(RProtoBuf)
  readProtoFiles(package=pkgname, lib.loc=libname)
}
