local id = 'Germany/Brandenburg/orthos/20cm';
local subdir = 'Germany';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
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
  title: 'Brandenburg (Germany) RGBN orthophotos 20 cm',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Orthophotos are an aerial photo dataset covering the Brandenburg state of
    Germany.
    This data is provided by State government of
    Brandenburg ([LGB](https://geobasis-bb.de/lgb/de/)).
    Digital orthophotos are digitally corrected aerial photos and show all
    objects that are visible from the air at the time of recording in a parallel
    perspective. They have a high density of information on ecological,
    phenological, geographical and other topics.

    For more information, please see the
    [Brandenburg orthophotos documentation](https://geobasis-bb.de/lgb/de/geodaten/luftbilder/luftbilder-aktuell/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'brandenburg',
    'germany',
    'orthophoto',
    'rgbn',
  ],
  providers: [
    ee.producer_provider(
    'Brandenburg orthophotos',
    'https://geobasis-bb.de/lgb/de/geodaten/luftbilder/luftbilder-aktuell'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(51.28, 11.0, 53.7, 15.0,
                    '2021-08-23T00:00:00Z', '2023-01-20T00:00:00Z'),
  /*
    listing the first and last filenames from which we deduced the date range
    dop_33404-5690.tif 2021-08-23
    dop_33414-5858.tif 2023-01-20
  */
  summaries: {
    gsd: [
      0.2,
    ],
    'eo:bands': [
      {
        name: 'N',
        description: 'Near infrared',
      },
      {
        name: 'R',
        description: 'Red',
      },
      {
        name: 'G',
        description: 'Green',
      },
      {
        name: 'B',
        description: 'Blue',
      }
    ],
    'gee:visualizations': [
        {
        display_name: 'RGB',
        lookat: {
          lat: 13.4,
          lon: 52.5,
          zoom: 18,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              255
            ],
            bands: [
              'R',
              'G',
              'B',
            ],
          },
        },
      },
      {
        display_name: 'NRG',
        lookat: {
          lat: 13.4,
          lon: 52.5,
          zoom: 18,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              255,
            ],
            bands: [
              'N',
              'R',
              'G',
            ],
          },
        },
      },
    ],
    N: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    R: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    G: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': 'Data License Germany - Attribution - Version 2.0',
  'gee:terms_of_use': |||
    The user must ensure that the source note contains the following
    information:

      1. the name of the provider,
      2. the annotation "Data licence Germany - attribution - Version 2.0" or
         "dl-de/by-2-0" referring to the licence text available at
         www.govdata.de/dl-de/by-2-0, and
      3. a reference to the dataset (URI).
    This applies only if the entity keeping the data provides the pieces of
    information 1-3 for the source note.

    Changes, editing, new designs or other amendments must be marked as such
    in the source note.

    For more details please see the
    [Terms of use](https://www.govdata.de/dl-de/by-2-0)
  |||,
  // TODO(sanketagrawal): reupload into a public folder and remove this
  'gee:user_uploaded': true,
}
