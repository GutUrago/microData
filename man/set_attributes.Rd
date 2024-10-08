% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set_attributes.R
\name{set_attributes}
\alias{set_attributes}
\title{Cleans Microdata}
\usage{
set_attributes(
  data,
  metadata,
  old_name,
  new_name,
  label = NULL,
  slt_cols = TRUE
)
}
\arguments{
\item{data}{a data frame}

\item{metadata}{a data frame that contains old names, new names and
labels of each variables}

\item{old_name}{a column name in the \code{metadata} that contains
old names that exist in the \code{data}.}

\item{new_name}{a column name in the \code{metadata} that contains
new names to be set to the variables in the \code{data}.}

\item{label}{a column name in the \code{metadata} that contains
labels to be set to the variables in the \code{data}}

\item{slt_cols}{a logical. If \code{TRUE (default)} only variables that have new names
will be returned, and if \code{FALSE} all variables will be returned.}
}
\value{
A data frame with new attributes
}
\description{
Set names and label attributes to the data frame
}
\examples{
if(FALSE){
set_attributes(data = read.csv("microdata.csv"),
              metadata = 'readxl::read_excel("metadata.xlsx")',
              old_name = "Names",
              new_name = "New Names",
              label = "Labels")
}
}
\author{
Gutama Girja Urago
}
