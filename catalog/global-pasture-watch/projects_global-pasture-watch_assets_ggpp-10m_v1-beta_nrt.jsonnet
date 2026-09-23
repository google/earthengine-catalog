local id = 'projects/global-pasture-watch/assets/ggpp-10m/v1-beta/nrt';
local subdir = 'global-pasture-watch';
local version = '1-beta';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local ugpp10m_v1beta = importstr 'ugpp-10m_v1-beta.md';
local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Time2Graze daily uncalibrated Gross Primary Productivity (uGPP) v' + version,
  version: version,
  description: |||
    This dataset provides near-real-time, daily uncalibrated Gross Primary
    Productivity (uGPP) at 10-m spatial resolution, computed from Sentinel-2
    and VIIRS within the MOD17 light use efficiency lineage.
  ||| + ugpp10m_v1beta,
  'gee:categories': ['plant-productivity'],
  keywords: [
    'vegetation',
    'land',
    'landcover',
    'landuse',
    'global',
  ],
  'gee:user_uploaded': true,
  'gee:status': 'beta',
  providers: [
    ee.producer_provider('Land and Carbon Lab Global Pasture Watch', 'https://landcarbonlab.org/data/global-grassland-and-livestock-monitoring'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2026-06-27T00:00:00Z', null),
  summaries: {
    'eo:bands': [
      {
        name: 'ugpp',
        description: 'Daily uncalibrated gross primary productivity in grams of carbon per square meter per day (gC/m^2/day). Stored as 16-bit integers scaled by 10 (multiply by 0.1 to obtain gC/m^2/day); the no-data value is -1.',
        gsd: 10,
        'gee:scale': 0.1,
        'gee:units': 'gC m-2 d-1',
      }
    ],
    ugpp: {minimum: 0, maximum: 20, 'gee:estimated_range': true},
    'gee:visualizations': [
      {
        display_name: 'uGPP value',
        lookat: {lon: -55.50, lat: -12.20, zoom: 8},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [20],
            palette: [
              'faccfa',
              'f19d6b',
              '828232',
              '226061',
              '011959',
            ],
            bands: ['ugpp'],
          }
        },
      }
    ],
    'gee:schema': [
      {
        name: 'version',
        description: 'Product version',
        type: ee_const.var_type.double
      },
      {
        name: 'tile',
        description: 'Sentinel-2 Military Grid Reference System (MGRS) tile identifier',
        type: ee_const.var_type.string
      },
    ],
  },

  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'sci:publications': [
    {
      citation: |||
        Isik MS, Parente L, Consoli D, et al. (2025).
        Light use efficiency (LUE) based bimonthly gross primary
        productivity (GPP) for global grasslands at 30 m spatial
        resolution (2000–2022), PeerJ.
        [doi: https://doi.org/10.7717/peerj.19774](https://doi.org/10.7717/peerj.19774)
      |||,
      doi: '10.7717/peerj.19774',
    },
    {
      citation: |||
        Isik MS, Parente L, Sloat L, Krizan J, Čmelar K, Ferreira LG. (2026).
        A Semi-Empirical Method for Estimating All-Sky Photosynthetically Active
        Radiation from Sentinel-2 for High-Resolution Land Surface Analysis.
        Remote Sensing, 18(16), 2745.
        [doi: https://doi.org/10.3390/rs18162745](https://doi.org/10.3390/rs18162745)
      |||,
      doi: '10.3390/rs18162745',
    },
  ],
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
