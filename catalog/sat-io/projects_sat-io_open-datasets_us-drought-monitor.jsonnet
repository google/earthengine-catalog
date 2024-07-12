local id = 'projects/sat-io/open-datasets/us-drought-monitor';
local subdir = 'sat-io';

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
  ],
  id: id,
  title: 'United States Drought Monitor',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The U.S. Drought Monitor is a map released every Thursday, showing parts of the U.S. that are in drought. The map uses five classifications: abnormally dry (D0), showing areas that may be going into or are coming out of drought, and four levels of drought: moderate (D1), severe (D2), extreme (D3) and exceptional (D4). The Drought Monitor has been a team effort since its inception in 1999, produced jointly by the National Drought Mitigation Center (NDMC) at the University of Nebraska-Lincoln, the National Oceanic and Atmospheric Administration (NOAA), and the U.S. Department of Agriculture (USDA). The NDMC hosts the web site of the drought monitor and the associated data, and provides the map and data to NOAA, USDA and other agencies. It is freely available at droughtmonitor.unl.edu.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'drought',
    'ndmc',
    'noaa',
    'usda',
  ],
  providers: [
    ee.producer_provider('National Drought Mitigation Center', 'https://drought.unl.edu/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-04T00:00:00Z', null),
  summaries: {
    gsd: [
      250,
    ],
    'eo:bands': [
      {
        name: 'b1',
        description: 'Drought classes',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'USDM Drought Classes',
        lookat: {
          lat: 39.648,
          lon: -100.576,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
               0.0,
            ],
            max: [
              4,
            ],
            bands: [
              'b1',
            ],
            palette:["FFFF00","FCD37F", "FFAA00","E60000", "730000"],
          },
        },
      },
    ],
    b1: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation':|||
      National Drought Mitigation Center; U.S. Department of Agriculture; National Oceanic and Atmospheric Administration (2023). United States Drought Monitor. University of Nebraska-Lincoln. https://droughtmonitor.unl.edu/. Accessed 2023-09-17
  |||,
  'gee:terms_of_use': |||
      The work is licensed under an Open data license for use. The U.S. Drought Monitor is jointly produced by the National Drought Mitigation Center
      at the University of Nebraska-Lincoln, the United States Department of Agriculture and the National Oceanic and Atmospheric Administration. Map courtesy of NDMC.
  |||,
}
