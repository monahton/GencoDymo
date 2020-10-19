#' @title Extract protein-coding genes from GENCODE basic annotation file
#'
#' @description This function takes a data frame of basic annotations provided by GENCODE as input. The function extracts from the data frame all the protein-coding genes and gives as an output a data frame in the R Global Environment. The output data frame includes the gene, transcript and exon annotations only.
#' @usage extract_pc(input)
#' @param input The name of the downloaded basic annotation gtf file from GENCODE website
#' @export
#' @keywords protein-coding
#' @return A data frame of protein-coding genes
#' @examples
#' df <- load_gtf("gencode.v27.basic.annotation.gtf")
#' extract_pc(df)

extract_pc <- function(input) {
  # extracting pc annotations
  pc <- subset(input, input$gene_type=="protein_coding")
  # extracting genes, transcripts and exons
  pc_gte <- subset(pc, pc$type=="gene" | pc$type=="transcript" | pc$type=="exon")
  df <- as.data.frame(pc_gte)
  return(df)
}
