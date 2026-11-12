local id = 'JAXA/GPM_L3/GSMaP/v9/operational';
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
  title: 'GSMaP Operational: Global Satellite Mapping of Precipitation - V9',
  version: 'v9',
  'gee:type': ee_const.gee_type.image_collection,
  description: gsmap.description_header + |||
    This dataset is processed by GSMaP algorithm version 9 (product version 6),
    which migrated distribution to NetCDF4 and expanded spatial coverage from
    60S-60N to global 90S-90N (using NEXRA/JRA-3Q water vapor above 60 degrees
    latitude).
    See [GSMaP Technical Documentation](https://www.eorc.jaxa.jp/GPM/doc/product/format/en/07.GPM_GSMaP_Product_Format_V6_E.pdf)
    for more details.
  ||| + gsmap.description_footer,
  license: gsmap.license,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['precipitation'],
  keywords: gsmap.keywords,
  providers: gsmap.providers + [ee.host_provider(self_ee_catalog_url)],
  extent: ee.extent_global('2026-10-16T00:00:00Z', null),
  summaries: {
    // StartGranuleDateTime and StopGranuleDateTime are excluded from v9
    'gee:schema': gsmap.schema[0:4:1] + [gsmap.schema[6]],
    gsd: gsmap.gsd,
    'eo:bands': gsmap.bands_v9,
    'gee:visualizations': gsmap.visualizations,
  } + gsmap.bands_range,
  'sci:citation': gsmap.citation,
  'sci:doi': gsmap.doi,
  'gee:interval': gsmap.interval,
  'gee:terms_of_use': gsmap.terms_of_use,
}
