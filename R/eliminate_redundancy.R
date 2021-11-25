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
#' @return A data frame with unique introns
#' @examples
#' eliminate_redundant_introns(introns_df)

eliminate_redundant_introns <- function(input) {
  # assigning a unique id
  uniqueid <- tidyr::unite(input, id, c(seqnames, intron_start, intron_end), remove=FALSE, sep = "-")
  # eliminating redundant introns
  nonredundant <- uniqueid[!duplicated(data.table::rleidv(uniqueid, cols = c("id", "gene_id"))), ]
  nonredundant$id <- NULL
  df <- as.data.frame(nonredundant)
  return(df)
}

