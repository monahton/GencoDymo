#' @title Eliminate redundant introns
#'
#' @description This function takes a dataframe of intron coordinates and return a dataframe containing non-redundant introns and only one assignment from redundant ones.
#' @usage eliminate_redundant_introns(input)
#' @param input The name of the dataframe containing all intron coordinates
#' @export
#' @importFrom  tidyr unite
#' @importFrom  data.table rleidv
#' @keywords redundant duplicated
#' @seealso \code{\link{eliminate_redundant_exons}}
#' @return A dataframe with unique introns
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' eliminate_redundant_introns(introns_df)
#’}
eliminate_redundant_introns <- function(input) {
  # assigning a unique id
  uniqueid <- tidyr::unite(input, id, c(seqnames, intron_start, intron_end), remove=FALSE, sep = "-")
  # eliminating redundant introns
  nonredundant <- uniqueid[!duplicated(data.table::rleidv(uniqueid, cols = c("id", "gene_id"))), ]
  nonredundant$id <- NULL
  df <- as.data.frame(nonredundant)
  return(df)
}
