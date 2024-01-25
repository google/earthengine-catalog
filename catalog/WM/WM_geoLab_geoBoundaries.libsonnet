local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';


{
  description: |||
    The geoBoundaries Global Database of Political Administrative Boundaries
    Database is an online, open license resource of boundaries (i.e., state,
    county) for every country in the world. Currently 199 total entities are
    tracked, including all 195 UN member states, Greenland, Taiwan, Niue, and
    Kosovo. They provide three different type of datasets, the one currently
    ingested is Comprehensive Global Administrative Zones.

    Comprehensive Global Administrative Zones (CGAZ) is a set of global
    composites for administrative boundaries. Disputed areas are removed and
    replaced with polygons following US Department of State definitions. It has
    three boundary levels ADM0, ADM1 and ADM2, clipped to international
    boundaries (US Department of State), with gaps filled between borders.
  |||,
  keywords: [
    'borders',
    'cgaz',
    'countries',
    'wm',
  ],
  providers(name, catalog_url): [
    ee.producer_provider(
      'William and Mary geoLab',
      'https://geolab.wm.edu/'),
    ee.host_provider(catalog_url),
  ],
  license: spdx.proprietary.id,
  extent: ee.extent_global('2017-01-01T01:00:00Z', '2017-12-31T16:45:00Z'),
  citation: |||
    GEDI L2A Elevation and Height Metrics Data Global Footprint Level - GEDI02_A
    Dubayah, R., M. Hofton, J. Blair, J. Armston, H. Tang, S. Luthcke. GEDI L2A
    Elevation and Height Metrics Data Global Footprint Level V002. 2021,
    distributed by NASA EOSDIS Land Processes DAAC. Accessed YYYY-MM-DD.
  |||,
  regular_bands: [
    {
        name: 'shapeGroup',
        description: 'Unique country code',
        type: ee_const.var_type.string,
      },
      {
        name: 'shapeName',
        description: 'Administrative region name',
        type: ee_const.var_type.string,
      },
      {
        name: 'shapeType',
        description: |||
          Boundary type: country level (AMD0), District level (AMD1),
          Municipality level (AMD2)
        |||,
        type: ee_const.var_type.string,
      }
  ],
  shapeid_band: [
    {
      name: 'shapeID',
      description: 'Unique ID assigned to the shape',
      type:: ee_const.var_type.double,
    }
  ],
  terms_of_use: |||
    geoBoundaries datasets are provided under the CC BY 4.0 license, which
    allows for most commmercial, noncommercial, and academic uses
    [WM geoBoundaries License document](
      https://www.geoboundaries.org/index.html#usage)
  |||,
}
