local id = 'NASA/ORNL/DAYMET_V4';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/DAYMET_versions.libsonnet';

local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local units = import 'units.libsonnet';

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Daymet V4: Daily Surface Weather and Climatological Summaries',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Daymet V4 provides gridded estimates of daily weather parameters for
    Continental North America, Hawaii, and Puerto Rico (Data for Puerto Rico is available starting
    in 1950). It is derived from selected meteorological station data and various supporting data
    sources.

    Compared to the previous version, Daymet V4 provides effective solutions to known issues and
    further considers improvements to what were believed to be input weather station biases.
    Improvements include:

    - Reductions in the timing bias of input reporting weather station measurements.

    - Improvement to the three-dimensional regression model techniques in the core algorithm.

    - A novel approach to handling high elevation temperature measurement biases.

    2020 and 2021 data are ingested from V4 R1 sources

    Documentation:

    * [ORNL DAAC Dataset Documentation](https://daac.ornl.gov/DAYMET/guides/Daymet_Daily_V4.html)

    * [Dataset Documentation](https://daac.ornl.gov/daacdata/daymet/Daymet_Daily_V4/comp/Daymet_Daily_V4.pdf)

    * [The THREDDS location for this Collection](https://thredds.daac.ornl.gov/thredds/catalogs/ornldaac/Regional_and_Global_Data/DAYMET_COLLECTIONS/DAYMET_COLLECTIONS.html)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.3334/ORNLDAAC/1840',
    },
  ] + version_config.version_links,
  keywords: [
    'climate',
    'daily',
    'daylight',
    'daymet',
    'flux',
    'geophysical',
    'nasa',
    'ornl',
    'precipitation',
    'radiation',
    'snow',
    'temperature',
    'vapor',
    'water',
    'weather',
  ],
  providers: [
    ee.producer_provider('NASA ORNL DAAC at Oak Ridge National Laboratory', 'https://doi.org/10.3334/ORNLDAAC/1840'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2031536952-ORNL_CLOUD',
  ],
  extent: ee.extent(-150.8, 1.6, -1.1, 84.0, '1980-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'dayl',
        description: |||
          Duration of the daylight period. Based on the period
          of the day during which the sun is above a hypothetical flat horizon.
        |||,
        'gee:units': 'seconds',
      },
      {
        name: 'prcp',
        description: 'Daily total precipitation, sum of all forms converted to\nwater-equivalent.',
        'gee:units': units.millimeter,
      },
      {
        name: 'srad',
        description: 'Incident shortwave radiation flux density, taken as an average\nover the daylight period of the day.',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'swe',
        description: 'Snow water equivalent, the amount of water contained within\nthe snowpack.',
        'gee:units': units.area_density,
      },
      {
        name: 'tmax',
        description: 'Daily maximum 2-meter air temperature.',
        'gee:units': units.celsius,
      },
      {
        name: 'tmin',
        description: 'Daily minimum 2-meter air temperature.',
        'gee:units': units.celsius,
      },
      {
        name: 'vp',
        description: 'Daily average partial pressure of water vapor.',
        'gee:units': units.pascal,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Maximum Temperature',
        lookat: {
          lat: 35.1,
          lon: -110.21,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              -40.0,
            ],
            max: [
              30.0,
            ],
            palette: [
              'blue',
              'white',
              'cyan',
              'green',
              'yellow',
              'orange',
              'red',
            ],
            bands: [
              'tmax',
            ],
          },
        },
      },
    ],
    dayl: {
      minimum: 0.0,
      maximum: 86400.0,
      'gee:estimated_range': true,
    },
    prcp: {
      minimum: 0.0,
      maximum: 544.0,
      'gee:estimated_range': true,
    },
    srad: {
      minimum: 0.0,
      maximum: 1051.0,
      'gee:estimated_range': true,
    },
    swe: {
      minimum: 0.0,
      maximum: 13931.0,
      'gee:estimated_range': true,
    },
    tmax: {
      minimum: -60.0,
      maximum: 60.0,
      'gee:estimated_range': true,
    },
    tmin: {
      minimum: -60.0,
      maximum: 42.0,
      'gee:estimated_range': true,
    },
    vp: {
      minimum: 0.0,
      maximum: 8230.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.3334/ORNLDAAC/2129',
  'sci:citation': |||
    Thornton, M.M., R. Shrestha, Y. Wei, P.E. Thornton, S-C. Kao, and B.E. Wilson. 2022.
    Daymet: Daily Surface Weather Data on a 1-km Grid for North America, Version 4 R1.
    ORNL DAAC, Oak Ridge, Tennessee, USA. https://doi.org/10.3334/ORNLDAAC/2129
  |||,
  'sci:publications': [
    {
      citation: |||
        Other Citation Details - Thornton, M.M., R. Shrestha, Y. Wei, P.E. Thornton, S. Kao, and B.E. Wilson. 2020.
        Daymet: Daily Surface Weather Data on a 1-km Grid for North America, Version 4. ORNL DAAC, Oak Ridge, Tennessee, USA.
        [doi:10.3334/ORNLDAAC/1840](https://doi.org/10.3334/ORNLDAAC/1840)
      |||,
      doi: '10.3334/ORNLDAAC/1840',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
