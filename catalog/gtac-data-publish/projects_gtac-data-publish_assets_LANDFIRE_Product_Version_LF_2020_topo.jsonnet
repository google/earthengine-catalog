local id = 'projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2020-Topo';
local subdir = 'gtac-data-publish';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/LANDFIRE_Topography_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  'gee:status': 'beta',
  'gee:user_uploaded': true,

  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LANDFIRE 2020 Topography ' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    LANDFIRE 2020 Topography is a 30-meter collection of elevation, aspect,
    slope in degrees, and slope in percent for the conterminous United States,
    Alaska, Hawaii, and Puerto Rico and the U.S. Virgin Islands. Each image
    represents one LANDFIRE study area.

    The LF 2020 topographic products were recalculated from U.S. Geological
    Survey 3D Elevation Program data. Aspect was calculated relative to true
    north, correcting inconsistencies in earlier LANDFIRE topographic products.
    Aspect value -1 represents flat terrain or no aspect; source value -9999 is
    NoData and is masked during ingestion.

    LANDFIRE topographic products are updated infrequently. Although delivered
    at 30-meter resolution, they are intended primarily for national, regional,
    and large subregional planning rather than analysis of individual pixels.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links + [
    ee.link.license('https://www.landfire.gov/'),
    {
      rel: ee_const.rel.source,
      href: 'https://www.landfire.gov/topographic',
    },
  ],
  'gee:categories': ['elevation-topography'],
  keywords: [
    'aspect',
    'dem',
    'elevation',
    'landfire',
    'slope',
    'topography',
    'usda',
    'usfs',
    'usgs',
  ],
  providers: [
    ee.producer_provider(
      'LANDFIRE, U.S. Department of Agriculture Forest Service and U.S. '
      + 'Department of the Interior Geological Survey',
      'https://www.landfire.gov/'
    ),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-175.1, 17.52, -63.66, 71.48,
                    '2020-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),
  summaries: {
    gsd: [30],
    'gee:schema': [
      {
        name: 'study_area',
        description: |||
          LANDFIRE study area. Values are CONUS, AK, HI, and PRVI.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'year',
        description: 'LANDFIRE product year.',
        type: ee_const.var_type.string,
      },
      {
        name: 'landfire_ver',
        description: 'LANDFIRE semantic version.',
        type: ee_const.var_type.string,
      },
      {
        name: 'landfire_version_name',
        description: 'LANDFIRE version name, such as LF_2020.',
        type: ee_const.var_type.string,
      },
      {
        name: 'landfire_version_number',
        description: 'Integer LANDFIRE version number, such as 220.',
        type: ee_const.var_type.int,
      },
    ],
    'eo:bands': [
      {
        name: "Asp",
        description: "Aspect in degrees clockwise from north. Value -1 represents flat terrain or no aspect. Source value -9999 is NoData and is masked.",
        "gee:units": units.degree,
      },
      {
        name: "Elev",
        description: "Elevation above sea level. Source value -9999 is NoData and is masked.",
        "gee:units": units.meter,
      },
      {
        name: "SlpD",
        description: "Terrain slope in degrees. Source value -9999 is NoData and is masked.",
        "gee:units": units.degree,
      },
      {
        name: "SlpP",
        description: "Terrain slope as percent rise. Source value -9999 is NoData and is masked.",
        "gee:units": units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {lon: -112.0, lat: 40.0, zoom: 5},
        image_visualization: {
          band_vis: {
            bands: ['Elev'],
            min: [-100],
            max: [4500],
            palette: [
              '00204c',
              '2a4a84',
              '4d798e',
              '7ba66f',
              'c9cc57',
              'fee838',
            ],
          },
        },
      },
      {
        display_name: 'Aspect',
        lookat: {lon: -112.0, lat: 40.0, zoom: 8},
        image_visualization: {
          band_vis: {
            bands: ['Asp'],
            min: [0],
            max: [360],
            palette: [
              '30123b',
              '4675ed',
              '1bcfd4',
              '61fc6c',
              'd1e834',
              'fd8d3c',
              'c73e7b',
              '30123b',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5066/P1LJEZ3G',
  'sci:citation': |||
    LANDFIRE. 2022. LANDFIRE 2020 Topographic Products, LANDFIRE 2.2.0. U.S.
    Department of the Interior, U.S. Geological Survey, and U.S. Department
    of Agriculture, Forest Service. Available from
    [LANDFIRE](https://www.landfire.gov/).
    [doi:10.5066/P1LJEZ3G](https://doi.org/10.5066/P1LJEZ3G).
  |||,
  'sci:publications': [
    {
      citation: |||
        Picotte, J. J., Dockter, D. J., Long, J., Tolk, B., Davidson, A.,
        Peterson, B., and Gage, J. D. 2023. LANDFIRE Remap technical
        documentation. U.S. Geological Survey Open-File Report 2023-1045.
        [doi:10.3133/ofr20231045](https://doi.org/10.3133/ofr20231045).
      |||,
      doi: '10.3133/ofr20231045',
    },
    {
      citation: |||
        Alexandre, P. M., Stewart, S. I., Mockrin, M. H., Keuler, N. S.,
        Syphard, A. D., Bar-Massada, A., Clayton, M. K., and Radeloff, V. C.
        2016. The relative impacts of vegetation, topography and spatial
        arrangement on building loss to wildfires in case studies of California
        and Colorado. Landscape Ecology, v. 31, no. 2, p. 415–430.
        [doi:10.1007/s10980-015-0257-6](https://doi.org/10.1007/s10980-015-0257-6).
      |||,
      doi: '10.1007/s10980-015-0257-6',
    },
    {
      citation: |||
        Cram, D. S., Sabie, R. P., Smallidge, S. T., and Ashcroft, N. K. 2017.
        Assessment of postfire debris-flow hazards, La Jara Watershed,
        north-central New Mexico. New Mexico State University Cooperative
        Extension Service Publications RITF–86, accessed October 11, 2021.
        [Publication](https://pubs.nmsu.edu/_ritf/RITF86/index.html).
      |||,
    },
    {
      citation: |||
        Esri. 2011. ArcGIS Desktop (release 10). Esri software release,
        accessed October 11, 2021.
        [Installation guide](https://desktop.arcgis.com/en/arcmap/10.6/get-started/installation-guide/installing-on-your-computer.htm).
      |||,
    },
    {
      citation: |||
        GDAL/OGR contributors. 2021. GDAL/OGR (version 2.0.12). GDAL/OGR
        software release, accessed October 11, 2021.
        [Past releases](https://gdal.org/download.html#past-releases).
      |||,
    },
    {
      citation: |||
        National Aeronautics and Space Administration, Ministry of Economy,
        Trade, and Industry, National Institute of Advanced Industrial Science
        and Technology, Japan Space Systems, and U.S./Japan ASTER Science Team.
        2019. ASTER Global Digital Elevation Model V003 [dataset]. U.S.
        Geological Survey digital data, accessed October 11, 2021.
        [doi:10.5067/ASTER/ASTGTM.003](https://doi.org/10.5067/ASTER/ASTGTM.003).
      |||,
      doi: '10.5067/ASTER/ASTGTM.003',
    },
    {
      citation: |||
        Nelson, K. J., Long, D. G., and Connot, J. A. 2016. LANDFIRE
        2010—Updates to the national dataset to support improved fire and
        natural resource management. U.S. Geological Survey Open-File Report
        2016–1010, 48 p., accessed October 11, 2021.
        [doi:10.3133/ofr20161010](https://doi.org/10.3133/ofr20161010).
      |||,
      doi: '10.3133/ofr20161010',
    },
    {
      citation: |||
        U.S. Geological Survey. 2012. USGS EROS archive—Digital
        elevation—Interferometric synthetic aperture radar (IFSAR)–Alaska.
        U.S. Geological Survey digital data, accessed October 11, 2021.
        [Dataset](https://www.usgs.gov/centers/eros/science/usgs-eros-archive-radar-ifsar-orthorectified-radar-image-ori-alaska?qt-science_center_objects=0#qt-science_center_objects).
      |||,
    },
    {
      citation: |||
        U.S. Geological Survey. 2017. 1/3rd arc-second Digital Elevation Models
        (DEM)—USGS National Map 3DEP downloadable data collection. U.S.
        Geological Survey digital data, accessed October 11, 2021.
        [Dataset](https://www.sciencebase.gov/catalog/item/4f70aa9fe4b058caae3f8de5).
      |||,
    },
    {
      citation: |||
        U.S. Geological Survey. 2021. 3D Elevation Program 1-meter resolution
        digital elevation model. U.S. Geological Survey web page, accessed
        May 5, 2023.
        [3D Elevation Program](https://www.usgs.gov/3d-elevation-program).
      |||,
    },
  ],
  'gee:terms_of_use': |||
    LANDFIRE data are public domain data with no use restrictions. If
    modifications or derivatives are created, add a descriptive modifier to
    the dataset name to avoid confusion with the source LANDFIRE product.
  |||,
}
