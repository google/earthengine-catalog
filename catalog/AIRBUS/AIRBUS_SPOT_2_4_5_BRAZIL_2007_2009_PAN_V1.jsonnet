local id = 'AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/PAN/V1';
local subdir = 'AIRBUS';
local version = 'V1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local swhp = import 'spot_world_heritage_programme.libsonnet';
local units = import 'units.libsonnet';
local access_note = importstr '../GOOGLE/includes/_BRAZIL_FOREST_2008_access_note.md';
local description = importstr 'AIRBUS_SPOT_2_4_5_BRAZIL_2007_2009_PAN_V1_description.md';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'SPOT Panchromatic Imagery 5-10m, Brazil',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: description + access_note,
  license: 'proprietary',
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://developers.google.com/earth-engine/datasets/catalog/Earth_Engine_SPOT_542_Datasets_License.pdf'),
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'google',
    'brazil',
    'forest-code',
    'imagery',
    'spot',
  ],
  providers: [
    ee.producer_provider('Google/CNES', 'https://developers.google.com/earth-engine/guides/spot_brazil_forest_imagery_dataset_2008_v1'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(xmin=-74, ymin=-34, xmax=-34, ymax=6, start='2007-01-01T00:00:00Z', end='2009-11-26T23:59:59Z'),
  summaries: {
    'gee:schema': swhp.pan_schema,
    gsd: [
      10,
    ],
    'eo:bands': [
      {
        name: 'P',
        description: 'Panchromatic',
        'gee:units': units.dn,
      },
    ],
    P: {minimum: 0, maximum: 255, 'gee:estimated_range': true},
    'gee:visualizations': [
      {
        display_name: 'Panchromatic',
        lookat: {lon: -55.0, lat: -10.0, zoom: 6},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [255],
            bands: ['P'],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': importstr 'spot_world_heritage_programme_terms_of_use.md',
}
