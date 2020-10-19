#' @title Load a gtf file from GENCODE as a data frame.
#'
#' @description This function combines import with loading the gtf file as a data frame in the R Global Environment
#' @usage load_gtf(input)
#' @param input The name of the downloaded gtf file from GENCODE website
#' @export
#' @importFrom rtracklayer import
#' @keywords import gencode gtf
#' @seealso \code{\link[rtracklayer]{import}}
#' @return A data frame of the gtf file selected
#' @examples
#' load_gtf("gencode.v27.lncRNAs.gtf")

load_gtf <- function(input) {
  # importing gtf
  gtf <- rtracklayer::import(input)
  # saving as data frame
  df <- as.data.frame(gtf)
  return(df)
}
