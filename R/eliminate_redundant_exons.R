#' @title Eliminate redundant exons
#'
#' @description This function takes a data frame containing exon coordinates and return a data frame containing unique exons and only one assignment from redundant ones.
#' @usage eliminate_redundant_exons(input)
#' @param input The name of the data frame containing all intron coordinates
#' @export
#' @importFrom  tidyr unite
#' @importFrom  data.table rleidv
#' @keywords redundant duplicated
#' @seealso \code{\link{eliminate_redundant_introns}}
#' @return A data frame with unique exons
#' @examples
#' eliminate_redundant_exons(classified_exons_df)

eliminate_redundant_exons <- function(input) {
  # assigning a unique id
  uniqueid <- tidyr::unite(input, id, c(seqnames, start, end), remove=FALSE, sep = "-")
  # eliminating redundant exons
  nonredundant <- uniqueid[!duplicated(data.table::rleidv(uniqueid, cols = c("id", "gene_id"))), ]
  nonredundant$id <- NULL
  df <- as.data.frame(nonredundant)
  return(df)
}
