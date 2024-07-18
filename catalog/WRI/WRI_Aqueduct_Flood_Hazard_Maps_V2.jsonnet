local id = 'WRI/Aqueduct_Flood_Hazard_Maps/V2';
local subdir = 'WRI';

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
  ],
  id: id,
  title: 'WRI Aqueduct Floods Hazard Maps Version 2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Aqueduct Floods data measures riverine and coastal food risks under both
    current baseline conditions and future projections in 2030, 2050, and 2080.
    In addition to providing hazard maps and assessing risks, Aqueduct Floods
    helps to conduct comprehensive cost-benefit analysis to evaluate the value
    of dike food protection strategies.

    Aqueduct Floods aims to empower disaster risk analysts and managers with
    quantitative information on food risks and adaptation strategy costs, and to
    help inform policy and investment decision-making.

    [This](https://files.wri.org/d8/s3fs-public/aqueduct-floods-methodology.pdf)
    technical note explains in detail the framework, methodology, and data used
    in developing Aqueduct Floods.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'flood',
    'monitoring',
    'wri',
  ],
  providers: [
    ee.producer_provider('World Resources Institute', 'https://www.wri.org/research/aqueduct-floods-methodology'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2010-01-01T00:00:00Z', '2080-12-31T23:59:59Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'climatescenario',
        description: |||
          Climate Scenario types:

          * historical: Baseline condition/ no climate scenario needed
          * rcp4p5: Representative Concentration Pathway 4.5 (steady carbon emissions)
          * rcp8p5: Representative Concentration Pathway 8.5 (rising carbon emissions)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'floodtype',
        description: |||
          Type of Flood:

          * inuncoast: Coastal flood hazard
          * inunriver: Riverine flood hazard
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'projection',
        description: 'Sea level rise scenario (in percentile)',
        type: ee_const.var_type.int,
      },
      {
        name: 'returnperiod',
        description: 'Return period of flood in years',
        type: ee_const.var_type.int,
      },
      {
        name: 'subsidence',
        description: |||
          Applies only for inuncoast flood type

          * nosub: Subsidence not included in projection
          * wtsub: Subsidence included in projection
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'model',
        description: |||
          Applies only for inunriver flood type, represents type of model used.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'year',
        description: 'Flood occurence year',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'inundation_depth',
        description: 'Flood inundation depth',
        'gee:units': units.meter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Aqueduct Flood Hazard Maps',
        lookat: {
          lon: -68.36,
          lat: -6.73,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1.0,
            ],
            palette: [
              'ffffff',
              '0000ff',
            ],
            bands: [
              'inundation_depth',
            ],
          },
        },
      },
    ],
    inundation_depth: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
  },
  'gee:terms_of_use': |||
    The WRI datasets are available without restriction
    on use or distribution. WRI does request that the
    user give proper attribution and identify WRI, where applicable,
    as the source of the data. For more information check
    [WRI's open data commitment](https://www.wri.org/data/open-data-commitment),
  |||,
}
