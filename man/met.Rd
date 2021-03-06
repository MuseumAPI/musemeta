% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/met.R
\name{met}
\alias{met}
\alias{muse_get}
\title{Get metadata for objects in the Metropolitan Museum of Art.}
\usage{
met(id, ascii = FALSE, ...)

muse_get(id, ...)
}
\arguments{
\item{id}{An object id}

\item{ascii}{(logical) Allow non-ascii characters. Set to \code{TRUE} to show
non-ascii characters. Default: FALSE}

\item{...}{Curl args passed on to \code{\link[httr]{GET}}}
}
\description{
Get metadata for objects in the Metropolitan Museum of Art.
}
\details{
\code{muse_get} has changed to \code{met}
}
\examples{
\dontrun{
(out <- met(559490))
out$name
out$values
met(246562)
lapply(c(479283, 228901, 436876, 444244), met)
}
}

