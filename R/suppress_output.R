#' @title Supress the output message of R commands
#'
#' @description This function suppresses all output messages from an R command
#' @usage suppress_output(input)
#' @param input The name of an R command
#' @export
#' @return The output from a command without displaying any message
#' @examples
#' examples \dontrun {
#' # You don't have to run this
#' suppress_output(stat_intron(intron_df))
#’}
suppress_output <- function(input) {
  sink("empt_obj")
  tmp = input
  sink()
  return(input)
}
