local id = 'projects/ee-earth-timelapse/assets/annual';
local subdir = 'ee-earth-timelapse';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;
local version = 'v0';

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
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'Earth Timelapse ' + version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Earth Timelapse dataset provides a four-decade visual record of
    planetary change spanning from 1984 to 2022. Synthesized by Google from
    petabytes of spaceborne observations acquired by NASA/USGS Landsat missions
    (Landsat 4, 5, 7, 8, and 9) and ESA's Copernicus Sentinel-2 constellation,
    the dataset is offered as annual mosaics for visual interpretation.

    The annual mosaics are globally complete, gap-filled, and water-masked
    visual basemaps that power the public Google Earth Timelapse interactive
    viewer. Pre-1999 observation voids are smoothly reconstructed using
    pixel-wise temporal linear regression interpolation across adjacent
    valid observation years. Open ocean waters are replaced with styled
    NOAA ETOPO1 shaded-relief bathymetry and global water masking (using Hansen
    GFC and MOD44W datasets). These data are suitable for: visual
    interpretation, educational storytelling, base mapping, or custom video
    exports.

    See [the Timelapse developer documentation](https://developers.google.com/earth-engine/timelapse/about)
    for more details on data characteristics, processing, and limitations.

  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'change',
    'copernicus',
    'global',
    'google',
    'landsat',
    'sentinel',
  ],
  providers: [
    ee.producer_provider(
      'Google Earth Outreach',
      'https://earthengine.google.com/timelapse/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1984-01-01T00:00:00Z', '2022-12-31T23:59:59Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: 'Observation year of the annual mosaic.',
        type: ee_const.var_type.int,
      },
    ],
    'eo:bands': [
      {
        name: 'red',
        description: |||
          Red value in 8-bits.
        |||,
      },
      {
        name: 'green',
        description: |||
          Green value in 8-bits.
        |||,
      },
      {
        name: 'blue',
        description: |||
          Blue value in 8-bits.
        |||,
      },
    ],
    gsd: [
      19.11,
      30.0,
    ],
    red: { minimum: 0, maximum: 255, 'gee:estimated_range': false },
    green: { minimum: 0, maximum: 255, 'gee:estimated_range': false },
    blue: { minimum: 0, maximum: 255, 'gee:estimated_range': false },
    'gee:visualizations': [
      {
        display_name: 'Earth Timelapse Natural Color',
        lookat: { lon: -7, lat: 7, zoom: 6 },
        image_visualization: {
          band_vis: {
            bands: ['red', 'green', 'blue'],
            min: [0],
            max: [255],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Google Earth Timelapse (Google, Landsat, Copernicus). [Online](https://developers.google.com/earth-engine/timelapse/about)
  |||,
  'gee:terms_of_use': |||
    This work is licensed under a Creative Commons Attribution 4.0 International License.

    Contains modified Copernicus Sentinel data [2015-present]. See the
    [Sentinel Data Legal Notice](https://sentinels.copernicus.eu/documents/247904/690755/Sentinel_Data_Legal_Notice).
  |||,
}

