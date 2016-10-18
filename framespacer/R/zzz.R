# Load proto files on load of library function
# //TODO look into .onUnload()

.onLoad <- function(libname, pkgname){
  library(RProtoBuf)
  readProtoFiles(dir='R/proto', package=pkgname, lib.loc=libname)
}
