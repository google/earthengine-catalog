local id = 'AU/GA/DEM_1SEC/v10/DEM-S';
local subdir = 'AU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;
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
  title: 'DEM-S: Australian Smoothed Digital Elevation Model',
  version: '1.0',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Smoothed Digital Elevation Model (DEM-S) was derived
    from the SRTM data acquired by NASA in February 2000. DEM-S represents
    ground surface topography (excluding vegetation features) and has
    been smoothed to reduce noise and improve the representation of
    surface shape. An adaptive process applied more smoothing in flatter
    areas than hilly areas, and more smoothing in noisier areas than
    in less noisy areas.

    This DEM-S supports calculation of local terrain shape attributes
    such as slope, aspect, and curvature that could not be reliably
    derived from the unsmoothed 1 second DEM because of noise.

    There are several areas with unexpected negative values: close to
    Canberra around (150.443044, -35.355281) with values of -55 and in Western
    Australia around (124.84, -16.44) with -43.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  keywords: [
    'australia',
    'dem',
    'elevation',
    'ga',
    'geophysical',
    'geoscience_australia',
    'smoothed',
    'srtm',
  ],
  providers: [
    ee.producer_provider('Geoscience Australia', 'https://www.ga.gov.au/metadata-gateway/metadata/record/72759/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(112.99, -44.06, 154.0, -9.99,
                    '2010-02-01T00:00:00Z', '2010-02-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.92,
    ],
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': 'm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: -24.69,
          lon: 133.95,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              -10.0,
            ],
            max: [
              1300.0,
            ],
            palette: [
              '3ae237',
              'b5e22e',
              'd6e21f',
              'fff705',
              'ffd611',
              'ffb613',
              'ff8b13',
              'ff6e08',
              'ff500d',
              'ff0000',
              'de0101',
              'c21301',
              '0602ff',
              '235cb1',
              '307ef3',
              '269db1',
              '30c8e2',
              '32d3ef',
              '3be285',
              '3ff38f',
              '86e26f',
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
    elevation: {
      minimum: -73.31,
      maximum: 2224.32,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Geoscience Australia, 2015. Digital Elevation Model (DEM) of Australia
    derived from LiDAR 5 Metre Grid. Geoscience Australia, Canberra.
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution 4.0 International License.',
}
