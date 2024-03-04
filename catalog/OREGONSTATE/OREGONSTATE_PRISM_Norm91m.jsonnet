local id = 'OREGONSTATE/PRISM/Norm91m';
local subdir = 'OREGONSTATE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';
local prism = import 'OREGONSTATE_PRISM_Norm.libsonnet';

local version_config = versions(subdir, prism.versions, id);
local version = version_config.version;

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
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'PRISM Long-Term Average Climate Dataset Norm91m',
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
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(prism.license_link)
  ] + version_config.version_links,
  keywords: [
    '30_year',
    'climate',
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
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-125.0, 24.0, -66.0, 50.0,
                    '1991-01-01T00:00:00Z', '2020-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'PRISM_DATASET_CREATE_DATE',
        description: |||
          List of original creation dates for each band, e.g:
          the first element is for the first band "ppt", the second element
          is for the second band "tmean"
        |||,
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_TYPE',
        description: 'List of dataset types per-band',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_CODE_VERSION',
        description: 'List of code versions per-band',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'PRISM_DATASET_FILENAME',
        description: 'List of original filenames per-band',
        type: ee_const.var_type.string_list,
      },
    ],
    gsd: [
      928,
    ],
    'eo:bands': [
      {
        name: 'ppt',
        description: '30-year average of monthly total precipitation (including rain and melted snow)',
        'gee:units': units.millimeter,
      },
      {
        name: 'tmean',
        description: '30-year average of monthly mean temperature (calculated as (tmin+tmax)/2)',
        'gee:units': units.celsius,
      },
      {
        name: 'tmin',
        description: '30-year average of monthly minimum temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'tmax',
        description: '30-year average of monthly maximum temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'tdmean',
        description: '30-year average of monthly mean dew point temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'vpdmin',
        description: '30-year average of monthly minimum vapor pressure deficit',
        'gee:units': units.hectopascal,
      },
      {
        name: 'vpdmax',
        description: '30-year average of monthly maximum vapor pressure deficit',
        'gee:units': units.hectopascal,
      },
      {
        name: 'solclear',
        description: |||
          30-year average of monthly global shortwave solar radiation
          received on a horizontal surface under clear sky conditions
        |||,
        'gee:units': 'MJ m^-2 day^-1',
      },
      {
        name: 'solslope',
        description: |||
          30-year average of monthly global shortwave solar radiation
          received on a sloped surface
        |||,
        'gee:units': 'MJ m^-2 day^-1',
      },
      {
        name: 'soltotal',
        description: |||
          30-year average of monthly global shortwave solar
          radiation received on a horizontal surface
        |||,
        'gee:units': 'MJ m^-2 day^-1',
      },
      {
        name: 'soltrans',
        description: '30-year average of atmospheric transmittance (cloudiness)',
        'gee:units': units.unspecified_fraction,
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
      minimum: 0.03,
      maximum: 1046.09,
      'gee:estimated_range': true,
    },
    tmean: {
      minimum: -16.15,
      maximum: 37.88,
      'gee:estimated_range': true,
    },
    tmin: {
      minimum: -21.9,
      maximum: 29.79,
      'gee:estimated_range': true,
    },
    tmax: {
      minimum: -10.78,
      maximum: 46.63,
      'gee:estimated_range': true,
    },
    tdmean: {
      minimum: -19.07,
      maximum: 25.22,
      'gee:estimated_range': true,
    },
    vpdmin: {
      minimum: 0.0,
      maximum: 33.11,
      'gee:estimated_range': true,
    },
    vpdmax: {
      minimum: 0.37,
      maximum: 94.11,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Daly, C., Halbleib, M., Smith, J.I., Gibson, W.P., Doggett, M.K.,
    Taylor, G.H., Curtis, J., and Pasteris, P.A. 2008. Physiographically-sensitive
    mapping of temperature and precipitation across the conterminous
    United States. International Journal of Climatology, 28: 2031-2064
    [doi:10.1002/joc.1688](https://doi.org/10.1002/joc.1688)
    [pdf](https://www.prism.oregonstate.edu/documents/pubs/2008intjclim_physiographicMapping_daly.pdf).
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
    type: 'climatological_interval',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    These PRISM datasets are available without restriction
    on use or distribution. PRISM Climate Group does request that the
    user give proper attribution and identify PRISM, where applicable,
    as the source of the data.
    [%(license_link)s](%(license_link)s)
  ||| % {license_link: prism.license_link},
}
