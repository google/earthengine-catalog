local id = 'USGS/LIMA/SR';
local subdir = 'USGS';

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
  title: 'Landsat Image Mosaic of Antarctica (LIMA) - Processed Landsat Scenes (16 bit)',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Landsat Image Mosaic of Antarctica (LIMA) is a seamless
    and virtually cloudless mosaic created from processed
    Landsat 7 ETM+ scenes.

    Processed Landsat Scenes (16 bit) are Level 1Gt NLAPS
    scenes converted to 16 bit, processed with sun-angle
    correction, and converted to reflectance values
    ([Bindschadler 2008](https://lima.usgs.gov/LIMA_paper.pdf)).

    Each Landsat scene is processed with elevation
    data and sun-angle correction to ensure surface features
    were accurately represented. The sun's angle in Antarctica
    gives the appearance of a setting sun. Because of the low
    sun angle, as Landsat passes over Antarctica, the outer
    edges of the continent appear brighter than areas closer
    to the South Pole, so scenes have bright and dark areas.
    Inconsistent sun angles and shadows where corrected for
    these scenes. Without this process, mosaicking would produce
    a patchwork of scenes since each scene would have a brighter
    and a darker side.

    Users can find individual image metadata available as a table at:
    [USGS/LIMA/SR_METADATA](USGS_LIMA_SR_METADATA)
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
    'eo:bands': [
      {
        name: 'B1',
        description: 'Blue',
        center_wavelength: 0.485,
        gsd: 30.0,
        'gee:wavelength': '0.45 - 0.52 &mu;m',
      },
      {
        name: 'B2',
        description: 'Green',
        center_wavelength: 0.56,
        gsd: 30.0,
        'gee:wavelength': '0.52 - 0.60 &mu;m',
      },
      {
        name: 'B3',
        description: 'Red',
        center_wavelength: 0.66,
        gsd: 30.0,
        'gee:wavelength': '0.63 - 0.69 &mu;m',
      },
      {
        name: 'B4',
        description: 'Near infrared',
        center_wavelength: 0.835,
        gsd: 30.0,
        'gee:wavelength': '0.77 - 0.90 &mu;m',
      },
      {
        name: 'B5',
        description: 'Shortwave infrared 1',
        center_wavelength: 1.65,
        gsd: 30.0,
        'gee:wavelength': '1.55 - 1.75 &mu;m',
      },
      {
        name: 'B7',
        description: 'Shortwave infrared 2',
        center_wavelength: 2.215,
        gsd: 30.0,
        'gee:wavelength': '2.08 - 2.35 &mu;m',
      },
      {
        name: 'B8',
        description: 'Panchromatic',
        center_wavelength: 0.71,
        gsd: 15.0,
        'gee:wavelength': '0.52 - 0.90 &mu;m',
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
