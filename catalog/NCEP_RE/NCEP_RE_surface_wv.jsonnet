local id = 'NCEP_RE/surface_wv';
local subdir = 'NCEP_RE';

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
  title: 'NCEP/NCAR Reanalysis Data, Water Vapor',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NCEP/NCAR Reanalysis Project is a joint project between the National
    Centers for Environmental Prediction (NCEP, formerly "NMC") and the
    National Center for Atmospheric Research (NCAR). The goal of this joint
    effort is to produce new atmospheric analyses using historical data as
    well as to produce analyses of the current atmospheric state (Climate Data
    Assimilation System, CDAS). The NCEP/NCAR Reanalysis 1 project is using a
    state-of-the-art analysis/forecast system to perform data assimilation using
    past data from 1948 to the present. The data have 6-hour temporal
    resolution (0000, 0600, 1200, and 1800 UTC) and 2.5 degree spatial
    resolution.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'atmosphere',
    'climate',
    'geophysical',
    'ncep',
    'noaa',
    'precipitable',
    'reanalysis',
    'vapor',
  ],
  providers: [
    ee.producer_provider('NCEP', 'https://www.esrl.noaa.gov/psd/data/gridded/data.ncep.reanalysis.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1948-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      278300.0,
    ],
    'eo:bands': [
      {
        name: 'pr_wtr',
        description: 'Total column water vapor',
        'gee:units': units.area_density,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Total Column Water Vapor',
        lookat: {
          lat: 2.81,
          lon: -158.2,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              60.0,
            ],
            palette: [
              '0000ff',
              '00ffff',
              '008000',
              'ffff00',
              'ff0000',
            ],
            bands: [
              'pr_wtr',
            ],
          },
        },
      },
    ],
    pr_wtr: {
      minimum: -8.2,
      maximum: 89.8,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Kalnay et al., 1996, The NCEP/NCAR 40-Year Reanalysis Project. Bull. Amer.
    Meteor. Soc., 77, 437-471.
    [doi:10.1175/1520-0477(1996)077<0437:TNYRP\\>2.0.CO;2](https://doi.org/10.1175/1520-0477(1996)077<0437:TNYRP>2.0.CO;2).
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 6,
  },
  'gee:terms_of_use': 'There are no restrictions on the use of these datasets.',
}
