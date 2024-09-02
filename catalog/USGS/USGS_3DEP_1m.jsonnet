local id = 'USGS/3DEP/1m';
local subdir = 'USGS';

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
  ],
  id: id,
  title: 'USGS 3DEP 1m National Map',
  'gee:type': ee_const.gee_type.image_collection,
  // TODO(schwehr): Need to link the slope calculations to the catalog
  // https://code.earthengine.google.com/a8d904ce1894287963cbfc412bc90bea
  description: |||
    This is a tiled collection of images with 1m pixel size from the 3D
    Elevation Program (3DEP). The 3DEP data holdings serve as the elevation
    layer of The National Map and provide foundational elevation information for
    earth science studies and mapping applications in the United States.

    The elevations in this DEM represent the topographic bare-earth surface.
    USGS standard 1m pixel size DEMs are produced exclusively from high
    resolution light detection and ranging (lidar) source data of images with 1m
    pixel size or higher resolution. 1m pixel size DEM surfaces are seamless
    within collection projects but not necessarily seamless across projects.
    The spatial reference used for tiles of the 1m pixel size DEM within the
    conterminous United States (CONUS) is Universal Transverse Mercator (UTM) in
    units of meters and in conformance with the North American Datum of 1983
    (NAD83). All bare earth elevation values are in meters and are referenced to
    the North American Vertical Datum of 1988 (NAVD88). Each tile is distributed
    in the UTM Zone in which it lies. If a tile crosses two UTM zones, it is
    delivered in both zones.
    In this and other cases of image overlaps, elevation values might be
    slightly different in different images covering the same area.

    The 1m pixel size DEM is the highest resolution standard DEM offered in the
    3DEP product suite. The 10m 3DEP dataset is available at
    [USGS_3DEP_10m](USGS_3DEP_10m).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(
      'https://www.usgs.gov/information-policies-and-instructions/crediting-usgs'),
    {
      rel: ee_const.rel.source,
      href: 's3://prd-tnm/StagedProducts/Elevation/1m/Projects',
    }
  ],
  keywords: [
    '3dep',
    'dem',
    'elevation',
    'geophysical',
    'topography',
    'usgs',
  ],
  providers: [
    ee.producer_provider(
      'United States Geological Survey',
      'https://www.sciencebase.gov/catalog/item/543e6b86e4b0fd76af69cf4c'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-171.0, -16.6, 164.0, 76.9,
                    '2015-01-01T00:00:00Z', null),
  summaries: {
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation (NAVD88)',
        'gee:units': units.meter,
        gsd: 1,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 35.87,
          lon: -115.11,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              3000.0,
            ],
            palette: [
                '3ae237', 'b5e22e','d6e21f',
                'fff705','ffd611', 'ffb613',
                'ff8b13', 'ff6e08','ff500d',
                'ff0000','de0101', 'c21301',
                '0602ff', '235cb1','307ef3',
                '269db1','30c8e2', '32d3ef',
                '3be285', '3ff38f','86e26f',
              ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    U.S. Geological Survey, 3D Elevation Program 1-Meter Resolution Digital
    Elevation Model.
  |||,
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs)
    is available.
  |||,
}
