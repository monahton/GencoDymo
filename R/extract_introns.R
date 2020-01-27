#' @title Extract introns coordinates from a GENCODE gtf file as a dataframe.
#'
#' @description This function takes a gtf file from GENCODE and returns a dataframe in the R Global Environment containing introns coordinates and their position in the transcript.
#' @usage extract_introns(input)
#' @param input The name of a gtf file from GENCODE
#' @export
#' @return A dataframe of intron coordinates
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' df <- load_gtf("gencode.v27.lncRNAs.gtf")
#' introns <- extract_introns(df)
#’}
extract_introns <- function(input) {
  exons1 <- subset(input, input$type=="exon")
  # classifying exons positions
  classified_exons <- suppress_output(classify_exons(exons1))
  # removing single exons
  cat(paste("\033[0;32mRemoving single exons\033[0m"), sep = "\n")
  trans_id1 <- subset(classified_exons, select = c("transcript_id", "exon_number"))
  trans_id2 <- as.data.frame(table(trans_id1$transcript_id))
  single_exons <- subset(trans_id2, Freq== '1')
  single_exons_total <- nrow(single_exons)
  cat(paste0("Single exons: ", single_exons_total), sep = "\n")
  exons2 <- suppressWarnings(dplyr::anti_join(classified_exons,single_exons, by = c("transcript_id" = "Var1")))
  colnames(trans_id2) <- c("transcript_id", "exon_count")
  # assigning introns coordinates
  cat(paste("\033[0;32mExtracting introns coordinates ... \033[0m"), sep = "\n")
  sorted_exon_count <- sort(unique(as.integer(trans_id2$exon_count)))
  max_exon_count <- max(sorted_exon_count)
  sorted_exon_num <- sort(unique(as.integer(exons2$exon_number)))
  exons_intersect <- dplyr::setdiff(union(sorted_exon_count, sorted_exon_num), intersect(sorted_exon_count, sorted_exon_num))
  ## last introns
  y <- NULL
  for(i in sorted_exon_count) {
    if (i==max_exon_count) {
      next
    }
    exons3 <- subset(exons2, exons2$EXON_CLASSIFICATION!="last_exons" & exons2$exon_number==i)
    exons3$intron_start <- ifelse(exons3$strand=="+", exons3$end + 1, exons3$start - 1)
    exons4 <- subset(exons2,exons2$exon_number==i+1)
    exons4$intron_end <- ifelse(exons4$strand=="+", exons4$start - 1, exons4$end + 1)
    introns_end1 <- subset(exons4, select = "intron_end")
    introns1 <- cbind(exons3,introns_end1)
    introns1$intron_number <- paste("intron", i, sep = "")
    y <- rbind(y,introns1)
  }
  ## inner introns
  m <- NULL
  for(i in exons_intersect) {
    exons5 <- subset(exons2, exons2$exon_number==i)
    exons5$intron_start <- ifelse(exons5$strand=="+", exons5$end + 1, exons5$start - 1)
    exons6 <- subset(exons2,exons2$exon_number==i+1)
    exons6$intron_end <- ifelse(exons6$strand=="+", exons6$start - 1, exons6$end + 1)
    introns_end2 <- subset(exons6, select = "intron_end")
    introns2 <- cbind(exons5,introns_end2)
    introns2$intron_number <- paste("intron", i, sep = "")
    m <- rbind(m,introns2)
  }
  introns3 <- rbind(y,m)
  introns3$type <- "intron"
  ## collecting introns data
  cat(paste("\033[0;32mCollecting introns data\033[0m"), sep = "\n")
  introns_plus <- subset(introns3, introns3$strand=="+")
  introns_minus <- subset(introns3, introns3$strand=="-")
  introns_end3 <- introns_minus$intron_start
  introns_minus$intron_start <- introns_minus$intron_end
  introns_minus$intron_end <- introns_end3
  introns4 <- rbind(introns_plus,introns_minus)
  introns5 <- subset(introns4, select = c("seqnames", "intron_start", "intron_end", "width"))
  introns5$width <- introns5$intron_end-introns5$intron_start+1
  introns6 <- introns4[,-which(names(introns4) %in% c("seqnames", "start", "end", "width", "exon_number", "exon_id", "EXON_CLASSIFICATION", "intron_start", "intron_end"))]
  introns7 <- cbind(introns5,introns6)
  introns_total <- introns7 %>% dplyr::group_by(gene_id) %>% dplyr::arrange(seqnames, intron_start)
  introns_total_number <- nrow(introns_total)
  cat(paste0("Total introns: ", introns_total_number), sep = "\n")
  rm(classified_exons_df, envir = .GlobalEnv)
  df <- as.data.frame(introns_total)
  return(df)
}






