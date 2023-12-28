local id = 'NASA/GSFC/MERRA/aer_nv/2';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local bands_info = import 'NASA_GSFC_MERRA_aer_nv_2.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MERRA-2 M2I3NVAER: Aerosol Mixing Ratio V5.12.4',
  version: 'V5.12.4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    M2I3NVAER (or inst3_3d_aer_Nv) is an instantaneous 3-dimensional 3-hourly
    data collection in Modern-Era Retrospective analysis for Research and
    Applications version 2 (MERRA-2). This collection consists of assimilations
    of aerosol mixing ratio parameters at 72 model layers, such as dust, sulphur
    dioxide, sea salt, black carbon, and organic carbon. The data field is
    available every three hour starting from 00:00 UTC, e.g.: 00:00, 03:00,...
    ,21:00 UTC. Section 4.2 of the
    [MERRA-2 File Specification document](https://gmao.gsfc.nasa.gov/pubs/docs/Bosilovich785.pdf)
    provides
    pressure values nominal for a 1000 hPa surface pressure and refers to the
    top edge of the layer. The lev=1 is for the top layer, and lev=72 is for
    the bottom (or surface) model layer.

    MERRA-2 is the latest version of global atmospheric reanalysis for the
    satellite era produced by NASA Global Modeling and Assimilation Office
    (GMAO) using the Goddard Earth Observing System Model (GEOS) version 5.12.4.
    The dataset covers the period of 1980-present with the latency of ~3 weeks
    after the end of a month.
  |||,
  license: license.id,
  links:  ee.standardLinks(subdir, id) + [
    ee.link.license(
    'https://earthdata.nasa.gov/collaborate/open-data-services-and-software/data-information-policy'
    ),
  ],
  keywords: [
    'aerosol',
    'dust',
    'mass',
    'merra',
    'nasa',
    'sea_salt',
    'so2',
    'so4',
  ],
  providers: [
    ee.producer_provider('NASA/MERRA', 'https://disc.gsfc.nasa.gov/datasets/M2I3NVAER_5.12.4/summary'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1980-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      69375,
      55000
    ],
    'eo:bands': [
      {
        name: band.name + '_' + index,
        description: band.description,
        'gee:units': band.units,
      }
      for index in std.range(1, 72)
      for band in bands_info.multi_layer_bands
    ] + [
      {
        name: band.name,
        description: band.description,
      }
      for band in bands_info.single_layer_bands
    ],
    'gee:visualizations': [
      {
        display_name: 'pressure thickness',
        lookat: {
          lat: 39.91,
          lon: -95.62,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              1194.9099111470955,
            ],
            max: [
              1749.3213800941699,
            ],
            palette: [
              '001137',
              '01abab',
              'e7eb05',
              '620500',
            ],
            bands: [
              'DELP_72',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 3,
  },
  'gee:terms_of_use': |||
    NASA promotes the full and open sharing of all data with research and
    applications communities, private industry, academia, and the general
    public.
  |||
}
