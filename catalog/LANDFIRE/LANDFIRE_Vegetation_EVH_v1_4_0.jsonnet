local id = 'LANDFIRE/Vegetation/EVH/v1_4_0';
local subdir = 'LANDFIRE';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LANDFIRE EVH (Existing Vegetation Height) v1.4.0',
  version: '1.4.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    LANDFIRE (LF), Landscape Fire and Resource Management Planning Tools, is a
    shared program between the wildland fire management programs of the U.S.
    Department of Agriculture's Forest Service, U.S. Department of the Interior's
    Geological Survey, and The Nature Conservancy.

    LANDFIRE (LF) layers are created using predictive landscape models based on
    extensive field-referenced data, satellite imagery and biophysical gradient
    layers using classification and regression trees.

    Existing Vegetation Height (EVH) represents the average height of the dominant vegetation for a 30-m cell.
    Canopy height is generated separately for tree, shrub, and herbaceous lifeforms using training data and other geospatial layers. EVH is determined by the average height weighted by species cover and based on the Existing Vegetation Type (EVT) lifeform.

    * Decision tree models using field reference data, lidar, Landsat, and ancillary data are developed separately for each lifeform. Decision tree relationships are used to generate lifeform specific height class layers, which are merged into a single composite EVH layer.

    * Disturbance data were used to develop LF Remap products for LFRDB plot filtering and to ensure 2015 and 2016 disturbances were included that were not visible in the source imagery.

    * The EVC product is then reconciled through QA/QC measures to ensure life-form is synchronized with both Existing Vegetation Cover and EVT products.

    LF uses EVH in several subsequent layers, including the development of the fuel products.

    The LANDIFRE Vegetation datasets include:

    * Biophysical Settings (BPS)
    * Environmental Site Potential (ESP)
    * Existing Vegetation Canopy Cover (EVC)
    * Existing Vegetation Height (EVH).
    * Existing Vegetation Type (EVT)
    These layers are created using predictive landscape models based on extensive
    field-referenced data, satellite imagery and biophysical gradient layers using
    classification and regression trees.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'doi',
    'fire',
    'landfire',
    'nature_conservancy',
    'usda',
    'usgs',
    'vegetation',
    'wildfire',
  ],
  providers: [
    ee.producer_provider("U.S. Department of Agriculture's (USDA), U.S. Forest Service (USFS), U.S.
Department of the Interior's Geological Survey (USGS), and The Nature Conservancy.", 'https://landfire.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-175.1, 17.52, -63.66, 71.48,
                    '2014-09-01T00:00:00Z', '2014-09-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'EVH_classes',
        description: 'Class values of the Existing Vegetation Height.',
        type: ee_const.var_type.double,
      },
      {
        name: 'EVH_names',
        description: 'Descriptive names of the Existing Vegetation Height.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'EVH',
        description: 'Existing Vegetation Height',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'EVH',
        lookat: {
          lat: 40.699,
          lon: -121.671,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'EVH',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    The suggested way to cite LANDFIRE products is specific to each product,
    so the model for citation is provided, with an example for a particular product.
    Producer. Year released. Product xxxxx:

    - Individual model name.
    - BpS Models and Descriptions, Online. LANDFIRE. Washington, DC. U.S. Department of
      Agriculture, Forest Service
    - U.S. Department of the Interior; U.S. Geological Survey; Arlington, VA
    - The Nature Conservancy (Producers). Available- URL. Access date.

    Example Citation: LANDFIRE Biophysical Settings. 2018. Biophysical setting 14420:
    South Texas sand sheet grassland. In: LANDFIRE Biophysical Setting Model: Map zone 36,
    [Online]. In: BpS Models and Descriptions. In: LANDFIRE. Washington, DC:
    U.S. Department of Agriculture, Forest Service; U.S. Department of the Interior;
    U.S. Geological Survey; Arlington, VA: The Nature Conservancy (Producers).
    Available: [https://www.landfire.gov/bps-models.php](https://www.landfire.gov/bps-models.php) [2018, June 27].
    Additional guidance on citation of LANDFIRE products can be found
    [here](https://landfire.gov/data/citation)
  |||,
  'gee:terms_of_use': |||
    LANDFIRE data are public domain data with no use restrictions, though if modifications
    or derivatives of the product(s) are created, then please add some descriptive modifier
    to the data set to avoid confusion.
  |||,
  'gee:user_uploaded': true,
}
