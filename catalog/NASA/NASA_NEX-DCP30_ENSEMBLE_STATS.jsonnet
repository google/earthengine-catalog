local id = 'NASA/NEX-DCP30_ENSEMBLE_STATS';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'NEX-DCP30: Ensemble Stats for NASA Earth Exchange Downscaled Climate Projections',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NASA NEX-DCP30 dataset is comprised of downscaled climate scenarios
    for the conterminous United States that are derived from the General
    Circulation Model (GCM) runs conducted under the Coupled Model
    Intercomparison Project Phase 5 (CMIP5, see [Taylor et al. 2012](https://journals.ametsoc.org/doi/abs/10.1175/BAMS-D-11-00094.1))
    and across the four greenhouse gas emissions scenarios known as
    Representative Concentration Pathways (RCPs, see [Meinshausen et al. 2011](https://rd.springer.com/article/10.1007%2Fs10584-011-0156-z#page-1))
    developed for the Fifth Assessment Report of the Intergovernmental Panel
    on Climate Change (IPCC AR5). The purpose of these datasets is to provide
    a set of high resolution, bias-corrected climate change projections that
    can be used to evaluate climate change impacts on processes that are
    sensitive to finer-scale climate gradients and the effects of local
    topography on climate conditions.

    The dataset contains monthly projections covering the periods from 1950
    through 2005 (Retrospective Run) and from 2006 to 2099 (Prospective Run).
    It includes ensemble statistics calculated for each RCP from all model
    runs available for the pr, tasmin, and tasmax bands.

    NEX-DCP30 was prepared by the Climate Analytics Group and NASA Ames
    Research Center using the NASA Earth Exchange, and distributed by the NASA
    Center for Climate Simulation (NCCS).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'cag',
    'climate',
    'cmip5',
    'geophysical',
    'nasa',
    'nex',
    'precipitation',
    'temperature',
  ],
  providers: [
    ee.producer_provider('NASA / Climate Analytics Group', 'https://www.nccs.nasa.gov/services/data-collections/land-based-products/nex-dcp30'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-125.03, 24.07, -66.47, 49.93,
                    '1950-01-01T00:00:00Z', '2099-12-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'scenario',
        description: |||
          Name of the CMIP5 scenario. It is one of: 'historical',
          'rcp26', 'rcp45', 'rcp60', 'rcp85', where 'historical' designates
          retrospective model runs (pre-2006).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'month',
        description: 'Calendar month',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'pr_mean',
        description: |||
          Monthly mean of the daily precipitation rate at surface;
          includes both liquid and solid phases from all types of clouds
          (both large-scale and convective)
        |||,
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'pr_quartile25',
        description: |||
          25th quartile of the precipitation at surface; includes both
          liquid and solid phases from all types of clouds (both large-scale
          and convective)
        |||,
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'pr_median',
        description: |||
          Median of precipitation at surface; includes both liquid and
          solid phases from all types of clouds (both large-scale and convective)
        |||,
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'pr_quartile75',
        description: |||
          75th quartile of the precipitation at surface; includes both
          liquid and solid phases from all types of clouds (both large-scale
          and convective)
        |||,
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'tasmin_mean',
        description: 'Monthly mean of the daily-minimum near-surface air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmin_quartile25',
        description: '25th quartile the daily-minimum near-surface air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmin_median',
        description: 'Median of the daily-minimum near-surface air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmin_quartile75',
        description: '75th quartile of the daily-minimum near-surface air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmax_mean',
        description: 'Monthly mean of the daily-maximum near-surface air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmax_quartile25',
        description: '25th quartile of the daily-maximum near-surface air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmax_median',
        description: 'Median of the daily-maximum near-surface air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmax_quartile75',
        description: '75th quartile of the daily-maximum near-surface air temperature',
        'gee:units': units.kelvin,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Monthly Mean Minimum Air Temperature',
        lookat: {
          lat: 38.686,
          lon: -115.356,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              247.0,
            ],
            max: [
              311.0,
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
              'tasmin_mean',
            ],
          },
        },
      },
    ],
    pr_mean: {
      minimum: 0.0,
      maximum: 0.0006,
      'gee:estimated_range': true,
    },
    pr_quartile25: {
      minimum: 0.0,
      maximum: 0.0004,
      'gee:estimated_range': true,
    },
    pr_median: {
      minimum: 0.0,
      maximum: 0.0006,
      'gee:estimated_range': true,
    },
    pr_quartile75: {
      minimum: 0.0,
      maximum: 0.0008,
      'gee:estimated_range': true,
    },
    tasmin_mean: {
      minimum: 247.58,
      maximum: 311.09,
      'gee:estimated_range': true,
    },
    tasmin_quartile25: {
      minimum: 243.28,
      maximum: 310.06,
      'gee:estimated_range': true,
    },
    tasmin_median: {
      minimum: 246.87,
      maximum: 311.12,
      'gee:estimated_range': true,
    },
    tasmin_quartile75: {
      minimum: 248.42,
      maximum: 312.59,
      'gee:estimated_range': true,
    },
    tasmax_mean: {
      minimum: 258.47,
      maximum: 326.48,
      'gee:estimated_range': true,
    },
    tasmax_quartile25: {
      minimum: 256.13,
      maximum: 325.52,
      'gee:estimated_range': true,
    },
    tasmax_median: {
      minimum: 257.89,
      maximum: 326.28,
      'gee:estimated_range': true,
    },
    tasmax_quartile75: {
      minimum: 260.2,
      maximum: 328.2,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Thrasher, B., J. Xiong, W. Wang, F. Melton, A. Michaelis and R. Nemani
    (2013), Downscaled Climate Projections Suitable for Resource Management,
    Eos Trans. AGU, 94(37), 321.
    [doi:10.1002/2013EO370002](https://doi.org/10.1002/2013EO370002)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
