#' @title Calculate the length of splices transcripts
#'
#' @description This function takes a data frame of GENCODE annotations as input. It calculates the length of the transcripts considering only the length of their corresponding exons.
#' @usage spliced_trans_length(input)
#' @param input The name of the downloaded  gtf file from GENCODE website
#' @export
#' @importFrom data.table setkey setDT
#' @keywords mature transcript
#' @return A data frame of the transcript ids and their length when spliced
#' @examples
#' load_gtf("gencode.v27.lncRNAs.gtf")
#' spliced_trans_length(gtf_df)

spliced_trans_length <- function(input) {
  exons <- subset(input, input$type=="exon")
  transcripts_id <- subset(exons, select = c("transcript_id", "width"))
  transcript_len <- data.table::setkey(data.table::setDT(transcripts_id), transcript_id)[, list(width=sum(width)), by=list(transcript_id)]
  df <- as.data.frame(transcript_len)
  return(df)
}
