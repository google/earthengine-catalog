local id = 'NASA/GRACE/MASS_GRIDS_V04/LAND';
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
  title: 'GRACE Monthly Mass Grids Release 06 Version 04 - Land',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The monthly land mass grids contain water mass anomalies given as equivalent
    water thickness derived from GRACE & GRACE-FO time-variable gravity
    observations during the specified timespan, and relative to the specified
    time-mean reference period. The equivalent water thickness represents the
    total terrestrial water storage anomalies from soil moisture, snow, surface
    water (incl. rivers, lakes, reservoirs etc.), as well as groundwater and
    aquifers. A glacial isostatic adjustment (GIA) correction has been applied,
    and standard corrections for geocenter (degree-1), C20 (degree-20) and
    C30 (degree-30) are incorporated. Post-processing filters have been applied
    to reduce correlated errors. Version 04 (v04) of the terrestrial water
    storage data uses updated and consistent C20 and Geocenter corrections
    (i.e., Technical Notes TN-14 and TN-13), as well as an ellipsoidal
    correction to account for the non-spherical shape of the Earth when mapping
    gravity anomalies to surface mass change.

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
  'gee:provider_ids': [
    'C2077042515-POCLOUD',
    'C2077042566-POCLOUD',
    'C2077042612-POCLOUD',
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
      {
        name: 'uncertainty_csr',
        description: 'Error estimation by CSR.',
      },
      {
        name: 'uncertainty_gfz',
        description: 'Error estimation by GFZ.',
      },
      {
        name: 'uncertainty_jpl',
        description: 'Error estimation by JPL.',
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
              -0.78,
            ],
            max: [
              0.57,
            ],
            bands: [
              'lwe_thickness_csr',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Felix Landerer. 2021. TELLUS_GRAC_L3_JPL_RL06_LND_v04. Ver. RL06 v04.
    PO.DAAC, CA, USA. Dataset accessed [YYYY-MM-DD] at
    [https://doi.org/10.5067/TELND-3AJ64](https://doi.org/10.5067/TELND-3AJ64).
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
