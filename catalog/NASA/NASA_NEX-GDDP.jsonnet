local id = 'NASA/NEX-GDDP';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

// There is a custom public domain statement in gee:terms_of_use.
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
  title: 'NEX-GDDP: NASA Earth Exchange Global Daily Downscaled Climate Projections',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NASA NEX-GDDP dataset is comprised of downscaled climate scenarios
    for the globe that are derived from the General Circulation Model (GCM)
    runs conducted under the Coupled Model Intercomparison Project Phase 5
    (CMIP5, see [Taylor et al. 2012](https://journals.ametsoc.org/doi/abs/10.1175/BAMS-D-11-00094.1))
    and across two of the four greenhouse gas emissions scenarios known as
    Representative Concentration Pathways (RCPs, see [Meinshausen et
    al. 2011](https://rd.springer.com/article/10.1007%2Fs10584-011-0156-z#page-1)).
    The CMIP5 GCM runs were developed in support of the Fifth Assessment
    Report of the Intergovernmental Panel on Climate Change (IPCC AR5).

    This dataset was prepared by the Climate Analytics Group and NASA Ames
    Research Center using the NASA Earth Exchange, and distributed by the NASA
    Center for Climate Simulation (NCCS).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'cag',
    'climate',
    'cmip5',
    'gddp',
    'geophysical',
    'nasa',
    'nex',
    'precipitation',
    'temperature',
  ],
  providers: [
    ee.producer_provider('NASA /  Climate Analytics Group', 'https://www.nccs.nasa.gov/services/data-collections/land-based-products/nex-gddp'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1950-01-01T00:00:00Z', '2100-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'model',
        description: |||
          Name of the CMIP5 model. It is one of 'ACCESS1-0',
          'bcc-csm1-1', 'BNU-ESM', 'CanESM2', 'CCSM4', 'CESM1-BGC', 'CNRM-CM5',
          'CSIRO-Mk3-6-0', 'GFDL-CM3', 'GFDL-ESM2G', 'GFDL-ESM2M', 'inmcm4',
          'IPSL-CM5A-LR', 'IPSL-CM5A-MR', 'MIROC-ESM', 'MIROC-ESM-CHEM', 'MIROC5',
          'MPI-ESM-LR', 'MPI-ESM-MR', 'MRI-CGCM3', 'NorESM1-M'.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'scenario',
        description: |||
          Name of the CMIP5 scenario. It is one of: 'historical',
          'rcp45', 'rcp85', where 'historical' designates
          retrospective model runs (pre-2006).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'year',
        description: 'Calendar year',
        type: ee_const.var_type.double,
      },
      {
        name: 'month',
        description: 'Calendar month',
        type: ee_const.var_type.double,
      },
      {
        name: 'day',
        description: 'Calendar day',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: 'pr',
        description: |||
          Daily mean of precipitation at surface; includes both
          liquid and solid phases from all types of clouds (both large-scale
          and convective)
        |||,
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'tasmin',
        description: 'Daily mean of the daily-minimum near-surface air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmax',
        description: 'Daily mean of the daily-maximum near-surface air temperature',
        'gee:units': units.kelvin,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Minimum Air Temperature',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              240.0,
            ],
            max: [
              300.0,
            ],
            palette: [
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'tasmin',
            ],
          },
        },
      },
    ],
    pr: {
      minimum: 0.0,
      maximum: 0.42,
      'gee:estimated_range': true,
    },
    tasmin: {
      minimum: 165.31,
      maximum: 318.89,
      'gee:estimated_range': true,
    },
    tasmax: {
      minimum: 188.38,
      maximum: 335.13,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Thrasher, B., Maurer, E. P., McKellar, C., & Duffy, P. B., 2012:
    Technical Note: Bias correcting climate model simulated daily temperature
    extremes with quantile mapping. Hydrology and Earth System Sciences,
    16(9), 3309-3314.
    [doi:10.5194/hess-16-3309-2012](https://doi.org/10.5194/hess-16-3309-2012)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
