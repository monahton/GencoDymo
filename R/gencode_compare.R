#' @title Compare number of annotations between 2 different releases from GENCODE
#'
#' @description This function compares the number of annotated genes, transcripts, exons or introns from 2 data frames. It is used to compare the different annotations between different releases from GENCODE
#' @usage gencode_compare(df1, df2, type)
#' @param df1 The name of the first data frame of a particular release from GENCODE
#' @param df2 The name of the second data frame of a particular release from GENCODE
#' @param type A string specifying the genetic element to be compared
#' @export
#' @keywords gencode releases
#' @return Delta: The difference between annotated numbers of a particular genetic element.
#' Percentage: the percentage of delta
#' @examples
#' data1 <- load_gtf("gencode.v27.lncRNAs.gtf")
#' data2 <- load_gtf("gencode.v28.lncRNAs.gtf")
#' gencode_compare(data1, data2, type = "gene")
#' gencode_compare(data1, data2, type = "transcript")
#' gencode_compare(data1, data2, type = "exon")
#' gencode_compare(data1, data2, type = "intron")

gencode_compare <- function(df1, df2, type) {
  if(type=="gene") {
    genes1 <- subset(df1, df1$type=="gene")
    genes2 <- subset(df2, df2$type=="gene")
    delta <- abs(nrow(genes2) - nrow(genes1))
    percentage <- round(delta/nrow(genes2)*100, digits = 3)
    cat(paste0("\033[0;32mDelta: \033[0m", delta), sep = "\n")
    cat(paste0("\033[0;32mPercentage: \033[0m", percentage), sep = "\n")
  } else if (type=="transcript") {
    transcripts1 <- subset(df1, df1$type=="transcript")
    transcripts2 <- subset(df2, df2$type=="transcript")
    delta <- abs(nrow(transcripts2) - nrow(transcripts1))
    percentage <- round(delta/nrow(transcripts2)*100, digits = 3)
    cat(paste0("\033[0;32mDelta: \033[0m", delta), sep = "\n")
    cat(paste0("\033[0;32mPercentage: \033[0m", percentage), sep = "\n")
  } else if (type=="exon") {
    exons1 <- subset(df1, df1$type=="exon")
    exons2 <- subset(df2, df2$type=="exon")
    delta <- abs(nrow(exons2) - nrow(exons1))
    percentage <- round(delta/nrow(exons2)*100, digits = 3)
    cat(paste0("\033[0;32mDelta: \033[0m", delta), sep = "\n")
    cat(paste0("\033[0;32mPercentage: \033[0m", percentage), sep = "\n")
  } else if (type=="intron") {
    introns1 <- subset(df1, df1$type=="intron")
    introns2 <- subset(df2, df2$type=="intron")
    delta <- abs(nrow(introns2) - nrow(introns1))
    percentage <- round(delta/nrow(introns2)*100, digits = 3)
    cat(paste0("\033[0;32mDelta: \033[0m", delta), sep = "\n")
    cat(paste0("\033[0;32mPercentage: \033[0m", percentage), sep = "\n")
  } else {
    print("No comparisons are found")
  }
}
