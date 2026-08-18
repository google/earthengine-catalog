local id = 'projects/openet/assets/ssebop/conus/gridmet/monthly/v2_1';
local subdir = 'OpenET';
local version = '2.1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local collection_v2_1 = importstr 'collection_v2_1.md';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'OpenET SSEBop Monthly Evapotranspiration v' + version,
  version: version,
  description: |||
    Operational Simplified Surface Energy Balance (SSEBop).

    The Operational Simplified Surface Energy Balance (SSEBop) model
    (Senay et al., 2013; 2023) is a thermal based approach for estimating
    actual evapotranspiration (ET) using the principles of satellite
    psychrometry (Senay, 2018). As one of the core models in the OpenET
    ensemble, SSEBop provides a computationally efficient framework for large-
    area, operational ET mapping.

    The OpenET Collection 2.1 implementation of SSEBop relies on two primary
    inputs:

    1. Land surface temperature from Landsat Collection 2 Level 2 Science
    Products.
    2. Gridded reference ET from gridMET (Abotzoglou, 2013).

    Key model parameters, including the cold/wet bulb reference temperature
    (Tc) and the surface psychrometric constant (1/dT), are derived using a
    combination of observed surface temperature, normalized difference
    vegetation index (NDVI), and ERA5 net radiation data
    (DOI: 10.5066/P9JBW6R9). These components are integrated within the Google
    Earth Engine processing environment, which links the full suite of SSEBop
    algorithms to generate both intermediate outputs and aggregated ET
    products. Extensive evaluation across the conterminous United States
    (Senay et al., 2022; Volk et al., 2024; Ji et al., 2025; Khand et al, 2025)
    has guided the cloud-based implementation and demonstrated the model’s
    utility for applications such as crop water use assessment and regional
    water budget analysis.

    For OpenET Collection 2.1, SSEBop model v0.7.1 (Senay et al., 2026)
    includes a notable enhancement: an improved implementation of the Forcing
    and Normalizing Operation (FANO) equation for determining Tc. This update
    strengthens the model’s ability to represent wet surfaces with low NDVI,
    improving performance in areas where vegetation signals are weak or mixed,
    particularly over farmlands and grasslands during sparse canopy cover.
  ||| + collection_v2_1,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['water-vapor'],
  keywords: [
    'evapotranspiration',
    'gridmet_derived',
    'landsat_derived',
    'monthly',
    'openet',
    'water',
  ],
  providers: [
    ee.producer_provider('OpenET, Inc.', 'https://etdata.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-126, 25, -66, 50, '2015-10-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'build_date',
        description: 'Date assets were built',
        type: ee_const.var_type.string,
      },
      {
        name: 'build_status',
        description: 'Status can be "permanent" or "provisional".  Images flagged as "provisional" may be updated in the future.',
        type: ee_const.var_type.string,
      },
      {
        name: 'cloud_cover_max',
        description: 'Maximum CLOUD_COVER_LAND percent value for Landsat images included in interpolation',
        type: ee_const.var_type.double,
      },
      {
        name: 'collections',
        description: 'List of Landsat collections for Landsat images included in the interpolation',
        type: ee_const.var_type.string,
      },
      {
        name: 'core_version',
        description: 'OpenET core library version',
        type: ee_const.var_type.string,
      },
      {
        name: 'end_date',
        description: 'End date of month',
        type: ee_const.var_type.string,
      },
      {
        name: 'et_reference_band',
        description: 'Band in et_reference_source that contains the daily reference ET data',
        type: ee_const.var_type.string,
      },
      {
        name: 'et_reference_resample',
        description: 'Spatial interpolation mode to resample daily reference ET data',
        type: ee_const.var_type.string,
      },
      {
        name: 'et_reference_source',
        description: 'Collection ID for the daily reference ET data',
        type: ee_const.var_type.string,
      },
      {
        name: 'image_source_count',
        description: 'Number of scene images used in the interpolation',
        type: ee_const.var_type.double,
      },
      {
        name: 'interp_days',
        description: 'Maximum number of days before and after each image date to include in interpolation',
        type: ee_const.var_type.double,
      },
      {
        name: 'interp_method',
        description: 'Method used to interpolate between Landsat model estimates',
        type: ee_const.var_type.string,
      },
      {
        name: 'interp_source_count',
        description: 'Number of available images in the interpolation source image collection for the target month',
        type: ee_const.var_type.double,
      },
      {
        name: 'mgrs_tile',
        description: 'MGRS grid zone ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'model_name',
        description: 'OpenET model name',
        type: ee_const.var_type.string,
      },
      {
        name: 'model_version',
        description: 'OpenET model version',
        type: ee_const.var_type.string,
      },
      {
        name: 'scale_factor_count',
        description: 'Scaling factor that should be applied to the count band',
        type: ee_const.var_type.double,
      },
      {
        name: 'scale_factor_et',
        description: 'Scaling factor that should be applied to the et band',
        type: ee_const.var_type.double,
      },
      {
        name: 'start_date',
        description: 'Start date of month',
        type: ee_const.var_type.string,
      },
      {
        name: 'units_et',
        description: 'Units of the "et" band',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'et',
        description: 'Total actual evapotranspiration (ET)',
        'gee:units': units.millimeter,
      },
      {
        name: 'count',
        description: 'Number of cloud free observations in the month included in the interpolation',
        'gee:units': units.count,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET SSEBop Monthly ET',
        lookat: {
          lat: 38,
          lon: -100,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [1400],
            palette: [
              '9e6212', 'ac7d1d', 'ba9829', 'c8b434', 'd6cf40', 'bed44b',
              '9fcb51', '80c256', '61b95c', '42b062', '45b677', '49bc8d',
              '4dc2a2', '51c8b8', '55cece', '4db4ba', '459aa7', '3d8094',
              '356681', '2d4c6e',
            ],
            bands: ['et'],
          },
        },
      },
    ],
  },
  'sci:doi': '10.3390/rs15010260',
  'sci:citation': |||
    Senay, G.B., Parrish, G.E., Schauer, M., Friedrichs, M., Khand, K., Boiko,
    O., Kagone, S., Dittmeier, R., Arab, S. and Ji, L., 2023. Improving the
    Operational Simplified Surface Energy Balance Evapotranspiration Model Using
    the Forcing and Normalizing Operation. Remote Sensing, 15(1), p.260.
    [doi:10.3390/rs15010260](https://doi.org/10.3390/rs15010260)
  |||,
  'sci:publications': [
    {
      citation: |||
        Senay, G.B., Bohms, S., Singh, R.K., Gowda, P.H., Velpuri, N.M., Alemu,
        H. and Verdin, J.P., 2013. Operational evapotranspiration mapping using
        remote sensing and weather datasets: A new parameterization for the SSEB
        approach. JAWRA Journal of the American Water Resources Association,
        49(3), pp.577-591.
        [doi:10.1111/jawr.12057](https://doi.org/10.1111/jawr.12057)
      |||,
    },
    {
      citation: |||
        Senay, G.B., Schauer, M., Friedrichs, M., Velpuri, N.M. and Singh, R.K.,
        2017. Satellite-based water use dynamics using historical Landsat data
        (1984–2014) in the southwestern United States. Remote Sensing of
        Environment, 202, pp.98-112.
        [doi:10.1016/j.rse.2017.05.005c](https://doi.org/10.1016/j.rse.2017.05.005)
      |||,
    },
    {
      citation: |||
        Senay, G.B., 2018. Satellite psychrometric formulation of the
        Operational Simplified Surface Energy Balance (SSEBop) model for
        quantifying and mapping evapotranspiration. Applied Engineering in
        Agriculture, 34(3), pp.555-566.
        [doi:10.13031/aea.12614](https://doi.org/10.13031/aea.12614)
      |||,
    },
    {
      citation: |||
        Senay, G.B., Friedrichs, M., Morton, C., Parrish, G.E., Schauer, M.,
        Khand, K., Kagone, S., Boiko, O. and Huntington, J., 2022.  Mapping
        actual evapotranspiration using Landsat for the conterminous United
        States: Google Earth Engine implementation and assessment of the SSEBop
        model. Remote Sensing of Environment, 275, p.113011.
        [doi:10.1016/j.rse.2022.113011](https://doi.org/10.1016/j.rse.2022.113011)
      |||,
    },
   ],
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:type': ee_const.gee_type.image_collection,
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
