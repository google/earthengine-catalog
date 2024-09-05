local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.cc_by_4_0;

local units = import 'units.libsonnet';

{
  description: |||
    The geoBoundaries Global Database of Political Administrative Boundaries
    Database is an online, open license resource of boundaries (i.e., state,
    county) for every country in the world. Currently 199 total entities are
    tracked, including all 195 UN member states, Greenland, Taiwan, Niue, and
    Kosovo.

    Comprehensive Global Administrative Zones (CGAZ) is a set of global
    composites for administrative boundaries. Disputed areas are removed and
    replaced with polygons following US Department of State definitions. It has
    three boundary levels ADM0, ADM1, and ADM2, clipped to international
    boundaries (US Department of State), with gaps filled between borders.

    This dataset is part of CGAZ. It was ingested from
    [version 6.0.0](https://github.com/wmgeolab/geoBoundaries/tree/1289e40e366c7b320550be1ee0614a9472d572d4)
    of Global Composite Files with DBF_DATE_LAST_UPDATE=2023-09-13.
    It shows boundaries at level 
  |||,
  keywords: [
    'borders',
    'countries',
  ],
  providers(name, catalog_url): [
    ee.producer_provider(
      'William and Mary geoLab',
      'https://www.geoboundaries.org/index.html'),
    ee.host_provider(catalog_url),
  ],
  license: license.id,
  extent: ee.extent_global('2023-09-14T00:00:00Z', '2023-09-14T00:00:00Z'),
  citation: |||
    Runfola, D. et al. (2020) geoBoundaries: A global database of political administrative boundaries. PLoS ONE 15(4): e0231866. [https://doi.org/10.1371/journal.pone.0231866](https://doi.org/10.1371/journal.pone.0231866)
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
          Boundary type:

          * ADM0: Country level
          * ADM1: District level
          * ADM2: Municipality level

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
    allows for most commmercial, noncommercial, and academic uses. See 
    [provider terms of use](https://www.geoboundaries.org/index.html#usage).
  |||,
}
