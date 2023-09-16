local id = 'JRC/GHSL/P2023A/GHS_BUILT_C';
local subdir = 'JRC';

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
  title: 'GHSL: Global Human Settlement Layers, Built-Up Characteristics 2018 (P2023A)',
  version: 'P2023A',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The GHS-BUILT-C spatial raster dataset delineates the boundaries of the
    human settlements at 10m pixel size and describes their inner
    characteristics in terms of the morphology of the built environment and the
    functional use.

    The Morphological Settlement Zone (MSZ) delineates the spatial domain of all
    the human settlements at the neighboring scale of approx. 100m, based on the
    spatial generalization of the built-up surface fraction (BUFRAC) function.
    The objective is to fill the open spaces that are surrounded by large
    patches of built space. MSZ, open spaces, and built spaces basic class
    abstractions are derived by mathematical morphology spatial filtering
    (opening, closing, regional maxima) from the BUFRAC function.

    The Global Human Settlement Layer (GHSL) project is supported by the
    European Commission, Joint Research Center, and Directorate-General for
    Regional and Urban Policy.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'built',
    'builtup',
    'ghsl',
    'jrc',
    'landsat_derived',
  ],
  providers: [
    ee.producer_provider('EC JRC', 'https://ghsl.jrc.ec.europa.eu/ghs_buC2023.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-01-01T00:00:00Z', '2018-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      10.0,
    ],
    'eo:bands': [
      {
        name: 'built_characteristics',
        description: 'Multitemporal Built-up Characteristics',
        'gee:classes': [
          {
            value: 1,
            color: '718c6c',
            description: 'open spaces, low vegetation surfaces',
          },
          {
            value: 2,
            color: '8ad86b',
            description: 'open spaces, medium vegetation surfaces',
          },
          {
            value: 3,
            color: 'c1ffa1',
            description: 'open spaces, high vegetation surfaces',
          },
          {
            value: 4,
            color: '01b7ff',
            description: 'open spaces, water surfaces',
          },
          {
            value: 5,
            color: 'ffd501',
            description: 'open spaces, road surfaces',
          },
          {
            value: 11,
            color: 'd28200',
            description: 'built spaces, residential, building height <= 3m',
          },
          {
            value: 12,
            color: 'fe5900',
            description: 'built spaces, residential, 3m < building height <= 6m',
          },
          {
            value: 13,
            color: 'ff0101',
            description: 'built spaces, residential, 6m < building height <= 15m',
          },
          {
            value: 14,
            color: 'ce001b',
            description: 'built spaces, residential, 15m < building height <= 30m',
          },
          {
            value: 15,
            color: '7a000a',
            description: 'built spaces, residential, building height > 30m',
          },
          {
            value: 21,
            color: 'ff9ff4',
            description: 'built spaces, non-residential, building height <= 3m',
          },
          {
            value: 22,
            color: 'ff67e4',
            description: 'built spaces, non-residential, 3m < building height <= 6m',
          },
          {
            value: 23,
            color: 'f701ff',
            description: 'built spaces, non-residential, 6m < building height <= 15m',
          },
          {
            value: 24,
            color: 'a601ff',
            description: 'built spaces, non-residential, 15m < building height <= 30m',
          },
          {
            value: 25,
            color: '6e00fe',
            description: 'built spaces, non-residential, building height > 30m',
          },
        ], 
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Multitemporal Built-up Characteristics',
        lookat: {
          lat: 68.99,
          lon: 39.94,
          zoom: 13,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'built_characteristics',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Pesaresi M., P. Panagiotis (2023):
    GHS-BUILT-C R2023A - GHS Settlement Characteristics, derived from Sentinel2
    composite (2018) and other GHS R2023A data.European Commission, Joint
    Research Centre (JRC)
    PID: http://data.europa.eu/89h/3c60ddf6-0586-4190-854b-f6aa0edc2a30
    [doi:10.2905/3c60ddf6-0586-4190-854b-f6aa0edc2a30](https://doi.org/10.2905/3c60ddf6-0586-4190-854b-f6aa0edc2a30)
  |||,
  'sci:doi': '10.2905/3c60ddf6-0586-4190-854b-f6aa0edc2a30',
  'gee:terms_of_use': |||
    The GHSL has been produced by the EC JRC as open and free data. Reuse is
    authorised, provided the source is acknowledged. For more information,
    please read the use conditions ([European Commission Reuse and Copyright
    Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
}