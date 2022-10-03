local id = 'projects/planet-nicfi/assets/basemaps/americas';
local subdir = 'planet-nicfi';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Planet & NICFI Basemaps for Tropical Forest Monitoring - Tropical Americas',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This image collection provides access to high-resolution satellite
    monitoring of the tropics for the primary purpose of reducing and reversing the
    loss of tropical forests, contributing to combating climate change, conserving
    biodiversity, contributing to forest regrowth, restoration and enhancement, and
    facilitating sustainable development, all of which must be Non-Commercial Use.

    To learn how to access the Basemaps, follow the
    [sign up instructions here](https://developers.planet.com/docs/integrations/gee/nicfi/).

    NICFI mosaics contain both monthly and biannual collections.
    (Biannual collections are generated every 6 months.)  The type of
    the mosaic is stored in the image metadata field 'cadence'. Use that
    field along with the start and end date for each mosaic to find
    the desired imagery.

    Full details about the Basemaps are available in
    [Planet's NICFI Basemap spec](https://assets.planet.com/docs/NICFI_Basemap_Spec_Addendum.pdf).

    For more information about NICFI (Norway's International Climate
    and Forest Initiative) and the NICFI Basemaps,
    [see the FAQ](https://assets.planet.com/docs/NICFI_General_FAQs.pdf).

    In support of NICFI's mission, you can use this data for a number of projects including, but not limited to:

    * Advance scientific research about the world's tropical forests and the critical services they provide.
    * Implement and improve policies for sustainable forest management and land use in developing tropical forest countries and jurisdictions.
    * Increase transparency and accountability in the tropics.
    * Protect and improve the rights of indigenous peoples and local communities in tropical forest countries.
    * Innovate solutions towards reducing pressure on forests from global commodities and financial markets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.license,
      href: 'https://assets.planet.com/docs/Planet_ParticipantLicenseAgreement_NICFI.pdf',
      type: ee_const.media_type.pdf,
    },
  ],
  keywords: [
    'basemaps',
    'forest',
    'nicfi',
    'planet',
    'sr',
    'surface_reflectance',
    'tropics',
  ],
  providers: [
    ee.producer_provider('Planet', 'https://planet.com/nicfi'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-118.5, -30.4, -34.5, 30.4,
                    '2015-12-01T00:00:00Z', '2021-06-29T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'cadence',
        description: 'The interval the mosaic covers: monthly or biannual',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4.77,
    ],
    'eo:bands': [
      {
        name: 'B',
        description: 'Blue',
        'gee:scale': 0.0001,
      },
      {
        name: 'G',
        description: 'Green',
        'gee:scale': 0.0001,
      },
      {
        name: 'R',
        description: 'Red',
        'gee:scale': 0.0001,
      },
      {
        name: 'NIR',
        description: 'Near-infrared',
        'gee:scale': 0.0001,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True color',
        lookat: {
          lon: -51.0,
          lat: 30.2,
          zoom: 4,
        },
        image_visualization: {
          global_vis: {
            min: [
              64.0,
            ],
            max: [
              5454.0,
            ],
            gamma: [
              1.855,
            ],
            bands: [
              'R',
              'G',
              'B',
            ],
          },
        },
      },
    ],
    B: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    G: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    R: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    NIR: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Planet Team (2017). Planet Application Program Interface: In Space for Life
    on Earth. San Francisco, CA. [https://api.planet.com](https://api.planet.com)
  |||,
  'gee:terms_of_use': |||
    This data has usage, reproduction, and distribution restrictions in support
    of the NICFI Forest Monitoring Purpose. The full licensing agreement is available
    [here](https://assets.planet.com/docs/Planet_ParticipantLicenseAgreement_NICFI.pdf).
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
  'gee:user_owned': true,
}
