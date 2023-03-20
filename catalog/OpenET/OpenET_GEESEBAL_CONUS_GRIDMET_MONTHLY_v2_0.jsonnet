local id = 'OpenET/GEESEBAL/CONUS/GRIDMET/MONTHLY/v2_0';
local subdir = 'OpenET';

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
  title: 'OpenET CONUS geeSEBAL Monthly Evapotranspiration v2.0',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Implementation of geeSEBAL was recently completed within the OpenET framework and an overview of
    the current geeSEBAL version can be found in Laipelt et al. (2021), which is based on the original
    algorithms developed by Bastiaanssen et al. (1998). The OpenET geeSEBAL implementation uses land surface
    temperature (LST) data from Landsat Collection 2, in addition to NLDAS and gridMET datasets as instantaneous
    and daily meteorological inputs, respectively. The automated statistical algorithm to select the hot and
    cold endmembers is based on a simplified version of the Calibration using Inverse Modeling at
    Extreme Conditions (CIMEC) algorithm proposed by Allen et al. (2013), where quantiles of LST and the
    normalized difference vegetation index (NDVI) values are used to select endmember candidates in the
    Landsat domain area. The cold and wet endmember candidates are selected in well vegetated areas, while
    the hot and dry endmember candidates are selected in the least vegetated cropland areas. Based on the
    selected endmembers, geeSEBAL assumes that in the cold and wet endmember all available energy is converted
    to latent heat (with high rates of transpiration), while in the hot and dry endmember all available energy is
    converted to sensible heat. Finally, estimates of daily evapotranspiration are upscaled from instantaneous
    estimates based on the evaporative fraction, assuming it is constant during the daytime without significant
    changes in soil moisture and advection. Based on the results from the OpenET Accuracy Assessment and
    Intercomparison study, the OpenET geeSEBAL algorithm was modified as follows: (i) the simplified version of
    CIMEC was improved by using additional filters to select the endmembers, including the use of the
    USDA Cropland Data Layer (CDL) and filters for NDVI, LST and albedo; (ii) corrections to LST for
    endmembers based on antecedent precipitation; (iii) definition of NLDAS wind speed thresholds to reduce
    model instability during the atmospheric correction; and, (iv) improvements to estimate daily net
    radiation, using FAO-56 as reference (Allen et al., 1998). Overall, geeSEBAL performance is dependent on
    topographic, climate, and meteorological conditions, with higher sensitivity and uncertainty related to hot
    and cold endmember selections for the CIMEC automated calibration, and lower sensitivity and uncertainty
    related to meteorological inputs (Laipelt et al., 2021 and Kayser et al., 2022). To reduce uncertainties
    related to complex terrain, improvements were added to correct LST and global (incident) radiation on the
    surface (including the environmental lapse rate, elevation slope and aspect) to represent the effects of
    topographic features on the model’s endmember selection algorithm and ET estimates.

    [Additional information](https://openetdata.org/methodologies/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'conus',
    'evapotranspiration',
    'gridmet_derived',
    'landsat_derived',
    'monthly',
    'water',
    'geesebal'
  ],
  providers: [
    ee.producer_provider('OpenET, Inc.', 'https://openetdata.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-126.0, 25.0, -66.0, 50.0, '2016-01-01T00:00:00Z', null),
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'et',
        description: |||
          geeSEBAL ET value
        |||,
        'gee:units': 'mm',
      },

      {
        name: 'count',
        description: |||
           Number of cloud free values
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET geeSEBAL Monthly ET',
        lookat: {
          lat: 38.0,
          lon: -100.0,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1400.0,
            ],
            palette: [
              '9E6212',
              'AC7D1D',
              'BA9829',
              'C8B434',
              'D6CF40',
              'BED44B',
              '9FCB51',
              '80C256',
              '61B95C',
              '42B062',
              '45B677',
              '49BC8D',
              '4DC2A2',
              '51C8B8',
              '55CECE',
              '4DB4BA',
              '459AA7',
              '3D8094',
              '356681',
              '2D4C6E',
            ],
            bands: [
              'et',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.1111/1752-1688.12956',
  'sci:citation': |||
    Bastiaanssen, W.G., Menenti, M., Feddes, R.A. and Holtslag, A.A.M., 1998. A remote sensing surface
    energy balance algorithm for land (SEBAL). 1. Formulation. Journal of hydrology, 212, pp.198-212.

    Laipelt, L., Kayser, R.H.B., Fleischmann, A.S., Ruhoff, A., Bastiaanssen, W., Erickson, T.A. and M
    elton, F., 2021. Long-term monitoring of evapotranspiration using the SEBAL algorithm and
    Google Earth Engine cloud computing. ISPRS Journal of Photogrammetry and Remote Sensing, 178, pp.81-96.

    Kayser, R.H., Ruhoff, A., Laipelt, L., de Mello Kich, E., Roberti, D.R., de Arruda Souza, V., Rubert,
    G.C.D., Collischonn, W. and Neale, C.M.U., 2022. Assessing geeSEBAL automated calibration and meteorological
    reanalysis uncertainties to estimate evapotranspiration in subtropical humid climates. Agricultural and
    Forest Meteorology, 314, p.108775.

    Allen, R.G., Burnett, B., Kramber, W., Huntington, J., Kjaersgaard, J., Kilic, A., Kelly, C. and Trezza, R., 2013.
    Automated calibration of the metric‐landsat evapotranspiration process. JAWRA Journal of the
    American Water Resources Association, 49(3), pp.563-576.

    [doi:10.1111/1752-1688.12956](https://doi.org/10.1111/1752-1688.12956)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
