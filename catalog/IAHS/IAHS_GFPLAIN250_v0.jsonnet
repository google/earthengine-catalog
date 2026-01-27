local id = 'IAHS/GFPLAIN250/v0';
local subdir = 'IAHS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'GFPLAIN250m: Global 250m Floodplain Dataset',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The GFPLAIN250m includes raster data of Earth's floodplains identified
    using a geomorphic approach presented in Nardi et al. (2006, 2018).
    The 250m floodplain dataset is derived by processing the NASA SRTM
    Digital Elevation model gathered from
    [http://srtm.csi.cgiar.org/](http://srtm.csi.cgiar.org/),
    and in particular the 250-m SRTM version 4.1 DTM. The coding used
    for each continent and additional information are detailed in the
    metadata included in the GFPLAIN250m data repository.

    The elevation data are processed by a fast geospatial tool for floodplain
    mapping available for download at
    [https://github.com/fnardi/GFPLAIN](https://github.com/fnardi/GFPLAIN).
    The tool first preprocesses DEM to derive hydrologic features
    (filled DEM, flow direction, flow accumulation, stream network),
    then computes floodplain extents.

    This dataset is applicable in regions where water-driven erosion and
    depositional processes govern the morphology of floodplain landscape
    features, and excludes deserts with low water availability and
    ice-covered regions with insignificant river flows. It is fit for
    river basins with a contributing area greater than 1000 km2.
    The GFPLAIN250m dataset can be used in combination with global
    datasets of human settlements to support large-scale studies of
    human-flood interactions, human pressure on rivers, and changes
    over time of floodplain and wetland habitats at risk.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['surface-ground-water'],
  keywords: [
    'flood',
    'monitoring'
  ],
  providers: [
    ee.producer_provider(
      'IAHS',
      'https://iahs.info/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180, -56, 180, 60, '2018-11-11T00:00:00Z', '2018-11-12T00:00:00Z'),
  summaries: {
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'flood',
        description: 'Flood plain',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Floodplains',
        lookat: {
          lat: 30.05,
          lon: 31.25,
          zoom: 7,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1,
            ],
            palette: [
              'ffffff',
              '0000ff',
            ],
            bands: [
              'flood',
            ],
          },
        },
      },
    ],
    flood: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
  },
  'gee:terms_of_use': |||
    This dataset is licensed under a Creative Commons Attribution 4.0
    International License.
  |||,
  'sci:publications': [
    {
      citation: |||
        Nardi, F. et al. GFPLAIN250m, a global high-resolution dataset of
        Earth's floodplains.
        Sci. Data. 6:180309 doi: 10.1038/sdata.2018.309 (2019).
        [https://doi.org/10.6084/m9.figshare.6665165.v1](https://doi.org/10.6084/m9.figshare.6665165.v1),
      |||,
      doi: '10.1038/sdata.2018.309',
    },
  ],
}
