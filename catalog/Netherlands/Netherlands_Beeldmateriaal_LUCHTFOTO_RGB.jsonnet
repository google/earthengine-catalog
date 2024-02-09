local id = 'Netherlands/Beeldmateriaal/LUCHTFOTO_RGB';
local subdir = 'Netherlands';

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
  title: 'Netherlands orthophotos',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Orthophotos of Netherlands is a set of color orthoimages. Two nationwide
    aerial photographs are collected per year: a leafless image at 7.5 cm
    resolution in the spring and one with leaves on trees at 25 cm resolution
    in the summer.

    For more information, please see the
    [Netherlands orthophotos documentation](https://opendata.beeldmateriaal.nl/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'orthophoto',
    'rgb',
    'netherlands'
  ],
  providers: [
    ee.producer_provider(
      'Beeldmateriaal Nederland',
      'https://opendata.beeldmateriaal.nl/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(50.75, 3.2, 53.7, 7.22,
                    '2021-01-01T00:00:00Z', '2022-12-31T00:00:00Z'),
  summaries: {
    gsd: [0.08],
    'eo:bands': [
      {name: 'R', description: 'Red', 'gee:units': units.dn},
      {name: 'G', description: 'Green', 'gee:units': units.dn},
      {name: 'B',  description: 'Blue', 'gee:units': units.dn}
    ],
    R: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    G: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    B: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    'gee:visualizations': [{
      display_name: 'Netherlands orthophotos RGB',
      lookat: {lon: 51.88, lat: 5.54, zoom: 18},
      image_visualization: {
        band_vis: {min: [0], max: [255], bands: ['R', 'G', 'B']}}}],
  },
  'sci:citation': 'opendata.beeldmaterial.nl',
  'gee:terms_of_use': |||
    The images are made available with a CC BY 4.0 license. The user is required
    to add a reference to the datasource as "opendata.beeldmaterial.nl".
  |||
}
