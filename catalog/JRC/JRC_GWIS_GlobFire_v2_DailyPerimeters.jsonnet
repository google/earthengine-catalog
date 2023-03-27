local id = 'JRC/GWIS/GlobFire/v2/DailyPerimeters';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GlobFire Daily Fire Event Detection Based on MCD64A1',
  version: 'v2',
  'gee:type': ee_const.gee_type.table_collection,
  description: |||
    Fire boundaries based on the MODIS dataset MCD64A1. The data were computed
    based on an algorithm that relies on encoding in a graph structure
    a space-time relationship among patches of burned areas.

    Each fire has a unique number identifying the event.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
   ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://gwis-globfire.s3.amazonaws.com/',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.1038/s41597-019-0312-2',
    },
  ],
  keywords: [
    'area',
    'burnt',
    'disaster',
    'fire',
    'globfire',
    'mcd64a1',
    'modis_derived',
    'wildfire',
  ],
  providers: [
    ee.producer_provider('European Commission, Joint Research Centre, Global Wildfire Information System', 'https://doi.org/10.1038/s41597-019-0312-2'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'Id',
        description: 'Numeric id of the fire',
        type: ee_const.var_type.int,
      },
      {
        name: 'InitialDate',
        description: 'Initial fire date in milliseconds since 1970-01-01',
        type: ee_const.var_type.int,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Countries',
        lookat: {
          lat: 38.56,
          lon: -122.121,
          zoom: 12,
        },
        polygon_visualization: {
          property_name: 'area',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              600000000.0,
            ],
            palette: [
              'f5ff64',
              'b5ffb4',
              'beeaff',
              'ffc0e8',
              '8e8dff',
              'adadad',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.1038/s41597-019-0312-2',
  'sci:citation': |||
    Artés, T., Oom, D., De Rigo, D., Durrant, T. H., Maianti, P., Libertà, G., &
    San-Miguel-Ayanz, J. (2019). A global wildfire dataset for the analysis of
    fire regimes and fire behaviour. Scientific data, 6(1), 1-11.
    [doi:10.1038/s41597-019-0312-2](https://doi.org/10.1038/s41597-019-0312-2)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
