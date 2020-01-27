#' @title Extract numbers of transcripts containing a single or multiple exons
#'
#' @description This function takes a gtf file of GENCODE annotations as input. It calculates the number of different exons of a transcript. Then, the output is a dataframe containing the number of transcripts having 1,2,3... or several exons and their percentage.
#' @usage trans_freq(input)
#' @param input The name of the downloaded  gtf file from GENCODE website
#' @export
#' @seealso \code{\link{genes_freq}}
#' @return A dataframe of number of transcripts and their percentage
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' df <- load_gtf("gencode.v27.lncRNAs.gtf")
#' trans_freq(df)
#’}
trans_freq<- function(input) {
  # extracting exons
  exons <- subset(input, input$type=="exon")
  # calculating exon and transcript frequency
  trans_id1 <- subset(exons, select = c("transcript_id", "exon_number"))
  trans_id2 <- as.data.frame(table(trans_id1$transcript_id))
  trans_id3 <- as.data.frame(table(trans_id2$Freq))
  colnames(trans_id3) <- c("num_of_exons", "trans_freq")
  # calculating percentage
  trans_id3$percentage <- round(trans_id3$trans_freq / sum(trans_id3$trans_freq) * 100, digits = 3)
  df <- as.data.frame(trans_id3)
  return(df)
}
