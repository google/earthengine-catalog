local id = 'FAO/GHG/1/DROS-E';
local subdir = 'FAO';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'UN FAO Drained Organic Soils (Emissions, Annual)',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
		The UN FAO DRained Organic Soils Emissions (DROS-E) disseminates annual estimates of the greenhouse gas (GHG) emissions from cropland and grassland organic soils that are drained for agricultural activities. This image collection consists of 4 bands:
	  1.	CO2 emissions from drained cropland organic soils.
	  2.	N2O emissions from drained cropland organic soils.
	  3.	CO2 emissions from drained grazed grassland organic soils.
	  4.	N2O emissions from drained grazed grassland organic soils.
		The GHG emissions are expressed in tonnes/hectare (tonnes/ha) and are available for the period 1992–2020. The data is available 
	globally at a resolution of 0.0083333 X 0.0083333 degrees (~1 km at the equator). This image collection is accompanied by the DROS-Area (DROS–A) dataset which 
	disseminates the annual area of drained organic soils, in a separate image collection.
		The GHG emissions from drained organic soils are computed in the Google Earth Engine (GEE) platform applying Tier I methods 
	from the Intergovernmental Guidelines on Climate Change (IPCC) (IPCC, 2014). The FAO estimates use the distribution of histosols as a proxy for the presence of organic 
	soils, in agreement with IPCC, and annual land cover maps as time-dependent as time-dependent components for yearly cropland and grassland extents. Finally, a geospatial layer of the distribution of ruminants from the FAO Gridded Livestock of the World was used to identify the grassland that is grazed.
		Organic soils are wet soils ecosystems, characterized by high levels of organic matter, which accumulates under the anoxic conditions 
	that exist in the presence of water. They include tropical and boreal peatlands, high-latitude bogs, ferns and mires. While organic soils 
	cover globally a mere 3 percent of the terrestrial land area, they represent up to 30 percent of the total soil carbon, playing an 
	important role in maintaining the earth’s carbon balance. Agriculture is a major cause of drainage of organic soils around the world and 
	restoration of degraded organic soils is currently a priority in several countries as part of their commitments under the climate convention.
		DROS-A and DROS-E are the basis for the country, regional and global statistics on drained organic soils that are disseminated in FAOSTAT (FAO 2020, 2022). This ‘DROS-E’ asset supersedes an earlier version, which is accessable at 'FAO/GHG/1/DROSE_A'.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
	'agriculture'
	'climate-change'
    'GHG-emissions'
	'IPCC-Tier-1'
	'organic-soils'
	'drainage-for-agriculture'
	'CO2'
	'N2O'
    'Global',
	'FAO',
  ],
  providers: [
    ee.producer_provider('FAOSTAT', 'https://www.fao.org/faostat/en/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1992-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'croplandco2',
        description: 'CO2 emissions from drained cropland organic soils',
        'gee:units': 'tonnes/ha',
      },
      {
        name: 'grasslandco2',
        description: 'CO2 emissions from drained grassland organic soils',
        'gee:units': 'tonnes/ha',
      },
	  {
        name: 'croplandn2o',
        description: 'N2O emissions from drained cropland organic soils',
        'gee:units': 'tonnes/ha',
      },
	  {
        name: 'grasslandn2o',
        description: 'N2O emissions from drained grassland organic soils',
        'gee:units': 'tonnes/ha',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Cropland CO2 emissions (Annual)',
        lookat: {
          lat: -0.4,
          lon: 108.0,
          zoom: 6,
        },
        image_visualization: {
          global_vis: {
			min: [
              0,
            ],
            max: [
              40,
            ],
            palette: [
              'yellow',
			  'red',
            ],
            bands: [
              'croplandco2',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
	[FAO 2022.  Drained organic soils. FAO, Rome.](https://www.fao.org/faostat/en/#data/GV)
	[FAO 2020.  Drained organic soils 1990–2019. Global, regional and country trends. FAOSTAT Analytical Brief Series No 4. FAO, Rome.]
	(https://www.fao.org/3/cb0489en/CB0489EN.pdf)
	[IPCC 2014.  2013 Supplement to the 2006 IPCC Guidelines for National Greenhouse Gas Inventories: Wetlands. IPCC, Switzerland.]
	(https://www.ipcc.ch/publication/2013-supplement-to-the-2006-ipcc-guidelines-for-national-greenhouse-gas-inventories-wetlands/)
  |||,
  'sci:publications': [
    {
      citation: |||
		Conchedda, G. & Tubiello, F. N. 2020. Drainage of organic soils and GHG emissions: validation with country data, Earth System Science Data		
        [10.1016/j.oneear.2020.08.016](https://doi.org/10.5194/essd-12-3113-2020)
      |||,
      doi: '10.5194/essd-12-3113-2020',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
		The Food and Agriculture Organization of the United Nations (FAO) is mandated to collect, analyze, interpret, and disseminate 
	information related to nutrition, food, and agriculture. In this regard, it publishes a number of databases on topics related 
	to FAO's mandate, and encourages the use of them for scientific and research purposes. Consistent with the principles of 
	openness and sharing envisioned under the Open Data Licensing For Statistical Databases, and consistent with the mandate of FAO, 
	data on GHG emissions from agriculture activities on organic soils as part of FAOSTAT - FAO's database on Food and Agriculture 
	data, is available free to the user community. 
  |||,
  'gee:user_uploaded': true,
}