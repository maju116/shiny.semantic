% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tables.R
\name{semantic_DT}
\alias{semantic_DT}
\title{Create Semantic DT Table}
\usage{
semantic_DT(...)
}
\arguments{
\item{...}{datatable parameters, check \code{?DT::datatable} to learn more.}
}
\description{
This creates DT table styled with Semantic UI.
}
\examples{
if (interactive()){
 library(shiny)
 library(shiny.semantic)

 ui <- semanticPage(
   semantic_DTOutput("table")
 )
 server <- function(input, output, session) {
   output$table <- DT::renderDataTable(
     semantic_DT(iris)
   )
 }
 shinyApp(ui, server)
}

}
