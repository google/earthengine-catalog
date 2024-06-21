local id = 'USGS/3DEP/10m';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/NED_versions.libsonnet';

local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local units = import 'units.libsonnet';

local license = spdx.proprietary {
  reference:
   'https://www.usgs.gov/information-policies-and-instructions/crediting-usgs',
};

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USGS 3DEP 10m National Map Seamless (1/3 Arc-Second)',
  version: version,
  'gee:type': ee_const.gee_type.image,
  description: |||
    This is the seamless 3DEP DEM dataset for the U.S.
    with full coverage of the 48 conterminous states, Hawaii, and
    U.S. territories. Alaska coverage is partially available now and is being
    expanded to statewide coverage as part of the Alaska Mapping Initiative.
    Ground spacing is approximately 10 meters north/south, but variable
    east/west due to convergence of meridians with latitude.

    Spatial metadata dataset is ingested as a separate asset
    [USGS_3DEP_10m_metadata](USGS_3DEP_10m_metadata).

    The 1m dataset is ingested
    as [USGS_3DEP_1m](USGS_3DEP_1m).

    Dataset uploaded by [Farmers Business Network](https://fbn.com).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ] + version_config.version_links,
  keywords: [
    '3dep',
    'dem',
    'elevation',
    'geophysical',
    'topography',
    'usgs',
  ],
  providers: [
    ee.producer_provider('United States Geological Survey', 'https://www.usgs.gov/core-science-systems/ngp/3dep/about-3dep-products-services'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-171.0, -16.6, 164.0, 76.9,
                    '1998-08-16T00:00:00Z', '2020-05-06T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': units.meter,
        gsd: 10.2,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 40.71,
          lon: -100.55,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              4000.0,
            ],
            gamma: [
              1.6,
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': 'U.S. Geological Survey, 3D Elevation Program 10-Meter Resolution Digital Elevation Model.',
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs)
    is available.
  |||,
  'gee:user_uploaded': true,
}
