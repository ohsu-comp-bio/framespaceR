# Load proto files on load of library function
# //TODO look into .onUnload()

.onLoad <- function(libname, pkgname){
  library(RProtoBuf)
  readProtoFiles("R/proto/framespace.proto")
}