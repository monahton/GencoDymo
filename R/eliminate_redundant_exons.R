#' @title Eliminate redundant exons
#'
#' @description This function takes a dataframe containing exon coordinates and return a dataframe containing unique exons and only one assignment from redundant ones.
#' @usage eliminate_redundant_exons(input)
#' @param input The name of the dataframe containing all intron coordinates
#' @export
#' @importFrom  tidyr unite
#' @importFrom  data.table rleidv
#' @keywords redundant duplicated
#' @seealso \code{\link{eliminate_redundant_introns}}
#' @return A dataframe with unique exons
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' eliminate_redundant_exons(classified_exons_df)
#’}
eliminate_redundant_exons <- function(input) {
  # assigning a unique id
  uniqueid <- tidyr::unite(input, id, c(seqnames, start, end), remove=FALSE, sep = "-")
  # eliminating redundant exons
  nonredundant <- uniqueid[!duplicated(data.table::rleidv(uniqueid, cols = c("id", "gene_id"))), ]
  nonredundant$id <- NULL
  df <- as.data.frame(nonredundant)
  return(df)
}
