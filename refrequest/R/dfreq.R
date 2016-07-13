#' Makes a json file from a data frame
#' @description This will make a json file from a data frame and then write it to your r directory so it can be used in the refreq function.
#' @param df = dataframe This is the data frame you want to make a request from. If you want to make an array put a list into the dataframe. i.e. df$names <- list("tcga-gene-expression")
#' @param file = string This is where you name your file. Remember to end in .json i.e. file = "searchobj.json"
#' @export
dfreq <- function(df, file = "reqobj.json"){
  dsa <- toJSON(df)
  #sink(file)
  dump(substring(dsa, 2, nchar(dsa)-1), file = file)
  #sink()
  print(paste("Your data frame has been written to the file ", file, "!"))
}
