local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

{
  description: |||
    This dataset consists of near-global, analysis-ready, multi-resolution
    gridded vegetation structure metrics derived from NASA Global Ecosystem
    Dynamics Investigation (GEDI) Level 2 and 4A products associated with 25-m
    diameter lidar footprints. This dataset provides a comprehensive
    representation of near-global vegetation structure that is inclusive of
    the entire vertical profile, based solely on GEDI lidar, and validated with
    independent data.

    The GEDI sensor, mounted on the International Space
    Station (ISS), uses eight laser beams spaced by 60 m along-track and 600 m
    across-track on the Earth surface to measure ground elevation and vegetation
    structure between approximately 52 degrees North and South latitude.
    Between April 17th 2019 and March 16th 2023, GEDI acquired 11 and 7.7
    billion quality waveforms suitable for measuring ground elevation and
    vegetation structure, respectively.

    In addition to many of the standard L2 and L4A shot metrics, several
    additional metrics have been derived which may be particularly useful for
    applications in carbon and water cycling processes in earth system models,
    as well as forest management, biodiversity modeling, and habitat assessment.
    Variables include canopy height, canopy cover, plant area index, foliage
    height diversity, and plant area volume density at 5 m strata. Refer to the
    [Gridded GEDI Vegetation Structure Metrics and Biomass Density]
    (https://daac.ornl.gov/GEDI/guides/GEDI_HighQuality_Shots_Rasters.html)
    for more information.

    Eight statistics are included for each GEDI shot metric: mean, bootstrapped
    standard error of the mean, median, standard deviation, interquartile range,
    95th percentile, Shannon's diversity index, and shot count.
    Quality shot filtering methodology that aligns with the GEDI L4B Gridded
    Aboveground Biomass Density, Version 2.1 was used. In comparison to the
    corresponding GEDI L3 dataset, this dataset provides additional gridded metrics at
    multiple spatial resolutions and over several temporal periods (annual and
    the full mission duration).

    This dataset provides GEDI shot metrics aggregated into raster grids at
    three spatial resolutions: 1 km, 6 km, and 12 km.
  |||,
  keywords: [
    'gedi',
    'larse',
    'nasa',
    'vegetation',
    'lidar',
    'forest',
    'biomass',
    'canopy',
  ],
  providers(name, catalog_url): [
    ee.producer_provider(
      name + 'USFS Laboratory for Applications of Remote Sensing in Ecology (LARSE)',
      'https://www.fs.usda.gov/'
    ),
    ee.processor_provider(
      'Gridded GEDI Vegetation Structure Metrics and Biomass Density',
      'https://daac.ornl.gov/GEDI/guides/GEDI_HighQuality_Shots_Rasters.html'
    ),
    ee.host_provider(catalog_url),
  ],
  license: spdx.proprietary.id,
  extent: ee.extent(-180,
                    -52,
                    180,
                    52,
                    '2019-04-17T00:00:00Z',
                    '2023-03-16T00:00:00Z'),
  citation: |||
    Burns, P., Hakkenberg, C.R. & Goetz, S.J. Multi-resolution gridded maps of
    vegetation structure from GEDI. Sci Data 11, 881 (2024).
    [doi:10.1038/s41597-024-03668-4](https://doi.org/10.1038/s41597-024-03668-4)
  |||,
  regular_bands: [
    {
      name: 'mean',
      description: 'The mean of GEDI shot metric values within a pixel',
      type:: ee_const.var_type.double,
    },
    {
      name: 'meanbse',
      description: |||
        Standard error of the mean calculated using bootstrap resampling.
        100 bootstrap samples were created; each sample included 70% of shots,
        randomly selected.  Standard error was calculated using the means of
        bootstrapped samples. (Only calculated when there are at least 10 GEDI
        shots in the grid cell.)
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'median',
      description: |||
        The median value (50th percentile) of GEDI shot metric values within a
        pixel.
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'sd',
      description: |||
        The standard deviation of GEDI shot metric values within a pixel.
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'iqr',
      description: |||
          The interquartile range (75 percentile minus 25th percentile) of GEDI
          shot metric values within a pixel.
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'p95',
      description: |||
          The 95th percentile value of GEDI shot metric values within a pixel.
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'shan',
      description: |||
        Shannons diversity index (H) of GEDI shot metric values within a pixel.
        Calculated as:-1*(sum(p*log(p))) where p is the proportion of
        GEDI shot values per bin.
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'countf',
      description: |||
        The count of GEDI shot metric values within a pixel. A 30-m sub-grid
        was used to select the (temporally) first GEDI shot acquired in each
        30-m sub-grid cell.
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'shots_count',
      description: |||
        The number of shots. For a shot to be counted in this layer the
        following fields need to be valid: longitude, latitude, elevation of the
        lowest mode, decimal date, and orbit.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'orbits_uniq',
      description: |||
        The number of unique orbits.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'tracks_uniq',
      description: |||
        The number of unique tracks. A track is the combination of orbit and
        beam.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'shots_nni',
      description: |||
        The Nearest Neighbor Index (Evans et al. 2023).
      |||,
      type:: ee_const.var_type.int,
    },
  ],

  terms_of_use: |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy]
    (https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
