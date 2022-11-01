local id = 'SNU/ESL/BESS/Rad/v1';
local subdir = 'SNU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Breathing Earth System Simulator (BESS) Radiation v1',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Breathing Earth System Simulator (BESS) is a simplified process-based model
    that couples atmosphere and canopy radiative transfers, canopy photosynthesis,
    transpiration, and energy balance. It couples an atmospheric radiative transfer
    model and artificial neural network with forcings from MODIS atmospheric products
    to generate 5-km daily products.

    Publications:

    * Ryu Youngryel, Chongya Jiang, Hideki Kobayashi, Matteo Detto, MODIS-derived global land products of shortwave radiation and diffuse and total photosynthetically active radiation at 5km resolution from 2000.  Remote Sensing of Environment, Volume 204, 2018. [doi:10.1016/j.rse.2017.09.021](https://doi.org/10.1016/j.rse.2017.09.021)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://drive.google.com/drive/folders/1B2aSPkgnGsSdQx4XtX4H21O7tP6kq-pG',
    },
  ],
  keywords: [
    'evapotranspiration',
    'gpp',
    'modis_derived',
    'par',
    'radiation',
    'shortwave',
  ],
  providers: [
    ee.producer_provider('Seoul National University (SNU)', 'https://www.environment.snu.ac.kr/bess-rad'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      5500.0,
    ],
    'eo:bands': [
      {
        name: 'PAR_Daily',
        description: 'Surface downwelling photosynthetic radiative flux in air',
        'gee:units': 'W/m^2',
      },
      {
        name: 'PARdiff_Daily',
        description: 'Surface diffuse downwelling photosynthetic radiative flux in air',
        'gee:units': 'W/m^2',
      },
      {
        name: 'RSDN_Daily',
        description: 'Surface downwelling shortwave flux in air',
        'gee:units': 'W/m^2',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Surface downwelling photosynthetic radiative flux',
        lookat: {
          lon: 2.1,
          lat: 24.9,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              200.0,
            ],
            bands: [
              'PAR_Daily',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
