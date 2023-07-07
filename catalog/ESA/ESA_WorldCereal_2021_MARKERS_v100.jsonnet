local worldcereal = import 'worldcereal.libsonnet';
local worldcereal_index = importstr 'worldcereal.md';

local id = 'ESA/WorldCereal/2021/MARKERS/v100';
local subdir = 'ESA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local self_ee_catalog_url = worldcereal.link(id).href;

{
  'gee:skip_indexing': true,
  'gee:user_uploaded': true,

  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver
  ],
  id: id,
  title: 'ESA WorldCereal Active Cropland 10 m v' + worldcereal.v100,
  version: worldcereal.v100,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The European Space Agency (ESA) WorldCereal Active Cropland 10 m 2021
    product suite contains global-scale seasonal active cropland markers. They
    were generated as part of the
    [ESA-WorldCereal project](https://esa-worldcereal.org/). The active cropland
    products indicate whether or not a pixel identified as temporary crops has
    been actively cultivated during a specific growing season. In order for a
    pixel to be labeled as “active” during a particular growing season, a full
    crop growth cycle (sowing, growing, senescence and harvesting) needs to take
    place within the designated time period. Note that this active marker is not
    crop-type specific. Any crop grown (slightly) outside the predefined growing
    seasons will not be flagged as active cropland in any of the seasons covered
    by the WorldCereal system. The active marker results from running a growing
    season detection algorithm [1] on the Sentinel-2 derived enhanced vegetation
    index (EVI). More information on the methodology used to generate these
    products is described in [2].

    This collection contains up to 106 agro-ecological zone (AEZ) images per
    crop season, where each AEZ has its own seasonality. The seasons for which
    the active cropland marker is available are described in the list below and
    were developed in [3] as part of the project.

    WorldCereal seasons description:
    - tc-wintercereals: the main cereals season defined in an AEZ
    - tc-springcereals: optional springcereals season, only defined in certain
    AEZ
    - tc-maize-main: the main maize season defined in an AEZ
    - tc-maize-second: optional second maize season, only defined in certain AEZ

    Each product (image) has a binary classification band where value 0
    corresponds to inactive cropland and value 100 corresponds to active
    cropland.

    The collection should be filtered using one or more of the following image
    properties:
    - aez_id, holding the ID of the AEZ to which the image belongs
    - season, describing the season for which the image is valid.

    References:

    - [1] Bolton, D. K., Gray, J. M., Melaas, E. K., Moon, M., Eklundh, L., and
    Friedl, M. A.: Continental-scale land surface phenology from harmonized
    Landsat 8 and Sentinel-2 imagery, Remote Sens. Environ., 240, 111685,
    https://doi.org/10.1016/j.rse.2020.111685, 2020.
    - [2] [WorldCereal methodology and products paper](https://doi.org/10.5194/essd-2023-184)
    - [3] [WorldCereal global seasonality paper](https://doi.org/10.1080/15481603.2022.2079273)

  ||| + worldcereal_index,
  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference)
  ],
  keywords: [
    'agriculture', 'copernicus', 'crop', 'esa', 'global', 'landcover',
    'landsat', 'sentinel1_derived', 'sentinel2_derived'
  ],
  providers: [
    ee.producer_provider(
      'ESA WorldCereal Consortium',
      'https://esa-worldcereal.org/en'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', '2021-12-31T23:59:59Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'aez_id',
        description: |||
          ID of the agro-ecological zone (AEZ) to which the product belongs.
        |||,
        type: ee_const.var_type.int
      },
      {
        name: 'product',
        description: 'WorldCereal product name.',
        type: ee_const.var_type.string,
      },
      {
        name: 'season',
        description: 'Season for which the product is valid.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [10],
    'eo:bands': [
      {
        name: 'classification',
        description: 'Classification: 0 or 100'
      },
    ],
    classification: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'WorldCereal active cropland marker',
        lookat: {lon: -98.987, lat: 38.045, zoom: 11},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            bands: ['classification'],
            palette: ['eb0000', '37e622']
          }
        },
      },
    ],
  },
  'sci:doi': worldcereal.doi_v100,
  'sci:citation': worldcereal.citation_v100,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
