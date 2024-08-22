local id = 'NASA/GRACE/MASS_GRIDS/MASCON_CRI';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MASCON_CRI_versions.libsonnet';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local version_config = versions(subdir, version_table, id);
local version = version_config.version;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GRACE Monthly Mass Grids - Global Mascon (CRI Filtered) [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    GRACE Tellus Monthly Mass Grids provides monthly
    gravitational anomalies relative to a 2004-2010 time-mean baseline.
    The data contained in this dataset are units of \"Equivalent Water Thickness\"
    which represent the deviations of mass in terms of vertical extent
    of water in centimeters. See the provider's [Monthly Mass
    Grids Overview](https://grace.jpl.nasa.gov/data/monthly-mass-grids/)
    for more details.

    The GRACE Tellus (GRCTellus) Global Mascon dataset
    is based on Level-1 GRACE observations and processed
    at NASA Jet Propulsion Laboratory (JPL).

    This dataset uses a-priori constraints in space and time to
    estimate global, monthly gravity fields in terms of equal-area
    3&deg;x3&deg; spherical cap mass concentration (mascon) functions to minimize the
    effect of measurement errors. This results in better S/N
    ratios of the mascon fields compared to the conventional
    spherical-harmonic solutions.

    This version of the Global Mascon dataset has a Coastline Resolution
    Improvement (CRI) filter applied to separate the land and ocean
    portions of mass within each land/ocean mascon in a post-processing step.
    For users who wish to do their own separation of land and ocean mass
    signals, a version of the data without the CRI filter is available
    at [NASA/GRACE/MASS_GRIDS/MASCON](https://developers.google.com/earth-engine/datasets/catalog/NASA_GRACE_MASS_GRIDS_MASCON).

    **Note**

    * A set of global gain factors to aid in the interpretation of signals
      at sub-mascon resolution is available at
      [NASA/GRACE/MASS_GRIDS/MASCON_SCALE_CRI_2015](https://code.earthengine.google.com/?asset=NASA/GRACE/MASS_GRIDS/MASCON_SCALE_CRI_2015).
      **Please note**: the gain factors can be used for hydrology-related
      signals, but not for mountain glaciers or ice sheets. For more
      information on scaling the mascon solutions, please see [Wiese et al.
      (2016)](https://doi.org/10.1002/2016WR019344).

    * The data are represented on a 1/2 degree lon-lat grid, but they
      represent the 3x3 degree equal-area caps, which is the current
      native resolution of JPL-RL05M.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ] + version_config.version_links,
  keywords: [
    'grace',
    'gravity',
    'jpl',
    'mascon',
    'mass',
    'nasa',
    'tellus',
    'water',
  ],
  providers: [
    ee.producer_provider('NASA Jet Propulsion Laboratory', 'https://grace.jpl.nasa.gov/data/get-data/jpl_global_mascons/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2002-03-31T00:00:00Z', '2017-05-22T00:00:00Z'),
  summaries: {
    gsd: [
      55660.0,
    ],
    'eo:bands': [
      {
        name: 'lwe_thickness',
        description: 'Equivalent liquid water thickness in centimeters.',
        'gee:units': units.centimeter,
      },
      {
        name: 'uncertainty',
        description: |||
          1-sigma uncertainty for each 3-degree mascon estimate.
          The provided estimates of uncertainty are regarded to be conservative.
          See the provider's [Error & Uncertainty Estimates
          section](https://grace.jpl.nasa.gov/data/get-data/jpl_global_mascons/)
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Equivalent Water Thickness',
        lookat: {
          lat: 6.746,
          lon: 46.529,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -25.0,
            ],
            max: [
              25.0,
            ],
            bands: [
              'lwe_thickness',
            ],
          },
        },
      },
    ],
    lwe_thickness: {
      minimum: -570.65,
      maximum: 495.53,
      'gee:estimated_range': true,
    },
    uncertainty: {
      minimum: 0.29,
      maximum: 31.1,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    D.N. Wiese. 2015. GRACE monthly global water mass grids NETCDF
    RELEASE 5.0. Ver. 5.0. PO.DAAC, CA, USA.. Dataset accessed [YYYY-MM-DD] at
    [https://doi.org/10.5067/TEMSC-OCL05](https://doi.org/10.5067/TEMSC-OCL05).
  |||,
  'sci:publications': [
    {
      citation: |||
        Watkins, M. M., D. N. Wiese, D.-N. Yuan, C. Boening, and F. W.
        Landerer (2015), Improved methods for observing Earth's time variable mass,
        mass distribution with GRACE using spherical cap mascons, J. Geophys. Res
        Solid Earth, 120,
        [doi:10.1002/2014JB011547](https://doi.org/10.1002/2014JB011547).
      |||,
      doi: '10.1002/2014JB011547',
    },
    {
      citation: |||
        Wiese, D. N., F. W. Landerer, and M. M. Watkins (2016),
        Quantifying and reducing leakage errors in the JPL RL05M GRACE
        mascon solution, Water Resour. Res., 52, 7490-7502,
        [doi:10.1002/2016WR019344](https://doi.org/10.1002/2016WR019344).
      |||,
      doi: '10.1002/2016WR019344',
    },
  ],
  'gee:terms_of_use': |||
    All NASA-produced data from the GRACE mission is made freely available
    for the public to use. When using any of the GRCTellus data, please
    add an acknowledgment: "GRACE land are available at
    [https://grace.jpl.nasa.gov](https://grace.jpl.nasa.gov),
    supported by the NASA MEaSUREs Program." and cite with the
    citations provided.
  |||,
}
