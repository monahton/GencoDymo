#' @title Create a summary statistics table for exons width data
#'
#' @description This function takes a data frame of GENCODE annotations as input. It calculates the summary statistics of exons length taking into consideration their ordinal position. It returns a data frame containing the summarized exons length data data.
#' @usage stat_exon(input)
#' @param input The name of the data frame containing exon annotations from GENCODE and the ordinal position of each exon
#' @export
#' @import dplyr
#' @importFrom plotrix std.error
#' @keywords statistics parameters
#' @seealso \code{\link{stat_intron}}
#' @return A data frame of exons width summary statistics
#' @examples
#' df <- load_gtf("gencode.v27.lncRNAs.gtf")
#' stat_exon(df)

stat_exon <- function(input) {
  
  ## classify exons
  suppress_output(classify_exons(input))
  exons <- subset(classified_exons_df, classified_exons_df$type=="exon")
  exons_len <- subset(exons, select = c("width", "EXON_CLASSIFICATION"))
  grouped_exons <- dplyr::group_by(exons_len, EXON_CLASSIFICATION)
  
  # calculating mean, median, sd, and standard error
  summarised_df <- dplyr::summarise_all(grouped_exons, 
                                        suppressWarnings(dplyr::funs(mean=mean, 
                                                                     median=median, 
                                                                     sd=sd, 
                                                                     std_error=plotrix::std.error)))
  
  # assigning number of elements
  N <- as.data.frame(table(grouped_exons$EXON_CLASSIFICATION))
  colnames(N) <- c("EXON_CLASSIFICATION", "N")
  final <- suppressWarnings(left_join(N,summarised_df, by = "EXON_CLASSIFICATION"))
  df <- as.data.frame(final)
  return(df)
}
