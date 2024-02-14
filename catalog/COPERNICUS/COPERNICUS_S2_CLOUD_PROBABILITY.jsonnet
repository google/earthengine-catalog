local id = 'COPERNICUS/S2_CLOUD_PROBABILITY';
local subdir = 'COPERNICUS';

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
  ],
  id: id,
  title: 'Sentinel-2: Cloud Probability',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The S2 cloud probability is created with the
    [sentinel2-cloud-detector](https://github.com/sentinel-hub/sentinel2-cloud-detector)
    library (using [LightGBM](https://github.com/microsoft/LightGBM)).
    All bands are upsampled using bilinear interpolation to 10m resolution
    before the gradient boost base algorithm is applied.  The resulting
    `0..1` floating point probability is scaled to `0..100` and stored as
    a UINT8.  Areas missing any or all of the bands are masked out.
    Higher values are more likely to be clouds or highly reflective surfaces
    (e.g. roof tops or snow).

    Sentinel-2 is a wide-swath, high-resolution, multi-spectral
    imaging mission supporting Copernicus Land Monitoring studies,
    including the monitoring of vegetation, soil and water cover,
    as well as observation of inland waterways and coastal areas.

    The Level-2 data can be found in the collection
    [COPERNICUS/S2_SR](COPERNICUS_S2_SR).  The Level-1B data can be found in the collection
    [COPERNICUS/S2](COPERNICUS_S2).  Additional metadata is available on assets in those
    collections.

    See
    [this tutorial](https://developers.google.com/earth-engine/tutorials/community/sentinel-2-s2cloudless)
    explaining how to apply the cloud mask.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'cloud',
    'copernicus',
    'esa',
    'eu',
    'msi',
    'radiance',
    'sentinel',
    'sentinelhub',
  ],
  providers: [
    ee.producer_provider('European Union/ESA/Copernicus/SentinelHub', 'https://sentinel.esa.int/web/sentinel/user-guides/sentinel-2-msi/processing-levels/level-1'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -56.0, 180.0, 83.0, '2015-06-27T00:00:00Z', null),
  summaries: {
    platform: [
      'Sentinel-2A',
      'Sentinel-2B',
    ],
    instruments: [
      'MSI',
    ],
    'eo:bands': [
      {
        name: 'probability',
        description: 'Probability that the pixel is cloudy.',
        gsd: 10.0,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lat: 51.4191,
          lon: 4.1968,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            bands: [
              'probability',
            ],
          },
        },
      },
    ],
    probability: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 5,
  },
  'gee:terms_of_use': |||
    The use of Sentinel data is governed by the [Copernicus
    Sentinel Data Terms and Conditions.](https://scihub.copernicus.eu/twiki/pub/SciHubWebPortal/TermsConditions/Sentinel_Data_Terms_and_Conditions.pdf)
  |||,
}
