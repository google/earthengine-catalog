local subdir = 'AHN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc0_1_0;
local self_ee_catalog_url(id) =
  ee_const.ee_catalog_url + std.strReplace(id, '/', '_');

{
  ahn_dataset(id, description_type, description_detail):: {
    stac_version: ee_const.stac_version,
    type: ee_const.stac_type.collection,
    stac_extensions: [
      ee_const.ext_eo,
    ],
    id: id,
    title: 'AHN Netherlands 0.5m DEM, ' + description_type,
    'gee:type': ee_const.gee_type.image,
    description: |||
      The AHN DEM is a 0.5m DEM covering the Netherlands. It was generated from
      LIDAR data taken in the spring between 2007 and 2012.

    ||| + description_detail,
    license: license.id,
    links: ee.standardLinks(subdir, id),
    keywords: [
      'ahn',
      'dem',
      'elevation',
      'geophysical',
      'lidar',
      'netherlands',
    ],
    providers: [
      ee.producer_provider('AHN', 'https://www.ahn.nl'),
      ee.host_provider(self_ee_catalog_url(id)),
    ],
    extent: ee.extent(3.35, 50.74, 7.24, 53.55,
                      '2012-01-01T00:00:00Z', '2012-01-01T00:00:00Z'),
    summaries: {
      gsd: [
        0.5,
      ],
      'eo:bands': [
        {
          name: 'elevation',
          description: 'Elevation',
          'gee:units': units.meter,
        },
      ],
      'gee:visualizations': [
        {
          display_name: 'Elevation',
          lookat: {
            lat: 53.4113,
            lon: 5.36785,
             zoom: 15,
          },
          image_visualization: {
            band_vis: {
              min: [
                -5.0,
              ],
              max: [
                30.0,
              ],
              bands: [
                'elevation',
              ],
            },
          },
        },
      ],
    },
    'gee:terms_of_use': |||
      The datasets of the AHN are available as Open Data.
      This means that the data can be used by anyone for free and without
      restrictions. For more information visit the
      [Open Data](https://www.ahn.nl/open-data/) page. Downloads are available
      under the terms of the
      [CC-0 license](https://data.overheid.nl/licenties-voor-hergebruik).
    |||,
  },
}
