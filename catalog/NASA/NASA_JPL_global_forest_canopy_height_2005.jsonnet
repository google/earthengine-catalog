local id = 'NASA/JPL/global_forest_canopy_height_2005';
local subdir = 'NASA';

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
  ],
  id: id,
  title: 'Global Forest Canopy Height, 2005',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This dataset represents global tree heights based on a fusion of
    spaceborne-lidar data (2005) from the Geoscience Laser Altimeter
    System (GLAS) and ancillary geospatial data. See
    [Simard et al. (2011)](https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2011JG001708)
    for details.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'canopy',
    'forest',
    'geophysical',
    'glas',
    'jpl',
    'nasa',
  ],
  providers: [
    ee.producer_provider('NASA/JPL', 'https://earthobservatory.nasa.gov'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2005-05-20T00:00:00Z', '2005-06-23T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: '1',
        description: 'Tree heights',
        'gee:units': units.meter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Forest Canopy Height',
        lookat: {
          lat: 28.3,
          lon: -28.1,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30.0,
            ],
            palette: [
              'ffffff',
              'fcd163',
              '99b718',
              '66a000',
              '3e8601',
              '207401',
              '056201',
              '004c00',
              '011301',
            ],
            bands: [
              '1',
            ],
          },
        },
      },
    ],
    '1': {
      minimum: 0.0,
      maximum: 73.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Simard, M., Pinto, N., Fisher, J., Baccini, A. 2011. Mapping forest
    canopy height globally with spaceborne lidar. Journal of Geophysical
    Research. 116: G04021.
    [doi:10.1029/2011JG001708](https://doi.org/10.1029/2011JG001708)
  |||,
  'gee:terms_of_use': |||
    Most materials published on the Earth Observatory, including images, are
    freely available for re-publication or re-use, including commercial
    purposes, except for where copyright is indicated.

    NASA's Earth Observatory must be given credit for its original materials;
    the only mandatory credit is NASA.

    For more information about using NASA imagery visit the [Earth Observatory
    Image Use Policy](https://earthobservatory.nasa.gov/ImageUse/) site.
  |||,
}
