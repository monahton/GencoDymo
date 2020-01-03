#' @title Extract single-exon transcripts
#'
#' @description This function takes a gtf file from GENCODE and returns a dataframe in the R Global Environment containing a column of the transcripts id of the single-exon transcripts.
#' @usage se_transcripts(input)
#' @param input The name of the downloaded gtf file from GENCODE website
#' @export
#' @keywords single-exon transcript
#' @seealso \code{\link{se_genes}}
#' @return A dataframe of the transcript ids of single-exon transcripts
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' load_gtf("gencode.v27.lncRNAs.gtf")
#' se_transcripts(gtf_df)
#’}
se_transcripts <- function(input) {
  exons <- subset(input, input$type=="exon")
  transcript_ids1 <- subset(exons, select = c("transcript_id", "exon_number"))
  transcript_ids2 <- as.data.frame(table(transcript_ids1$transcript_id))
  colnames(transcript_ids2) <- c("transcript_id", "exon_count")
  se <- subset(transcript_ids2, transcript_ids2$exon_count == 1)
  se_transcripts_id <- subset(se, select = "transcript_id")
  assign(deparse(substitute(single_exon_transcripts)), se_transcripts_id, envir = .GlobalEnv)
}
