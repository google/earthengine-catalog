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
    of dike flood protection strategies.

    Aqueduct Floods aims to empower disaster risk analysts and managers with
    quantitative information on food risks and adaptation strategy costs, and to
    help inform policy and investment decision-making.

    Google Earth Engine team recommendation:

    This dataset can be used for:

    * Larger scale regional analysis: what is the broad risk to the big area of
      the size of a US county level / large city?
    * Preliminary assessments: when you need a quick, regional-scale "first
      look" at potential changes in river discharge without needing precise
      floodplain inundation maps.
    * Relative changes: This looks at different climate scenarios so can be
      used for generalized changes in magnitude of impacts

    This dataset should not be used for:

    * Detailed flood inundation mapping: such as looking at properties specific
      risk
    * Flat, lowland rivers: the simplification of the equations do not take
      into account backwater effects (water flowing backwards) which happens a
      lot in flood plains
    * Analyzing hydraulic structures: it is not suitable for assessing the
      specific impact of structures like bridges, levees, or weirs that cause
      significant backwater effects

    Please see
    [the technical note](https://files.wri.org/d8/s3fs-public/aqueduct-floods-methodology.pdf)
    from data provider for full details on the methods used and to
    understand if this data is right for your application.

  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['surface-ground-water'],
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
        description: |||
          Sea level rise scenario (in percentile)

          * 5: A low sea level rise scenario
          * 50: The median sea level rise projection
          * 95: A high sea level rise scenario
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'returnperiod',
        description: |||
          Return period is the average time interval expected between hazard
          events of a given magnitude or greater (in years). The flood hazard
          maps are generated for return periods of 1, 2, 5, 10, 25, 50, 100,
          250, 500, and 1000 years.
        |||,
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

          * 000000000WATCH: Baseline condition
          * 00000NorESM1-M: (GCM model) Bjerknes Centre for Climate Research,
            Norwegian Meteorological Institute
          * 0000GFDL_ESM2M: (GCM model) Geophysical Fluid Dynamics Laboratory
            (NOAA)
          * 0000HadGEM2-ES: (GCM model) Met Office Hadley Centre
          * 00IPSL-CM5A-LR: (GCM model) Institut Pierre Simon Laplace
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
      maximum: 32.05,
      'gee:estimated_range': true,
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
