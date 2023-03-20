local id = 'OSU/GIMP/2000_ICE_OCEAN_MASK';
local subdir = 'OSU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'Greenland Ice & Ocean Mask - Greenland Mapping Project (GIMP)',
  version: '2.0',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This dataset provides complete land ice and ocean
    classification masks at 15 m for the Greenland ice sheet.
    Ice cover was mapped using
    a combination of orthorectified panchromatic (band 8)
    imagery from the Landsat 7 Enhanced Thematic Mapper
    Plus (ETM+), distributed by the USGS, and RADARSAT-1
    Synthetic Amplitude Radar (SAR) amplitude images produced
    and distributed by I. Joughin at the Applied Physics
    Laboratory, University of Washington.

    The Landsat imagery was acquired for the months of July
    through September in 1999, 2000 and 2001 (mostly 2000)
    and the RADARSAT imagery was acquired in fall of 2000.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/B8X58MQBFUPA',
    },
  ],
  keywords: [
    'arctic',
    'gimp',
    'greenland',
    'ice',
    'mask',
    'nasa',
    'polar',
  ],
  providers: [
    ee.producer_provider('NASA NSIDC DAAC at CIRES', 'https://doi.org/10.5067/B8X58MQBFUPA'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-89.3211593425295, 58.79601275381146, 7.555941634834938, 83.95386175580668,
                    '1999-06-30T00:00:00Z', '2002-09-04T00:00:00Z'),
  summaries: {
    gsd: [
      15.0,
    ],
    'eo:bands': [
      {
        name: 'ocean_mask',
        description: 'Ocean mask',
        'gee:classes': [
          {
            color: '000000',
            description: 'all other terrain',
            value: 0,
          },
          {
            value: 1,
            color: '0000FF',
            description: 'ocean',
          },
        ],
      },
      {
        name: 'ice_mask',
        description: 'Ice mask',
        'gee:classes': [
          {
            color: '000000',
            description: 'not glacier ice',
            value: 0,
          },
          {
            value: 1,
            color: 'FFFFFF',
            description: 'glacier ice',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Ocean and Ice Mask',
        lookat: {
          lat: 74.0,
          lon: -41.0,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            bands: [
              'ice_mask',
              'ice_mask',
              'ocean_mask',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/B8X58MQBFUPA',
  'sci:citation': |||
    Howat, I.M., A. Negrete, B.E. Smith, 2014, The Greenland Ice
    Mapping Project (GIMP) land classification and surface elevation
    datasets, The Cryosphere, 8, 1509-1518,
    [doi:10.5194/tc-8-1509-2014](https://doi.org/10.5194/tc-8-1509-2014)
    [article pdf](https://www.the-cryosphere.net/8/1509/2014/tc-8-1509-2014.pdf)
  |||,
  'gee:terms_of_use': |||
    As a condition of using these data, you must cite the use of this
    data set using the given citation.
  |||,
}
