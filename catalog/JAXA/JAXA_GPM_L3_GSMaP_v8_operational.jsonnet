local id = 'JAXA/GPM_L3/GSMaP/v8/operational';
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
  title: 'GSMaP Operational: Global Satellite Mapping of Precipitation - V8',
  version: 'v8',
  'gee:type': ee_const.gee_type.image_collection,
  description: gsmap.description_header + |||
    This dataset is processed by GSMaP algorithm version 8 (product version 5).
    See [GSMaP Technical Documentation](https://www.eorc.jaxa.jp/GPM/doc/product/format/en/07.GPM_GSMaP_Product_Format_V5_E.pdf)
    for more details.
  ||| + gsmap.description_footer,
  license: gsmap.license,
  links: ee.standardLinks(subdir, id),
  keywords: gsmap.keywords,
  providers: gsmap.providers + [ee.host_provider(self_ee_catalog_url)],
  extent: ee.extent(-180.0, -60.0, 180.0, 60.0, '1998-01-01T00:00:00Z', null),
  summaries: {
    // StartGranuleDateTime and StopGranuleDateTime are excluded from v8
    'gee:schema': gsmap.schema[0:4:1] + [gsmap.schema[6]],
    gsd: gsmap.gsd,
    'eo:bands': gsmap.bands,
    'gee:visualizations': gsmap.visualizations,
  } + gsmap.bands_range,
  'sci:citation': gsmap.citation,
  'sci:doi': gsmap.doi,
  'gee:interval': gsmap.interval,
  'gee:terms_of_use': gsmap.terms_of_use,
}
