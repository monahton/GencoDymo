#' @title Classify exons as single, first, inner or last.
#'
#' @description This function takes a gtf file from GENCODE and returns a dataframe in the R Global Environment containing an additional columnn which states the exons position within a transcript; whether they are a single exon, first, inner or last exons.
#' @usage classify_exons(input)
#' @param input The name of the downloaded gtf file from GENCODE website
#' @export
#' @import dplyr
#' @keywords single first inner last
#' @return A dataframe with additional column describing exon positions within a trnscript
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' df <- load_gtf("gencode.v27.lncRNAs.gtf")
#' classify_exons(df)
#’}
classify_exons <- function(input) {
  gtf <- input
  # extracting exons
  exons <- subset(gtf, gtf$type=="exon")
  # extracting single exons
  cat(paste("\033[0;32mExtracting single exons\033[0m"), sep = "\n")
  trans_id1 <- subset(exons, select = c("transcript_id", "exon_number"))
  trans_id2 <- as.data.frame(table(trans_id1$transcript_id))
  colnames(trans_id2) <- c("transcript_id", "exon_count")
  single_exons1 <- subset(trans_id2, trans_id2$exon_count == 1)
  single_exons2 <- suppressWarnings(dplyr::semi_join(exons,single_exons1, by = "transcript_id")) ## single_exons
  single_exons2$EXON_CLASSIFICATION <- "single_exons"
  single_exons_total <- nrow(single_exons2)
  cat(paste0("Single exons: ", single_exons_total), sep = "\n")
  # extracting first exons
  cat(paste("\033[0;32mExtracting first exons\033[0m"), sep = "\n")
  first_exons1 <- suppressWarnings(dplyr::anti_join(exons,single_exons1, by = "transcript_id"))
  first_exons2 <- subset(first_exons1, first_exons1$exon_number==1) ## first_exons
  first_exons2$EXON_CLASSIFICATION <- "first_exons"
  first_exons_total <- nrow(first_exons2)
  cat(paste0("First exons: ", first_exons_total), sep = "\n")
  # extracting last exons
  cat(paste("\033[0;32mExtracting last exons\033[0m"), sep = "\n")
  last_exons1 <- subset(first_exons1, first_exons1$exon_number!=1)
  trans_id3 <- subset(trans_id2, trans_id2$exon_count!= 1)
  colnames(trans_id3)[2] <- "exon_number"
  last_exons2 <- as.data.frame(as.numeric(last_exons1$exon_number))
  colnames(last_exons2) <- "exon_number"
  last_exons1$exon_number <- NULL
  last_exons3 <- cbind(last_exons1,last_exons2)
  last_exons4 <- suppressWarnings(dplyr::semi_join(last_exons3,trans_id3, by = c("transcript_id", "exon_number"))) ## last_exons
  last_exons4$EXON_CLASSIFICATION <- "last_exons"
  last_exons_total <- nrow(last_exons4)
  cat(paste0("Last exons: ", last_exons_total), sep = "\n")
  # extracting inner exons
  cat(paste("\033[0;32mExtracting inner exons\033[0m"), sep = "\n")
  inner_exons <- suppressWarnings(dplyr::anti_join(last_exons3, last_exons4, by = c("seqnames", "start", "end", "width", "strand", "source", "type", "score", "phase", "gene_id", "gene_type", "gene_name", "level", "tag", "havana_gene", "transcript_id", "transcript_type", "transcript_name", "transcript_support_level", "havana_transcript", "exon_id", "exon_number"))) ## inner_exons
  inner_exons$EXON_CLASSIFICATION <- "inner_exons"
  inner_exons_total <- nrow(inner_exons)
  cat(paste0("Inner exons: ", inner_exons_total), sep = "\n")
  # total exons
  total_exons1 <- rbind(single_exons2,first_exons2,last_exons4,inner_exons)
  total_exons2 <- nrow(total_exons1)
  cat(paste0("Total exons: ", total_exons2), sep = "\n")
  total_exons3 <- suppressWarnings(dplyr::left_join(gtf,total_exons1, by = c("seqnames", "start", "end", "width", "strand", "source", "type", "score", "phase", "gene_id", "gene_type", "gene_name","level","hgnc_id", "tag", "havana_gene", "transcript_id", "transcript_type", "transcript_name", "transcript_support_level", "havana_transcript", "exon_number", "ont","exon_id")))
  # assigning new dataframe
  df <- as.data.frame(total_exons3)
  return(df)
}
