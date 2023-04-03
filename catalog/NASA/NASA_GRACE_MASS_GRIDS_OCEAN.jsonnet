local id = 'NASA/GRACE/MASS_GRIDS/OCEAN';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

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
  title: 'GRACE Monthly Mass Grids - Ocean',
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

    The GRACE Tellus (GRCTellus) Monthly Mass Grids Ocean dataset is produced
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

    * Land leakage correction: Ocean signals are typically weaker
      than land signals, by factors of 2 and more, on seasonal and
      interannual time scales. To minimize leakage from high land
      signals onto ocean signals, a destriping filter has been applied
      which may cause cause correlations over much larger distances.

    * The GRCTellus Ocean datasets are optimized to examine regional
      ocean bottom pressure, but NOT intended to be spatially
      averaged to determine global mean ocean mass.

    * A filtered version of the  GRCTellus Ocean dataset is also available
      which uses an alternative filtering method which may reduce leakage
      errors, and have results which agree better with altimetric sea surface
      height. [NASA/GRACE/MASS_GRIDS/OCEAN_EOFR](https://developers.google.com/earth-engine/datasets/catalog/NASA_GRACE_MASS_GRIDS_OCEAN_EOFR).
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
  extent: ee.extent_global('2002-07-31T00:00:00Z', '2016-12-10T00:00:00Z'),
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
          lat: 6.746,
          lon: 46.529,
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
      minimum: -27.0,
      maximum: 36.81,
      'gee:estimated_range': true,
    },
    lwe_thickness_gfz: {
      minimum: -28.87,
      maximum: 33.02,
      'gee:estimated_range': true,
    },
    lwe_thickness_jpl: {
      minimum: -26.03,
      maximum: 37.36,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    D.P. Chambers. 2012. GRACE MONTHLY OCEAN MASS GRIDS NETCDF
    RELEASE 5.0. Ver. 5.0. PO.DAAC, CA, USA. Dataset accessed
    [YYYY-MM-DD] at [https://doi.org/10.5067/TEOCN-0N005](https://doi.org/10.5067/TEOCN-0N005).
  |||,
  'sci:publications': [
    {
      citation: |||
        Chambers, D.P. and J.A. Bonin: Evaluation of Release 05
        time-variable gravity coefficients over the ocean. Ocean Science 8,
        859-868, 2012.
        [https://www.ocean-sci.net/8/859/2012](https://www.ocean-sci.net/8/859/2012).
      |||,
    },
    {
      citation: |||
        Chambers D.P. and J. K. Willis: A Global Evaluation of Ocean Bottom
        Pressure from GRACE, OMCT, and Steric-Corrected Altimetry. J.
        of Oceanic and Atmosph. Technology, vol 27, pp 1395-1402.
        [doi:10.1175/2010JTECHO738.1](https://doi.org/10.1175/2010JTECHO738.1),
        2010.
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
