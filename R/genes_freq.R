#' @title Extract numbers of genes containing single or multiple transcripts
#'
#' @description This function takes a data frame of annotations provided by GENCODE as input. It calculates the number of different transcripts of a gene. The output is a data frame containing the number of genes having 1,2,3... or several isoforms and their percentage.
#' @usage genes_freq(input)
#' @param input The name of the downloaded  gtf file from GENCODE website
#' @export
#' @seealso \code{\link{trans_freq}}
#' @return A data frame of number of genes and their percentage
#' @examples
#' df <- load_gtf("gencode.v27.lncRNAs.gtf")
#' genes_freq(df)

genes_freq<- function(input) {
  # extracting transcripts
  transcripts <- subset(input, input$type=="transcript")
  # calculating exon and transcript frequency
  gene_ids1 <- subset(transcripts, select = c("gene_id", "transcript_id"))
  gene_ids2 <- as.data.frame(table(gene_ids1$gene_id))
  gene_ids3 <- as.data.frame(table(gene_ids2$Freq))
  # calculating percentage
  colnames(gene_ids3) <- c("num_of_transcripts", "genes_freq")
  gene_ids3$percentage <- round(gene_ids3$genes_freq / sum(gene_ids3$genes_freq) * 100, digits = 3)
  # assigning new data frame
  df <- as.data.frame(gene_ids3)
  return(df)
}
