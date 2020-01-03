#' @title Extract protein-coding genes from GENCODE basic annotation file
#'
#' @description This function takes a dataframe of basic annotations provided by GENCODE as input. The function extracts from the dataframe all the protein-coding genes and gives as an output a dataframe in the R Global Environment. The output dataframe includes the gene, transcript and exon annotations only.
#' @usage extract_pc(input)
#' @param input The name of the downloaded basic annoation gtf file from GENCODE website
#' @export
#' @keywords protein-coding
#' @return A dataframe of protein-coding genes
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' load_gtf("gencode.v27.basic.annotation.gtf")
#’}
extract_pc <- function(input) {
  # extracting pc annotations
  pc <- subset(input, input$gene_type=="protein_coding")
  # extracting genes, transcripts and exons
  pc_gte <- subset(pc, pc$type=="gene" | pc$type=="transcript" | pc$type=="exon")
  # assigning a new dataframe
  assign(deparse(substitute(pc_df)), pc_gte, envir = .GlobalEnv)

}
