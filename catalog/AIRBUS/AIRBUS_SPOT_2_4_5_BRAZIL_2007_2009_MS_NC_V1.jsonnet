local id = 'AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS_NC/V1';
local subdir = 'AIRBUS';
local version = 'V1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local swhp = import 'spot_world_heritage_programme.libsonnet';
local units = import 'units.libsonnet';
local access_note = importstr '../GOOGLE/includes/_BRAZIL_FOREST_2008_access_note.md';
local google_mods = importstr '../GOOGLE/includes/_BRAZIL_SPOT_google_mods.md';
local description = importstr 'AIRBUS_SPOT_2_4_5_BRAZIL_2007_2009_MS_NC_V1_description.md';

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
  title: 'Airbus SPOT Multispectral Pseudo Natural Color (MS_NC) Imagery 10-20m, Brazil',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'beta',
  description:
    description +
    google_mods +
    access_note,
  license: 'proprietary',
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://developers.google.com/earth-engine/datasets/catalog/Earth_Engine_SPOT_542_Datasets_License.pdf'),
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'airbus',
    'brazil',
    'forest-code',
    'rgb',
    'spot',
  ],
  providers: [
    ee.producer_provider('Airbus / CNES', 'https://regards.cnes.fr/html/swh/Home-swh3.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(xmin=-74, ymin=-34, xmax=-34, ymax=6, start='2007-01-01T00:00:00Z', end='2009-11-26T23:59:59Z'),
  summaries: {
    'gee:schema': swhp.ms_nc_schema,
    gsd: [
      20,
    ],
    'eo:bands': [
      {
        name: 'R',
        description: 'Red reflectance',
        'gee:units': units.dn,
      },
      {
        name: 'G',
        description: 'Green reflectance',
        'gee:units': units.dn,
      },
      {
        name: 'B',
        description: 'Blue reflectance, representing the synthetic blue channel of the pseudo-natural color product for SPOT 2, 4, and 5',
        'gee:units': units.dn,
      },
      {
        name: 'cloud_mask',
        description: 'Cloud mask: 0 = cloud/shadow, 1 = clear',
      },
    ],
    R: {minimum: 0, maximum: 255, 'gee:estimated_range': true},
    G: {minimum: 0, maximum: 255, 'gee:estimated_range': true},
    B: {minimum: 0, maximum: 255, 'gee:estimated_range': true},
    cloud_mask: { minimum: 0, maximum: 1, 'gee:estimated_range': false },
    'gee:visualizations': [
      {
        display_name: 'Natural Color RGB',
        lookat: {lon: -55.0, lat: -10.0, zoom: 6},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [255],
            bands: ['R', 'G', 'B'],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': importstr 'spot_world_heritage_programme_terms_of_use.md',
}
