local id = 'CAS/IGSNRR/PML/V2_v018';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/IGSNRR_PML_versions.libsonnet';

local subdir = 'CAS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.cc_by_4_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title:
    'PML_V2 ' + version +
    ': Coupled Evapotranspiration and Gross Primary Product (GPP)',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Penman-Monteith-Leuning Evapotranspiration V2 (PML_V2) products include
    evapotranspiration (ET), its three components, and
    gross primary product (GPP) at 500m and 8-day resolution during 2000-2023
    and with spatial range from -60&deg;S to 90&deg;N. The major advantages of the
    PML_V2 products are:

      1. Coupled estimates of transpiration and GPP via canopy
      conductance (Gan et al., 2018; Zhang et al., 2019)
      2. Partitioning ET into three components: transpiration from vegetation,
      direct evaporation from the soil, and vaporization of intercepted
       rainfall from vegetation (Zhang et al., 2016).

    The PML_V2 products perform well against observations
    at 95 flux sites across globe, and are similar to or noticeably better than
    major state-of-the-art ET and GPP products widely used by water and ecology
    science communities (Zhang et al., 2019).

    Key changes in v0.1.8 compared with the original v0.1.4:

    1. Temporal coverage is lengthened to the latest (may update annually) with the MODIS C6.1 data.
    2. MODIS Terra LAI (MOD15A2H) is used rather than the composite LAI (MCD15A3H).
    3. Parameters are recalibrated with the change in LAI, while other forcings remain the same.
  |||,
  license: license.id,

  // links: ee.standardLinks(subdir, id) + version_config.version_links,
  // for testing
  links: ee.standardLinks(subdir, id),

  keywords: [
    'evapotranspiration',
    'gpp',
  ],
  providers: [
    ee.producer_provider('PML_V2', 'https://github.com/kongdd/PML'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 90.0, '2000-02-26T00:00:00Z', null),
  summaries: {
    gsd: [500.0],
    'eo:bands': [
      {
        name: 'GPP',
        description: 'Gross primary product',
        'gee:units': 'gC m-2 d-1',
      },
      {
        name: 'Ec',
        description: 'Vegetation transpiration',
        'gee:units': units.millimeter_per_day,
      },
      {
        name: 'Es',
        description: 'Soil evaporation',
        'gee:units': units.millimeter_per_day,
      },
      {
        name: 'Ei',
        description: 'Interception from vegetation canopy',
        'gee:units': units.millimeter_per_day,
      },
      {
        name: 'ET_water',
        description: |||
          Water body, snow and ice evaporation. Penman evapotranspiration is
          regarded as actual evaporation for them.
        |||,
        'gee:units': units.millimeter_per_day,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'PML_V2 ' + version + ' Gross Primary Product (GPP)',
        lookat: {
          lon: 66.3,
          lat: 15.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [0.0],
            max: [9.0],
            palette: [
              'a50026',
              'd73027',
              'f46d43',
              'fdae61',
              'fee08b',
              'ffffbf',
              'd9ef8b',
              'a6d96a',
              '66bd63',
              '1a9850',
              '006837',
            ],
            bands: ['GPP'],
          },
        },
      },
    ],
    GPP: {
      minimum: 0.0,
      maximum: 39.01,
      'gee:estimated_range': true,
    },
    Ec: {
      minimum: 0.0,
      maximum: 15.33,
      'gee:estimated_range': true,
    },
    Es: {
      minimum: 0.0,
      maximum: 8.2,
      'gee:estimated_range': true,
    },
    Ei: {
      minimum: 0.0,
      maximum: 12.56,
      'gee:estimated_range': true,
    },
    ET_water: {
      minimum: 0.0,
      maximum: 20.11,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Zhang, Y., Kong, D., Gan, R., Chiew, F.H.S., McVicar, T.R., Zhang, Q.,
    and Yang, Y., 2019. Coupled estimation of 500m and 8-day resolution global
    evapotranspiration and gross primary production in 2002-2017.
    Remote Sens. Environ. 222, 165-182,
    [doi:10.1016/j.rse.2018.12.031](https://doi.org/10.1016/j.rse.2018.12.031)
  |||,
  'sci:publications': [
    {
      citation: |||
        Gan, R., Zhang, Y.Q., Shi, H., Yang, Y.T., Eamus, D., Cheng, L.,
        Chiew, F.H.S., Yu, Q., 2018. Use of satellite leaf area index estimating
        evapotranspiration and gross assimilation for Australian ecosystems.
        Ecohydrology, [doi:10.1002/eco.1974](https://doi.org/10.1002/eco.1974)
      |||,
      doi: '10.1002/eco.1974',
    },
    {
      citation: |||
        Zhang, Y., Peña-Arancibia, J.L., McVicar, T.R., Chiew, F.H.S., Vaze, J.,
        Liu, C., Lu, X., Zheng, H., Wang, Y., Liu, Y.Y., Miralles, D.G., Pan,
        M., 2016. Multi-decadal trends in global terrestrial evapotranspiration
        and its components. Sci. Rep. 6, 19124.
        [doi:10.1038/srep19124](https://doi.org/10.1038/srep19124)
      |||,
      doi: '10.1038/srep19124',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    Acknowledgements

    Whenever PML datasets are used in a scientific publication, the given
    references should be cited.

    License

    The dataset is licensed under the
    [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).
  |||,
  'gee:user_uploaded': true,
}
