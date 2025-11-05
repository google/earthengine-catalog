local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    'https://stac-extensions.github.io/version/v1.0.0/schema.json',
  ],
  'gee:type': ee_const.gee_type.image_collection,
  description_intro:: |||
    The PRISM daily and monthly datasets are gridded climate
    datasets for the conterminous United States, produced by the
    PRISM Climate Group at Oregon State University.
  |||,
  description_outro:: |||

    Grids are
    developed using PRISM (Parameter-elevation Regressions on Independent
    Slopes Model). PRISM interpolation routines simulate how weather
    and climate vary with elevation, and account for coastal effects,
    temperature inversions, and terrain barriers that can cause rain
    shadows. Station data are assimilated from many networks across
    the country. For more information, see the [Descriptions of PRISM
    Spatial Climate Datasets](https://www.prism.oregonstate.edu/documents/PRISM_datasets.pdf).

    **Note**

    * **Warning**: This dataset should not be
      used to calculate century-long climate trends due to non-climatic
      variations from to station equipment and location changes, openings
      and closings, varying observation times, and the use of relatively
      short-term networks. Please see the [dataset documentation
      ](https://www.prism.oregonstate.edu/documents/PRISM_datasets.pdf)
      for more details.
    * The assets have start time of noon UTC, not midnight UTC.
    * It takes time for observation networks to conduct quality control and
      release station data. Therefore,
      PRISM datasets are re-modeled several times until six months
      have elapsed, when they are considered permanent. A [release
      schedule is available](https://www.prism.oregonstate.edu/calendar/).
  |||,
  license: spdx.proprietary.id,
  links: ee.standardLinks('OREGONSTATE', self.id),
  'gee:categories': ['climate'],
  keywords: [
    'climate',
    'daily',
    'geophysical',
    'oregonstate',
    'precipitation',
    'pressure',
    'prism',
    'temperature',
    'vapor',
    'weather',
  ],
  providers: [
    ee.producer_provider('PRISM / OREGONSTATE', 'https://www.prism.oregonstate.edu/'),
    ee.host_provider(ee_const.ee_catalog_url + std.strReplace(self.id, '/', '_')),
  ],
  extent: ee.extent(-125.0, 24.0, -66.0, 50.0, '1981-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'PRISM_CODE_VERSION',
        description: |||
          List of code versions per band, e.g: the first element
          is for the first band "ppt", the second element is for the second
          band "tmean"
        |||,
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_CREATE_DATE',
        description: |||
          List of original creation dates per band in the format YYYYMMDD
        |||,
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_FILENAME',
        description: 'List of original filenames for each band',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_TYPE',
        description: 'List of dataset types per band',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_VERSION',
        description: |||
          List of dataset versions per band e.g: D1 or D2 for daily products;
          M1, M2 or M3 for monthly products.
        |||,
        type: ee_const.var_type.string_list,
      },
    ],
    gsd: [
      4638.3,
    ],
    'eo:bands': [
      {
        name: 'ppt',
        description: 'Daily total precipitation (including rain and melted snow)',
        'gee:units': units.millimeter,
      },
      {
        name: 'tmean',
        description: 'Daily mean temperature (calculated as (tmin+tmax)/2)',
        'gee:units': units.celsius,
      },
      {
        name: 'tmin',
        description: 'Daily minimum temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'tmax',
        description: 'Daily maximum temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'tdmean',
        description: 'Daily mean dew point temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'vpdmin',
        description: 'Daily minimum vapor pressure deficit',
        'gee:units': units.hectopascal,
      },
      {
        name: 'vpdmax',
        description: 'Daily maximum vapor pressure deficit',
        'gee:units': units.hectopascal,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation',
        lookat: {
          lat: 40.71,
          lon: -100.55,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              50.0,
            ],
            palette: [
              'red',
              'yellow',
              'green',
              'cyan',
              'purple',
            ],
            bands: [
              'ppt',
            ],
          },
        },
      },
    ],
    ppt: {
      minimum: 0.0,
      maximum: 731.65,
      'gee:estimated_range': true,
    },
    tmean: {
      minimum: -40.37,
      maximum: 45.98,
      'gee:estimated_range': true,
    },
    tmin: {
      minimum: -47.56,
      maximum: 39.59,
      'gee:estimated_range': true,
    },
    tmax: {
      minimum: -38.38,
      maximum: 54.13,
      'gee:estimated_range': true,
    },
    tdmean: {
      minimum: -46.18,
      maximum: 31.61,
      'gee:estimated_range': true,
    },
    vpdmin: {
      minimum: 0.0,
      maximum: 69.86,
      'gee:estimated_range': true,
    },
    vpdmax: {
      minimum: 0.0,
      maximum: 142.42,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    [Daly, C., Halbleib, M., Smith, J.I., Gibson, W.P., Doggett, M.K.,
    Taylor, G.H., Curtis, J., and Pasteris, P.A. 2008. Physiographically-sensitive
    mapping of temperature and precipitation across the conterminous
    United States. International Journal of Climatology, 28: 2031-2064](https://www.prism.oregonstate.edu/documents/pubs/2008intjclim_physiographicMapping_daly.pdf)
  |||,
  'sci:publications': [
    {
      citation: |||
        [Daly, C., J.I. Smith, and K.V. Olson. 2015. Mapping atmospheric
        moisture climatologies across the conterminous United States. PloS
        ONE 10(10):e0141140.
        [doi:10.1371/journal.pone.0141140](https://doi.org/10.1371/journal.pone.0141140).
      |||,
      doi: '10.1371/journal.pone.0141140',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    These PRISM datasets are available without restriction
    on use or distribution. PRISM Climate Group does request that the
    user give proper attribution and identify PRISM, where applicable,
    as the source of the data.
  |||,
}
