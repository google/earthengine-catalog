local id = 'LANDFIRE/Fire/VDep/v1_4_0';
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
  title: 'LANDFIRE VDep (Vegetation Departure) v1.4.0',
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

    Vegetation Departure (VDep) indicates how different current vegetation on a landscape is from estimated historical conditions.
    VDep is based on changes to species composition, structural stage, and canopy closure using methods originally described in the Interagency Fire Regime Condition Class Guidebook, but is not identical to those methods.
    LANDFIRE (LF) VDep is based only on departure of current vegetation conditions from reference vegetation conditions, whereas the Guidebook approach includes departure of current fire regimes from those of the reference period.
    VDep is a landscape metric and is scale dependent. Every pixel in a unique biophysical settings (BpS) in a summary unit has the same VDep value.
    These large landscape values may not represent smaller areas within a summary unit.
    The VDep metric ranges from 0 - 100, and is based on four factors. These inputs are held constant within a single version of LF, but can be different across LF versions, which directly impacts VDep comparability across versions.
    VDep can be compared across versions but caution is advised.

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
        name: 'VDep_classes',
        description: 'Class values of the  Vegetation Departure.',
        type: ee_const.var_type.double,
      },
      {
        name: 'VDep_names',
        description: 'Descriptive names of Vegetation Departure.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'VDep',
        description: 'Vegetation Departure',
        'gee:classes': [
          {
            color: '00f0ff',
            description: '0',
            value: 0,
          },
          {
            value: 1,
            color: '00e5ee',
            description: '1',
          },
          {
            value: 2,
            color: '00dadd',
            description: '2',
          },
          {
            value: 3,
            color: '00cfcc',
            description: '3',
          },
          {
            value: 4,
            color: '00c4bb',
            description: '4',
          },
          {
            value: 5,
            color: '00b9aa',
            description: '5',
          },
          {
            value: 6,
            color: '00ae99',
            description: '6',
          },
          {
            value: 7,
            color: '00a388',
            description: '7',
          },
          {
            value: 8,
            color: '009877',
            description: '8',
          },
          {
            value: 9,
            color: '008d66',
            description: '9',
          },
          {
            value: 10,
            color: '008255',
            description: '10',
          },
          {
            value: 11,
            color: '007744',
            description: '11',
          },
          {
            value: 12,
            color: '006c33',
            description: '12',
          },
          {
            value: 13,
            color: '006122',
            description: '13',
          },
          {
            value: 14,
            color: '005611',
            description: '14',
          },
          {
            value: 15,
            color: '004b00',
            description: '15',
          },
          {
            value: 16,
            color: '0e5900',
            description: '16',
          },
          {
            value: 17,
            color: '1c6600',
            description: '17',
          },
          {
            value: 18,
            color: '2a7400',
            description: '18',
          },
          {
            value: 19,
            color: '388100',
            description: '19',
          },
          {
            value: 20,
            color: '468f00',
            description: '20',
          },
          {
            value: 21,
            color: '549c00',
            description: '21',
          },
          {
            value: 22,
            color: '62aa00',
            description: '22',
          },
          {
            value: 23,
            color: '70b700',
            description: '23',
          },
          {
            value: 24,
            color: '7ec500',
            description: '24',
          },
          {
            value: 25,
            color: '8cd200',
            description: '25',
          },
          {
            value: 26,
            color: '9ad815',
            description: '26',
          },
          {
            value: 27,
            color: 'a9dd2b',
            description: '27',
          },
          {
            value: 28,
            color: 'b7e340',
            description: '28',
          },
          {
            value: 29,
            color: 'c6e955',
            description: '29',
          },
          {
            value: 30,
            color: 'd4ee6a',
            description: '30',
          },
          {
            value: 31,
            color: 'e2f480',
            description: '31',
          },
          {
            value: 32,
            color: 'f1f995',
            description: '32',
          },
          {
            value: 33,
            color: 'ffffaa',
            description: '33',
          },
          {
            value: 34,
            color: 'ffffa0',
            description: '34',
          },
          {
            value: 35,
            color: 'ffff96',
            description: '35',
          },
          {
            value: 36,
            color: 'ffff8c',
            description: '36',
          },
          {
            value: 37,
            color: 'ffff82',
            description: '37',
          },
          {
            value: 38,
            color: 'ffff78',
            description: '38',
          },
          {
            value: 39,
            color: 'ffff6e',
            description: '39',
          },
          {
            value: 40,
            color: 'ffff64',
            description: '40',
          },
          {
            value: 41,
            color: 'ffff5a',
            description: '41',
          },
          {
            value: 42,
            color: 'ffff50',
            description: '42',
          },
          {
            value: 43,
            color: 'ffff46',
            description: '43',
          },
          {
            value: 44,
            color: 'ffff3c',
            description: '44',
          },
          {
            value: 45,
            color: 'ffff32',
            description: '45',
          },
          {
            value: 46,
            color: 'ffff28',
            description: '46',
          },
          {
            value: 47,
            color: 'ffff1e',
            description: '47',
          },
          {
            value: 48,
            color: 'ffff14',
            description: '48',
          },
          {
            value: 49,
            color: 'ffff0a',
            description: '49',
          },
          {
            value: 50,
            color: 'ffff00',
            description: '50',
          },
          {
            value: 51,
            color: 'fff500',
            description: '51',
          },
          {
            value: 52,
            color: 'ffeb00',
            description: '52',
          },
          {
            value: 53,
            color: 'ffe000',
            description: '53',
          },
          {
            value: 54,
            color: 'ffd600',
            description: '54',
          },
          {
            value: 55,
            color: 'ffcc00',
            description: '55',
          },
          {
            value: 56,
            color: 'ffc200',
            description: '56',
          },
          {
            value: 57,
            color: 'ffb800',
            description: '57',
          },
          {
            value: 58,
            color: 'ffad00',
            description: '58',
          },
          {
            value: 59,
            color: 'ffa300',
            description: '59',
          },
          {
            value: 60,
            color: 'ff9900',
            description: '60',
          },
          {
            value: 61,
            color: 'ff8f00',
            description: '61',
          },
          {
            value: 62,
            color: 'ff8500',
            description: '62',
          },
          {
            value: 63,
            color: 'ff7a00',
            description: '63',
          },
          {
            value: 64,
            color: 'ff7000',
            description: '64',
          },
          {
            value: 65,
            color: 'ff6600',
            description: '65',
          },
          {
            value: 66,
            color: 'ff5c00',
            description: '66',
          },
          {
            value: 67,
            color: 'ff5200',
            description: '67',
          },
          {
            value: 68,
            color: 'ff4700',
            description: '68',
          },
          {
            value: 69,
            color: 'ff3d00',
            description: '69',
          },
          {
            value: 70,
            color: 'ff3300',
            description: '70',
          },
          {
            value: 71,
            color: 'ff2900',
            description: '71',
          },
          {
            value: 72,
            color: 'ff1f00',
            description: '72',
          },
          {
            value: 73,
            color: 'ff1400',
            description: '73',
          },
          {
            value: 74,
            color: 'ff0a00',
            description: '74',
          },
          {
            value: 75,
            color: 'ff0000',
            description: '75',
          },
          {
            value: 76,
            color: 'fb0000',
            description: '76',
          },
          {
            value: 77,
            color: 'f70000',
            description: '77',
          },
          {
            value: 78,
            color: 'f20000',
            description: '78',
          },
          {
            value: 79,
            color: 'ee0000',
            description: '79',
          },
          {
            value: 80,
            color: 'ea0000',
            description: '80',
          },
          {
            value: 81,
            color: 'e60000',
            description: '81',
          },
          {
            value: 82,
            color: 'e10000',
            description: '82',
          },
          {
            value: 83,
            color: 'dd0000',
            description: '83',
          },
          {
            value: 84,
            color: 'd90000',
            description: '84',
          },
          {
            value: 85,
            color: 'd50000',
            description: '85',
          },
          {
            value: 86,
            color: 'd00000',
            description: '86',
          },
          {
            value: 87,
            color: 'cc0000',
            description: '87',
          },
          {
            value: 88,
            color: 'c80000',
            description: '88',
          },
          {
            value: 89,
            color: 'c40000',
            description: '89',
          },
          {
            value: 90,
            color: 'c00000',
            description: '90',
          },
          {
            value: 91,
            color: 'bb0000',
            description: '91',
          },
          {
            value: 92,
            color: 'b70000',
            description: '92',
          },
          {
            value: 93,
            color: 'b30000',
            description: '93',
          },
          {
            value: 94,
            color: 'af0000',
            description: '94',
          },
          {
            value: 95,
            color: 'aa0000',
            description: '95',
          },
          {
            value: 96,
            color: 'a60000',
            description: '96',
          },
          {
            value: 97,
            color: 'a20000',
            description: '97',
          },
          {
            value: 98,
            color: '9e0000',
            description: '98',
          },
          {
            value: 99,
            color: '990000',
            description: '99',
          },
          {
            value: 100,
            color: '950000',
            description: '100',
          },
          {
            value: 101,
            color: '000000',
            description: 'Departure not calculated',
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
            description: 'Non-burnable Urban',
          },
          {
            value: 121,
            color: '8418a8',
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
            description: 'Sparse Vegetation',
          },
          {
            value: 180,
            color: 'df73ff',
            description: 'Non-burnable Agriculture',
          },
          {
            value: 181,
            color: 'df73f0',
            description: 'Burnable Agriculture',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'VDep',
        lookat: {
          lat: 40.699,
          lon: -121.671,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'VDep',
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
