local id = 'projects/pml_evapotranspiration/PML/OUTPUT/PML_V22a';
local subdir = 'pml_evapotranspiration';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  'gee:status': 'beta',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'PML_V2.2a: Coupled Evapotranspiration and Gross Primary Product (GPP)',
  version: '2.2a',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The dataset is produced by the Large Scale Hydrology Lab, which specializes in advancing global and regional water cycle research 
    through big data analytics and advanced hydrological modeling. 

    The PML-V2.2a product provides 500m 8-day resolution global terrestrial evapotranspiration (ET) 
    and gross primary production (GPP) from 2000 to 2024. Driven by MSWEP and MSWX, this version 
    features expanded bottom-up calibration using 208 flux sites and refined parameterization 
    distinguishing irrigated from rainfed croplands.

    Validation confirms high accuracy across plant functional types (NSE > 0.60, absolute bias < 5%) 
    and reliable basin-scale water-balance performance (NSE: 0.89–0.91). This MODIS-based 
    record is optimized for high-resolution near-present monitoring.

    This dataset is part of the broader PML-V2.2 suite. For the long-term 43-year consolidated 
    record (PML-V2.2b/c at 0.1° with different remote sensing forcing), please visit the [TPDC data repository](https://doi.org/10.11888/Terre.tpdc.303314).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  'gee:categories': ['plant-productivity', 'water-vapor'],
  keywords: [
    'evapotranspiration',
    'gpp',
    //'pml',
    //'water-carbon',
  ],
  providers: [
    ee.producer_provider('Large Scale Hydrology Lab', 'https://scholar.google.com/citations?user=t5iGFeAAAAAJ&hl=en'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 90.0, '2000-03-05T00:00:00Z', null),
  summaries: {
    gsd: [500.0],
    'eo:bands': [
      { 
        name: 'GPP', 
        description: 'Gross primary production', 
        'gee:units': 'gC m-2 d-1',
        'gee:scale': 0.01
      },
      { 
        name: 'ET', 
        description: 'Actual evapotranspiration', 
        'gee:units': units.millimeter_per_day,
        'gee:scale': 0.01 
      },
      { 
        name: 'Ec', 
        description: 'Vegetation transpiration', 
        'gee:units': units.millimeter_per_day,
        'gee:scale': 0.01 
      },
      { 
        name: 'Es', 
        description: 'Soil evaporation', 
        'gee:units': units.millimeter_per_day,
        'gee:scale': 0.01 
      },
      { 
        name: 'Ei', 
        description: 'Interception from vegetation canopy', 
        'gee:units': units.millimeter_per_day,
        'gee:scale': 0.01 
      },
      { 
        name: 'PET', 
        description: |||
          Potential evapotranspiration (PET). Calculated using the Shuttleworth-simplified 
          version of the Penman equation, which provides estimates of evaporation 
          from water bodies, snow, and ice.
        |||, 
        'gee:units': units.millimeter_per_day,
        'gee:scale': 0.01
      },
      { 
        name: 'Ew', 
        description: |||
          Evaporation from water bodies, snow, and ice. Calculated using the
          Penman equation, which is considered a good estimate of actual
          evaporation for these surfaces.
        |||, 
        'gee:units': units.millimeter_per_day,
        'gee:scale': 0.01
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'PML_V2.2a GPP',
        lookat: { lon: 116.3, lat: 40.0, zoom: 5 },
        image_visualization: {
          band_vis: {
            min: [0.0],
            max: [900.0],
            palette: ['a50026', 'd73027', 'f46d43', 'fdae61', 'fee08b', 'ffffbf', 'd9ef8b', 'a6d96a', '66bd63', '1a9850', '006837'],
            bands: ['GPP'],
          },
        },
      },
    ],
    GPP: { minimum: 0.0, maximum: 3901.0, 'gee:estimated_range': true },
    ET: { minimum: 0.0, maximum: 2011.0, 'gee:estimated_range': true },
    Ec: { minimum: 0.0, maximum: 1533.0, 'gee:estimated_range': true },
    Es: { minimum: 0.0, maximum: 820.0, 'gee:estimated_range': true },
    Ei: { minimum: 0.0, maximum: 1256.0, 'gee:estimated_range': true },
    PET: { minimum: 0.0, maximum: 2011.0, 'gee:estimated_range': true },
    Ew: { minimum: 0.0, maximum: 2011.0, 'gee:estimated_range': true },
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
  'gee:interval': { type: 'cadence', unit: 'day', interval: 8 },
  'gee:terms_of_use': |||
    Acknowledgements
    Whenever PML datasets are used in a scientific publication, the given references should be cited.

    License
    The dataset is licensed under the [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).
  |||,
  'gee:user_uploaded': true,
}