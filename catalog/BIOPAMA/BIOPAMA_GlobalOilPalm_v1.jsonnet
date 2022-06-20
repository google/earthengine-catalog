local id = 'BIOPAMA/GlobalOilPalm/v1';
local subdir = 'BIOPAMA';

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
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Global Map of Oil Palm Plantations',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The dataset is a 10m global industrial and smallholder oil palm map for 2019.
    It covers areas where oil palm plantations were detected. The classified images are the output
    of a convolutional neural network based on Sentinel-1 and Sentinel-2 half-year composites.

    See [article](https://essd.copernicus.org/articles/13/1211/2021/) for additional information.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.4473715',
    },
  ],
  keywords: [
    'biodiversity',
    'biopama',
    'conservation',
    'crop',
    'global',
    'landuse',
    'oilpalm',
    'plantation',
  ],
  providers: [
    ee.producer_provider('Biopama programme', 'https://doi.org/10.5281/zenodo.4473715'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2019-01-01T00:00:00Z', '2019-12-31T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'classification',
        description: 'Oil Palm class description',
        gsd: 10.0,
        'gee:classes': [
          {
            value: 1,
            color: 'ff0000',
            description: 'Industrial closed-canopy oil palm plantations',
          },
          {
            value: 2,
            color: 'ef00ff',
            description: 'Smallholder closed-canopy oil palm plantations',
          },
          {
            value: 3,
            color: '696969',
            description: 'Other land covers and/or uses that are not closed-canopy oil palm.',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'classificationVis',
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              3.0,
            ],
            palette: [
              'ff0000',
              'ef00ff',
              '808080',
            ],
            bands: [
              'classification',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5281/zenodo.4473715',
  'sci:citation': |||
    Adrià, Descals, Serge, Wich, Erik, Meijaard, David, Gaveau, Stephen, Peedell, & Zoltan, Szantoi. (2021, January 27).
    High resolution global industrial and smallholder oil palm map for 2019 (Version v1). *Zenodo.*
    [doi:10.5281/zenodo.4473715](https://doi.org/10.5281/zenodo.4473715)
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution 4.0 International License.',
  'gee:user_uploaded': true,
}
