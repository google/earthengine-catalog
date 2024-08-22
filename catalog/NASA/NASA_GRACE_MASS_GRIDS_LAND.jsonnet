local id = 'NASA/GRACE/MASS_GRIDS/LAND';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/LAND_versions.libsonnet';
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
  title: 'GRACE Monthly Mass Grids - Land [deprecated]',
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

    The GRACE Tellus (GRCTellus) Monthly Mass Grids dataset is produced
    by three centers: CSR (U. Texas / Center for Space Research),
    GFZ (GeoForschungsZentrum Potsdam), and JPL
    (NASA Jet Propulsion Laboratory). Each center is a part
    of the GRACE Ground System and generates Level-2 data
    (spherical harmonic fields) used in this dataset.
    The output includes spherical harmonic coefficients
    of the gravity field and of the dealiasing fields used to compute them.
    Since each center independently produces the coefficients, the results
    may be slightly different. It is recommended for most users to
    use the mean of all three datasets. See the provider's [choosing a
    solution](https://grace.jpl.nasa.gov/data/choosing-a-solution/) page
    for more details.

    **Note**

    * Due to the sampling and post-processing of GRACE observations,
      surface mass variations at small spatial scales tend to be attenuated.
      Therefore, users should multiply the GRCTellus Land data by the
      scaling grid available at
      [NASA/GRACE/MASS_GRIDS/LAND_AUX_2014](https://code.earthengine.google.com/?asset=NASA/GRACE/MASS_GRIDS/LAND_AUX_2014).

    * The GRCTellus Land grids processed from the Spherical Harmonic
      Level-2 data are not suited to accurately quantify ice mass
      changes over Greenland or Antarctica, or glaciers and ice caps.
      For those areas it is recommended to use JPL's mascon
      solution available as the following image collection:
      [NASA/GRACE/MASS_GRIDS/MASCON](https://developers.google.com/earth-engine/datasets/catalog/NASA_GRACE_MASS_GRIDS_MASCON)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ] + version_config.version_links,
  keywords: [
    'crs',
    'gfz',
    'grace',
    'gravity',
    'jpl',
    'land',
    'mass',
    'nasa',
    'tellus',
    'water',
  ],
  providers: [
    ee.producer_provider('NASA Jet Propulsion Laboratory', 'https://grace.jpl.nasa.gov/data/get-data/monthly-mass-grids-land/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2002-04-01T00:00:00Z', '2017-01-07T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'CSR_END_TIME',
        description: 'End date in milliseconds of spherical harmonics solution from CSR.',
        type: ee_const.var_type.double,
      },
      {
        name: 'CSR_START_TIME',
        description: 'Start date in milliseconds of spherical harmonics solution from CSR.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GFZ_END_TIME',
        description: 'End date in milliseconds of spherical harmonics solution from GFZ.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GFZ_START_TIME',
        description: 'Start date in milliseconds of spherical harmonics solution from GFZ.',
        type: ee_const.var_type.double,
      },
      {
        name: 'JPL_END_TIME',
        description: 'End date in milliseconds of spherical harmonics solution from JPL.',
        type: ee_const.var_type.double,
      },
      {
        name: 'JPL_START_TIME',
        description: 'Start date in milliseconds of spherical harmonics solution from JPL.',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      111320.0,
    ],
    'eo:bands': [
      {
        name: 'lwe_thickness_csr',
        description: 'Equivalent liquid water thickness in centimeters calculated by CSR.',
        'gee:units': units.centimeter,
      },
      {
        name: 'lwe_thickness_gfz',
        description: 'Equivalent liquid water thickness in centimeters calculated by GFZ.',
        'gee:units': units.centimeter,
      },
      {
        name: 'lwe_thickness_jpl',
        description: 'Equivalent liquid water thickness in centimeters calculated by JPL.',
        'gee:units': units.centimeter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Equivalent Water Thickness CSR',
        lookat: {
          lon: 6.746,
          lat: 46.529,
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
              'lwe_thickness_csr',
            ],
          },
        },
      },
    ],
    lwe_thickness_csr: {
      minimum: -139.2,
      maximum: 74.88,
      'gee:estimated_range': true,
    },
    lwe_thickness_gfz: {
      minimum: -145.45,
      maximum: 70.19,
      'gee:estimated_range': true,
    },
    lwe_thickness_jpl: {
      minimum: -137.94,
      maximum: 71.86,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    S.C. Swenson. 2012. GRACE monthly land water mass grids NETCDF
    RELEASE 5.0. Ver. 5.0. PO.DAAC, CA, USA. Dataset accessed
    [YYYY-MM-DD] at
    [https://doi.org/10.5067/TELND-NC005](https://doi.org/10.5067/TELND-NC005).
  |||,
  'sci:publications': [
    {
      citation: |||
        Landerer F.W. and S. C. Swenson, Accuracy of scaled GRACE terrestrial
        water storage estimates. Water Resources Research, Vol 48, W04531, 11 PP,
        [doi:10.1029/2011WR011453](https://doi.org/10.1029/2011WR011453), 2012.
      |||,
      doi: '10.1029/2011WR011453',
    },
    {
      citation: |||
        Swenson, S. C. and J. Wahr, Post-processing removal of correlated
        errors in GRACE data, Geophys. Res. Lett., 33, L08402,
        [doi:10.1029/2005GL025285](https://doi.org/10.1029/2005GL025285), 2006.
      |||,
      doi: '10.1029/2005GL025285',
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
