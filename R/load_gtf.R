#' @title Load a gtf file from GENCODE as a dataframe.
#'
#' @description This function combines import with loading the gtf file as a dataframe in the R Global Environment
#' @usage load_gtf(input)
#' @param input The name of the downloaded gtf file from GENCODE website
#' @export
#' @importFrom rtracklayer import
#' @keywords import gencode gtf
#' @seealso \code{\link[rtracklayer]{import}}
#' @return A dataframe of the gtf file selected
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' load_gtf("gencode.v27.lncRNAs.gtf")
#’}
load_gtf <- function(input) {
  # importing gtf
  gtf <- rtracklayer::import(input)
  # saving as dataframe
  df <- as.data.frame(gtf)
  # assigning new dataframe
  assign(deparse(substitute(gtf_df)), df, envir = .GlobalEnv)
}
