local id = 'NASA/GRACE/MASS_GRIDS_V03/MASCON';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MASCON_versions.libsonnet';
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
  title: 'GRACE Monthly Mass Grids Release 6.1 Version 3 - Global Mascons',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains gridded monthly global water storage/height anomalies
    relative to a time-mean, derived from GRACE and GRACE-FO and processed at
    JPL using the Mascon approach (RL06.1Mv03). These data are provided in a
    single data file in netCDF format, and can be used for analysis for ocean,
    ice, and hydrology phenomena. The water storage/height anomalies are given
    in equivalent water thickness units (cm). The solution provided here is
    derived from solving for monthly gravity field variations in terms of
    geolocated spherical cap mass concentration functions, rather than global
    spherical harmonic coefficients. Additionally, realistic geophysical
    information is introduced during the solution inversion to intrinsically
    remove correlated error. Thus, these Mascon grids do not need to be
    destriped or smoothed, like traditional spherical harmonic gravity
    solutions. The complete Mascon solution consists of 4,551 relatively
    independent estimates of surface mass change that have been derived using an
    equal-area 3-degree grid of individual mascons. It should be noted that this
    dataset does not correct for leakage errors across coastlines; it is
    therefore recommended only for users who want to apply their own algorithm
    to separate between land and ocean mass very near coastlines.
    This RL06.1Mv03 is an updated version of the previous [Tellus JPL Mascon
    RL06Mv02](https://doi.org/10.5067/TEMSC-3JC62). RL06.1Mv03 differs from RL06Mv02 only
    in the Level-1B accelerometer transplant data that is used for the GF2
    (GRACE-FO 2) satellite; RL06.1Mv03 uses the ACH data product.
    For more information,
    please visit [GRACE page](https://grace.jpl.nasa.gov/data/get-data/jpl_global_mascons/).
    For a detailed description on the Mascon solution, including
    the mathematical derivation, implementation of geophysical constraints, and
    solution validation, please see [Watkins et al., 2015](https://doi.org/10.1002/2014JB011547).
    This product is intended for expert use only; other users are encouraged to
    use the [CRI-filtered Mascon dataset](https://podaac.jpl.nasa.gov/dataset/TELLUS_GRAC-GRFO_MASCON_GRID_RL06.1_V3).
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
  'gee:provider_ids': [
    'C2536982552-POCLOUD',
  ],
  extent: ee.extent_global('2002-03-31T00:00:00Z', null),
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
  },
  'sci:citation': |||
    D.N. Wiese. 2015. GRACE monthly global water mass grids NETCDF
    RELEASE 6.1. Ver. 3.0. PO.DAAC, CA, USA.. Dataset accessed [YYYY-MM-DD] at
    [https://doi.org/10.5067/TEMSC-3MJ63](https://doi.org/10.5067/TEMSC-3MJ63).
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
