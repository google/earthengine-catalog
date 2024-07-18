local id = 'projects/sat-io/open-datasets/GLOBathy/GLOBathy_bathymetry';
local subdir = 'sat-io';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc0_1_0;

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
  title: 'GLOBathy Global lakes bathymetry dataset',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The GLObal Bathymetric (GLOBathy) dataset, comprising data on over 1.4 million waterbodies globally, has been meticulously developed to harmonize with the widely recognized HydroLAKES dataset. Utilizing a sophisticated Geographic Information System (GIS)-based framework, GLOBathy constructs detailed bathymetric maps by integrating maximum depth estimates and geometric/geophysical attributes sourced from HydroLAKES. Ensuring data accuracy and reliability, GLOBathy undergoes stringent validation procedures involving 1,503 waterbodies and a diverse range of observed data sources. Consequently, GLOBathy stands as a robust and comprehensive dataset for hydrography and aquatic sciences, offering invaluable resources for researchers and professionals in these fields.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'bathymetry',
    'hydrology',
    'lake',
  ],
  providers: [
    ee.producer_provider('Bahram Khazaei', 'https://springernature.figshare.com/articles/dataset/GLOBathy_Bathymetry_Rasters/13404635'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-01-26T00:00:00Z', '2022-01-26T23:59:00Z'),
  summaries: {
    gsd: [
      30,
    ],
    'eo:bands': [
      {
        name: 'b1',
        description: 'Maximum depth',
        'gee:units': units.meter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Globathy Global lakes bathymetry dataset',
        lookat: {
          lat: 48.2875,
          lon: 31.175,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
               0.0,
            ],
            max: [
              1548.53,
            ],
            bands: [
              'b1',
            ],
            palette:["001219", "005f73", "0a9396", "94d2bd", "e9d8a6", "ee9b00", "ca6702", "bb3e03", "ae2012", "9b2226"],
          },
        },
      },
    ],
    b1: {
      minimum: 0.0,
      maximum: 1548.53,
      'gee:estimated_range': true,
    },
  },
  'sci:citation':|||
        Khazaei, Bahram; Read, Laura K; Casali, Matthew; Sampson, Kevin M; Yates, David N (2022): GLOBathy Bathymetry Rasters. figshare. Dataset. https://doi.org/10.6084/m9.figshare.c.5243309.v1
  |||,
  'sci:doi': '10.6084/m9.figshare.c.5243309.v1',
  'gee:terms_of_use': |||
    The dataset is released under an assumed CC0 1.0 Universal (CC0 1.0) Public Domain Dedication. The organizations responsible for generating and funding this dataset make no representations of any kind including, but not limited to the warranties of merchantability or fitness for a particular use, nor are any such warranties to be implied with respect to the data.
  |||,
}
