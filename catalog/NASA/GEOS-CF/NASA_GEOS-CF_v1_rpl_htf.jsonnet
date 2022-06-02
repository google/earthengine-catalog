local id = 'NASA/GEOS-CF/v1/rpl/htf';
local subdir = 'NASA/GEOS-CF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: 'Collection',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  'gee:type': ee_const.gee_type.image_collection,
  title: 'GEOS-CF rpl htf v1: Goddard Earth Observing System Composition Forecast',
  version: 'v1',
  description: |||
    This dataset contains meteorological replay (rpl) of high-temporal
    frequency data (htf).

    The Goddard Earth Observing System Composition Forecast (GEOS-CF) system is
    a high-resolution (0.25&deg;) global constituent prediction system from
    NASA's [Global Modeling and Assimilation Office(GMAO)](
    https://gmao.gsfc.nasa.gov/).

    GEOS-CF offers a new tool for atmospheric chemistry research, with the goal
    to supplement NASA's broad range of space-based and in-situ observations.
    GEOS-CF expands on the GEOS weather and aerosol modeling system by
    introducing the [GEOS-Chem](http://wiki.seas.harvard.edu/geos-chem/)
    chemistry module to provide hindcasts and 5-days forecasts of atmospheric
    constituents including ozone (O3), carbon monoxide (CO), nitrogen dioxide
    (NO2), sulfur dioxide (SO2), and fine particulate matter (PM2.5). The
    chemistry module integrated in GEOS-CF is identical to the offline GEOS-Chem
    model and readily benefits from the innovations provided by the GEOS-Chem
    community.

    Evaluation of GEOS-CF against satellite, ozonesonde, and surface
    observations for years 2018&ndash;2019 shows realistic simulated
    concentrations of O3, NO2, and CO, with normalized mean biases of &minus;0.1
    to 0.3, normalized root mean square errors between 0.1&ndash;0.4, and
    correlations between 0.3&ndash;0.8. Comparisons against surface observations
    highlight the successful representation of air pollutants in many regions of
    the world and during all seasons, yet also highlight current limitations,
    such as a global high bias in SO2 and an overprediction of summertime O3
    over the Southeast United States.

    GEOS-CF v1.0 generally overestimates aerosols by 20%&ndash;50% due to known
    issues in GEOS-Chem v12.0.1 that have been addressed in later versions. The
    5-days forecasts have skill scores comparable to the 1-day hindcast. Model
    skills can be improved significantly by applying a bias-correction to the
    surface model output using a machine-learning approach.
  |||,
  'sci:citation': |||
    Keller, C. A., Knowland, K. E., Duncan, B. N., Liu, J., Anderson, D. C.,
    Das, S., ... & Pawson, S. (2021). Description of the NASA GEOS composition
    forecast modeling system GEOS-CF v1. 0. Journal of Advances in Modeling
    Earth Systems, 13(4), e2020MS002413.
    [doi:10.1029/2020MS002413](https://doi.org/10.1029/2020MS002413)
  |||,
  'sci:doi': '10.1029/2020MS002413',
  providers: [
    ee.producer_provider(
      'NASA / GMAO',
      'https://gmao.gsfc.nasa.gov/weather_prediction/GEOS-CF/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  license: license.id,
  links: ee.standardLinks(subdir, id),
  extent: ee.extent_global('2018-01-01T00:00:00Z', null),
  keywords: [
    'composition',
    'forecast',
    'geos',
    'gmao',
    'nasa',
  ],
  'gee:terms_of_use': |||
    Unless otherwise noted, all NASA-produced data may be used for any purpose
    without prior permission. For more information and exceptions visit the
    [NASA Data & Information Policy page](https://earthdata.nasa.gov/collaborate/open-data-services-and-software/data-information-policy).
  |||,
  summaries: {
    gsd: [
      27750.0,
    ],
    'eo:bands': [
      {
        name: 'CO',
        description: 'Carbon monoxide (CO, MW = 28.00 g mol-1) volume mixing ratio dry air',
        'gee:units': 'mol mol-1',
      },
      {
        name: 'NO2',
        description: 'Nitrogen dioxide (NO2, MW = 46.00 g mol-1) volume mixing ratio dry air',
        'gee:units': 'mol mol-1',
      },
      {
        name: 'O3',
        description: 'Ozone (O3, MW = 48.00 g mol-1) volume mixing ratio dry air',
        'gee:units': 'mol mol-1',
      },
      {
        name: 'PM25_RH35_GCC',
        description: 'Particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PM25_RH35_GOCART',
        description: 'Total reconstructed PM2.5 RH 35',
        'gee:units': 'kg m-3',
      },
      {
        name: 'Q',
        description: 'Specific humidity',
        'gee:units': 'kg kg-1',
      },
      {
        name: 'RH',
        description: 'Relative humidity after moist',
      },
      {
        name: 'SLP',
        description: 'Sea level pressure',
        'gee:units': 'Pa',
      },
      {
        name: 'SO2',
        description: 'Sulfur dioxide (SO2, MW = 64.00 g mol-1) volume mixing ratio dry air',
        'gee:units': 'mol mol-1',
      },
      {
        name: 'T',
        description: 'Air temperature',
        'gee:units': 'K',
      },
      {
        name: 'U',
        description: 'Eastward wind',
        'gee:units': 'm s-1',
      },
      {
        name: 'V',
        description: 'Northward wind',
        'gee:units': 'm s-1',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Temperature',
        lookat: {
          lat: 20.0,
          lon: 100.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              220,
            ],
            max: [
              320,
            ],
            palette: [
              'd7191c',
              'fdae61',
              'ffffbf',
              'abd9e9',
              '2c7bb6',
            ],
            bands: [
              'T',
            ],
          },
        },
      },
      {
        display_name: 'NO2',
        lookat: {
          lat: 20.0,
          lon: 100.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              6.96e-11,
            ],
            max: [
              4.42e-8,
            ],
            bands: [
              'NO2',
            ],
          },
        },
      },
    ],
  },
}
