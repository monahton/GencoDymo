## ----eval=FALSE, include=FALSE------------------------------------------------
#  # This is required to load an Example Dataset. This image file must be present in the vignette folder.
#    load("exampleData.RData")
#    library(dplyr)

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
#   # download basic annotations gtf file
#  download.file(url="ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_32/gencode.v32.basic.annotation.gtf.gz", destfile = "gencode.v32.basic.annotation.gtf.gz", method = "wget")
#  
#   # download lncRNAs annotations gtf file
#  download.file(url="ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_32/gencode.v32.long_noncoding_RNAs.gtf.gz", destfile = "gencode.v32.long_noncoding_RNAs.gtf.gz", method = "wget")

## ----eval=FALSE---------------------------------------------------------------
#   # Load BSgenome object
#     library(BSgenome.Hsapiens.UCSC.hg38)
#     hg38 <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38

## ----eval=FALSE---------------------------------------------------------------
#   # Load BSgenome object
#     library(GencoDymo)

## ----eval=FALSE---------------------------------------------------------------
#   # Import basic annotations gtf as a dataframe
#     gen32 <- load_gtf("gencode.v32.basic.annotation.gtf.gz")
#   # Import lncRNAs annotations gtf as a dataframe
#     gen32_lncRNA <- load_gtf("gencode.v32.long_noncoding_RNAs.gtf.gz")

## ----eval=FALSE---------------------------------------------------------------
#    # Extract protein-coding genes from basic annotation file
#      extract_pc(gen32)
#      View(pc_df)

## ----eval=FALSE---------------------------------------------------------------
#  # Extract introns from the gtf file of lncRNAs
#    gen32_lncRNA_introns <- extract_introns(gen32_lncRNA)
#  

## ----eval=FALSE---------------------------------------------------------------
#  assign_ss(gen32_lncRNA_introns, genome = hg38)

## ----eval=FALSE---------------------------------------------------------------
#  # Produce a fasta file with 5'ss 9-mers:
#  extract_5ss_motif(gen32_lncRNA_introns, BSgenome.Hsapiens.UCSC.hg38)
#  # Produce a fasta file with 3'ss 23-mers:
#  extract_3ss_motif(gen32_lncRNA_introns, BSgenome.Hsapiens.UCSC.hg38)

## ----eval=FALSE---------------------------------------------------------------
#  # Extract single-Exon genes:
#    se_genes(gen32)
#    se_genes(gen32_lncRNA)

## ----eval=FALSE---------------------------------------------------------------
#  # Extract single-Exon transcripts:
#    se_transcripts(gen32)
#    se_transcripts(gen32_lncRNA)

## ----eval=FALSE---------------------------------------------------------------
#  # Annotate each exons as first, inner, last or single exons.
#    classified_exons_df <- classify_exons(gen32_lncRNA)

## ----eval=FALSE---------------------------------------------------------------
#  # Remove redundant exons
#  eliminate_redundant_exons(gen32_lncRNA)

## ----eval=FALSE---------------------------------------------------------------
#  # Remove redundant introns
#  eliminate_redundant_introns(introns_df)

## ----eval=FALSE---------------------------------------------------------------
#  # download gtf file of lncRNA annotations from release 30
#    download.file(url="ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_30/gencode.v30.long_noncoding_RNAs.gtf.gz", destfile = "gencode.v30.long_noncoding_RNAs.gtf.gz", method = "wget")
#  
#  # load the downloaded gtf file as a data frame in r
#    gen30_lncRNA <- load_gtf("gencode.v30.long_noncoding_RNAs.gtf.gz")
#    gen30_lncRNA_introns <- extract_introns(gen30_lncRNA)

## ----eval=FALSE---------------------------------------------------------------
#  # Calculates the number of differing genetic elements
#    gencode_compare(gen30_lncRNA, gen32_lncRNA, type = "gene")
#    gencode_compare(gen30_lncRNA, gen32_lncRNA, type = "transcript")
#    gencode_compare(gen30_lncRNA, gen32_lncRNA, type = "exon")
#    gencode_compare(gen30_lncRNA_introns, gen32_lncRNA_introns, type = "intron")

## ----eval=FALSE---------------------------------------------------------------
#  # Transcripts per Gene frequency table:
#    genes_freq_df <- genes_freq(gen32_lncRNA)
#  

## ----eval=FALSE---------------------------------------------------------------
#  # Exons per transcript frequency table:
#    trans_freq_df <- trans_freq(gen32_lncRNA)
#  

## ----eval=FALSE---------------------------------------------------------------
#  # Length of spliced transcript
#    spliced_trans_length(gen32_lncRNA)

## ----eval=FALSE---------------------------------------------------------------
#  # Calculates mean, median, sd and std error of exons
#    stat_exon(gen32_lncRNA)

## ----eval=FALSE---------------------------------------------------------------
#  # Calculates mean, median, sd and std error of introns
#  stat_intron(introns_ss)

## ----eval=TRUE----------------------------------------------------------------
   devtools::session_info()

