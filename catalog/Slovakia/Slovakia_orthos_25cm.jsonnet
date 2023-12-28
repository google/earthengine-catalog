local id = 'Slovakia/orthos/25cm';
local subdir = 'Slovakia';

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
  title: 'Slovakia orthophotos',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Orthophotomosaic of the Slovak Republic is a set of color orthoimages
    without overlaps, gaps and visible brightness and color differences along
    the connecting lines.

    For more information, please see the
    [Slovakia orthophotos documentation](https://www.geoportal.sk/files/zbgis/orto/technicka_sprava_ortofotomozaika_sr_2017-2019.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'orthophoto',
    'rgb',
    // 'slovakia'
  ],
  providers: [
    ee.producer_provider(
      'Slovakia orthophotomosaic',
      'https://www.geoportal.sk/en/zbgis/orthophotomosaic/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(47.44, 16.5, 49.36, 22.33,
                    '2017-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [0.25],
    'eo:bands': [
      {name: 'R', description: 'Red', 'gee:units': units.dn},
      {name: 'G', description: 'Green', 'gee:units': units.dn},
      {name: 'B',  description: 'Blue', 'gee:units': units.dn}
    ],
    R: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    G: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    B: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    'gee:visualizations': [{
      display_name: 'Slovakia orthophotos RGB',
      lookat: {lon: 48.8, lat: 19.2, zoom: 18},
      image_visualization: {
        band_vis: {min: [0], max: [255], bands: ['R', 'G', 'B']}}}],
  },
  'sci:citation': 'GKU Bratislava, NLC',
  'gee:terms_of_use': |||
    The User is entitled to combine the Source Data with other data, use it in
    the creation of his/her own work for commercial and non-commercial purposes,
    create a new work, publish the work on the Internet, publish the Source Data
    as a base map, publish the Source Data in connection with other
    data/thematic layers through web apps. The User is obliged to provide the
    name of the Author of the Source Data when creating his/her own work and
    when publishing it as follows: "GK&Uacute; Bratislava, NLC".

    For more details, see [Terms of use](
       https://www.geoportal.sk/files/zbgis/orto/licencne_podmienky_orto.zip)
  |||
}
