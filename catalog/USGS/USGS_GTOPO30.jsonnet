local id = 'USGS/GTOPO30';
local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  ],
  id: id,
  title: 'GTOPO30: Global 30 Arc-Second Elevation',
  'gee:type': ee_const.gee_type.image,
  description: |||
    GTOPO30 is a global digital elevation model (DEM) with
    a horizontal grid spacing of 30 arc seconds (approximately 1 kilometer).
    The DEM was derived from several raster and vector sources of topographic
    information.  Completed in late 1996, GTOPO30 was developed over
    a three-year period through a collaborative effort led by the U.S.
    Geological Survey''s Center for Earth Resources Observation and
    Science (EROS). The following organizations  participated by contributing
    funding or source data:  the National Aeronautics  and Space Administration
    (NASA), the United Nations Environment Programme/Global Resource
    Information Database (UNEP/GRID), the U.S. Agency for International
    Development (USAID), the Instituto Nacional de Estadistica Geografica
    e Informatica (INEGI) of Mexico, the Geographical Survey Institute  (GSI)
    of Japan, Manaaki Whenua Landcare Research of New Zealand, and
    the  Scientific Committee on Antarctic Research (SCAR).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'dem',
    'elevation',
    'geophysical',
    'gtopo30',
    'nasa',
    'topography',
    'usgs',
  ],
  providers: [
    ee.producer_provider('United States Geological Survey', 'https://www.usgs.gov/centers/eros/science/usgs-eros-archive-digital-elevation-global-30-arc-second-elevation-gtopo30'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1996-01-01T00:00:00Z', '1996-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': units.meters,
        gsd: 927.67,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 43.9,
          lon: 11.69,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              -10.0,
            ],
            max: [
              8000.0,
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
    elevation: {
      minimum: -407.0,
      maximum: 8752.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': 'GTOPO30 DEM courtesy of the U.S. Geological Survey',
  'gee:terms_of_use': |||
    There are no restrictions on the use of data received
    from the U.S. Geological Survey's Earth Resources Observation and
    Science (EROS) Center. For more information, visit the USGS' [Data
    Use and Citation](https://www.usgs.gov/centers/eros/science/usgs-eros-archive-data-use-and-citation) page.
  |||,
}
