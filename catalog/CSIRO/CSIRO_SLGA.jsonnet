local id = 'CSIRO/SLGA';
local subdir = 'CSIRO';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'SLGA: Soil and Landscape Grid of Australia (Soil Attributes)',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Soil and Landscape Grid of Australia (SLGA) is a comprehensive dataset
    of soil attributes across Australia at 3 arc-second resolution (~90m
    pixels). The surfaces are the outcomes from modelling that describe the
    spatial distribution of the soil attributes using existing soil data and
    environmental covariates. See [Viscarra Rossel et al (2015)](https://www.publish.csiro.au/sr/SR14366)
    for further details. The SLGA can be used in studies of vadose zone
    processes, including solute transport, groundwater and nutrient fluxes
    beyond the root zone, as well as a wide spectrum of ecological,
    hydrological, and broader environmental applications.

    Each product contains six digital soil attribute maps and their upper and
    lower confidence limits, representing the soil attribute at six depths:
    0-5cm, 5-15cm, 15-30cm, 30-60cm, 60-100cm, and 100-200cm. These depths and
    soil attributes are consistent with the specifications of
    [GlobalSoilMap](https://www.isric.org/projects/globalsoilmapnet).

    This collection has 12 images. Ten of them contain data for GSM primary
    soil attributes; the other two contain regolith depth and soil depth GSM
    attributes.

    | Attribute                              | Description                                                                                                                   | Code | # of Bands |
    |----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|------|------------|
    | Bulk Density (whole earth)             | Bulk density of the whole soil (including coarse fragments) in mass per unit volume by a method equivalent to the core method | BDW  | 18         |
    | Organic Carbon                         | Mass fraction of carbon by weight in the < 2mm soil material as determined by dry combustion at 900 Celsius                   | SOC  | 18         |
    | Clay                                   | < 2μm mass fraction of the <2mm soil material determined using the pipette method                                             | CLY  | 18         |
    | Silt                                   | 2-20μm mass fraction of the < 2mm soil material determined using the pipette method                                           | SLT  | 18         |
    | Sand                                   | 20μm - 2mm mass fraction of the < 2mm soil material determined using the pipette method                                       | SND  | 18         |
    | pH (CaCl2)                             | pH of 1:5 soil/0.01M calcium chloride extract                                                                                 | pHc  | 18         |
    | Available Water Capacity               | Available water capacity computed for each of the specified depth increments                                                  | AWC  | 18         |
    | Total Nitrogen                         | Mass fraction of total nitrogen in the soil by weight                                                                         | NTO  | 18         |
    | Total Phosphorus                       | Mass fraction of total phosphorus in the soil by weight                                                                       | PTO  | 18         |
    | Effective Cation Exchange Capacity     | Cations extracted using barium chloride (BaCl2) plus exchangeable H + Al                                                      | ECE  | 18         |
    | Depth of Regolith                      | Depth to hard rock. Depth is inclusive of all regolith.                                                                       | DER  | 3          |
    | Depth of Soil                          | Depth of soil profile (A & B horizons)                                                                                        | DES  | 3          |
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://www.clw.csiro.au/aclep/soilandlandscapegrid/'),
    ee.link.license('https://www.clw.csiro.au/aclep/soilandlandscapegrid/About-Disclaimer.html'),
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546ED604ADD8A',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546EE212B0048',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546EEE35164BF',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546F091C11777',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546F17EC6AB6E',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546F29646877E',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546F48D6A6D48',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546F540FE10AA',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546F564AE11F9',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/546F617719CAF',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/547523BB0801A',
    },
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.4225/08/55C9472F05295',
    },
  ],
  keywords: [
    'australia',
    'csiro',
    'digital_soil_mapping',
    'globalsoilmap',
    'slga',
    'soil',
    'soil_depth',
    'tern',
  ],
  providers: [
    ee.producer_provider('CSIRO/SLGA', 'https://www.clw.csiro.au/aclep/soilandlandscapegrid/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(113.0, -44.15, 154.0, -9.97,
                    '1950-01-01T00:00:00Z', '2013-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'anzlic_topic_category',
        description: "Topic category according to Australia's and New Zealand's Spatial\nInformation Council",
        type: ee_const.var_type.string,
      },
      {
        name: 'contact',
        description: 'General contact',
        type: ee_const.var_type.string,
      },
      {
        name: 'contact_gee_ingestion',
        description: 'Who to contact for issues related to Earth Engine ingestion',
        type: ee_const.var_type.string,
      },
      {
        name: 'contact_lead_researcher',
        description: 'Lead Researcher',
        type: ee_const.var_type.string,
      },
      {
        name: 'contact_project_director',
        description: 'Project Director',
        type: ee_const.var_type.string,
      },
      {
        name: 'contact_project_leader',
        description: 'Project Leader',
        type: ee_const.var_type.string,
      },
      {
        name: 'country',
        description: 'Country this asset covers',
        type: ee_const.var_type.string,
      },
      {
        name: 'country_code',
        description: 'ISO country code',
        type: ee_const.var_type.string,
      },
      {
        name: 'credit',
        description: 'Credit',
        type: ee_const.var_type.string,
      },
      {
        name: 'datatype',
        description: "'Numeric Value' or 'Categorical Value'",
        type: ee_const.var_type.string,
      },
      {
        name: 'datatype_code',
        description: "'N' or 'C'",
        type: ee_const.var_type.string,
      },
      {
        name: 'date_created',
        description: 'Date of publication',
        type: ee_const.var_type.double,
      },
      {
        name: 'estimate_spatial_support',
        description: "GSM v2.3 tier 1 or 2, 'P' or 'B'",
        type: ee_const.var_type.string,
      },
      {
        name: 'estimate_spatial_support_code',
        description: "'Point estimate' or 'Block estimate'",
        type: ee_const.var_type.string,
      },
      {
        name: 'field_of_research',
        description: "'Soil sciences not elsewhere classified'",
        type: ee_const.var_type.string,
      },
      {
        name: 'gsm_type',
        description: 'GlobalSoilMap attribute type',
        type: ee_const.var_type.string,
      },
      {
        name: 'product_type',
        description: |||
          'Data mining-kriging methods', 'Composite models. Various modelling
          combined with variance weighted averaging', or 'Polygon disaggregation
          methods'
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'product_type_code',
        description: "'N', 'C', or 'D'",
        type: ee_const.var_type.string,
      },
      {
        name: 'project',
        description: |||
          ' National Soil Attribute Maps - Composite product', 'Australia-wide 3D
          Soil Attribute Maps', 'Western Australia Polygon Dissaggregation (DAFW)',
          'South Australia Polygon Dissaggregation (DEWNR)', or 'Tasmania (DPIWE)
          Soil Attribute Mapping'
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'project_code',
        description: "'NAT', 'TRN', 'WAT', 'SAT', or 'TAS'",
        type: ee_const.var_type.string,
      },
      {
        name: 'provider_url',
        description: 'Provider URL',
        type: ee_const.var_type.string,
      },
      {
        name: 'rights_statement',
        description: 'Rights statement',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      92.77,
    ],
    'eo:bands': [
      {
        name: 'AWC_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'AWC_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'BDW_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'BDW_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
        'gee:units': 'g/cm^3',
      },
      {
        name: 'CLY_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'CLY_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'DER_000_200_EV',
        description: 'The estimated value for the regolith depth',
        'gee:units': 'm',
      },
      {
        name: 'DER_000_200_05',
        description: 'The 5th percentile confidence limit for the regolith depth',
        'gee:units': 'm',
      },
      {
        name: 'DER_000_200_95',
        description: 'The 95th percentile confidence limit for the regolith depth',
        'gee:units': 'm',
      },
      {
        name: 'DES_000_200_EV',
        description: 'The estimated value for the soil depth',
        'gee:units': 'm',
      },
      {
        name: 'DES_000_200_05',
        description: 'The 5th percentile confidence limit for the soil depth',
        'gee:units': 'm',
      },
      {
        name: 'DES_000_200_95',
        description: 'The 5th percentile confidence limit for the soil depth',
        'gee:units': 'm',
      },
      {
        name: 'ECE_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'ECE_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
        'gee:units': 'meq/100g',
      },
      {
        name: 'NTO_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'NTO_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'pHc_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
      },
      {
        name: 'pHc_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
      },
      {
        name: 'pHc_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
      },
      {
        name: 'pHc_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
      },
      {
        name: 'pHc_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
      },
      {
        name: 'pHc_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
      },
      {
        name: 'pHc_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
      },
      {
        name: 'pHc_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
      },
      {
        name: 'pHc_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
      },
      {
        name: 'pHc_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
      },
      {
        name: 'pHc_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
      },
      {
        name: 'pHc_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
      },
      {
        name: 'pHc_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
      },
      {
        name: 'pHc_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
      },
      {
        name: 'pHc_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
      },
      {
        name: 'pHc_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
      },
      {
        name: 'pHc_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
      },
      {
        name: 'pHc_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
      },
      {
        name: 'PTO_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'PTO_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'SLT_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'SND_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'SND_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'SND_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'SND_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'SND_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'SND_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'SND_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'SND_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'SND_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'SND_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'SND_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'SND_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'SND_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'SND_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'SND_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'SND_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'SND_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'SND_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_000_005_EV',
        description: "The soil attribute's estimated value at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_000_005_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_000_005_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 0-5cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_005_015_EV',
        description: "The soil attribute's estimated value at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_005_015_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_005_015_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 5-15cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_015_030_EV',
        description: "The soil attribute's estimated value at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_015_030_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_015_030_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 15-30cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_030_060_EV',
        description: "The soil attribute's estimated value at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_030_060_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_030_060_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 30-60cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_060_100_EV',
        description: "The soil attribute's estimated value at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_060_100_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_060_100_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 60-100cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_100_200_EV',
        description: "The soil attribute's estimated value at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_100_200_05',
        description: "The soil attribute's 5th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
      {
        name: 'SOC_100_200_95',
        description: "The soil attribute's 95th percentile confidence limit at depth 100-200cm",
        'gee:units': '%',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Soil Depth',
        lookat: {
          lat: -21.984,
          lon: 132.495,
          zoom: 5,
        },
        filter: {
          filter_name: 'EQUALS',
          property_name: 'attribute_code',
          property_value: 'DES',
        },
        image_visualization: {
          band_vis: {
            min: [
              0.1,
            ],
            max: [
              1.84,
            ],
            palette: [
              '8d6738',
              '252525',
            ],
            bands: [
              'DES_000_200_EV',
            ],
          },
          image_id: 'CSIRO/SLGA/DES',
        },
      },
    ],
  },
  'sci:doi': '10.4225/08/546ED604ADD8A',
  'gee:extra_dois': [
    '10.4225/08/546EE212B0048',
    '10.4225/08/546EEE35164BF',
    '10.4225/08/546F091C11777',
    '10.4225/08/546F17EC6AB6E',
    '10.4225/08/546F29646877E',
    '10.4225/08/546F48D6A6D48',
    '10.4225/08/546F540FE10AA',
    '10.4225/08/546F564AE11F9',
    '10.4225/08/546F617719CAF',
    '10.4225/08/547523BB0801A',
    '10.4225/08/55C9472F05295',
  ],
  'sci:citation': |||
    Viscarra Rossel, Raphael; Chen, Charlie; Grundy, Mike; Searle, Ross;
    Clifford, David; Odgers, Nathan; Holmes, Karen; Griffin, Ted; Liddicoat,
    Craig; Kidd, Darren (2014): Soil and Landscape Grid National Soil Attribute
    Maps - SOIL ATTRIBUTE Release 1. v2. CSIRO. Data Collection
    [doi:10.1071/SR14366](https://doi.org/10.1071/SR14366).
  |||,
  'gee:terms_of_use': |||
    All products developed by the Soil and Landscape Grid of Australia are
    available at no cost under a
    [Creative Commons Attribution Licence](https://creativecommons.org/licenses/by/4.0/)
    (CC BY) and users should read the
    [Disclaimer](https://www.clw.csiro.au/aclep/soilandlandscapegrid/About-Disclaimer.html).
  |||,
}
