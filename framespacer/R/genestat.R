#' Calculates means and variances for genes from a dataframe/slice response
#' @description Takes a responce from a dataframe/slice request and then calculates the mean and variance for specified genes. (or for all genes if the genes parameter is left NULL)
#' @param resp \strong{list} A responce from a dataframe/slice request
#' @param genes \strong{vector} An atomic vector comtaining the names of genes that you want the mean and variance for.
#' @return A list containing gene names associated with their respective means and variances.
#' @import stats
#' @export
genestat <- function(resp, genes = NULL){

  if(is.null(genes)){
    genes <- names(resp$contents)
  }

  ans <- vector("list", length(genes))
  names(ans) <- genes
  n <- length(resp$contents[[1]])

  for(j in 1:length(genes)){
    meandata <- mean(unname(unlist(resp$contents[[genes[[j]]]])))
    vardata <- var(unname(unlist(resp$contents[[genes[[j]]]])))
    meddata <- median(unname(unlist(resp$contents[[genes[[j]]]])))
    mindata <- min(unname(unlist(resp$contents[[genes[[j]]]])))
    maxdata <- max(unname(unlist(resp$contents[[genes[[j]]]])))

    ans[[genes[[j]]]]$mean <- meandata
    ans[[genes[[j]]]]$var <- vardata
    ans[[genes[[j]]]]$median <- meddata
    ans[[genes[[j]]]]$min <- mindata
    ans[[genes[[j]]]]$max <- maxdata
  }
  return(ans)
}
