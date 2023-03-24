local id = 'TERN/AET/CMRSET_LANDSAT_V2_2';
local subdir = 'TERN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'Actual Evapotranspiration for Australia (CMRSET Landsat V2.2)',
  version: 'V2.2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset provides accurate actual evapotranspiration (AET or ETa) for
    Australia using the CMRSET algorithm. The AET band (named 'ETa') contains
    the average daily value from the CMRSET model for all cloud-free Landsat
    observations in that month (indicated with value 3 in the AET Data Source QA
    bits). After the Landsat 7 ETM+ Scan Line Corrector (SLC) failed on 31 May
    2003, Landsat 7 ETM+ data are only used if there are no cloud-free Landsat 5
    TM or Landsat 8 OLI data for that month. If there is no cloud-free Landsat
    data available, pixels are infilled with blended data. The blended data will
    be blended Landsat-MODIS until Feb 2012, then blended Landsat-VIIRS onwards
    (indicated with value 2 in the AET Data Source QA bits). If there is no
    blended data available in a month, then missing monthly AET values are
    linearly interpolated (indicated with value 1 in the AET Data Source QA
    bits). This means monthly 30 m AET data covering all Australia, with no gaps
    due to cloud, are available and ready to use.

    Accurate AET information is important for irrigation, food security, and
    environmental management. Like many other parts of the world, water
    availability in Australia is limited and AET is the largest consumptive
    component of the water balance. In Australia 70% of available water is used
    for crop and pasture irrigation. Better monitoring will support improved
    water use efficiency in this sector, with any water savings available as
    environmental flows. Additionally, ground-water dependent ecosystems (GDE)
    occupy a small area yet are "biodiversity hotspots". Knowing their water
    needs enables enhanced management of these critical areas. AET can also be
    used to model the catchment water balance. If used in water balance (mass
    balance) calculations, then this AET value needs to be multiplied by the
    number of days in the month.

    To let the developers know you are using this dataset, to get information on
    updates, or if you have any questions please contact: tim.mcvicar@csiro.au,
    tom.vanniel@csiro.au, jamie.vleeshouwer@csiro.au.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(spdx.cc_by_4_0.reference),
  ],
  keywords: [
    'agriculture',
    'australia',
    'csiro',
    'evaporation',
    'evapotranspiration',
    'hydrology',
    'landsat_derived',
    'tern',
    'viirs_derived',
  ],
  providers: [
    ee.producer_provider(
        'TERN Landscapes / CSIRO Land and Water',
        'https://portal.tern.org.au/actual-evapotranspiration-australia-cmrset-algorithm/21915'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(110.0, -45.0, 155.0, -10.0, '2000-02-01T00:00:00Z', null),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'ETa',
        description: 'Average daily evapotranspiration',
        'gee:units': units.millimeter_per_day,
      },
      {
        name: 'pixel_qa',
        description: 'Pixel QA attributes',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'AET Data Source',
              bit_count: 2,
              values: [
                {
                  description: 'N/A (i.e., surrounding oceans)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'AET value was linearly interpolated.',
                },
                {
                  value: 2,
                  description: |||
                    AET value was from data blending.
                    (CMRSET_MCD43_C6_LANDSAT_V2_0 until Feb 2012, then
                    CMRSET_VIIRS_LANDSAT_V2_0 onwards)
                  |||,
                },
                {
                  value: 3,
                  description: 'AET value was from CMRSET_LANDSAT_V2_0',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Condensation Adjustment',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'AET value was not adjusted.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'AET value was adjusted to 0 mm/day (due to a negative value).',
                },
              ],
            },
            {
              description: 'Number of Landsat observations used for this pixel (0-15).',
              first_bit: 3,
              bit_count: 4,
            },
            {
              description: 'SLC-Off',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'SLC-Off was not applied.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'SLC-Off was applied to Landsat 7 (may contain sensor artifacts).',
                },

              ],
            },
          ],
          total_bit_count: 8,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Average daily evapotranspiration',
        lookat: {
          lat: -27.0,
          lon: 132.0,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              7.0,
            ],
            palette: [
              'd7191c',
              'fdae61',
              'ffffbf',
              'abd9e9',
              '2c7bb6',
            ],
            bands: [
              'ETa',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Juan P. Guerschman, Tim R. McVicar, Jamie Vleeshower, Thomas G. Van Niel,
    Jorge L. Peña-Arancibia, Yun Chen. Estimating actual evapotranspiration at
    field-to-continent scales by calibrating the CMRSET algorithm with MODIS,
    VIIRS, Landsat and Sentinel-2 data, Journal of Hydrology, Volume 605, 2022,
    127318,
    [doi:10.1016/j.jhydrol.2021.127318](https://doi.org/10.1016/j.jhydrol.2021.127318).
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
