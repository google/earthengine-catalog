local id = 'JAXA/GPM_L3/GSMaP/v6/operational';
local subdir = 'JAXA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local gsmap = import 'templates/JAXA_GPM_L3_GSMaP.libsonnet';

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
  title: 'GSMaP Operational: Global Satellite Mapping of Precipitation - V6',
  version: 'v6',
  'gee:type': ee_const.gee_type.image_collection,
  description: gsmap.description_header + |||
    This dataset is processed by GSMaP algorithm version 6 (product version 3).
    See [GSMaP Technical Documentation](https://www.eorc.jaxa.jp/GPM/doc/product/format/en/07.GPM_GSMaP_Product_Format_V5_E.pdf)
    for more details.
  ||| + gsmap.description_footer,
  license: gsmap.license,
  links: ee.standardLinks(subdir, id),
  keywords: gsmap.keywords,
  providers: gsmap.providers + [ee.host_provider(self_ee_catalog_url)],
  extent: gsmap.extent,
  summaries: {
    'gee:schema': gsmap.schema,
    gsd: gsmap.gsd,
    'eo:bands': gsmap.bands,
    'gee:visualizations': gsmap.visualizations,
  } + gsmap.bands_range,
  'sci:citation': gsmap.citation,
  'sci:doi': gsmap.doi,
  'gee:interval': gsmap.interval,
  'gee:terms_of_use': gsmap.terms_of_use,
}
