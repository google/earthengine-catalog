local id = 'UMD/GLAD/PRIMARY_HUMID_TROPICAL_FORESTS/v1';
local subdir = 'UMD';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

// gee:terms_of_use is non-standard.
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
  title: 'Primary Humid Tropical Forests',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Primary humid tropical forests provide numerous global ecosystem services,
    but are under continuing threat of clearing from economic drivers. To facilitate
    national land use planning and balancing the goals of economic development and
    maintenance of ecosystem services, a primary humid tropical forest map was
    created by the UMD GLAD team. The primary forest extent was mapped
    for the year 2001 at a spatial resolution of 30 meters using globally acquired,
    free-of-charge, and consistently processed Landsat imagery.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['forest-biomass'],
  keywords: [
    'forest',
    'glad',
    'global',
    'landsat_derived',
    'umd',
  ],
  providers: [
    ee.producer_provider('UMD/GLAD', 'https://glad.umd.edu/dataset/primary-forest-humid-tropics'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', '2002-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'Primary_HT_forests',
        description: 'Primary Humid Tropical Forests',
        'gee:classes': [
          {
            value: 1,
            color: '008000',
            description: 'Primary Humid Tropical Forests',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Primary HT forests',
        lookat: {
          lon: 20.39,
          lat: -0.85,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              '008000',
            ],
            bands: [
              'Primary_HT_forests',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Turubanova S., Potapov P., Tyukavina, A., and Hansen M. (2018) Ongoing primary forest
    loss in Brazil, Democratic Republic of the Congo, and Indonesia. Environmental
    Research Letters.
    [https://doi.org/10.1088/1748-9326/aacd1c](https://doi.org/10.1088/1748-9326/aacd1c)
  |||,
  'gee:terms_of_use': |||
    The data may be used by anyone, anywhere, anytime without permission,
    license or royalty payment.
    Attribution using the recommended citation is requested.
  |||,
  'gee:user_uploaded': true,
}
