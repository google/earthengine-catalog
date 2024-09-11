local id = 'LANDFIRE/Fire/PRS/v1_2_0';
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
  title: 'LANDFIRE PRS (Percent of Replacement-severity Fire) v1.2.0',
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

    The Percent of Replacement-severity Fire (PRS) layer quantifies the amount of replacement-severity fires relative to low- and mixed-severity fires under the presumed historical fire regime.
    Replacement severity is defined as greater than 75 percent average top-kill within a typical fire perimeter for a given vegetation type.
    PRS was derived from the vegetation and disturbance dynamics model VDDT (Vegetation Dynamics Development Tool) (LF 1.0.0 CONUS only used the vegetation and disturbance dynamics model LANDSUM).
    This layer is intended to describe one component of historical fire regime characteristics in the context of the broader historical time period represented by the LANDFIRE(LF) Biophysical Settings (BPS) layer and BPS Model documentation.
    This layer is created by linking the BPS Group attribute in the BPS layer with the Refresh Model Tracker (RMT) data and assigning the PRS attribute.
    This geospatial product should display a reasonable approximation of PRS, as documented in the RMT.
    PRS is used in landscape assessments.

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
        name: 'PRS_classes',
        description: 'Class values of the  Percent of Replacement-severity Fire.',
        type: ee_const.var_type.double,
      },
      {
        name: 'PRS_names',
        description: 'Descriptive names of Percent of Replacement-severity Fire.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'PRS',
        description: 'Percent of Replacement-severity Fire',
        'gee:classes': [
          {
            value: 1,
            color: '008200',
            description: '0-5%',
          },
          {
            value: 2,
            color: '138f00',
            description: '6-10%',
          },
          {
            value: 3,
            color: '229c00',
            description: '11-15%',
          },
          {
            value: 4,
            color: '34a600',
            description: '16-20%',
          },
          {
            value: 5,
            color: '47b300',
            description: '21-25%',
          },
          {
            value: 6,
            color: '66bf00',
            description: '26-30%',
          },
          {
            value: 7,
            color: '7ecc00',
            description: '31-35%',
          },
          {
            value: 8,
            color: '9bd900',
            description: '36-40%',
          },
          {
            value: 9,
            color: 'b8e600',
            description: '41-45%',
          },
          {
            value: 10,
            color: 'e2f200',
            description: '46-50%',
          },
          {
            value: 11,
            color: 'fffb00',
            description: '51-55%',
          },
          {
            value: 12,
            color: 'fadd00',
            description: '56-60%',
          },
          {
            value: 13,
            color: 'f7c600',
            description: '61-65%',
          },
          {
            value: 14,
            color: 'f5a300',
            description: '66-70%',
          },
          {
            value: 15,
            color: 'f08c00',
            description: '71-75%',
          },
          {
            value: 16,
            color: 'eb7100',
            description: '76-80%',
          },
          {
            value: 17,
            color: 'e85d00',
            description: '81-85%',
          },
          {
            value: 18,
            color: 'e63d00',
            description: '86-90%',
          },
          {
            value: 19,
            color: 'e32a00',
            description: '91-95%',
          },
          {
            value: 20,
            color: 'de1200',
            description: '96-100%',
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
            description: 'Indeterminate Fire Regime',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'PRS',
        lookat: {
          lat: 40.699,
          lon: -121.671,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'PRS',
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
