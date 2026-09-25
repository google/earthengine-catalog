local id = 'projects/openet/assets/reference_et/conus/gridmet/monthly/v1';
local subdir = 'OpenET';
local version = '1.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'OpenET Bias Corrected GRIDMET Monthly Reference Evapotranspiration v' + version,
  version: version,
  description: |||
    OpenET Bias-Corrected GRIDMET Monthly Reference Evapotranspiration.

    Provides monthly grass reference (ETo) and alfalfa reference (ETr)
    evapotranspiration for the contiguous United States. The products apply
    spatially varying, month-specific correction factors to gridMET reference
    ET to reduce systematic bias relative to quality-controlled agricultural
    weather station data. The weather station data used for bias correction
    are described by Dunkerly et al. (2026) and the statistical and
    spatial mapping methods are described by Volk et al. (2026).

    [Additional information](https://etdata.org/methods/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['water-vapor'],
  keywords: [
    'conus',
    'evapotranspiration',
    'gridmet_derived',
    'monthly',
    'openet',
    'water',
  ],
  providers: [
    ee.producer_provider('OpenET, Inc.', 'https://etdata.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-126, 25, -66, 50, '1979-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'build_date',
        description: 'Date assets were built',
        type: ee_const.var_type.string,
      },
      {
        name: 'early',
        description: 'Number of "early" status daily images used to generate monthly total"',
        type: ee_const.var_type.string,
      },
      {
        name: 'eto_source_data_version',
        description: 'Bias correction ratio version summary of the daily source "eto" images',
        type: ee_const.var_type.string,
      },
      {
        name: 'etr_source_data_version',
        description: 'Bias correction ratio version summary of the daily source "etr" images',
        type: ee_const.var_type.string,
      },
      {
        name: 'permanent',
        description: 'Number of "permanent" status daily images used to generate monthly total"',
        type: ee_const.var_type.string,
      },
      {
        name: 'provisional',
        description: 'Number of "provisional" status daily images used to generate monthly total"',
        type: ee_const.var_type.string,
      },
      {
        name: 'scale_factor_eto',
        description: 'Scaling factor that should be applied to the "eto" band',
        type: ee_const.var_type.double,
      },
      {
        name: 'scale_factor_etr',
        description: 'Scaling factor that should be applied to the "etr" band',
        type: ee_const.var_type.double,
      },
      {
        name: 'status',
        description: '"permanent" or "provisional"',
        type: ee_const.var_type.string,
      },
      {
        name: 'units_eto',
        description: 'Units of the "eto" band',
        type: ee_const.var_type.string,
      },
      {
        name: 'units_etr',
        description: 'Units of the "etr" band',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [4000],
    'eo:bands': [
      {
        name: 'eto',
        description: 'ASCE Standardized Grass Reference ET',
        'gee:units': units.millimeter,
      },

      {
        name: 'etr',
        description: 'ASCE Standardized Alfalfa Reference ET',
        'gee:units': units.millimeter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET Bias Corrected GRIDMET Monthly Grass Reference ET',
        lookat: {
          lat: 38,
          lon: -100,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [600],
            max: [2200],
            palette: [
              '9e6212', 'ac7d1d', 'ba9829', 'c8b434', 'd6cf40', 'bed44b',
              '9fcb51', '80c256', '61b95c', '42b062', '45b677', '49bc8d',
              '4dc2a2', '51c8b8', '55cece', '4db4ba', '459aa7', '3d8094',
              '356681', '2d4c6e',
            ],
            bands: ['eto'],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5281/zenodo.18673483',
  'sci:citation': |||
    Volk, J., Dunkerly, C., Majumdar, S., Huntington, J., Minor, B., Kim, Y.,
    Morton, C., ReVelle, P., Kilic, A., Melton, F., Allen, R., Pearson, C.,
    Purdy, A., and Caldwell, T. (2026). Assessing and correcting bias in
    gridded reference evapotranspiration over agricultural lands across the
    contiguous United States. Agricultural Water Management, 333, 110647.
    [10.1016/j.agwat.2026.110647](https://doi.org/10.1016/j.agwat.2026.110647)
  |||,
  'sci:publications': [
    {
      citation: |||
        Dunkerly, C., Volk, J., Majumdar, S., Huntington, J., Allen, R.,
        Pearson, C., Kim, Y., Morton, C., Minor, B., ReVelle, P., Kilic, A.,
        Melton, F., Purdy, A., and Caldwell, T. (2026). A Benchmark Dataset of
        Agricultural Weather Stations over the Contiguous United States for
        Evapotranspiration Applications. Scientific Data, 13(1), 1182.
        [10.1038/s41597-026-07819-7](https://doi.org/10.1038/s41597-026-07819-7)
      |||,
    },
   ],
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:status': 'beta',
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:type': ee_const.gee_type.image_collection,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
