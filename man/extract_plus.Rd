% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract_plus.R
\name{extract_plus}
\alias{extract_plus}
\title{Extract elements on the plus strand from a gtf file.}
\usage{
extract_plus(input, type)
}
\arguments{
\item{input}{The name of the downloaded gtf file from GENCODE website or a data frame of introns}

\item{type}{A string that specifies the type of element to be reported}
}
\value{
A data frame of elements on the plus strand
}
\description{
This function takes a gtf file from GENCODE or the data frame of extracted introns. It returns as a data frame a specified element; i.e gene, transcript, exon or intron; that are on the forward strand
}
\examples{
df <- load_gtf("gencode.v27.lncRNAs.gtf")
extract_plus(df, type = "gene")
extract_plus(df, type = "transcript")
extract_plus(df, type = "exon")
extract_plus(df, "intron")
}
\seealso{
\code{\link{extract_minus}}
}
\keyword{positive}
\keyword{strand}
