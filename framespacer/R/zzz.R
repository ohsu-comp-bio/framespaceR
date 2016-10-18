# Load proto files on load of library function
# //TODO look into .onUnload()

.onLoad <- function(libname, pkgname){
  library(RProtoBuf)
  readProtoFiles(package=pkgname, lib.loc=libname)
  #protodir <- system.file("proto", package="framespacer")
  #print(protodir)
  #print(pkgname)
  #print(libname)
  #readProtoFiles(package=pkgname, lib.loc=libname)
}
