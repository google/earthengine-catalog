local id = 'NASA/TEMPO/CLDO4_L3_V4';
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
  'gee:status': 'beta',
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TEMPO gridded cloud fraction and pressure (O2-O2 dimer) V04 (PROVISIONAL)',
  version: 'V04',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The TEMPO Level 3 Cloud Product (O2-O2 dimer) provides gridded cloud fraction
    and cloud pressure data. These parameters are derived from the O2-O2 absorption
    band near 477 nm and are essential for air quality retrievals and atmospheric
    monitoring. The data are created by combining and re-gridding Level 2 files
    from single East-West scan cycles using an area-weighted methodology.

    Documentation:

    * [User's Guide](https://asdc.larc.nasa.gov/documents/tempo/guide/TEMPO_Level-2-3_trace_gas_clouds_user_guide_V1.2.pdf)

    * [General Documentation](https://asdc.larc.nasa.gov/project/TEMPO)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/IS-40e/TEMPO/CLDO4_L3.004',
    },
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'air_quality',
    'nasa',
    'cloud',
    'pollution',
    'tempo',
  ],
  providers: [
    ee.producer_provider('NASA ASDC', 'https://doi.org/10.5067/IS-40e/TEMPO/CLDO4_L3.004'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C3685896149-LARC_CLOUD',
  ],
  extent: ee.extent(-170.0, 10.0, -10.0, 80.0, '2023-08-02T00:00:00Z', null),
  summaries: {
    gsd: [
      2226,
    ],
    instruments: [
      'TEMPO',
    ],
    'eo:bands': [
      {
        name: 'weight',
        description: |||
          Sum of Level 2 pixel overlap areas. Represents the weighting
          factor for each grid cell, indicating the fraction of the grid
          cell area with valid data.
        |||,
        'gee:units': units.square_km,
      },
      {
        name: 'relative_azimuth_angle',
        description: 'Relative azimuth angle at pixel center',
        'gee:units': units.degree,
      },
      {
        name: 'solar_zenith_angle',
        description: 'Solar zenith angle at pixel center',
        'gee:units': units.degree,
      },
      {
        name: 'viewing_zenith_angle',
        description: 'Viewing zenith angle at pixel center',
        'gee:units': units.degree,
      },
      {
        name: 'cloud_fraction',
        description: 'Cloud fraction derived from O2-O2 absorption',
        'gee:units': units.dimensionless,
      },
      {
        name: 'cloud_pressure',
        description: 'Cloud top pressure derived from O2-O2 absorption',
        'gee:units': units.hectopascal,
      },
      {
        name: 'CloudRadianceFraction440',
        description: 'Cloud radiance fraction at 440 nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'CloudRadianceFraction466',
        description: 'Cloud radiance fraction at 466 nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'GLER440',
        description: 'Geometry-dependent Lambertian Equivalent Reflectivity at 440 nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'GLER466',
        description: 'Geometry-dependent Lambertian Equivalent Reflectivity at 466 nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'surface_pressure',
        description: 'Surface pressure',
        'gee:units': units.hectopascal,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Cloud Fraction',
        lookat: {
          lat: 35,
          lon: -95,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [1],
            bands: ['cloud_fraction'],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/IS-40e/TEMPO/CLDO4_L3.004',
  'sci:citation': |||
    NASA/LARC/SD/ASDC.(2025). TEMPO gridded cloud fraction and pressure (O2-O2 dimer) V04 (PROVISIONAL)
    [Data set]. NASA Langley Atmospheric Science Data Center DAAC.
    Retrieved from [10.5067/IS-40e/TEMPO/CLDO4_L3.004](https://doi.org/10.5067/IS-40e/TEMPO/CLDO4_L3.004)
  |||,
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution.
    See [NASA's Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
