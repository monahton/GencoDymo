#' @title Extract elements on the plus strand from a gtf file.
#'
#' @description This function takes a gtf file from GENCODE or the dataframe of extracted introns. It returns as a dataframe a specified element; i.e gene, transcript, exon or intron; that are on the forward strand
#' @usage extract_plus(input, type)
#' @param input The name of the downloaded gtf file from GENCODE website or a data frame of introns
#' @param type A string that specifies the type of element to be reported
#' @export
#' @keywords positive strand
#' @seealso \code{\link{extract_minus}}
#' @return A data frame of elements on the plus strand
#' @examples
#' df <- load_gtf("gencode.v27.lncRNAs.gtf")
#' extract_plus(df, type = "gene")
#' extract_plus(df, type = "transcript")
#' extract_plus(df, type = "exon")
#' extract_plus(df, "intron")

extract_plus <- function(input, type) {
  if (type=="gene") {
    genes <- subset(input, input$type=="gene")
    genes_plus <- subset(genes, genes$strand=="+")
    genes_num <- nrow(genes_plus)
    cat(paste0("\033[0;32mGenes: \033[0m", genes_num), sep = "\n")
    df <- as.data.frame(genes_plus)
    return(df)
  } else if (type=="transcript") {
    trans <- subset(input, input$type=="transcript")
    trans_plus <- subset(trans, trans$strand=="+")
    trans_num <- nrow(trans_plus)
    cat(paste0("\033[0;32mTranscripts: \033[0m", trans_num), sep = "\n")
    df <- as.data.frame(trans_plus)
    return(df)
  } else if (type=="exon") {
    exons <- subset(input, input$type=="exon")
    exons_plus <- subset(exons, exons$strand=="+")
    exons_num <- nrow(exons_plus)
    cat(paste0("\033[0;32mExons: \033[0m", exons_num), sep = "\n")
    df <- as.data.frame(exons_plus)
    return(df)
  } else if (type=="intron") {
    introns <- subset(input, input$type=="intron")
    introns_plus <- subset(introns, introns$strand=="+")
    introns_num <- nrow(introns_plus)
    cat(paste0("\033[0;32mIntrons: \033[0m", introns_num), sep = "\n")
    df <- as.data.frame(introns_plus)
    return(df)
  } else {
    print("Error: operation could not be performed - check the help page for examples")
  }
}


#' @title Extract elements on the minus strand from a gtf file.
#'
#' @description This function takes a gtf file from GENCODE or the dataframe containing extracted introns. It returns as a dataframe a specified element; i.e gene, transcript, exon or intron; that are on the reverse strand
#' @usage extract_minus(input, type)
#' @param input The name of the downloaded gtf file from GENCODE website
#' @param type A string that specifies the type of element to be reported
#' @export
#' @keywords negative strand
#' @seealso \code{\link{extract_plus}}
#' @return A data frame of elements on the minus strand
#' @examples
#' df <- load_gtf("gencode.v27.lncRNAs.gtf")
#' extract_minus(df, type = "gene")
#' extract_minus(df, type = "transcript")
#' extract_minus(df, type = "exon")
#' extract_minus(introns_df, type = "intron")

extract_minus <- function(input, type) {
  if (type=="gene") {
    genes <- subset(input, input$type=="gene")
    genes_minus <- subset(genes, genes$strand=="-")
    genes_num <- nrow(genes_minus)
    cat(paste0("\033[0;32mGenes: \033[0m", genes_num), sep = "\n")
    df <- as.data.frame(genes_minus)
    return(df)
  } else if (type=="transcript") {
    trans <- subset(input, input$type=="transcript")
    trans_minus <- subset(trans, trans$strand=="-")
    trans_num <- nrow(trans_minus)
    cat(paste0("\033[0;32mTranscripts: \033[0m", trans_num), sep = "\n")
    df <- as.data.frame(trans_minus)
    return(df)
  } else if (type=="exon") {
    exons <- subset(input, input$type=="exon")
    exons_minus <- subset(exons, exons$strand=="-")
    exons_num <- nrow(exons_minus)
    cat(paste0("\033[0;32mExons: \033[0m", exons_num), sep = "\n")
    df <- as.data.frame(exons_minus)
    return(df)
  } else if (type=="intron") {
    introns <- subset(input, input$type=="intron")
    introns_minus <- subset(introns, introns$strand=="-")
    introns_num <- nrow(introns_minus)
    cat(paste0("\033[0;32mIntrons: \033[0m", introns_num), sep = "\n")
    df <- as.data.frame(introns_minus)
    return(df)
  } else {
    print("Error: operation could not be performed - check the help page for examples")
  }
}










