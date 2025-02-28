local id = 'NASA/GDDP-CMIP6';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

// The tech note states that all outputs are available under Creative Common
// Zero as of September 2022. Individual models may be released under Creative
// Commons 4.0; to be sure, each asset has a "license" property.
local license = spdx.various {
  reference: 'https://pcmdi.llnl.gov/CMIP6/TermsOfUse/TermsOfUse6-1.html',
};

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
  title: 'NEX-GDDP-CMIP6: NASA Earth Exchange Global Daily Downscaled Climate Projections',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NEX-GDDP-CMIP6 dataset is comprised of global downscaled climate
    scenarios derived from the General Circulation Model (GCM) runs conducted
    under the Coupled Model Intercomparison Project Phase 6 (CMIP6, see
    [Thrasher et al. 2022](https://doi.org/10.7917/OFSG3345)) and across two of
    the four "Tier 1" greenhouse gas emissions scenarios known as Shared
    Socioeconomic Pathways (SSPs).

    The CMIP6 GCM runs were developed in support of the Sixth Assessment Report
    of the Intergovernmental Panel on Climate Change (IPCC AR6). This dataset
    includes downscaled projections from ScenarioMIP model runs for which daily
    scenarios were produced and distributed through the Earth System Grid
    Federation.

    This collection contains 34 different models. One model, "GFDL-CM4," has
    data for two different configurations that can be differentiated by further
    filtering on the *grid_label* property.

    See also
    [the provider tech note](https://www.nccs.nasa.gov/sites/default/files/NEX-GDDP-CMIP6-Tech_Note.pdf).

    [You can submit data questions about CMIP6 to the provider](https://airtable.com/shr01weJfA7DYq6jf)
    and
    [see their answers](https://airtable.com/shrX4mj20TLSH0r2y/tblUMAYpCfCCwucSV).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.license,
      href: license.reference,
      type: ee_const.media_type.html,
    },
  ],
  'gee:categories': ['climate'],
  keywords: [
    'cag',
    'climate',
    // TODO(dpencosk): Consider making a "cmip" keyword for this dataset and
    // the three existing datasets with the "cmip5" keyword.
    // 'cmip6',
    'gddp',
    'geophysical',
    'ipcc',
    'nasa',
    'nex',
    'precipitation',
    'temperature',
  ],
  providers: [
    ee.producer_provider('NASA / Climate Analytics Group', 'https://www.nccs.nasa.gov/services/data-collections/land-based-products/nex-gddp-cmip6'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1950-01-01T00:00:00Z', '2100-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'model',
        description: |||
          Name of the CMIP6 model. It is one of:

          * ACCESS-CM2
          * ACCESS-ESM1-5
          * BCC-CSM2-MR
          * CESM2
          * CESM2-WACCM
          * CMCC-CM2-SR5
          * CMCC-ESM2
          * CNRM-CM6-1
          * CNRM-ESM2-1
          * CanESM5
          * EC-Earth3
          * EC-Earth3-Veg-LR
          * FGOALS-g3
          * GFDL-CM4 (see *grid_label* for additional information)
          * GFDL-ESM4
          * GISS-E2-1-G
          * HadGEM3-GC31-LL
          * HadGEM3-GC31-MM
          * IITM-ESM
          * INM-CM4-8
          * INM-CM5-0
          * IPSL-CM6A-LR
          * KACE-1-0-G
          * KIOST-ESM
          * MIROC-ES2L
          * MIROC6
          * MPI-ESM1-2-HR
          * MPI-ESM1-2-LR
          * MRI-ESM2-0
          * NESM3
          * NorESM2-LM
          * NorESM2-MM
          * TaiESM1
          * UKESM1-0-LL
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'scenario',
        description: |||
          Name of the CMIP6 scenario. It is one of:

          * historical (retrospective model runs pre-2015)
          * ssp245
          * ssp585
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
      {
        name: 'grid_label',
        description: |||
          The grid label, which is only set when differentiating simulation
          results for the 'GFDL-CM4' model. It is one of:

          * gr1
          * gr2
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'license',
        description: |||
          The license under which a model is released. It will be one of:

          * %s (%s)
          * %s (%s)
        ||| % [
          spdx.cc_by_4_0.id, spdx.cc_by_4_0.name, spdx.cc0_1_0.id,
          spdx.cc0_1_0.name
        ],
        type: ee_const.var_type.string,
      },
      {
        name: 'interpolated',
        description: |||
          Present and 'true' if data for a particular day has been filled in
          using the value from the previous day. This happens when the
          simulation does not produce a data band for every day in the year.

          The following models always duplicate the last day in leap years
          because they only yield 365 bands: 'BCC-CSM2-MR', 'CanESM5', 'CESM2',
          'CESM2-WACCM', 'CMCC-CM2-SR5', 'CMCC-ESM2', 'FGOALS-g3', 'GFDL-CM4',
          'GFDL-ESM4', 'GISS-E2-1-G', 'INM-CM4-8', 'INM-CM5-0', 'KIOST-ESM',
          'NorESM2-LM', 'NorESM2-MM', 'TaiESM1'.

          These models yield 360 bands per year and have the outstanding 5 or 6
          days filled by duplicating one every 60-70 days: 'HadGEM3-GC31-LL',
          'HadGEM3-GC31-MM', 'KACE-1-0-G', 'UKESM1-0-LL'.

          'IITM-ESM' only has 364 bands in years divisible by 5 (and does not
          have data for 2100 at all), so the final day is always duplicated,
          plus the midpoint day in leap years.
        |||,
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      27830.0,  // 0.25 degrees x 0.25 degrees
    ],
    'eo:bands': [
      {
        name: 'hurs',
        description: |||
          Near-surface relative humidity. Not present in these models:
          'BCC-CSM2-MR', 'NESM3', 'KIOST-ESM' (only for scenario 'ssp245' in
          2058).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'huss',
        description: |||
          Near-surface specific humidity. Not present in these models:
          'IPSL-CM6A-LR', 'MIROC6', 'NESM3'.
        |||,
        'gee:units': units.mass_fraction,
      },
      {
        name: 'pr',
        description: 'Precipitation (mean of the daily precipitation rate)',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'rlds',
        description: 'Surface downwelling longwave radiation',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'rsds',
        description: 'Surface downwelling shortwave radiation',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'sfcWind',
        description: 'Daily-mean near-surface wind speed',
        'gee:units': units.velocity_si,
      },
      {
        name: 'tas',
        description: |||
          Daily near-surface air temperature. Not present in these models:
          'NorESM2-LM' (only for scenario 'ssp585' in 2096).
        |||,
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmin',
        description: |||
          Daily minimum near-surface air temperature. Not present in these
          models: 'CESM2', 'CESM2-WACCM', 'IITM-ESM', 'TaiESM1' (only for
          scenario 'ssp585' in 2093).
        |||,
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmax',
        description: |||
          Daily maximum near-surface air temperature. Not present in these
          models: 'CESM2', 'CESM2-WACCM', 'IITM-ESM'.
        |||,
        'gee:units': units.kelvin,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Minimum Air Temperature (K)',
        lookat: {
          lat: 52,
          lon: 71,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              240,
            ],
            max: [
              300,
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
    hurs: {
      minimum: -101.85,
      maximum: 179.44,
      'gee:estimated_range': true,
    },
    huss: {
      minimum: -0.007,
      maximum: 11.76,
      'gee:estimated_range': true,
    },
    pr: {
      minimum: 0.0,
      maximum: 0.0083,
      'gee:estimated_range': true,
    },
    rlds: {
      minimum: -481.17,
      maximum: 908.96,
      'gee:estimated_range': true,
    },
    rsds: {
      minimum: -702710.19,
      maximum: 553087.44,
      'gee:estimated_range': true,
    },
    sfcWind: {
      minimum: -4.98,
      maximum: 28.29,
      'gee:estimated_range': true,
    },
    tas: {
      minimum: 192.15,
      maximum: 336.94,
      'gee:estimated_range': true,
    },
    tasmin: {
      minimum: 163.66,
      maximum: 334.92,
      'gee:estimated_range': true,
    },
    tasmax: {
      minimum: 202.09,
      maximum: 352.77,
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
    All CMIP6 GCM model inputs and any derivatives work, such as this dataset,
    are governed by the original
    [Terms of use](https://pcmdi.llnl.gov/CMIP6/TermsOfUse/TermsOfUse6-1.html)
    and may have some restrictions on usage. See the "license" property on
    each EE Image that notes the specific license the data may fall under.

    (Note that while the official Terms of Use mention that some models are
    restricted under '%s' (%s), models available in EarthEngine either fall
    under '%s' (%s) or '%s' (%s).)
  ||| % [
    spdx.cc_by_sa_4_0.id, spdx.cc_by_sa_4_0.name, spdx.cc_by_4_0.id,
    spdx.cc_by_4_0.name, spdx.cc0_1_0.id, spdx.cc0_1_0.name
  ]
}
