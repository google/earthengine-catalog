local subdir = 'AHN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc0_1_0;
local self_ee_catalog_url(id) =
  ee_const.ee_catalog_url + std.strReplace(id, '/', '_');

{
  ahn_dataset(id, title, description_detail, extent_from, extent_to):: {
    stac_version: ee_const.stac_version,
    type: ee_const.stac_type.collection,
    stac_extensions: [
      ee_const.ext_eo,
    ],
    id: id,
    title: title,
    'gee:type': ee_const.gee_type.image_collection,
    description: |||
      The Actueel Hoogtebestand Nederland (AHN) is a dataset with detailed and
      precise elevation data for the whole of the Netherlands. Elevation
      information was collected from helicopters and aircraft using laser
      technology with vertical accuracy of 5 cm.

    ||| + description_detail + |||

      The Digital Terrain Model (DTM) product represents the elevation of the
      ground, while the Digital Surface Model (DSM) product represents the
      elevation of the tallest surfaces at that point.
    |||,
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
    extent: ee.extent(3.35, 50.74, 7.24, 53.55, extent_from, extent_to),
    summaries: {
      gsd: [
        0.5,
      ],
      'eo:bands': [
        {
          name: 'dtm',
          description: 'Elevation of the ground',
          'gee:units': units.meter,
        },
        {
          name: 'dsm',
          description: 'Elevation of the tallest surfaces at that point',
          'gee:units': units.meter,
        },
      ],
      'gee:visualizations': [
        {
          display_name: 'AHN Netherlands',
          lookat: {
            lat: 52.39,
            lon: 4.78,
             zoom: 12,
          },
          image_visualization: {
            band_vis: {
              min: [
                0.0,
              ],
              max: [
                30.0,
              ],
              bands: [
                'dsm',
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
