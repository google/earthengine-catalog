local id = 'OpenET/REFERENCE_ET/CONUS/GRIDMET/MONTHLY/v1_0';
local subdir = 'OpenET';
local version = '1.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'OpenET Bias Corrected GRIDMET Monthly Reference Evapotranspiration v' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Gridded reference evapotranspiration (ETo) data from gridMET (https://www
    .climatologylab.org/gridmet.html) and weather data from agriculturally
    located weather stations were used to to create monthly bias correction
    surfaces that can be used to correct or examine gridMET ETo bias. Like
    other gridded weather datasets, gridMET may exhibit bias over irrigated
    agriculture due to the cooling effects of irrigation and feedbacks
    between the land surface and atmosphere that are not well accounted for
    in the underlying data and methods of gridded weather data production.
    For example, gridded datasets, including gridMET, incorporate data from
    observational networks that include non agricultural observations.

    To produce this asset, weather station data was collected from
    approximately 800 agricultural weather stations that met the well-watered
    criteria, their data were subject to quality assurance and quality
    control using the agweather-qaqc Python package (https://github
    .com/WSWUP/agweather-qaqc), and the American Society of Civil Engineers
    (ASCE) standardized Penman-Monteith ETo equation was used to estimate
    ETo for a grass reference crop. The station data were temporally paired
    with gridMET ASCE ETo data at their respective locations and long-term
    bias ratios were calculated using the gridwxcomp Python package
    (https://github.com/WSWUP/gridwxcomp). The monthly bias ratios between
    station and gridMET ETo were then spatially interpolated using an
    exponential kriging model with a parameterized semivariogram with a 3
    station minimum for each point. The kriging resolution was 12 km and was
    performed in the Lambert Conformal Conic projected coordinate reference
    system. The interpolated monthly correction surfaces were bilinearly
    resampled to 4 km and reprojected to WGS 84 geographic coordinate
    reference system, to match gridMET. The surfaces were then used to
    correct daily and monthly gridMET ETo images.

    [Additional information](https://etdata.org/methodologies/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'conus',
    'evapotranspiration',
    'gridmet_derived',
    'monthly',
    'openet',
    'water',
  ],
  providers: [
    ee.producer_provider('OpenET, Inc.', 'https://etdata.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-126, 25, -66, 50, '2016-01-01T00:00:00Z', null),
  summaries: {
    gsd: [4000],
    'eo:bands': [
      {
        name: 'eto',
        description: 'ASCE Standardized Grass Reference ET',
        'gee:units': units.millimeter,
      },

      {
        name: 'etr',
        description: 'ASCE Standardized Alfalfa Reference ET',
        'gee:units': units.millimeter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET Bias Corrected GRIDMET Monthly Grass Reference ET',
        lookat: {
          lat: 38,
          lon: -100,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [500],
            max: [2200],
            palette: [
              '9e6212', 'ac7d1d', 'ba9829', 'c8b434', 'd6cf40', 'bed44b',
              '9fcb51', '80c256', '61b95c', '42b062', '45b677', '49bc8d',
              '4dc2a2', '51c8b8', '55cece', '4db4ba', '459aa7', '3d8094',
              '356681', '2d4c6e',
            ],
            bands: ['eto'],
          },
        },
      },
    ],
  },
  # TODO: Add a DOI once we have a citation
  'sci:doi': '',
  'sci:citation': |||
    TODO: Add a citation
  |||,
  'sci:publications': [
    {
      TODO: Add some publications
    },
   ],
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
