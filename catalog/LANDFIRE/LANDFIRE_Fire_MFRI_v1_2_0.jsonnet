local id = 'LANDFIRE/Fire/MFRI/v1_2_0';
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
  title: 'LANDFIRE MFRI (Mean Fire Return Interval) v1.2.0',
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

    The Mean Fire Return Interval (MFRI) layer quantifies the average period between fires under the presumed historical fire regime.
    MFRI is intended to describe one component of historical fire regime characteristics in the context of the broader historical time period represented by the LANDFIRE (LF) Biophysical Settings (BPS) layer and BPS Model documentation.
    MFRI is derived from the vegetation and disturbance dynamics model VDDT (Vegetation Dynamics Development Tool) (LF 1.0.0 CONUS only used the vegetation and disturbance dynamics model LANDSUM).
    This layer is created by linking the BpS Group attribute in the BpS layer with the Refresh Model Tracker (RMT) data and assigning the MFRI attribute.
    This geospatial product should display a reasonable approximation of MFRI, as documented in the RMT.
    MFRI is used in landscape assessments.

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
                    '2010-01-01T00:00:00Z', '2010-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'MFRI_classes',
        description: 'Class values of the  mean fire return interval.',
        type: ee_const.var_type.double,
      },
      {
        name: 'MFRI_names',
        description: 'Descriptive names of the mean fire return interval.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'MFRI',
        description: 'Mean Fire Return Interval',
        'gee:classes': [
          {
            value: 1,
            color: '0b0080',
            description: '0-5 Years',
          },
          {
            value: 2,
            color: '3800a1',
            description: '6-10 Years',
          },
          {
            value: 3,
            color: '470087',
            description: '11-15 Years',
          },
          {
            value: 4,
            color: '9300b0',
            description: '16-20 Years',
          },
          {
            value: 5,
            color: 'bf00ac',
            description: '21-25 Years',
          },
          {
            value: 6,
            color: 'cf008a',
            description: '26-30 Years',
          },
          {
            value: 7,
            color: 'de0059',
            description: '31-35 Years',
          },
          {
            value: 8,
            color: 'f00028',
            description: '36-40 Years',
          },
          {
            value: 9,
            color: 'e60000',
            description: '41-45 Years',
          },
          {
            value: 10,
            color: 'ff4d00',
            description: '46-50 Years',
          },
          {
            value: 11,
            color: 'ff8400',
            description: '51-60 Years',
          },
          {
            value: 12,
            color: 'ffbf00',
            description: '61-70 Years',
          },
          {
            value: 13,
            color: 'fffb00',
            description: '71-80 Years',
          },
          {
            value: 14,
            color: 'fff642',
            description: '81-90 Years',
          },
          {
            value: 15,
            color: 'fff782',
            description: '91-100 Years',
          },
          {
            value: 16,
            color: 'fffac4',
            description: '101-125 Years',
          },
          {
            value: 17,
            color: 'd4de8a',
            description: '126-150 Years',
          },
          {
            value: 18,
            color: '9dbf58',
            description: '151-200 Years',
          },
          {
            value: 19,
            color: '64a132',
            description: '201-300 Years',
          },
          {
            value: 20,
            color: '4b8c23',
            description: '301-500 Years',
          },
          {
            value: 21,
            color: '146600',
            description: '501-1000 Years',
          },
          {
            value: 22,
            color: '004700',
            description: '>1000 Years',
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
            value: 133,
            color: 'e1e1e1',
            description: 'Indeterminate Fire Regime Characteristics',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'MFRI',
        lookat: {
          lat: 40.699,
          lon: -121.671,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'MFRI',
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
    [here](https://www.landfire.gov/landfire_citation.php)
  |||,
  'gee:terms_of_use': |||
    LANDFIRE data are public domain data with no use restrictions, though if modifications
    or derivatives of the product(s) are created, then please add some descriptive modifier
    to the data set to avoid confusion.
  |||,
  'gee:user_uploaded': true,
}
