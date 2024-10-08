local id = 'UK/NHM/BII/V1';
local subdir = 'UK';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

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
  title: 'Biodiversity Intactness Index, V1',
  version: 'V1',
  // The collection contains tiles for a global mosaic.
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Biodiversity Intactness Index (BII) indicates the average abundance
    of a large, taxonomically, and ecologically diverse set of naturally-occurring
    species in a terrestrial area, relative to a baseline with minimal human
    impacts. BII was first proposed by Scholes & Biggs (2005). BII estimates the
    status of local terrestrial biodiversity; average BII is meaningful at any
    spatial scale, making it easy to estimate status and trends within any
    desired region (e.g. UN subregion, country or biome).

    BII was first estimated globally by Newbold et al. (2016) as part of the
    [PREDICTS project](www.nhm.ac.uk/our-science/research/projects/predicts.html)
    by combining models of overall abundance with models of abundance-based
    compositional similarity and global fine-scale (1km) estimates of land use
    and other pressures. The modelling framework has now been refined,
    especially for compositional similarity, improving the ability to detect human
    impacts on assemblage composition. This approach to BII estimation is
    discussed in detail by Purvis et al. (2018).

    BII is estimated based on statistical models of how local biodiversity
    responds to land use and related pressures, it can be projected for any
    past or future date for which estimates of pressures are available.
    As a result, BII can report not only on current status and recent
    trends (using observed data on pressures), but also on the longer history
    of biodiversity change; and it can be used for policy screening of scenarios.

    More information is available in the provider's
    [Dataset Description](https://www.bipindicators.net/indicators/biodiversity-intactness-index).

    Note:

    *   It is a global dataset, though at present, only data for the year 2005 is
        available.

  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'uk',
    'biodiversity',
    'conservation',
    'global',
  ],
  providers: [
    ee.producer_provider(
      'Biodiversity Intactness Index',
      'https://data.nhm.ac.uk/dataset/global-map-of-the-biodiversity-intactness-index-from-newbold-et-al-2016-science'
    ),
    ee.host_provider(self_ee_catalog_url)
  ],
  extent: ee.extent_global('2005-01-01T00:00:00Z','2005-01-01T00:00:00Z'),
  'sci:citation': |||
      Katia Sanchez-Ortiz; Ricardo E Gonzalez; Adriana De Palma;
      Tim Newbold et al. (2019). Global maps of Biodiversity Intactness Index
      (Sanchez-Ortiz et al., 2019 - bioRxiv ) [Data set].
      Natural History Museum. https://doi.org/10.5519/0000082
  |||,
  'gee:user_uploaded': true,
  'gee:terms_of_use': |||
      The data may be used for non commercial purpose by anyone, anywhere,
      anytime without permission, license or royalty payment.
      Attribution using the recommended citation is requested.
  |||,
  // There's only one year for now.
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  summaries: {
    gsd: [
      10
    ],
    'gee:visualizations': [
      {
        display_name: 'BII',
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
        description: 'Biodiversity Intactness Index',
        'gee:classes': [
          {
            value: 1,
            color: '4d9221',
            description: 'BII',
          },
        ]
      },
    ],
  },
}

