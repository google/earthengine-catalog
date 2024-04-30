local id = 'UK/NHM/BII/V1/2005';
local subdir = 'UK';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: 'Collection',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Biodiversity Intactness Index V1.',
  version: 'V1',
  // The collection contains tiles for a global mosaic.
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This is the data used to plot figure S4 in Newbold et al. (2016) “Has 
    land use pushed terrestrial biodiversity beyond the planetary boundary?
    A global assessment”, Science 353:288-29, doi 10.1126/science.aaf2201.
    The variable plotted, Biodiversity Intactness Index, is the modeled average
    abundance of originally-present species, relative to their abundance in an
    intact ecosystem. Please refer to Newbold et al. (2016) for all details, and
    please cite it when using these data.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'biodiversity',
    'conservation',
    'global',
    'landuse',
  ],
  providers: [
    ee.producer_provider(
      'Natural History Museum.',
      'https://doi.org/10.5519/0009936'
    ),
    ee.host_provider(self_ee_catalog_url)
  ],
  extent: ee.extent_global('2005-01-01T00:00:00Z', '2006-01-01T00:00:00Z'),
  'sci:citation': |||
    Tim Newbold; Lawrence Hudson; Andy Arnell; Sara Contu et al. (2016). Global
    map of the Biodiversity Intactness Index, from Newbold et al. (2016) 
    Science [Data set]. Natural History Museum.[https://doi.org/10.5519/0009936]
    (https://doi.org/10.5519/0009936),
  |||,

  'gee:terms_of_use': ee.gee_terms_of_use(license),

  summaries: {
    gsd: [
      925
    ],
    'gee:visualizations': [
      {
        display_name: 'Biodiversity Intactness Index',
        lookat: {
          lat: 0,
          lon: 0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              1
            ],
            max: [
              1
            ],
            bands: [
              'b1',
            ],
            palette: ['4d9221']
          },
        },
      },
    ],
    'eo:bands': [
      {
        name: 'b1',
        description: 'Biodiversity Intactness Index.',
      },
    ],
  },
}
