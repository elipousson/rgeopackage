% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/timestamp.R
\name{amend_timestamp}
\alias{amend_timestamp}
\title{Amend the timestamp(s) in a GeoPackage file}
\usage{
amend_timestamp(dsn, timestamp = Sys.time(), quiet = FALSE, verbose = TRUE)
}
\arguments{
\item{dsn}{the path to the GeoPackage file (*.gpkg)}

\item{timestamp}{a \code{Date} or \code{POSIXct} object, used to generate
the timestamp.
For a \code{Date} object, time will be considered as \verb{00:00:00 UTC}.
Defaults to system time, however must be set explicitly for reproducible
workflows.}

\item{quiet}{If \code{TRUE},print informational message}

\item{verbose}{Deprecated. Logical. For each relevant table, prints a message with the number of affected rows.}
}
\value{
\code{NULL} is returned invisibly.
}
\description{
Overwrites all timestamps (column \code{last_change}) of the
\code{gpkg_contents} table in an existing GeoPackage file.
If the optional table \code{gpkg_metadata_reference} is present, does the
same with its \code{timestamp} column.
As such the function assists in making a binary-reproducible GeoPackage file.
}
\details{
Internally the timestamp is converted to a specific ISO 8601 format
that is required by the GeoPackage standard.
}
\note{
Directly editing a GeoPackage is not advised; whenever possible use
\code{\link[=preset_timestamp]{preset_timestamp()}} since it goes via GDAL.

However \code{amend_timestamp()} is especially useful when a
GeoPackage file also contains a timestamp in the optional table
\code{gpkg_metadata_reference}, as GDAL does not control that timestamp
as of writing (for GDAL 3.1.3).
See a corresponding \href{https://github.com/OSGeo/gdal/issues/3537}{issue}
in the GDAL source repository.
}
\examples{
library(sf)
library(openssl)
md5sum <- function(x) paste(md5(file(x)))

# Using existing geopackage with vector layer:
filepath <- system.file("gpkg/b_pump.gpkg", package = "sf")
(md5_original <- md5sum(filepath))

sf_layer <- read_sf(system.file("gpkg/b_pump.gpkg", package = "sf"))

# A rewrite changes the checksum:
filepath_notimeset <- file.path(tempdir(), "b_pump_notimeset.gpkg")
# write 1:
st_write(sf_layer, dsn = filepath_notimeset, delete_dsn = TRUE)
(md5_notimeset1 <- md5sum(filepath_notimeset))
# write 2:
st_write(sf_layer, dsn = filepath_notimeset, delete_dsn = TRUE)
(md5_notimeset2 <- md5sum(filepath_notimeset))
# compare:
md5_notimeset1 == md5_notimeset2

# Setting a fixed date
filepath_timeset <- file.path(tempdir(), "b_pump_timeset.gpkg")
(fixed_date <- as.Date("2020-12-25"))
# write 1 (date):
st_write(sf_layer, dsn = filepath_timeset, delete_dsn = TRUE)
amend_timestamp(filepath_timeset, fixed_date)
md5_timeset1 <- md5sum(filepath_timeset)
# write 2 (date):
st_write(sf_layer, dsn = filepath_timeset, delete_dsn = TRUE)
amend_timestamp(filepath_timeset, fixed_date)
md5_timeset2 <- md5sum(filepath_timeset)
# compare:
all.equal(md5_timeset1, md5_timeset2)

# Setting a fixed time
(fixed_time <- as.POSIXct("2020-12-25 12:00:00", tz = "CET"))
# write 3 (time):
st_write(sf_layer, dsn = filepath_timeset, delete_dsn = TRUE)
amend_timestamp(filepath_timeset, fixed_time)
md5_timeset3 <- md5sum(filepath_timeset)
# write 4 (time):
st_write(sf_layer, dsn = filepath_timeset, delete_dsn = TRUE)
amend_timestamp(filepath_timeset, fixed_time)
md5_timeset4 <- md5sum(filepath_timeset)
# compare:
all.equal(md5_timeset3, md5_timeset4)

# Also works for GPKG 2D gridded coverage (with stars):
library(stars)
library(dplyr)

filepath_stars <- file.path(tempdir(), "stars_2d.gpkg")

stars_2d <-
  system.file("tif/L7_ETMs.tif", package = "stars") \%>\%
  read_stars() \%>\%
  slice(band, 1)
# write 1:
stars_2d \%>\%
  write_stars(filepath_stars, driver = "GPKG")
amend_timestamp(filepath_stars, fixed_time)
md5_stars1 <- md5sum(filepath_stars)
# write 2:
stars_2d \%>\%
  write_stars(filepath_stars, driver = "GPKG")
amend_timestamp(filepath_stars, fixed_time)
md5_stars2 <- md5sum(filepath_stars)
# compare:
all.equal(md5_stars1, md5_stars2)

}
\seealso{
Other functions to control the GeoPackage timestamp(s):
\code{\link[=preset_timestamp]{preset_timestamp()}},
\code{\link[sf:st_write]{sf::st_write()}}
}
\author{
Floris Vanderhaeghe, \url{https://github.com/florisvdh}
}
