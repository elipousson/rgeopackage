## Helper tools to work with GeoPackage files in R

### Functionality

The package currently provides following functions that assist in writing reproducible GeoPackage files:

- `preset_timestamp()`: presets the file timestamp for usage by GDAL by setting the environment variable `OGR_CURRENT_DATE`.
The timestamp is adopted by GDAL during the entire session, unless `unset_timestamp()` is called.
- `amend_timestamp()`: overwrites timestamps in the `gpkg_contents` and `gpkg_metadata_reference` tables of an existing GeoPackage file.
While directly editing a GeoPackage is not advised, this function is especially useful in the presence of the optional table `gpkg_metadata_reference`, as GDAL does not control its timestamps as of writing (for GDAL 3.1.3).
See a corresponding [issue](https://github.com/OSGeo/gdal/issues/3537) in the GDAL source repository.

By default, GDAL sets timestamps corresponding to system time, so GeoPackages change when rewriting.

Both functions accept a `Date` or `POSIXct` object and format the timestamp in order to comply with the GeoPackage requirement.
See the functions' documentation and examples to get a better understanding.

### Installation

```r
remotes::install_github("florisvdh/rgeopackage")
```

