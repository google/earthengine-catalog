local id = 'LANDFIRE/Fire/VCC/v1_4_0';
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
  title: 'LANDFIRE VCC (Vegetation Condition Class) v1.4.0',
  version: '1.4.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    LANDFIRE (LF), Landscape Fire and Resource Management Planning Tools, is a
    shared program between the wildland fire management programs of the U.S.
    Department of Agriculture's Forest Service, U.S. Department of the Interior's
    Geological Survey, and The Nature Conservancy.

    Landfire (LF) Historical fire regimes, intervals, and vegetation conditions
    are mapped using the Vegetation Dynamics Development Tool (VDDT).
    These data support fire and landscape management planning goals in
    the National Cohesive Wildland Fire Management Strategy, the Federal Wildland
    Fire Management Policy, and the Healthy Forests Restoration Act.

    Vegetation Condition Class (VCC) represents a simple categorization of the associated Vegetation Departure (VDEP) layer and indicates the general level to which current vegetation is different from the simulated historical vegetation reference conditions.
    VDEP and VCC are based upon methods originally described in Interagency Fire Regime Condition Class Guidebook, but are not identical to those methods.
    Full descriptions of the methods used can be found in the VDEP product description.
    Users should review those methods before comparing VDEP or VCC values across LANDFIRE (LF) versions.
    VCC is a derivative of the VDEP layer.
    It is important to read and understand the characteristics of the VDEP spatial product, particularly if VCC values are compared across versions as the VDEP methods varied which directly impacts across-version VDEP and VCC comparability.
    In LF 2012, the original three VCC classes were divided in half to create six VCC classes to provide additional precision.

    The LANDIFRE Fire datasets include:

    * Fire Regime Groups (FRG) is intended to characterize presumed historical
      fire regimes within landscapes based on interactions between vegetation
      dynamics, fire spread, fire effects, and spatial context
    * Mean Fire Return Interval (MFRI) quantifies the average period between
      fires under the presumed historical fire regime
    * Percent of Low-severity Fire (PLS) image quantifies the amount of
      low-severity fires relative to mixed- and replacement-severity fires
      under the presumed historical fire regime and is defined as less than 25
      percent average top-kill within a typical fire perimeter for a given
      vegetation type
    * Percent of Mixed-severity Fire (PMS) layer quantifies the amount of
      mixed-severity fires relative to low- and replacement-severity fires under
      the presumed historical fire regime, and is defined as between 25 and 75
      percent average top-kill within a typical fire perimeter for a given
      vegetation type
    * Percent of Replacement-severity Fire (PRS) layer quantifies the amount of
      replacement-severity fires relative to low- and mixed-severity fires under
      the presumed historical fire regime, and is defined as greater than 75
      percent average top-kill within a typical fire perimeter for a given
      vegetation type
    * Succession Classes (SClass) layer characterizes current vegetation conditions
      with respect to the vegetation species composition, cover, and height ranges
      of successional states that occur within each biophysical setting
    * Vegetation Condition Class (VCC) represents a simple categorization of the
      associated Vegetation Departure (VDEP) layer and indicates the general level
      to which current vegetation is different from the simulated historical
      vegetation reference conditions
    * Vegetation Departure (VDep) indicates how different current vegetation on a
      landscape is from estimated historical conditions. VDep is based on changes
      to species composition, structural stage, and canopy closure.
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
        name: 'VCC_classes',
        description: 'Class values of the  Vegetation Condition Class.',
        type: ee_const.var_type.double,
      },
      {
        name: 'VCC_names',
        description: 'Descriptive names of Vegetation Condition Class.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'VCC',
        description: 'Vegetation Condition Class',
        'gee:classes': [
          {
            value: 1,
            color: '38a800',
            description: 'Very Low, Vegetation Departure 0-16%',
          },
          {
            value: 2,
            color: '4ce600',
            description: 'Low to Moderate, Vegetation Departure 17-33%',
          },
          {
            value: 3,
            color: 'ffff00',
            description: 'Moderate to Low, Vegetation Departure 34-50%',
          },
          {
            value: 4,
            color: 'ffaa00',
            description: 'Moderate to High, Vegetation Departure 51-66%',
          },
          {
            value: 5,
            color: 'ff0000',
            description: 'High, Vegetation Departure 67-83%',
          },
          {
            value: 6,
            color: 'a80000',
            description: 'Very High, Vegetation Departure 84-100%',
          },
          {
            value: 111,
            color: '0000ff',
            description: 'Water',
          },
          {
            value: 112,
            color: 'c8ffff',
            description: 'Snow / Ice',
          },
          {
            value: 120,
            color: '8400a8',
            description: 'Non burnable Urban',
          },
          {
            value: 121,
            color: 'f516b6',
            description: 'Burnable Urban',
          },
          {
            value: 131,
            color: '4e4e4e',
            description: 'Barren',
          },
          {
            value: 132,
            color: 'b2b2b2',
            description: 'Sparsely Vegetated',
          },
          {
            value: 180,
            color: 'df73ff',
            description: 'Non burnable Agriculture',
          },
          {
            value: 181,
            color: 'e8beff',
            description: 'Burnable Agriculture',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'VCC',
        lookat: {
          lat: 40.699,
          lon: -121.671,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'VCC',
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
