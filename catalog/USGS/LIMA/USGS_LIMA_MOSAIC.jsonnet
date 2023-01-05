local id = 'USGS/LIMA/MOSAIC';
local subdir = 'USGS/LIMA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

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
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Landsat Image Mosaic of Antarctica (LIMA) 16-Bit Pan-Sharpened Mosaic',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Landsat Image Mosaic of Antarctica (LIMA) is a seamless
    and virtually cloudless mosaic created from processed
    Landsat 7 ETM+ scenes.

    This LIMA dataset is the 16-bit Intermediate LIMA.
    The mosaic consists of pan-sharpened normalized surface reflectance
    scenes (Landsat ETM+ bands 1, 2, 3, and 4). The mosaic was
    constructed by ordering cloud free images on top and trimming
    image boundaries when tile discontinuities occurred.

    Users can find the mosaic tile footprints available at:
    [USGS/LIMA/MOSAIC_TILE_FOOTPRINTS](https://code.earthengine.google.com/?asset=USGS/LIMA/MOSAIC_TILE_FOOTPRINTS)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'antarctica',
    'ice',
    'landsat_derived',
    'lima',
    'mosaic',
    'sr',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://lima.usgs.gov/index.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -90.0, 180.0, -55.0,
                    '1999-06-30T00:00:00Z', '2002-09-04T00:00:00Z'),
  summaries: {
    gsd: [15],
    'eo:bands': [
      {
        name: 'B1',
        description: 'Blue',
        center_wavelength: 0.485,
        'gee:wavelength': '0.45 - 0.52 &mu;m',
      },
      {
        name: 'B2',
        description: 'Green',
        center_wavelength: 0.56,
        'gee:wavelength': '0.52 - 0.60 &mu;m',
      },
      {
        name: 'B3',
        description: 'Red',
        center_wavelength: 0.66,
        'gee:wavelength': '0.63 - 0.69 &mu;m',
      },
      {
        name: 'B4',
        description: 'Near infrared',
        center_wavelength: 0.835,
        'gee:wavelength': '0.77 - 0.90 &mu;m',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Antarctica',
        lookat: {
          lat: -77.99,
          lon: 164.619,
          zoom: 7,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              10000.0,
            ],
            bands: [
              'B3',
              'B2',
              'B1',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Bindschadler, R., Vornberger, P., Fleming, A., Fox, A., Mullins, J.,
    Binnie, D., Paulson, S., Granneman, B., and Gorodetzky, D., 2008,
    The Landsat Image Mosaic of Antarctica, Remote Sensing of
    Environment, 112, pp. 4214-4226.
    [PDF](https://lima.usgs.gov/LIMA_paper.pdf)
  |||,
  'gee:terms_of_use': |||
    These images are in the public domain and can be used freely
    and without acknowledgement. However, credit to the Landsat
    Image Mosaic of Antarctica (LIMA) Project is greatly appreciated.
  |||,
}
