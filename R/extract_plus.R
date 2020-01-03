#' @title Extract elements on the plus strand from a gtf file.
#'
#' @description This function takes a gtf file from GENCODE or the dataframe of extracted introns. It returns as a dataframe a specified element; i.e gene, transcript, exon or intron; that are on the forward strand
#' @usage extract_plus(input, type)
#' @param input The name of the downloaded gtf file from GENCODE website or a dataframe of introns
#' @param type A string that specifies the type of element to be reported
#' @export
#' @keywords positive strand
#' @seealso \code{\link{extract_minus}}
#' @return A dataframe of elements on the plus strand
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' load_gtf("gencode.v27.lncRNAs.gtf")
#' extract_plus(gtf_df, type = "gene")
#' extract_plus(gtf_df, type = "transcript")
#' extract_plus(gtf_df, type = "exon")
#' extract_plus(introns_df, "intron")
#’}
extract_plus <- function(input, type) {
  if (type=="gene") {
    genes <- subset(input, input$type=="gene")
    genes_plus <- subset(genes, genes$strand=="+")
    genes_num <- nrow(genes_plus)
    cat(paste0("\033[0;32mGenes: \033[0m", genes_num), sep = "\n")
    assign(deparse(substitute(genes_plus_strand)), genes_plus, envir = .GlobalEnv)
  } else if (type=="transcript") {
    trans <- subset(input, input$type=="transcript")
    trans_plus <- subset(trans, trans$strand=="+")
    trans_num <- nrow(trans_plus)
    cat(paste0("\033[0;32mTranscripts: \033[0m", trans_num), sep = "\n")
    assign(deparse(substitute(transcripts_plus_strand)), trans_plus, envir = .GlobalEnv)
  } else if (type=="exon") {
    exons <- subset(input, input$type=="exon")
    exons_plus <- subset(exons, exons$strand=="+")
    exons_num <- nrow(exons_plus)
    cat(paste0("\033[0;32mExons: \033[0m", exons_num), sep = "\n")
    assign(deparse(substitute(exons_plus_strand)), exons_plus, envir = .GlobalEnv)
  } else if (type=="intron") {
    introns <- subset(input, input$type=="intron")
    introns_plus <- subset(introns, introns$strand=="+")
    introns_num <- nrow(introns_plus)
    cat(paste0("\033[0;32mIntrons: \033[0m", introns_num), sep = "\n")
    assign(deparse(substitute(introns_plus_strand)), introns_plus, envir = .GlobalEnv)
  } else {
    print("Error: operation could not be performed - check the help page for examples")
  }
}
