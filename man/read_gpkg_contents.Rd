% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gpkg_contents.R
\name{read_gpkg_contents}
\alias{read_gpkg_contents}
\alias{update_gpkg_contents}
\title{Read and update GeoPackage contents table}
\usage{
read_gpkg_contents(dsn, quiet = FALSE)

update_gpkg_contents(
  dsn,
  identifier = NULL,
  description = NULL,
  timestamp = Sys.time(),
  title = identifier,
  quiet = FALSE
)
}
\arguments{
\item{dsn}{Path or url for GeoPackage file. Optional if con is provided.}

\item{quiet}{If \code{TRUE}, do not show informational messages. Defaults to
\code{FALSE}.}

\item{identifier}{Identifier for GeoPackage file.}

\item{description}{Description for GeoPackage file.}

\item{timestamp}{a \code{Date} or \code{POSIXct} object, used to generate
the timestamp.
For a \code{Date} object, time will be considered as \verb{00:00:00 UTC}.
Defaults to system time, however must be set explicitly for reproducible
workflows.}

\item{title}{Title for GeoPackage file.}
}
\description{
Read and update GeoPackage contents table
}
