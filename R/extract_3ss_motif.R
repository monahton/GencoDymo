#' @title Extract the acceptor splice site motif for MaxEntScan web tool
#'
#' @description This function takes a dataframe of intron coordinates and the full genome sequence of a particular species and return a "bed-file" structured dataframe containing the motif coordinates, their corresponding transcripts id and intron number and the motif sequence which are also saved as a fasta file in the working directory. The fasta file can be uploaded to MaxEntScan::3ss web tool for the retrieval of the scores of acceptor splice sites.
#' @usage extract_3ss_motif(input,genome)
#' @param input The name of the dataframe containing intron coordinates
#' @param genome The full genome sequence of a particular species. The default value is the human genome sequence of the hg38 assembly
#' @export
#' @importFrom tidyr unite
#' @importFrom seqRFLP dataframe2fas
#' @importFrom BSgenome getSeq
#' @keywords acceptor ss maxentscan
#' @seealso \code{\link{extract_5ss_motif}}
#' @return A dataframe with motif coordinates and their sequences
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' extract_3ss_motif(introns_df, genome=BSgenome.Hsapiens.UCSC.hg38)
#’}
extract_3ss_motif <- function(input, genome = BSgenome.Hsapiens.UCSC.hg38) {
  # preparing 3ss motifs coordinate according to MaxEntScan
  intron_plus <- suppress_output(extract_plus(input, "intron"))
  intron_plus$motif_start <- intron_plus$intron_end - 19
  intron_plus$motif_end <- intron_plus$intron_end + 3
  intron_minus <- suppress_output(extract_minus(input, "intron"))
  intron_minus$motif_start <- intron_minus$intron_start - 3
  intron_minus$motif_end <- intron_minus$intron_start + 19
  df_plus <- subset(intron_plus, select = c("seqnames", "motif_start", "motif_end", "strand", "transcript_id", "intron_number"))
  df_minus <- subset(intron_minus, select = c("seqnames", "motif_start", "motif_end", "strand", "transcript_id", "intron_number"))
  df <- rbind(df_plus,df_minus)
  # extracting sequences
  cat(paste("\033[0;32mPreparing acceptor splice sites motif sequences ... \033[0m"), sep = "\n")
  motifs <- as.data.frame(BSgenome::getSeq(genome, df$seqnames, start=df$motif_start, end=df$motif_end, strand=df$strand))
  colnames(motifs)[1] <- "acceptor_ss_motif"
  df2 <- cbind(df,motifs)
  # assigning sequences id
  motifs$name <- "seq"
  motifs$obs <- 1:nrow(motifs)
  id1 <- tidyr::unite(motifs, id, c(name, obs), remove=FALSE, sep = "")
  id2 <- subset(id1, select = c("id","acceptor_ss_motif"))
  # compiling fasta file
  cat(paste("Compiling sequences in fasta file ... please be patient as this might take several minutes ..."), sep = "\n")
  fasta <- seqRFLP::dataframe2fas(id2, file = "3ss_motif_fasta.fa")
  cat(paste("Done"), sep = "\n")
  # assigning new dataframe
  pos <- 1
  envir = as.environment(pos)
  assign(deparse(substitute(acceptor_motif_df)), df2, envir = envir)
}
