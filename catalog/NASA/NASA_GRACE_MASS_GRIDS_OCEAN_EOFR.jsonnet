local id = 'NASA/GRACE/MASS_GRIDS/OCEAN_EOFR';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GRACE Monthly Mass Grids - Ocean EOFR',
  version: 'Release 05',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    GRACE Tellus Monthly Mass Grids provides monthly
    gravitational anomalies relative to a 2004-2010 time-mean baseline.
    The data contained in this dataset are units of \"Equivalent Water Thickness\"
    which represent the deviations of mass in terms of vertical extent
    of water in centimeters. See the provider's [Monthly Mass
    Grids Overview](https://grace.jpl.nasa.gov/data/monthly-mass-grids/)
    for more details.

    This dataset is a filtered version of the GRACE Tellus (GRCTellus)
    Ocean dataset. The 'EOFR' bottom pressure (OBP) grids are obtained by
    projecting the data from the regular GRC Ocean grids product
    onto the Empirical Orthogonal Functions (EOFs) of the
    Ocean Model for Circulation and Tides (OMCT). This effectively
    filters out signals in the GRACE data that are inconsistent
    with the physics and OBP variations in the OMCT ocean model.

    The EOFR filtered reconstructed OBP fields agree
    better with radar altimetric sea surface height,
    reduce leakage around ice sheets and glaciers, and reduce
    noise in the mid latitudes where OBP variability is lower.
    [(Chambers and Willis, 2010)](https://doi.org/10.1175/2010JTECHO738.1)

    **Note**

    * The GRCTellus Ocean datasets are optimized to examine regional
      ocean bottom pressure, but NOT intended to be spatially
      averaged to determine global mean ocean mass.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'crs',
    'gfz',
    'grace',
    'gravity',
    'jpl',
    'mass',
    'nasa',
    'ocean',
    'tellus',
    'water',
  ],
  providers: [
    ee.producer_provider('NASA Jet Propulsion Laboratory', 'https://grace.jpl.nasa.gov/data/get-data/monthly-mass-grids-ocean/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2002-12-31T00:00:00Z', '2016-12-10T00:00:00Z'),
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
        'gee:units': 'cm',
      },
      {
        name: 'lwe_thickness_gfz',
        description: 'Equivalent liquid water thickness in centimeters calculated by GFZ.',
        'gee:units': 'cm',
      },
      {
        name: 'lwe_thickness_jpl',
        description: 'Equivalent liquid water thickness in centimeters calculated by JPL.',
        'gee:units': 'cm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Equivalent Water Thickness CSR',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -10.0,
            ],
            max: [
              10.0,
            ],
            bands: [
              'lwe_thickness_csr',
            ],
          },
        },
      },
    ],
    lwe_thickness_csr: {
      minimum: -18.46,
      maximum: 12.29,
      'gee:estimated_range': true,
    },
    lwe_thickness_gfz: {
      minimum: -15.37,
      maximum: 14.56,
      'gee:estimated_range': true,
    },
    lwe_thickness_jpl: {
      minimum: -16.59,
      maximum: 11.7,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    D.P. Chambers. 2012. GRACE MONTHLY OCEAN MASS GRIDS NETCDF
    RELEASE 5.0. Ver. 5.0. PO.DAAC, CA, USA. Dataset accessed
    [YYYY-MM-DD] at [doi:10.5067/TEOCN-0N005](https://doi.org/10.5067/TEOCN-0N005).
  |||,
  'sci:publications': [
    {
      citation: |||
        Chambers, D.P. and J.A. Bonin: Evaluation of Release 05
        time-variable gravity coefficients over the ocean. Ocean Science 8,
        859-868, 2012. [doi:10.5194/os-8-859-2012](https://doi.org/10.5194/os-8-859-2012).
      |||,
      doi: '10.5194/os-8-859-2012',
    },
    {
      citation: |||
        Chambers D.P. and J. K. Willis: A Global Evaluation of Ocean Bottom
        Pressure from GRACE, OMCT, and Steric-Corrected Altimetry. J.
        of Oceanic and Atmosph. Technology, vol 27, pp 1395-1402, 2010..
        [doi:10.1175/2010JTECHO738.1](https://doi.org/10.1175/2010JTECHO738.1)
      |||,
      doi: '10.1175/2010JTECHO738.1',
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
