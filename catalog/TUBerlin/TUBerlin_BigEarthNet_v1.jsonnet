local id = 'TUBerlin/BigEarthNet/v1';
local subdir = 'TUBerlin';
local version = '1';

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
  title: 'TUBerlin/BigEarthNet/v' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    BigEarthNet is a new large-scale Sentinel-2 benchmark archive, consisting of
    590,326 Sentinel-2 image patches.  To construct BigEarthNet, 125 Sentinel-2
    tiles were acquired between June 2017 and May 2018 over the 10 countries
    (Austria, Belgium, Finland, Ireland, Kosovo, Lithuania, Luxembourg,
    Portugal, Serbia, Switzerland) of Europe. All the tiles were atmospherically
    corrected by the Sentinel-2 Level 2A product generation and formatting tool
    (sen2cor).  Then, they were divided into 590,326 non-overlapping image
    patches. Each image patch was annotated by the multiple land-cover classes
    (i.e., multi-labels) that were provided from the CORINE Land Cover database
    of the year 2018 (CLC 2018).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'chip',
    'copernicus',
    'corine_derived',
    'label',
    'ml',
    'sentinel',
    'tile',
  ],
  providers: [
    ee.producer_provider('BigEarthNet', 'http://bigearth.net/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-9.0, 36.9, 31.6, 68.1,
                    '2017-06-01T00:00:00Z', '2018-05-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'labels',
        description: 'List of landcover types found in this image',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'source',
        description: 'Product ID of the corresponding Sentinel-2 1C image',
        type: ee_const.var_type.string,
      },
      {
        name: 'tile_x',
        description: 'X coordinate of tile in source image',
        type: ee_const.var_type.double,
      },
      {
        name: 'tile_y',
        description: 'Y coordinate of tile in source image',
        type: ee_const.var_type.double,
      },
    ],
    'eo:bands': [
      {
        name: 'B1',
        description: 'Aerosols',
        center_wavelength: 0.4439,
        gsd: 60.0,
        'gee:scale': 0.001,
        'gee:wavelength': '443.9nm (S2A) / 442.3nm (S2B)',
      },
      {
        name: 'B2',
        description: 'Blue',
        center_wavelength: 0.4966,
        gsd: 10.0,
        'gee:scale': 0.001,
        'gee:wavelength': '496.6nm (S2A) / 492.1nm (S2B)',
      },
      {
        name: 'B3',
        description: 'Green',
        center_wavelength: 0.56,
        gsd: 10.0,
        'gee:scale': 0.001,
        'gee:wavelength': '560nm (S2A) / 559nm (S2B)',
      },
      {
        name: 'B4',
        description: 'Red',
        center_wavelength: 0.6645,
        gsd: 10.0,
        'gee:scale': 0.001,
        'gee:wavelength': '664.5nm (S2A) / 665nm (S2B)',
      },
      {
        name: 'B5',
        description: 'Red Edge 1',
        center_wavelength: 0.7039,
        gsd: 20.0,
        'gee:scale': 0.001,
        'gee:wavelength': '703.9nm (S2A) / 703.8nm (S2B)',
      },
      {
        name: 'B6',
        description: 'Red Edge 2',
        center_wavelength: 0.7402,
        gsd: 20.0,
        'gee:scale': 0.001,
        'gee:wavelength': '740.2nm (S2A) / 739.1nm (S2B)',
      },
      {
        name: 'B7',
        description: 'Red Edge 3',
        center_wavelength: 0.7825,
        gsd: 20.0,
        'gee:scale': 0.001,
        'gee:wavelength': '782.5nm (S2A) / 779.7nm (S2B)',
      },
      {
        name: 'B8',
        description: 'NIR',
        center_wavelength: 0.8351,
        gsd: 10.0,
        'gee:scale': 0.001,
        'gee:wavelength': '835.1nm (S2A) / 833nm (S2B)',
      },
      {
        name: 'B9',
        description: 'Water vapor',
        center_wavelength: 0.945,
        gsd: 60.0,
        'gee:scale': 0.001,
        'gee:wavelength': '945nm (S2A) / 943.2nm (S2B)',
      },
      {
        name: 'B10',
        description: 'Cirrus',
        center_wavelength: 1.3735,
        gsd: 60.0,
        'gee:scale': 0.001,
        'gee:wavelength': '1373.5nm (S2A) / 1376.9nm (S2B)',
      },
      {
        name: 'B11',
        description: 'SWIR 1',
        center_wavelength: 1.6137,
        gsd: 20.0,
        'gee:scale': 0.001,
        'gee:wavelength': '1613.7nm (S2A) / 1610.4nm (S2B)',
      },
      {
        name: 'B12',
        description: 'SWIR 2',
        center_wavelength: 2.2024,
        gsd: 20.0,
        'gee:scale': 0.001,
        'gee:wavelength': '2202.4nm (S2A) / 2185.7nm (S2B)',
      },
      {
        name: 'B8A',
        description: 'Red Edge 4',
        center_wavelength: 0.8648,
        gsd: 20.0,
        'gee:scale': 0.001,
        'gee:wavelength': '864.8nm (S2A) / 864nm (S2B)',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lat: 48.27,
          lon: 16.66,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [3000],
            bands: ['B4', 'B3', 'B2'],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    G. Sumbul, M. Charfuelan, B. Demir, V. Markl, BigEarthNet: A Large-Scale
    Benchmark Archive for Remote Sensing Image Understanding, IEEE International
    Conference on Geoscience and Remote Sensing Symposium, pp. 5901-5904,
    Yokohama, Japan, 2019.
  |||,
  'gee:terms_of_use': |||
    The BigEarthNet Archive is licensed under the Community Data License
    Agreement - Permissive, Version 1.0.  For more information,
    please refer to the (http://bigearth.net/downloads/documents/License.pdf).
  |||,
}
