local id = 'Latvia/Maamet/orthos/rgb';
local subdir = 'Latvia';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  ],
  id: id,
  title: 'Latvia RGB orthophotos',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    In Latvia, orthophoto maps are prepared in the Latvian coordinate system
    LKS-92 TM according to the TKS-93 map sheet division (scale 1:10000 map
    sheet corresponds to 5 x 5 kilometers in nature). Orthophoto maps are
    prepared for the whole territory of Latvia at the scale of
    1:10000, but for separate territories - for cities and densely populated
    areas - at the scale of 1:2000 or 1:1000.

    The RGB dataset has three bands: red, green, and blue.

    For more information, please see the
    [Latvia orthophotos documentation](https://www.lgia.gov.lv/lv/ortofotokartes-1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'latvia',
    'orthophoto',
    'rgb',
  ],
  providers: [
    ee.producer_provider(
      'Latvia orthophotos', 'https://www.lgia.gov.lv/lv/ortofotokartes-1'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(55.5, 20.5, 58.5, 28.6,
                    '2007-01-01T00:00:00Z', '2018-01-01T00:00:00Z'),
  summaries: {
    gsd: [0.2],
    'eo:bands': [
      {name: 'R', description: 'Red', 'gee:units': units.dn},
      {name: 'G', description: 'Green', 'gee:units': units.dn},
      {name: 'B', description: 'Blue', 'gee:units': units.dn}
    ],
    R: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    G: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    B: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    'gee:visualizations': [{
      display_name: 'RGB',
      lookat: {lon: 56.861, lat: 24.737, zoom: 18},
      image_visualization: {
        band_vis: {min: [0], max: [255], bands: ['R', 'G', 'B']}}}],
  },
  'sci:citation': 'Latvijas Geospatial Information Agency',
  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n' +
  |||
    For more details please see the
    [Terms of use](https://www.lgia.gov.lv/sites/lgia/files/document/Atverto%20datu%20licence%20CC%20BY_0.pdf)
  |||
}
