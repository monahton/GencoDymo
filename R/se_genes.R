#' @title Extract single-exon genes
#'
#' @description This function takes a gtf file from GENCODE and returns a data frame in the R Global Environment containing a column of the gene id of the single-exon genes.
#' @usage se_genes(input)
#' @param input The name of the downloaded gtf file from GENCODE website
#' @export
#' @keywords single-exon genes
#' @seealso \code{\link{se_transcripts}}
#' @return A dataframe of the gene IDs of single-exon transcripts
#' @examples
#' df <- load_gtf("gencode.v27.lncRNAs.gtf")
#' se_genes(df)

se_genes <- function(input) {
  exons <- subset(input, input$type=="exon")
  gene_ids1 <- subset(exons, select = c("gene_id", "exon_number"))
  gene_ids2 <- as.data.frame(table(gene_ids1$gene_id))
  colnames(gene_ids2) <- c("gene_id", "exon_count")
  se <- subset(gene_ids2, gene_ids2$exon_count == 1)
  se_genes_id <- subset(se, select = "gene_id")
  df <- as.data.frame(se_genes_id)
  return(df)
}
