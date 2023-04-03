local id = 'NOAA/NCEP_DOE_RE2/total_cloud_coverage';
local subdir = 'NOAA';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'NCEP-DOE Reanalysis 2 (Gaussian Grid), Total Cloud Coverage',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    NCEP-DOE Reanalysis 2 project is using a state-of-the-art analysis/forecast system to perform
    data assimilation using past data from 1979 through the previous year.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'atmosphere',
    'climate',
    'cloud',
    'geophysical',
    'ncep',
    'noaa',
    'reanalysis',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://psl.noaa.gov/data/gridded/data.ncep.reanalysis2.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1979-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      278300.0,
    ],
    'eo:bands': [
      {
        name: 'tcdc',
        description: 'Total cloud cover',
        'gee:units': units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Total Cloud Coverage',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'black',
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'tcdc',
            ],
          },
        },
      },
    ],
    tcdc: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    [NCEP-DOE AMIP-II Reanalysis (R-2): M. Kanamitsu, W. Ebisuzaki, J. Woollen, S-K Yang,
    J.J. Hnilo, M. Fiorino, and G. L. Potter. 1631-1643, Nov 2002, Bulletin of the American
    Meteorological Society.](https://journals.ametsoc.org/view/journals/bams/83/11/bams-83-11-1631.xml).
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 6,
  },
  'gee:terms_of_use': 'There are no restrictions on the use of these datasets.',
}
