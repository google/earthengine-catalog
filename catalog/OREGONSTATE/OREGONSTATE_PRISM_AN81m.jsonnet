local id = 'OREGONSTATE/PRISM/AN81m';
local subdir = 'OREGONSTATE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'PRISM Monthly Spatial Climate Dataset AN81m',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The PRISM daily and monthly datasets are gridded climate
    datasets for the conterminous United States, produced by the
    PRISM Climate Group at Oregon State University.

    Grids are
    developed using PRISM (Parameter-elevation Regressions on Independent
    Slopes Model). PRISM interpolation routines simulate how weather
    and climate vary with elevation, and account for coastal effects,
    temperature inversions, and terrain barriers that can cause rain
    shadows. Station data are assimilated from many networks across
    the country. For more information, see the [Descriptions of PRISM
    Spatial Climate Datasets](https://www.prism.oregonstate.edu/documents/PRISM_datasets.pdf).

    **Note**

    * **Warning**, this dataset should not be
      used to calculate century-long climate trends due to non-climatic
      variations from to station equipment and location changes, openings
      and closings, varying observation times, and the use of relatively
      short-term networks. Please see the [dataset
      documentation](https://www.prism.oregonstate.edu/documents/PRISM_datasets.pdf)
      for more details.
    * It takes time for observation networks to conduct quality control
      and release station data. Therefore, PRISM datasets are re-modeled
      several times until six months have elapsed, when they are
      considered permanent. A [release schedule is
      available](https://www.prism.oregonstate.edu/calendar/).
    * For use of the 30 arc-second (~800 m) version of this dataset
      please contact the provider at prism-questions@nacse.org.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'climate',
    'geophysical',
    'monthly',
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
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-125.0, 24.0, -66.0, 50.0, '1895-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'PRISM_CODE_VERSION',
        description: |||
          List of code versions per-band, e.g: the first element
          is for the first band "ppt", the second element is for the second
          band "tmean"
        |||,
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_CREATE_DATE',
        description: 'List of original creation dates per-band',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_FILENAME',
        description: 'List of original filenames for each band',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_TYPE',
        description: 'List of dataset types per-band',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_VERSION',
        description: 'List of dataset versions per-band e.g: D1 or D2 for\ndaily products; M1, M2 or M3 for monthly products.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'status',
        description: |||
          Data generated within 30 days of observation have
          the status "early". Data generated within 1-6 months of observation
          may have the status "provisional" and data older than 6 months
          are marked as "permanent".
        |||,
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4638.3,
    ],
    'eo:bands': [
      {
        name: 'ppt',
        description: 'Monthly total precipitation (including rain and melted snow)',
        'gee:units': units.millimeter,
      },
      {
        name: 'tmean',
        description: 'Monthly average of daily mean temperature (calculated as (tmin+tmax)/2)',
        'gee:units': units.celsius,
      },
      {
        name: 'tmin',
        description: 'Monthly minimum temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'tmax',
        description: 'Monthly average of daily maximum temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'tdmean',
        description: 'Monthly average of daily mean dew point temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'vpdmin',
        description: 'Monthly average of daily minimum vapor pressure deficit',
        'gee:units': units.hectopascal,
      },
      {
        name: 'vpdmax',
        description: 'Monthly average of daily maximum vapor pressure deficit',
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
              300.0,
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
      maximum: 2639.82,
      'gee:estimated_range': true,
    },
    tmean: {
      minimum: -30.8,
      maximum: 41.49,
      'gee:estimated_range': true,
    },
    tmin: {
      minimum: -35.11,
      maximum: 34.72,
      'gee:estimated_range': true,
    },
    tmax: {
      minimum: -29.8,
      maximum: 49.74,
      'gee:estimated_range': true,
    },
    tdmean: {
      minimum: -30.7,
      maximum: 26.76,
      'gee:estimated_range': true,
    },
    vpdmin: {
      minimum: 0.0,
      maximum: 44.79,
      'gee:estimated_range': true,
    },
    vpdmax: {
      minimum: 0.009,
      maximum: 110.06,
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
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    These PRISM datasets are available without restriction
    on use or distribution. PRISM Climate Group does request that the
    user give proper attribution and identify PRISM, where applicable,
    as the source of the data.
  |||,
}
