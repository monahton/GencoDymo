#' @title Create a summary statistics table for introns width data
#'
#' @description This function takes a dataframe of introns as input. It calculates the summary statistics of introns length taking into consideration their ordinal position and splice sites. The function returns a dataframe containing the summarised data.
#' @usage stat_intron(input)
#' @param input The name of the dataframe containing introns coordinates and the splice sites of each intron
#' @export
#' @import dplyr
#' @importFrom plotrix std.error
#' @keywords statistics parameters
#' @seealso \code{\link{stat_exon}}
#' @return A dataframe of introns width summary statistics
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' stat_intron(intron_df)
#’}
stat_intron <- function(input) {
  # first introns
  first_introns <- subset(input, input$intron_number=="intron1")
  fi_len <- subset(first_introns, select="width")
  fi_len$group <- "first_intron"
  # inner introns
  inner_introns <- subset(input, input$intron_number!="intron1")
  ii_len <- subset(inner_introns, select="width")
  ii_len$group <- "inner_intron"
  # gc introns
  gc <- subset(input, input$donor_ss=="GC" & input$acceptor_ss=="AG")
  gc_len <- subset(gc, select="width")
  gc_len$group <- "gc_intron"
  # gc first introns
  gc_fi <- subset(gc, gc$intron_number=="intron1")
  gc_fi_len <- subset(gc_fi, select = "width")
  gc_fi_len$group <- "gc_first_intron"
  # gc inner introns
  gc_ii <- subset(gc, gc$intron_number!="intron1")
  gc_ii_len <- subset(gc_ii, select = "width")
  gc_ii_len$group <- "gc_inner_intron"
  # gt introns
  gt <- subset(input, input$donor_ss=="GT" & input$acceptor_ss=="AG")
  gt_len <- subset(gt, select="width")
  gt_len$group <- "gt_intron"
  # gt first introns
  gt_fi <- subset(gt, gt$intron_number=="intron1")
  gt_fi_len <- subset(gt_fi, select = "width")
  gt_fi_len$group <- "gt_first_intron"
  # gt inner introns
  gt_ii <- subset(gt, gt$intron_number!="intron1")
  gt_ii_len <- subset(gt_ii, select = "width")
  gt_ii_len$group <- "gt_inner_intron"
  # at introns
  at <- subset(input, input$donor_ss=="AT" & input$acceptor_ss=="AC")
  at_len <- subset(at, select="width")
  at_len$group <- "at_intron"
  # at first introns
  at_fi <- subset(at, at$intron_number=="intron1")
  at_fi_len <- subset(at_fi, select = "width")
  at_fi_len$group <- "at_first_intron"
  # at inner introns
  at_ii <- subset(at, at$intron_number!="intron1")
  at_ii_len <- subset(at_ii, select = "width")
  at_ii_len$group <- "at_inner_intron"
  total <- rbind(fi_len,ii_len,gc_len,gc_fi_len,gc_ii_len,gt_len,gt_fi_len,gt_ii_len,at_len,at_fi_len,at_ii_len)
  grouped <- dplyr::group_by(total, group)
  # calculating mean, median, sd, and standard error
  stat <- dplyr::summarise_all(grouped, suppressWarnings(funs(mean=mean, median=median, sd=sd, std_error=plotrix::std.error)))
  stat$group <- factor(as.character(stat$group), levels = c("first_intron", "inner_intron", "gc_intron", "gt_intron", "gc_first_intron", "gt_first_intron", "gc_inner_intron", "gt_inner_intron"))
  final1 <- stat[order(stat$group), ]
  # assigning number of elements
  N <- c(nrow(first_introns), nrow(inner_introns), nrow(gc), nrow(gt), nrow(gc_fi), nrow(gt_fi), nrow(gc_ii), nrow(gt_ii))
  final2 <- cbind(final1, N)
  final3 <- final2[,c(1,6,2,3,4,5)]
  #assigning new dataframe
  assign(deparse(substitute(intron_stat_df)), final3, envir = .GlobalEnv)
}
