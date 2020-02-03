#' @title Assign introns donor and acceptor splice sites consensus
#'
#' @description This function takes a dataframe of intron coordinates and the full genome sequence of a particular species and return a dataframe with additional 2 columns for indicating the donor and acceptor splice sites for each intron.
#' @usage assign_ss(input,genome)
#' @param input The name of the dataframe containing intron coordinates
#' @param genome The full genome sequence of a particular species. The default value is the human genome sequence of the hg38 assembly
#' @export
#' @import dplyr
#' @importFrom BSgenome getSeq
#' @return A dataframe with additional 2 columns for donor and acceptor splice sites consensus
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' intr_splice_sites <- assign_ss(introns_df, genome=BSgenome.Hsapiens.UCSC.hg38)
#’}
assign_ss <- function(input, genome=BSgenome.Hsapiens.UCSC.hg38) {
  # Preparing donor splice sites data
  cat(paste("\033[0;32mPreparing donor splice sites data ... \033[0m"), sep = "\n")
  intron_plus <- suppress_output(extract_plus(input, "intron"))
  intron_plus$start_5ss <- intron_plus$intron_start
  intron_plus$end_5ss <- intron_plus$intron_start + 1
  intron_minus <- suppress_output(extract_minus(input, "intron"))
  intron_minus$start_5ss <- intron_minus$intron_end - 1
  intron_minus$end_5ss <- intron_minus$intron_end
  ip1 <- subset(intron_plus, select = c("seqnames", "start_5ss", "end_5ss", "strand", "transcript_id", "intron_number"))
  im1 <- subset(intron_minus, select = c("seqnames", "start_5ss", "end_5ss", "strand", "transcript_id", "intron_number"))
  intron_total1 <- rbind(ip1,im1)
  # Extracting donor splice sites sequences
  cat(paste("\033[0;32mExtracting donor splice sites sequences ... please be patient as this might take several minutes ... \033[0m"), sep = "\n")
  donor_ss1 <- as.data.frame(BSgenome::getSeq(genome, intron_total1$seqnames, start=intron_total1$start_5ss, end=intron_total1$end_5ss, strand=intron_total1$strand))
  donor_ss2 <- cbind(intron_total1,donor_ss1)
  colnames(donor_ss2)[7] <- "donor_ss"
  # Preparing donor splice sites data
  cat(paste("\033[0;32mPreparing acceptor splice sites data ... \033[0m"), sep = "\n")
  intron_plus$start_3ss <- intron_plus$intron_end - 1
  intron_plus$end_3ss <- intron_plus$intron_end
  intron_minus$start_3ss <- intron_minus$intron_start
  intron_minus$end_3ss <- intron_minus$intron_start + 1
  ip2 <- subset(intron_plus, select = c("seqnames", "start_3ss", "end_3ss", "strand", "transcript_id", "intron_number"))
  im2 <- subset(intron_minus, select = c("seqnames", "start_3ss", "end_3ss", "strand", "transcript_id", "intron_number"))
  intron_total2 <- rbind(ip2,im2)
  # Extracting donor splice sites sequences
  cat(paste("\033[0;32mExtracting acceptor splice sites sequences ... please be patient as this might take several minutes ... \033[0m"), sep = "\n")
  acceptor_ss1 <- as.data.frame(BSgenome::getSeq(genome, intron_total2$seqnames, start=intron_total2$start_3ss, end=intron_total2$end_3ss, strand=intron_total2$strand))
  acceptor_ss2 <- cbind(intron_total2,acceptor_ss1)
  colnames(acceptor_ss2)[7] <- "acceptor_ss"
  # Preparing introns splice sites dataframe
  cat(paste("\033[0;32mPreparing introns splice sites dataframe\033[0m"), sep = "\n")
  acceptor_ss3 <- subset(acceptor_ss2, select=c("transcript_id", "intron_number","acceptor_ss"))
  intron_merge1 <- dplyr::left_join(donor_ss2,acceptor_ss3, by = c("transcript_id", "intron_number"))
  intron_merge2 <- subset(intron_merge1, select=c("transcript_id", "intron_number","donor_ss", "acceptor_ss"))
  intron_ss_final <- dplyr::left_join(input,intron_merge2, by = c("transcript_id", "intron_number"))
  df <- as.data.frame(intron_ss_final)
  return(df)
}
