local id = 'USGS/GAP/CONUS/2011';
local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USGS GAP CONUS 2011',
  version: '2012',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The GAP/LANDFIRE National Terrestrial Ecosystems data represents a detailed
    vegetation and land cover classification for the Conterminous U.S., Alaska,
    Hawaii, and Puerto Rico.GAP/LF 2011 Ecosystems for the Conterminous U.S. is
    an update of the National Gap Analysis Program Land Cover Data - Version 2.2.
    Alaska ecosystems have been updated by LANDFIRE to 2012 conditions (LANDFIRE 2012).
    Hawaii and Puerto Rico data represent the 2001 time-frame (Gon et al. 2006, Gould et al. 2008).
    The classification scheme used for the Alaska and the lower 48 states is based
    on NatureServe's Ecological System Classification (Comer et al. 2003), while
    Puerto Rico and Hawaii's map legend are based on island specific classification
    systems (Gon et al. 2006, Gould et al. 2008).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'gap',
    'landcover',
    'landfire',
    'usgs',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://gapanalysis.usgs.gov/gaplandcover/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-127.98, 22.79, -65.27, 52.57,
                    '2011-01-01T00:00:00Z', '2012-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'landcover',
        description: 'Landcover class descriptions',
        'gee:classes': [
          {
            value: 1,
            color: '00847d',
            description: 'South Florida Bayhead Swamp',
          },
          {
            value: 2,
            color: '00847d',
            description: 'South Florida Cypress Dome',
          },
          {
            value: 3,
            color: '00847d',
            description: 'South Florida Dwarf Cypress Savanna',
          },
          {
            value: 4,
            color: '1edf9f',
            description: 'South Florida Mangrove Swamp',
          },
          {
            value: 5,
            color: '2bd234',
            description: 'South Florida Hardwood Hammock',
          },
          {
            value: 6,
            color: '2bd234',
            description: 'Southeast Florida Coastal Strand and Maritime Hammock',
          },
          {
            value: 7,
            color: '2bd234',
            description: 'Southwest Florida Coastal Strand and Maritime Hammock',
          },
          {
            value: 8,
            color: 'b2f9b0',
            description: 'South Florida Pine Rockland',
          },
          {
            value: 9,
            color: '28922c',
            description: 'Atlantic Coastal Plain Fall-line Sandhills Longleaf Pine Woodland - Open Understory',
          },
          {
            value: 10,
            color: '28922c',
            description: 'Atlantic Coastal Plain Fall-line Sandhills Longleaf Pine Woodland - Scrub/Shrub Understory',
          },
          {
            value: 11,
            color: '28922c',
            description: 'Atlantic Coastal Plain Upland Longleaf Pine Woodland',
          },
          {
            value: 12,
            color: '28922c',
            description: 'Atlantic Coastal Plain Xeric River Dune',
          },
          {
            value: 13,
            color: '28922c',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland - Open Understory Modifier',
          },
          {
            value: 14,
            color: '28922c',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland - Scrub/Shrub Modifier',
          },
          {
            value: 15,
            color: '28922c',
            description: 'Florida Longleaf Pine Sandhill - Scrub/Shrub Understory Modifier',
          },
          {
            value: 16,
            color: '28922c',
            description: 'Florida Longleaf Pine Sandhill- Open Understory Modifier',
          },
          {
            value: 17,
            color: '28922c',
            description: 'West Gulf Coastal Plain Upland Longleaf Pine Forest and Woodland',
          },
          {
            value: 18,
            color: '28bf00',
            description: 'Atlantic Coastal Plain Central Maritime Forest',
          },
          {
            value: 19,
            color: '28bf00',
            description: 'Atlantic Coastal Plain Southern Maritime Forest',
          },
          {
            value: 20,
            color: '28bf00',
            description: 'Central and South Texas Coastal Fringe Forest and Woodland',
          },
          {
            value: 21,
            color: '28bf00',
            description: 'East Gulf Coastal Plain Limestone Forest',
          },
          {
            value: 22,
            color: '28bf00',
            description: 'East Gulf Coastal Plain Maritime Forest',
          },
          {
            value: 23,
            color: '28bf00',
            description: 'East Gulf Coastal Plain Southern Loess Bluff Forest',
          },
          {
            value: 24,
            color: '28bf00',
            description: 'East Gulf Coastal Plain Southern Mesic Slope Forest',
          },
          {
            value: 25,
            color: '28bf00',
            description: 'Mississippi Delta Maritime Forest',
          },
          {
            value: 26,
            color: '28bf00',
            description: 'Southern Coastal Plain Dry Upland Hardwood Forest',
          },
          {
            value: 27,
            color: '28bf00',
            description: 'Southern Coastal Plain Oak Dome and Hammock',
          },
          {
            value: 28,
            color: '28bf00',
            description: 'West Gulf Coastal Plain Chenier and Upper Texas Coastal Fringe Forest and Woodland',
          },
          {
            value: 29,
            color: '28bf00',
            description: 'West Gulf Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 30,
            color: '64bf00',
            description: 'East-Central Texas Plains Pine Forest and Woodland',
          },
          {
            value: 31,
            color: '64bf00',
            description: 'West Gulf Coastal Plain Pine-Hardwood Forest',
          },
          {
            value: 32,
            color: '64bf00',
            description: 'West Gulf Coastal Plain Sandhill Oak and Shortleaf Pine Forest and Woodland',
          },
          {
            value: 33,
            color: 'a7bf2c',
            description: 'Atlantic Coastal Plain Fall-Line Sandhills Longleaf Pine Woodland - Loblolly Modifier',
          },
          {
            value: 34,
            color: 'a7bf2c',
            description: 'Deciduous Plantations',
          },
          {
            value: 35,
            color: 'a7bf2c',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland - Loblolly Modifier',
          },
          {
            value: 36,
            color: 'a7bf2c',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland - Offsite Hardwood Modifier',
          },
          {
            value: 37,
            color: 'a7bf2c',
            description: 'East Gulf Coastal Plain Near-Coast Pine Flatwoods - Offsite Hardwood Modifier',
          },
          {
            value: 38,
            color: 'a7bf2c',
            description: 'Evergreen Plantation or Managed Pine',
          },
          {
            value: 39,
            color: '1f9b5b',
            description: 'California Central Valley Mixed Oak Savanna',
          },
          {
            value: 40,
            color: '1f9b5b',
            description: 'California Coastal Closed-Cone Conifer Forest and Woodland',
          },
          {
            value: 41,
            color: '1f9b5b',
            description: 'California Coastal Live Oak Woodland and Savanna',
          },
          {
            value: 42,
            color: '1f9b5b',
            description: 'California Lower Montane Blue Oak-Foothill Pine Woodland and Savanna',
          },
          {
            value: 43,
            color: '1f9b5b',
            description: 'Central and Southern California Mixed Evergreen Woodland',
          },
          {
            value: 44,
            color: '1f9b5b',
            description: 'Mediterranean California Lower Montane Black Oak-Conifer Forest and Woodland',
          },
          {
            value: 45,
            color: '1f9b5b',
            description: 'Southern California Oak Woodland and Savanna',
          },
          {
            value: 46,
            color: '009b8e',
            description: 'Madrean Encinal',
          },
          {
            value: 47,
            color: '009b8e',
            description: 'Madrean Pinyon-Juniper Woodland',
          },
          {
            value: 48,
            color: '1f9b50',
            description: 'Madrean Pine-Oak Forest and Woodland',
          },
          {
            value: 49,
            color: '1f9b50',
            description: 'Madrean Upper Montane Conifer-Oak Forest and Woodland',
          },
          {
            value: 50,
            color: '009b85',
            description: 'Edwards Plateau Dry-Mesic Slope Forest and Woodland',
          },
          {
            value: 51,
            color: '009b85',
            description: 'Edwards Plateau Limestone Savanna and Woodland',
          },
          {
            value: 52,
            color: '009b85',
            description: 'Edwards Plateau Mesic Canyon',
          },
          {
            value: 53,
            color: '009b85',
            description: 'Llano Uplift Acidic Forest, Woodland and Glade',
          },
          {
            value: 54,
            color: '63785b',
            description: 'East Cascades Oak-Ponderosa Pine Forest and Woodland',
          },
          {
            value: 55,
            color: '63785b',
            description: 'Mediterranean California Mixed Evergreen Forest',
          },
          {
            value: 56,
            color: '63785b',
            description: 'Mediterranean California Mixed Oak Woodland',
          },
          {
            value: 57,
            color: '63785b',
            description: 'North Pacific Dry Douglas-fir-(Madrone) Forest and Woodland',
          },
          {
            value: 58,
            color: '63785b',
            description: 'North Pacific Oak Woodland',
          },
          {
            value: 59,
            color: '869b5b',
            description: 'Edwards Plateau Limestone Shrubland',
          },
          {
            value: 60,
            color: '26ac00',
            description: 'Allegheny-Cumberland Dry Oak Forest and Woodland - Hardwood',
          },
          {
            value: 61,
            color: '26ac00',
            description: 'Allegheny-Cumberland Dry Oak Forest and Woodland - Pine Modifier',
          },
          {
            value: 62,
            color: '26ac00',
            description: 'Central and Southern Appalachian Montane Oak Forest',
          },
          {
            value: 63,
            color: '26ac00',
            description: 'Central and Southern Appalachian Northern Hardwood Forest',
          },
          {
            value: 64,
            color: '26ac00',
            description: 'Central Appalachian Oak and Pine Forest',
          },
          {
            value: 65,
            color: '26ac00',
            description: 'Crosstimbers Oak Forest and Woodland',
          },
          {
            value: 66,
            color: '26ac00',
            description: 'East Gulf Coastal Plain Black Belt Calcareous Prairie and Woodland - Woodland Modifier',
          },
          {
            value: 67,
            color: '26ac00',
            description: 'East Gulf Coastal Plain Northern Dry Upland Hardwood Forest',
          },
          {
            value: 68,
            color: '26ac00',
            description: 'East Gulf Coastal Plain Northern Loess Plain Oak-Hickory Upland - Hardwood Modifier',
          },
          {
            value: 69,
            color: '26ac00',
            description: 'East Gulf Coastal Plain Northern Loess Plain Oak-Hickory Upland - Juniper Modifier',
          },
          {
            value: 70,
            color: '26ac00',
            description: 'East-Central Texas Plains Post Oak Savanna and Woodland',
          },
          {
            value: 71,
            color: '26ac00',
            description: 'Lower Mississippi River Dune Woodland and Forest',
          },
          {
            value: 72,
            color: '26ac00',
            description: 'Mississippi River Alluvial Plain Dry-Mesic Loess Slope Forest',
          },
          {
            value: 73,
            color: '26ac00',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 74,
            color: '26ac00',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 75,
            color: '26ac00',
            description: 'Northeastern Interior Dry Oak Forest - Mixed Modifier',
          },
          {
            value: 76,
            color: '26ac00',
            description: 'Northeastern Interior Dry Oak Forest - Virginia/Pitch Pine Modifier',
          },
          {
            value: 77,
            color: '26ac00',
            description: 'Northeastern Interior Dry Oak Forest-Hardwood Modifier',
          },
          {
            value: 78,
            color: '26ac00',
            description: 'Northeastern Interior Dry-Mesic Oak Forest',
          },
          {
            value: 79,
            color: '26ac00',
            description: 'Northern Atlantic Coastal Plain Dry Hardwood Forest',
          },
          {
            value: 80,
            color: '26ac00',
            description: "Crowley's Ridge Sand Forest",
          },
          {
            value: 81,
            color: '26ac00',
            description: 'Ouachita Montane Oak Forest',
          },
          {
            value: 82,
            color: '26ac00',
            description: 'Ozark-Ouachita Dry Oak Woodland',
          },
          {
            value: 83,
            color: '26ac00',
            description: 'Ozark-Ouachita Dry-Mesic Oak Forest',
          },
          {
            value: 84,
            color: '26ac00',
            description: 'Southern and Central Appalachian Oak Forest',
          },
          {
            value: 85,
            color: '26ac00',
            description: 'Southern and Central Appalachian Oak Forest - Xeric',
          },
          {
            value: 86,
            color: '26ac00',
            description: 'Southern Interior Low Plateau Dry-Mesic Oak Forest',
          },
          {
            value: 87,
            color: '26ac00',
            description: 'Southern Ridge and Valley Dry Calcareous Forest',
          },
          {
            value: 88,
            color: '26ac00',
            description: 'Southern Ridge and Valley Dry Calcareous Forest - Pine modifier',
          },
          {
            value: 89,
            color: '6d7200',
            description: 'East Gulf Coastal Plain Northern Dry Upland Hardwood Forest - Offsite Pine Modifier',
          },
          {
            value: 90,
            color: '6d7200',
            description: 'Managed Tree Plantation',
          },
          {
            value: 91,
            color: '6d7200',
            description: 'Ruderal forest',
          },
          {
            value: 92,
            color: '6d7200',
            description: 'Southern Piedmont Dry Oak-(Pine) Forest - Loblolly Pine Modifier',
          },
          {
            value: 93,
            color: '358100',
            description: 'Acadian Low-Elevation Spruce-Fir-Hardwood Forest',
          },
          {
            value: 94,
            color: '358100',
            description: 'Acadian-Appalachian Montane Spruce-Fir Forest',
          },
          {
            value: 95,
            color: '358100',
            description: 'Appalachian Hemlock-Hardwood Forest',
          },
          {
            value: 96,
            color: '358100',
            description: 'Central and Southern Appalachian Spruce-Fir Forest',
          },
          {
            value: 97,
            color: '000000',
            description: 'Unmapped 1',
          },
          {
            value: 98,
            color: '358100',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 99,
            color: '358100',
            description: 'Laurentian-Acadian Northern Pine-(Oak) Forest',
          },
          {
            value: 100,
            color: '358100',
            description: 'Laurentian-Acadian Pine-Hemlock-Hardwood Forest',
          },
          {
            value: 101,
            color: '358100',
            description: 'Paleozoic Plateau Bluff and Talus',
          },
          {
            value: 102,
            color: '358100',
            description: 'Southern Appalachian Northern Hardwood Forest',
          },
          {
            value: 103,
            color: '267200',
            description: 'Atlantic Coastal Plain Dry and Dry-Mesic Oak Forest',
          },
          {
            value: 104,
            color: '267200',
            description: 'Atlantic Coastal Plain Fall-line Sandhills Longleaf Pine Woodland - Offsite Hardwood',
          },
          {
            value: 105,
            color: '267200',
            description: 'East Gulf Coastal Plain Interior Shortleaf Pine-Oak Forest - Hardwood Modifier',
          },
          {
            value: 106,
            color: '267200',
            description: 'East Gulf Coastal Plain Interior Shortleaf Pine-Oak Forest - Mixed Modifier',
          },
          {
            value: 107,
            color: '267200',
            description: 'Ozark-Ouachita Shortleaf Pine-Bluestem Woodland',
          },
          {
            value: 108,
            color: '267200',
            description: 'Ozark-Ouachita Shortleaf Pine-Oak Forest and Woodland',
          },
          {
            value: 109,
            color: '267200',
            description: 'Southeastern Interior Longleaf Pine Woodland',
          },
          {
            value: 110,
            color: '267200',
            description: 'Southern Appalachian Low Mountain Pine Forest',
          },
          {
            value: 111,
            color: '267200',
            description: 'Southern Piedmont Dry Oak-(Pine) Forest',
          },
          {
            value: 112,
            color: '267200',
            description: 'Southern Piedmont Dry Oak-(Pine) Forest - Hardwood Modifier',
          },
          {
            value: 113,
            color: '267200',
            description: 'Southern Piedmont Dry Oak-(Pine) Forest - Mixed Modifier',
          },
          {
            value: 114,
            color: '267200',
            description: 'Southern Piedmont Dry Oak-Heath Forest - Mixed Modifier',
          },
          {
            value: 115,
            color: '636800',
            description: 'Eastern Great Plains Tallgrass Aspen Parkland',
          },
          {
            value: 116,
            color: '636800',
            description: 'Northwestern Great Plains Aspen Forest and Parkland',
          },
          {
            value: 117,
            color: '636800',
            description: 'Northwestern Great Plains Shrubland',
          },
          {
            value: 118,
            color: '636800',
            description: 'Western Great Plains Dry Bur Oak Forest and Woodland',
          },
          {
            value: 119,
            color: '636800',
            description: 'Western Great Plains Wooded Draw and Ravine',
          },
          {
            value: 120,
            color: '266d00',
            description: 'Southern Atlantic Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 121,
            color: '266d00',
            description: 'East Gulf Coastal Plain Northern Loess Bluff Forest',
          },
          {
            value: 122,
            color: '266d00',
            description: 'East Gulf Coastal Plain Northern Mesic Hardwood Forest',
          },
          {
            value: 123,
            color: '266d00',
            description: 'North-Central Interior Beech-Maple Forest',
          },
          {
            value: 124,
            color: '266d00',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 125,
            color: '266d00',
            description: 'Ozark-Ouachita Mesic Hardwood Forest',
          },
          {
            value: 126,
            color: '266d00',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 127,
            color: '266d00',
            description: 'Southern and Central Appalachian Cove Forest',
          },
          {
            value: 128,
            color: '266d00',
            description: "Crowley's Ridge Mesic Loess Slope Forest",
          },
          {
            value: 129,
            color: '266d00',
            description: 'Southern Piedmont Mesic Forest',
          },
          {
            value: 130,
            color: '267257',
            description: 'Appalachian Shale Barrens',
          },
          {
            value: 131,
            color: '267257',
            description: 'Atlantic Coastal Plain Northern Maritime Forest',
          },
          {
            value: 132,
            color: '267257',
            description: 'Laurentian Pine-Oak Barrens',
          },
          {
            value: 133,
            color: '267257',
            description: 'Northeastern Interior Pine Barrens',
          },
          {
            value: 134,
            color: '267257',
            description: 'Northern Atlantic Coastal Plain Pitch Pine Barrens',
          },
          {
            value: 135,
            color: '267257',
            description: 'Southern Appalachian Montane Pine Forest and Woodland',
          },
          {
            value: 136,
            color: '005300',
            description: 'East Cascades Mesic Montane Mixed-Conifer Forest and Woodland',
          },
          {
            value: 137,
            color: '005300',
            description: 'Middle Rocky Mountain Montane Douglas-fir Forest and Woodland',
          },
          {
            value: 138,
            color: '005300',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 139,
            color: '005300',
            description: 'Northern Rocky Mountain Foothill Conifer Wooded Steppe',
          },
          {
            value: 140,
            color: '005300',
            description: 'Northern Rocky Mountain Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 141,
            color: '005300',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna',
          },
          {
            value: 142,
            color: '005300',
            description: 'Northern Rocky Mountain Western Larch Savanna',
          },
          {
            value: 143,
            color: '005300',
            description: 'Northwestern Great Plains - Black Hills Ponderosa Pine Woodland and Savanna',
          },
          {
            value: 144,
            color: '005300',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 145,
            color: '004500',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 146,
            color: '004500',
            description: 'Inter-Mountain Basins Subalpine Limber-Bristlecone Pine Woodland',
          },
          {
            value: 147,
            color: '004500',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 148,
            color: '004500',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 149,
            color: '004500',
            description: 'Rocky Mountain Lodgepole Pine Forest',
          },
          {
            value: 150,
            color: '004500',
            description: 'Rocky Mountain Poor-Site Lodgepole Pine Forest',
          },
          {
            value: 151,
            color: '004500',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 152,
            color: '004500',
            description: 'Rocky Mountain Subalpine Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 153,
            color: '004500',
            description: 'Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland',
          },
          {
            value: 154,
            color: '006313',
            description: 'Rocky Mountain Bigtooth Maple Ravine Woodland',
          },
          {
            value: 155,
            color: '006313',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 156,
            color: '006313',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 157,
            color: '006313',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 158,
            color: '006313',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 159,
            color: '004532',
            description: 'California Montane Jeffrey Pine-(Ponderosa Pine) Woodland',
          },
          {
            value: 160,
            color: '004532',
            description: 'Klamath-Siskiyou Lower Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 161,
            color: '004532',
            description: 'Klamath-Siskiyou Upper Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 162,
            color: '004532',
            description: 'Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 163,
            color: '004532',
            description: 'Mediterranean California Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 164,
            color: '004532',
            description: 'Sierran-Intermontane Desert Western White Pine-White Fir Woodland',
          },
          {
            value: 165,
            color: '005345',
            description: 'California Coastal Redwood Forest',
          },
          {
            value: 166,
            color: '005345',
            description: 'North Pacific Broadleaf Landslide Forest and Shrubland',
          },
          {
            value: 167,
            color: '005345',
            description: 'North Pacific Dry-Mesic Silver Fir-Western Hemlock-Douglas-fir Forest',
          },
          {
            value: 168,
            color: '005345',
            description: 'North Pacific Hypermaritime Sitka Spruce Forest',
          },
          {
            value: 169,
            color: '005345',
            description: 'North Pacific Hypermaritime Western Red-cedar-Western Hemlock Forest',
          },
          {
            value: 170,
            color: '005345',
            description: 'North Pacific Lowland Mixed Hardwood-Conifer Forest and Woodland',
          },
          {
            value: 171,
            color: '005345',
            description: 'North Pacific Maritime Dry-Mesic Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 172,
            color: '005345',
            description: 'North Pacific Maritime Mesic-Wet Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 173,
            color: '005345',
            description: 'North Pacific Mesic Western Hemlock-Silver Fir Forest',
          },
          {
            value: 174,
            color: '005345',
            description: 'North Pacific Wooded Volcanic Flowage',
          },
          {
            value: 175,
            color: '4e8578',
            description: 'Mediterranean California Red Fir Forest',
          },
          {
            value: 176,
            color: '4e8578',
            description: 'Mediterranean California Subalpine Woodland',
          },
          {
            value: 177,
            color: '4e8578',
            description: 'North Pacific Maritime Mesic Subalpine Parkland',
          },
          {
            value: 178,
            color: '4e8578',
            description: 'North Pacific Mountain Hemlock Forest',
          },
          {
            value: 179,
            color: '4e8578',
            description: 'Northern California Mesic Subalpine Woodland',
          },
          {
            value: 180,
            color: '4e8578',
            description: 'Northern Pacific Mesic Subalpine Woodland',
          },
          {
            value: 181,
            color: '4e8578',
            description: 'Sierra Nevada Subalpine Lodgepole Pine Forest and Woodland',
          },
          {
            value: 182,
            color: '667d15',
            description: 'Columbia Plateau Western Juniper Woodland and Savanna',
          },
          {
            value: 183,
            color: '667d15',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 184,
            color: '667d15',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 185,
            color: '667d15',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 186,
            color: '597d15',
            description: 'Colorado Plateau Pinyon-Juniper Shrubland',
          },
          {
            value: 187,
            color: '597d15',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 188,
            color: '597d15',
            description: 'Southern Rocky Mountain Juniper Woodland and Savanna',
          },
          {
            value: 189,
            color: '597d15',
            description: 'Southern Rocky Mountain Pinyon-Juniper Woodland',
          },
          {
            value: 190,
            color: '006072',
            description: 'Northwestern Great Plains Floodplain',
          },
          {
            value: 191,
            color: '006072',
            description: 'Northwestern Great Plains Riparian',
          },
          {
            value: 192,
            color: '006072',
            description: 'Western Great Plains Floodplain',
          },
          {
            value: 193,
            color: '006072',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 194,
            color: '006072',
            description: 'Western Great Plains Riparian Woodland and Shrubland',
          },
          {
            value: 195,
            color: '005781',
            description: 'Central Appalachian Floodplain - Forest Modifier',
          },
          {
            value: 196,
            color: '005781',
            description: 'Central Appalachian Riparian - Forest Modifier',
          },
          {
            value: 197,
            color: '005781',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 198,
            color: '005781',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 199,
            color: '005781',
            description: 'Laurentian-Acadian Floodplain Systems',
          },
          {
            value: 200,
            color: '005781',
            description: 'Ozark-Ouachita Riparian',
          },
          {
            value: 201,
            color: '005781',
            description: 'South-Central Interior Large Floodplain',
          },
          {
            value: 202,
            color: '005781',
            description: 'South-Central Interior Large Floodplain - Forest Modifier',
          },
          {
            value: 203,
            color: '005781',
            description: 'South-Central Interior Small Stream and Riparian',
          },
          {
            value: 204,
            color: '666096',
            description: 'North-Central Interior and Appalachian Rich Swamp',
          },
          {
            value: 205,
            color: '000000',
            description: 'Unmapped 2',
          },
          {
            value: 206,
            color: '000000',
            description: 'Unmapped 3',
          },
          {
            value: 207,
            color: '666096',
            description: 'Laurentian-Acadian Swamp Systems',
          },
          {
            value: 208,
            color: '666096',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 209,
            color: '000000',
            description: 'Unmapped 4',
          },
          {
            value: 210,
            color: '666096',
            description: 'South-Central Interior / Upper Coastal Plain Wet Flatwoods',
          },
          {
            value: 211,
            color: '000000',
            description: 'Unmapped 5',
          },
          {
            value: 212,
            color: '666096',
            description: 'Southern Piedmont/Ridge and Valley Upland Depression Swamp',
          },
          {
            value: 213,
            color: '339b79',
            description: 'Atlantic Coastal Plain Blackwater Stream Floodplain Forest - Forest Modifier',
          },
          {
            value: 214,
            color: '339b79',
            description: 'Atlantic Coastal Plain Brownwater Stream Floodplain Forest',
          },
          {
            value: 215,
            color: '339b79',
            description: 'Atlantic Coastal Plain Northern Tidal Wooded Swamp',
          },
          {
            value: 216,
            color: '339b79',
            description: 'Atlantic Coastal Plain Small Blackwater River Floodplain Forest',
          },
          {
            value: 217,
            color: '339b79',
            description: 'Atlantic Coastal Plain Small Brownwater River Floodplain Forest',
          },
          {
            value: 218,
            color: '339b79',
            description: 'Atlantic Coastal Plain Southern Tidal Wooded Swamp',
          },
          {
            value: 219,
            color: '339b79',
            description: 'East Gulf Coastal Plain Large River Floodplain Forest - Forest Modifier',
          },
          {
            value: 220,
            color: '339b79',
            description: 'East Gulf Coastal Plain Small Stream and River Floodplain Forest',
          },
          {
            value: 221,
            color: '339b79',
            description: 'East Gulf Coastal Plain Tidal Wooded Swamp',
          },
          {
            value: 222,
            color: '000000',
            description: 'Unmapped 6',
          },
          {
            value: 223,
            color: '339b79',
            description: 'Southeastern Great Plains Riparian Forest',
          },
          {
            value: 224,
            color: '339b79',
            description: 'Southeastern Great Plains Floodplain Forest',
          },
          {
            value: 225,
            color: '339b79',
            description: 'Mississippi River Bottomland Depression',
          },
          {
            value: 226,
            color: '339b79',
            description: 'Mississippi River Floodplain and Riparian Forest',
          },
          {
            value: 227,
            color: '339b79',
            description: 'Mississippi River Low Floodplain (Bottomland) Forest',
          },
          {
            value: 228,
            color: '339b79',
            description: 'Mississippi River Riparian Forest',
          },
          {
            value: 229,
            color: '339b79',
            description: 'Red River Large Floodplain Forest',
          },
          {
            value: 230,
            color: '339b79',
            description: 'Southern Coastal Plain Blackwater River Floodplain Forest',
          },
          {
            value: 231,
            color: '339b79',
            description: 'Southern Piedmont Large Floodplain Forest - Forest Modifier',
          },
          {
            value: 232,
            color: '339b79',
            description: 'Southern Piedmont Small Floodplain and Riparian Forest',
          },
          {
            value: 233,
            color: '339b79',
            description: 'West Gulf Coastal Plain Large River Floodplain Forest',
          },
          {
            value: 234,
            color: '339b79',
            description: 'West Gulf Coastal Plain Near-Coast Large River Swamp',
          },
          {
            value: 235,
            color: '339b79',
            description: 'West Gulf Coastal Plain Small Stream and River Forest',
          },
          {
            value: 236,
            color: '339ba3',
            description: 'Atlantic Coastal Plain Streamhead Seepage Swamp -  Pocosin -  and Baygall',
          },
          {
            value: 237,
            color: '339ba3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 238,
            color: '339ba3',
            description: 'Southern Coastal Plain Hydric Hammock',
          },
          {
            value: 239,
            color: '339ba3',
            description: 'Southern Coastal Plain Seepage Swamp and Baygall',
          },
          {
            value: 240,
            color: '339ba3',
            description: 'West Gulf Coastal Plain Seepage Swamp and Baygall',
          },
          {
            value: 241,
            color: '00709b',
            description: 'Atlantic Coastal Plain Nonriverine Swamp and Wet Hardwood Forest  - Taxodium/Nyssa Modifier',
          },
          {
            value: 242,
            color: '00709b',
            description: 'Atlantic Coastal Plain Nonriverine Swamp and Wet Hardwood Forest - Oak Dominated Modifier',
          },
          {
            value: 243,
            color: '00709b',
            description: 'East Gulf Coastal Plain Southern Loblolly-Hardwood Flatwoods',
          },
          {
            value: 244,
            color: '00709b',
            description: 'Lower Mississippi River Bottomland Depressions - Forest Modifier',
          },
          {
            value: 245,
            color: '00709b',
            description: 'Lower Mississippi River Flatwoods',
          },
          {
            value: 246,
            color: '00709b',
            description: 'Northern Atlantic Coastal Plain Basin Swamp and Wet Hardwood Forest',
          },
          {
            value: 247,
            color: '00709b',
            description: 'Southern Coastal Plain Nonriverine Basin Swamp',
          },
          {
            value: 248,
            color: '00709b',
            description: 'Southern Coastal Plain Nonriverine Basin Swamp - Okefenokee Bay/Gum Modifier',
          },
          {
            value: 249,
            color: '00709b',
            description: 'Southern Coastal Plain Nonriverine Basin Swamp - Okefenokee Pine Modifier',
          },
          {
            value: 250,
            color: '00709b',
            description: 'Southern Coastal Plain Nonriverine Basin Swamp - Okefenokee Taxodium Modifier',
          },
          {
            value: 251,
            color: '00709b',
            description: 'West Gulf Coastal Plain Nonriverine Wet Hardwood Flatwoods',
          },
          {
            value: 252,
            color: '00709b',
            description: 'West Gulf Coastal Plain Pine-Hardwood Flatwoods',
          },
          {
            value: 253,
            color: '339ba0',
            description: 'Edwards Plateau Riparian',
          },
          {
            value: 254,
            color: '009b79',
            description: 'Atlantic Coastal Plain Clay-Based Carolina Bay Forested Wetland',
          },
          {
            value: 255,
            color: '00c5ff',
            description: 'Atlantic Coastal Plain Clay-Based Carolina Bay Herbaceous Wetland',
          },
          {
            value: 256,
            color: '009b79',
            description: 'Atlantic Coastal Plain Southern Wet Pine Savanna and Flatwoods',
          },
          {
            value: 257,
            color: '009b79',
            description: 'Central Atlantic Coastal Plain Wet Longleaf Pine Savanna and Flatwoods',
          },
          {
            value: 258,
            color: '009b79',
            description: 'Central Florida Pine Flatwoods',
          },
          {
            value: 259,
            color: '009b79',
            description: 'East Gulf Coastal Plain Near-Coast Pine Flatwoods',
          },
          {
            value: 260,
            color: '009b79',
            description: 'East Gulf Coastal Plain Near-Coast Pine Flatwoods - Open Understory Modifier',
          },
          {
            value: 261,
            color: '009b79',
            description: 'East Gulf Coastal Plain Near-Coast Pine Flatwoods - Scrub/Shrub Understory Modifier',
          },
          {
            value: 262,
            color: '009b79',
            description: 'South Florida Pine Flatwoods',
          },
          {
            value: 263,
            color: '009b79',
            description: 'Southern Coastal Plain Nonriverine Cypress Dome',
          },
          {
            value: 264,
            color: '009b79',
            description: 'West Gulf Coastal Plain Wet Longleaf Pine Savanna and Flatwoods',
          },
          {
            value: 265,
            color: '068580',
            description: 'Columbia Basin Foothill Riparian Woodland and Shrubland',
          },
          {
            value: 266,
            color: '068580',
            description: 'Great Basin Foothill and Lower Montane Riparian Woodland and Shrubland',
          },
          {
            value: 267,
            color: '000000',
            description: 'Unmapped 7',
          },
          {
            value: 268,
            color: '068580',
            description: 'Northern Rocky Mountain Conifer Swamp',
          },
          {
            value: 269,
            color: '068580',
            description: 'Northern Rocky Mountain Lower Montane Riparian Woodland and Shrubland',
          },
          {
            value: 270,
            color: '068580',
            description: 'Rocky Mountain Lower Montane Riparian Woodland and Shrubland',
          },
          {
            value: 271,
            color: '068580',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 272,
            color: '068580',
            description: 'Rocky Mountain Subalpine-Montane Riparian Woodland',
          },
          {
            value: 273,
            color: '0685a0',
            description: 'North Pacific Hardwood-Conifer Swamp',
          },
          {
            value: 274,
            color: '0685a0',
            description: 'North Pacific Lowland Riparian Forest and Shrubland',
          },
          {
            value: 275,
            color: '0685a0',
            description: 'North Pacific Montane Riparian Woodland and Shrubland',
          },
          {
            value: 276,
            color: '0685a0',
            description: 'North Pacific Shrub Swamp',
          },
          {
            value: 277,
            color: '3392a3',
            description: 'California Central Valley Riparian Woodland and Shrubland',
          },
          {
            value: 278,
            color: '3392a3',
            description: 'Mediterranean California Foothill and Lower Montane Riparian Woodland',
          },
          {
            value: 279,
            color: '3392a3',
            description: 'Mediterranean California Serpentine Foothill and Lower Montane Riparian Woodland and Seep',
          },
          {
            value: 280,
            color: '3392a3',
            description: 'North American Warm Desert Lower Montane Riparian Woodland and Shrubland',
          },
          {
            value: 281,
            color: '3392a3',
            description: 'North American Warm Desert Riparian Systems',
          },
          {
            value: 282,
            color: '3392a3',
            description: 'North American Warm Desert Riparian Woodland and Shrubland',
          },
          {
            value: 283,
            color: '3392a3',
            description: 'Tamaulipan Floodplain',
          },
          {
            value: 284,
            color: '3392a3',
            description: 'Tamaulipan Riparian Systems',
          },
          {
            value: 285,
            color: '4c4e26',
            description: 'Boreal Aspen-Birch Forest',
          },
          {
            value: 286,
            color: '4c4e26',
            description: 'Boreal Jack Pine-Black Spruce Forest',
          },
          {
            value: 287,
            color: '4c4e26',
            description: 'Boreal White Spruce-Fir-Hardwood Forest',
          },
          {
            value: 288,
            color: '005878',
            description: 'Boreal-Laurentian Conifer Acidic Swamp and Treed Poor Fen',
          },
          {
            value: 289,
            color: '00594c',
            description: 'Eastern Boreal Floodplain',
          },
          {
            value: 290,
            color: 'f68a12',
            description: 'South Florida Shell Hash Beach',
          },
          {
            value: 291,
            color: 'f68a12',
            description: 'Southeast Florida Beach',
          },
          {
            value: 292,
            color: 'f68a12',
            description: 'Southwest Florida Beach',
          },
          {
            value: 293,
            color: 'c9fff0',
            description: 'South Florida Everglades Sawgrass Marsh',
          },
          {
            value: 294,
            color: 'c9fff0',
            description: 'South Florida Freshwater Slough and Gator Hole',
          },
          {
            value: 295,
            color: 'c9fff0',
            description: 'South Florida Wet Marl Prairie',
          },
          {
            value: 296,
            color: 'f27612',
            description: 'California Maritime Chaparral',
          },
          {
            value: 297,
            color: 'f27612',
            description: 'California Mesic Chaparral',
          },
          {
            value: 298,
            color: 'f27612',
            description: 'California Xeric Serpentine Chaparral',
          },
          {
            value: 299,
            color: 'f27612',
            description: 'Klamath-Siskiyou Xeromorphic Serpentine Savanna and Chaparral',
          },
          {
            value: 300,
            color: 'f27612',
            description: 'Mediterranean California Mesic Serpentine Woodland and Chaparral',
          },
          {
            value: 301,
            color: 'f27612',
            description: 'Northern and Central California Dry-Mesic Chaparral',
          },
          {
            value: 302,
            color: 'f27612',
            description: 'Southern California Dry-Mesic Chaparral',
          },
          {
            value: 303,
            color: 'c77612',
            description: 'Southern California Coastal Scrub',
          },
          {
            value: 304,
            color: 'ecd78c',
            description: 'California Central Valley and Southern Coastal Grassland',
          },
          {
            value: 305,
            color: 'ecd78c',
            description: 'California Mesic Serpentine Grassland',
          },
          {
            value: 306,
            color: 'f4be63',
            description: 'Columbia Basin Foothill and Canyon Dry Grassland',
          },
          {
            value: 307,
            color: 'f4be63',
            description: 'Columbia Basin Palouse Prairie',
          },
          {
            value: 308,
            color: 'f4be63',
            description: 'North Pacific Alpine and Subalpine Dry Grassland',
          },
          {
            value: 309,
            color: 'f4be63',
            description: 'North Pacific Montane Grassland',
          },
          {
            value: 310,
            color: 'f4be63',
            description: 'North Pacific Montane Shrubland',
          },
          {
            value: 311,
            color: 'f4be63',
            description: 'Northern Rocky Mountain Lower Montane, Foothill and Valley Grassland',
          },
          {
            value: 312,
            color: 'f4be63',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 313,
            color: 'f4be63',
            description: 'Northern Rocky Mountain Subalpine Deciduous Shrubland',
          },
          {
            value: 314,
            color: 'f4be63',
            description: 'Northern Rocky Mountain Subalpine-Upper Montane Grassland',
          },
          {
            value: 315,
            color: 'f4be63',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 316,
            color: 'f6bf63',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 317,
            color: 'f6bf63',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 318,
            color: 'f6bf96',
            description: 'California Northern Coastal Grassland',
          },
          {
            value: 319,
            color: 'f6bf96',
            description: 'North Pacific Herbaceous Bald and Bluff',
          },
          {
            value: 320,
            color: 'f6bf96',
            description: 'North Pacific Hypermaritime Shrub and Herbaceous Headland',
          },
          {
            value: 321,
            color: 'f6bf96',
            description: 'Willamette Valley Upland Prairie and Savanna',
          },
          {
            value: 322,
            color: 'f6be63',
            description: 'Mediterranean California Subalpine Meadow',
          },
          {
            value: 323,
            color: 'f6be63',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 324,
            color: 'c19b64',
            description: 'Central Mixedgrass Prairie',
          },
          {
            value: 325,
            color: 'c19b64',
            description: 'Northwestern Great Plains Mixedgrass Prairie',
          },
          {
            value: 326,
            color: 'c19b64',
            description: 'Western Great Plains Foothill and Piedmont Grassland',
          },
          {
            value: 327,
            color: 'c19b64',
            description: 'Western Great Plains Tallgrass Prairie',
          },
          {
            value: 328,
            color: 'c18135',
            description: 'Western Great Plains Sand Prairie',
          },
          {
            value: 329,
            color: 'c18135',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 330,
            color: 'e0c964',
            description: 'Western Great Plains Mesquite Woodland and Shrubland',
          },
          {
            value: 331,
            color: 'e0c964',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 332,
            color: 'c99964',
            description: 'Arkansas Valley Prairie and Woodland',
          },
          {
            value: 333,
            color: 'c99964',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 334,
            color: 'c99964',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 335,
            color: 'c99964',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 336,
            color: 'c99964',
            description: 'North-Central Oak Barrens',
          },
          {
            value: 337,
            color: 'c99964',
            description: 'Northern Tallgrass Prairie',
          },
          {
            value: 338,
            color: 'c99964',
            description: 'Southeastern Great Plains Tallgrass Prairie',
          },
          {
            value: 339,
            color: 'c99964',
            description: 'Texas Blackland Tallgrass Prairie',
          },
          {
            value: 340,
            color: 'c99964',
            description: 'Texas-Louisiana Coastal Prairie',
          },
          {
            value: 341,
            color: 'f6a366',
            description: 'Central Appalachian Pine-Oak Rocky Woodland',
          },
          {
            value: 342,
            color: 'f0a366',
            description: 'Southern Appalachian Grass and Shrub Bald',
          },
          {
            value: 343,
            color: 'f0a366',
            description: 'Southern Appalachian Grass and Shrub Bald - Herbaceous Modifier',
          },
          {
            value: 344,
            color: 'f0a366',
            description: 'Southern Appalachian Grass and Shrub Bald - Shrub Modifier',
          },
          {
            value: 345,
            color: 'f6a359',
            description: 'Central Appalachian Alkaline Glade and Woodland',
          },
          {
            value: 346,
            color: 'f6a359',
            description: 'Central Interior Highlands Calcareous Glade and Barrens',
          },
          {
            value: 347,
            color: 'f6a359',
            description: 'Central Interior Highlands Dry Acidic Glade and Barrens',
          },
          {
            value: 348,
            color: 'f6a359',
            description: 'Cumberland Sandstone Glade and Barrens',
          },
          {
            value: 349,
            color: 'f6a359',
            description: 'Great Lakes Alvar',
          },
          {
            value: 350,
            color: 'f6a359',
            description: 'Nashville Basin Limestone Glade',
          },
          {
            value: 351,
            color: 'f6a359',
            description: 'Southern Ridge and Valley / Cumberland Dry Calcareous Forest',
          },
          {
            value: 352,
            color: 'f6a359',
            description: 'Southern Piedmont Glade and Barrens',
          },
          {
            value: 353,
            color: 'f6a366',
            description: 'East Gulf Coastal Plain Black Belt Calcareous Prairie and Woodland - Herbaceous Modifier',
          },
          {
            value: 354,
            color: 'f6a366',
            description: 'East Gulf Coastal Plain Jackson Prairie and Woodland',
          },
          {
            value: 355,
            color: 'f6a366',
            description: 'Eastern Highland Rim Prairie and Barrens - Dry Modifier',
          },
          {
            value: 356,
            color: 'edc971',
            description: 'Coahuilan Chaparral',
          },
          {
            value: 357,
            color: 'edc971',
            description: 'Madrean Oriental Chaparral',
          },
          {
            value: 358,
            color: 'edc971',
            description: 'Mogollon Chaparral',
          },
          {
            value: 359,
            color: 'edc971',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 360,
            color: 'd1c971',
            description: 'California Montane Woodland and Chaparral',
          },
          {
            value: 361,
            color: 'd1c971',
            description: 'Great Basin Semi-Desert Chaparral',
          },
          {
            value: 362,
            color: 'f6c466',
            description: 'Florida Dry Prairie',
          },
          {
            value: 363,
            color: 'f6c466',
            description: 'Florida Peninsula Inland Scrub',
          },
          {
            value: 364,
            color: 'ce8666',
            description: 'West Gulf Coastal Plain Catahoula Barrens',
          },
          {
            value: 365,
            color: 'ce8666',
            description: 'West Gulf Coastal Plain Nepheline Syenite Glade',
          },
          {
            value: 366,
            color: 'f6c4a5',
            description: 'East Gulf Coastal Plain Jackson Plain Dry Flatwoods - Open Understory Modifier',
          },
          {
            value: 367,
            color: 'f6c4a5',
            description: 'West Gulf Coastal Plain Northern Calcareous Prairie',
          },
          {
            value: 368,
            color: 'f6c4a5',
            description: 'West Gulf Coastal Plain Southern Calcareous Prairie',
          },
          {
            value: 369,
            color: 'ffe54a',
            description: 'Acadian-Appalachian Subalpine Woodland and Heath-Krummholz',
          },
          {
            value: 370,
            color: 'c99674',
            description: 'Atlantic and Gulf Coastal Plain Interdunal Wetland',
          },
          {
            value: 371,
            color: 'c99674',
            description: 'Atlantic Coastal Plain Southern Dune and Maritime Grassland',
          },
          {
            value: 372,
            color: 'c99674',
            description: 'Central and Upper Texas Coast Dune and Coastal Grassland',
          },
          {
            value: 373,
            color: 'c99674',
            description: 'East Gulf Coastal Plain Dune and Coastal Grassland',
          },
          {
            value: 374,
            color: 'c99674',
            description: 'Great Lakes Dune',
          },
          {
            value: 375,
            color: 'c99674',
            description: 'Northern Atlantic Coastal Plain Dune and Swale',
          },
          {
            value: 376,
            color: 'c99674',
            description: 'Northern Atlantic Coastal Plain Heathland and Grassland',
          },
          {
            value: 377,
            color: 'c99674',
            description: 'South Texas Dune and Coastal Grassland',
          },
          {
            value: 378,
            color: 'c99674',
            description: 'South Texas Sand Sheet Grassland',
          },
          {
            value: 379,
            color: 'c99674',
            description: 'Southwest Florida Dune and Coastal Grassland',
          },
          {
            value: 380,
            color: 'a58559',
            description: 'North Pacific Coastal Cliff and Bluff',
          },
          {
            value: 381,
            color: 'a58559',
            description: 'North Pacific Maritime Coastal Sand Dune and Strand',
          },
          {
            value: 382,
            color: 'a58559',
            description: 'Northern California Coastal Scrub',
          },
          {
            value: 383,
            color: 'a58659',
            description: 'Mediterranean California Coastal Bluff',
          },
          {
            value: 384,
            color: 'a58659',
            description: 'Mediterranean California Northern Coastal Dune',
          },
          {
            value: 385,
            color: 'a58659',
            description: 'Mediterranean California Southern Coastal Dune',
          },
          {
            value: 386,
            color: 'a5863d',
            description: 'Atlantic Coastal Plain Northern Sandy Beach',
          },
          {
            value: 387,
            color: 'a5863d',
            description: 'Atlantic Coastal Plain Sea Island Beach',
          },
          {
            value: 388,
            color: 'a5863d',
            description: 'Atlantic Coastal Plain Southern Beach',
          },
          {
            value: 389,
            color: 'a5863d',
            description: 'Florida Panhandle Beach Vegetation',
          },
          {
            value: 390,
            color: 'a5863d',
            description: 'Louisiana Beach',
          },
          {
            value: 391,
            color: 'a5863d',
            description: 'Northern Atlantic Coastal Plain Sandy Beach',
          },
          {
            value: 392,
            color: 'a5863d',
            description: 'Texas Coastal Bend Beach',
          },
          {
            value: 393,
            color: 'a5863d',
            description: 'Upper Texas Coast Beach',
          },
          {
            value: 394,
            color: '000000',
            description: 'Unmapped 8',
          },
          {
            value: 395,
            color: '709655',
            description: 'Mediterranean California Serpentine Fen',
          },
          {
            value: 396,
            color: '709655',
            description: 'Mediterranean California Subalpine-Montane Fen',
          },
          {
            value: 397,
            color: '709655',
            description: 'North Pacific Bog and Fen',
          },
          {
            value: 398,
            color: '70aeb9',
            description: 'Rocky Mountain Subalpine-Montane Fen',
          },
          {
            value: 399,
            color: '70ae55',
            description: 'Atlantic Coastal Plain Peatland Pocosin',
          },
          {
            value: 400,
            color: '70ae55',
            description: 'Southern and Central Appalachian Bog and Fen',
          },
          {
            value: 401,
            color: '70aee3',
            description: 'Atlantic Coastal Plain Central Fresh-Oligohaline Tidal Marsh',
          },
          {
            value: 402,
            color: '70aee3',
            description: 'Atlantic Coastal Plain Embayed Region Tidal Freshwater Marsh',
          },
          {
            value: 403,
            color: '70aee3',
            description: 'Atlantic Coastal Plain Northern Fresh and Oligohaline Tidal Marsh',
          },
          {
            value: 404,
            color: '70aee3',
            description: 'Florida Big Bend Fresh-Oligohaline Tidal Marsh',
          },
          {
            value: 405,
            color: '70aeb3',
            description: 'Atlantic Coastal Plain Depression Pondshore',
          },
          {
            value: 406,
            color: '70aeb3',
            description: 'Atlantic Coastal Plain Large Natural Lakeshore',
          },
          {
            value: 407,
            color: '70aeb3',
            description: 'Central Florida Herbaceous Pondshore',
          },
          {
            value: 408,
            color: '70aeb3',
            description: 'Central Florida Herbaceous Seep',
          },
          {
            value: 409,
            color: '70aeb3',
            description: 'East Gulf Coastal Plain Savanna and Wet Prairie',
          },
          {
            value: 410,
            color: '70aeb3',
            description: 'East Gulf Coastal Plain Depression Pondshore',
          },
          {
            value: 411,
            color: '70aeb3',
            description: 'Floridian Highlands Freshwater Marsh',
          },
          {
            value: 412,
            color: '70aeb3',
            description: 'Southern Coastal Plain Herbaceous Seepage Bog',
          },
          {
            value: 413,
            color: '70aeb3',
            description: 'Southern Coastal Plain Nonriverine Basin Swamp - Okefenokee Clethra Modifier',
          },
          {
            value: 414,
            color: '70aeb3',
            description: 'Southern Coastal Plain Nonriverine Basin Swamp - Okefenokee Nupea Modifier',
          },
          {
            value: 415,
            color: '70aeb3',
            description: 'Texas-Louisiana Coastal Prairie Slough',
          },
          {
            value: 416,
            color: '6ed6e3',
            description: 'Central Interior and Appalachian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 417,
            color: '6ed6e3',
            description: 'Great Lakes Coastal Marsh Systems',
          },
          {
            value: 418,
            color: '000000',
            description: 'Unmapped 9',
          },
          {
            value: 419,
            color: '000000',
            description: 'Unmapped 10',
          },
          {
            value: 420,
            color: '6ed6e3',
            description: 'Laurentian-Acadian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 421,
            color: '000000',
            description: 'Unmapped 11',
          },
          {
            value: 422,
            color: '8caee3',
            description: 'Eastern Great Plains Wet Meadow, Prairie  and Marsh',
          },
          {
            value: 423,
            color: '8caee3',
            description: 'Great Lakes Wet-Mesic Lakeplain Prairie',
          },
          {
            value: 424,
            color: '8caee3',
            description: 'Great Plains Prairie Pothole',
          },
          {
            value: 425,
            color: '8caee3',
            description: 'Western Great Plains Closed Depression Wetland',
          },
          {
            value: 426,
            color: '8caee3',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 427,
            color: '8caee3',
            description: 'Western Great Plains Open Freshwater Depression Wetland',
          },
          {
            value: 428,
            color: '64aee3',
            description: 'Cumberland Riverscour',
          },
          {
            value: 429,
            color: '00c1c4',
            description: 'Inter-Mountain Basins Interdunal Swale Wetland',
          },
          {
            value: 430,
            color: '00c1c4',
            description: 'North Pacific Avalanche Chute Shrubland',
          },
          {
            value: 431,
            color: '00c1c4',
            description: 'North Pacific Intertidal Freshwater Wetland',
          },
          {
            value: 432,
            color: '00c1c4',
            description: 'Temperate Pacific Freshwater Emergent Marsh',
          },
          {
            value: 433,
            color: '00c1c4',
            description: 'Temperate Pacific Freshwater Mudflat',
          },
          {
            value: 434,
            color: '00c1c3',
            description: 'Columbia Plateau Vernal Pool',
          },
          {
            value: 435,
            color: '00c1c3',
            description: 'Northern California Claypan Vernal Pool',
          },
          {
            value: 436,
            color: '00c1c3',
            description: 'Northern Rocky Mountain Wooded Vernal Pool',
          },
          {
            value: 437,
            color: '00ecfc',
            description: 'Columbia Plateau Silver Sagebrush Seasonally Flooded Shrub-Steppe',
          },
          {
            value: 438,
            color: '00ecfc',
            description: 'Rocky Mountain Alpine-Montane Wet Meadow',
          },
          {
            value: 439,
            color: '00ecfc',
            description: 'Rocky Mountain Subalpine-Montane Riparian Shrubland',
          },
          {
            value: 440,
            color: '00ecfc',
            description: 'Temperate Pacific Montane Wet Meadow',
          },
          {
            value: 441,
            color: '00ecfc',
            description: 'Willamette Valley Wet Prairie',
          },
          {
            value: 442,
            color: '70aec7',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland',
          },
          {
            value: 443,
            color: '70aec7',
            description: 'North American Arid West Emergent Marsh',
          },
          {
            value: 444,
            color: '70aec7',
            description: 'North American Warm Desert Riparian Mesquite Bosque',
          },
          {
            value: 445,
            color: '7dbdc6',
            description: 'Western Great Plains Saline Depression Wetland',
          },
          {
            value: 446,
            color: 'a3bde7',
            description: 'Acadian Salt Marsh and Estuary Systems',
          },
          {
            value: 447,
            color: 'a3bde7',
            description: 'Atlantic Coastal Plain Central Salt and Brackish Tidal Marsh',
          },
          {
            value: 448,
            color: 'a3bde7',
            description: 'Atlantic Coastal Plain Embayed Region Tidal Salt and Brackish Marsh',
          },
          {
            value: 449,
            color: 'a3bde7',
            description: 'Atlantic Coastal Plain Indian River Lagoon Tidal Marsh',
          },
          {
            value: 450,
            color: 'a3bde7',
            description: 'Atlantic Coastal Plain Northern Tidal Salt Marsh',
          },
          {
            value: 451,
            color: 'a3bde7',
            description: 'Florida Big Bend Salt-Brackish Tidal Marsh',
          },
          {
            value: 452,
            color: 'a3bde7',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 453,
            color: 'a3bde7',
            description: 'Mississippi Sound Salt and Brackish Tidal Marsh',
          },
          {
            value: 454,
            color: 'a3bde7',
            description: 'Texas Saline Coastal Prairie',
          },
          {
            value: 455,
            color: 'a3bdff',
            description: 'Temperate Pacific Tidal Salt and Brackish Marsh',
          },
          {
            value: 456,
            color: 'a3bdd6',
            description: 'Inter-Mountain Basins Alkaline Closed Depression',
          },
          {
            value: 457,
            color: 'a3bdd6',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 458,
            color: 'a3bdd6',
            description: 'Inter-Mountain Basins Playa',
          },
          {
            value: 459,
            color: 'a3bdd6',
            description: 'North American Warm Desert Playa',
          },
          {
            value: 460,
            color: 'd2b38c',
            description: 'Apacherian-Chihuahuan Mesquite Upland Scrub',
          },
          {
            value: 461,
            color: 'd2b38c',
            description: 'Apacherian-Chihuahuan Semi-Desert Grassland and Steppe',
          },
          {
            value: 462,
            color: 'd2b38c',
            description: 'Chihuahuan Creosotebush, Mixed Desert and Thorn Scrub',
          },
          {
            value: 463,
            color: 'd2b38c',
            description: 'Chihuahuan Gypsophilous Grassland and Steppe',
          },
          {
            value: 464,
            color: 'd2b38c',
            description: 'Chihuahuan Loamy Plains Desert Grassland',
          },
          {
            value: 465,
            color: 'd2b38c',
            description: 'Chihuahuan Mixed Desert and Thorn Scrub',
          },
          {
            value: 466,
            color: 'd2b38c',
            description: 'Chihuahuan Sandy Plains Semi-Desert Grassland',
          },
          {
            value: 467,
            color: 'd2b38c',
            description: 'Chihuahuan Stabilized Coppice Dune and Sand Flat Scrub',
          },
          {
            value: 468,
            color: 'd2b38c',
            description: 'Chihuahuan Succulent Desert Scrub',
          },
          {
            value: 469,
            color: 'd2b38c',
            description: 'Madrean Juniper Savanna',
          },
          {
            value: 470,
            color: 'dac4b8',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 471,
            color: 'dac4b8',
            description: 'North American Warm Desert Active and Stabilized Dune',
          },
          {
            value: 472,
            color: 'dac4b8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 473,
            color: 'dac4b8',
            description: 'Sonoran Mid-Elevation Desert Scrub',
          },
          {
            value: 474,
            color: 'dac4b8',
            description: 'Sonoran Paloverde-Mixed Cacti Desert Scrub',
          },
          {
            value: 475,
            color: 'd2b38b',
            description: 'Chihuahuan Mixed Salt Desert Scrub',
          },
          {
            value: 476,
            color: 'd2b38b',
            description: 'Sonora-Mojave Mixed Salt Desert Scrub',
          },
          {
            value: 477,
            color: 'b2acab',
            description: 'North American Warm Desert Wash',
          },
          {
            value: 478,
            color: 'd1b9b3',
            description: 'South Texas Lomas',
          },
          {
            value: 479,
            color: 'd1b9b3',
            description: 'Tamaulipan Calcareous Thornscrub',
          },
          {
            value: 480,
            color: 'd1b9b3',
            description: 'Tamaulipan Clay Grassland',
          },
          {
            value: 481,
            color: 'd1b9b3',
            description: 'Tamaulipan Mesquite Upland Scrub',
          },
          {
            value: 482,
            color: 'd1b9b3',
            description: 'Tamaulipan Mixed Deciduous Thornscrub',
          },
          {
            value: 483,
            color: 'd1b9b3',
            description: 'Tamaulipan Savanna Grassland',
          },
          {
            value: 484,
            color: 'b0967d',
            description: 'Inter-Mountain Basins Mat Saltbush Shrubland',
          },
          {
            value: 485,
            color: 'b0967d',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 486,
            color: 'c6ada7',
            description: 'Inter-Mountain Basins Wash',
          },
          {
            value: 487,
            color: 'ced1a7',
            description: 'Columbia Plateau Steppe and Grassland',
          },
          {
            value: 488,
            color: 'ced1a7',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 489,
            color: 'ced1a7',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 490,
            color: 'ced1a7',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 491,
            color: 'ced1a7',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 492,
            color: '9bb47d',
            description: 'Colorado Plateau Mixed Low Sagebrush Shrubland',
          },
          {
            value: 493,
            color: '9bb47d',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 494,
            color: '9bb47d',
            description: 'Columbia Plateau Scabland Shrubland',
          },
          {
            value: 495,
            color: '9bb47d',
            description: 'Wyoming Basins Dwarf Sagebrush Shrubland and Steppe',
          },
          {
            value: 496,
            color: 'ded391',
            description: 'Colorado Plateau Blackbrush-Mormon-tea Shrubland',
          },
          {
            value: 497,
            color: 'ded391',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 498,
            color: 'ded391',
            description: 'Inter-Mountain Basins Semi-Desert Shrub Steppe',
          },
          {
            value: 499,
            color: 'ded391',
            description: 'Southern Colorado Plateau Sand Shrubland',
          },
          {
            value: 500,
            color: 'ecdff2',
            description: 'Acadian-Appalachian Alpine Tundra',
          },
          {
            value: 501,
            color: 'ebd8e5',
            description: 'Rocky Mountain Alpine Dwarf-Shrubland',
          },
          {
            value: 502,
            color: 'ebd8e5',
            description: 'Rocky Mountain Alpine Fell-Field',
          },
          {
            value: 503,
            color: 'ebd8e5',
            description: 'Rocky Mountain Alpine Turf',
          },
          {
            value: 504,
            color: 'ebcec9',
            description: 'Mediterranean California Alpine Dry Tundra',
          },
          {
            value: 505,
            color: 'ebcec9',
            description: 'Mediterranean California Alpine Fell-Field',
          },
          {
            value: 506,
            color: 'ebcec9',
            description: 'North Pacific Dry and Mesic Alpine Dwarf-Shrubland, Fell-field and Meadow',
          },
          {
            value: 507,
            color: 'ebcec9',
            description: 'Rocky Mountain Alpine Tundra/Fell-field/Dwarf-shrub Map Unit',
          },
          {
            value: 508,
            color: 'c1df12',
            description: 'Temperate Pacific Intertidal Mudflat',
          },
          {
            value: 509,
            color: '3fdfec',
            description: 'Mediterranean California Eelgrass Bed',
          },
          {
            value: 510,
            color: '3fdfec',
            description: 'North Pacific Maritime Eelgrass Bed',
          },
          {
            value: 511,
            color: '00c5ff',
            description: 'South-Central Interior Large Floodplain - Herbaceous Modifier',
          },
          {
            value: 512,
            color: '00c5ff',
            description: 'East Gulf Coastal Plain Large River Floodplain Forest - Herbaceous Modifier',
          },
          {
            value: 513,
            color: '008eff',
            description: 'Temperate Pacific Freshwater Aquatic Bed',
          },
          {
            value: 514,
            color: 'd6d6d6',
            description: 'Central California Coast Ranges Cliff and Canyon',
          },
          {
            value: 515,
            color: 'd6d6d6',
            description: 'Mediterranean California Serpentine Barrens',
          },
          {
            value: 516,
            color: 'd6d6d6',
            description: 'Southern California Coast Ranges Cliff and Canyon',
          },
          {
            value: 517,
            color: 'c1c9bf',
            description: 'Central Interior Acidic Cliff and Talus',
          },
          {
            value: 518,
            color: 'c1c9bf',
            description: 'Central Interior Calcareous Cliff and Talus',
          },
          {
            value: 519,
            color: 'c1c9bf',
            description: 'East Gulf Coastal Plain Dry Chalk Bluff',
          },
          {
            value: 520,
            color: 'c1c9bf',
            description: 'North-Central Appalachian Acidic Cliff and Talus',
          },
          {
            value: 521,
            color: 'c1c9bf',
            description: 'North-Central Appalachian Circumneutral Cliff and Talus',
          },
          {
            value: 522,
            color: 'c1c9bf',
            description: 'Southern Appalachian Montane Cliff',
          },
          {
            value: 523,
            color: 'c1c9bf',
            description: 'Southern Interior Acid Cliff',
          },
          {
            value: 524,
            color: 'c1c9bf',
            description: 'Southern Interior Calcareous Cliff',
          },
          {
            value: 525,
            color: 'c1c9bf',
            description: 'Southern Piedmont Cliff',
          },
          {
            value: 526,
            color: 'c1c9b3',
            description: 'Southern Appalachian Granitic Dome',
          },
          {
            value: 527,
            color: 'c1c9b3',
            description: 'Southern Appalachian Rocky Summit',
          },
          {
            value: 528,
            color: 'c1c9b3',
            description: 'Southern Piedmont Granite Flatrock',
          },
          {
            value: 529,
            color: 'c7c7c7',
            description: 'Rocky Mountain Cliff, Canyon and Massive Bedrock',
          },
          {
            value: 530,
            color: '969696',
            description: 'Klamath-Siskiyou Cliff and Outcrop',
          },
          {
            value: 531,
            color: '969696',
            description: 'North Pacific Montane Massive Bedrock, Cliff and Talus',
          },
          {
            value: 532,
            color: '969696',
            description: 'North Pacific Serpentine Barren',
          },
          {
            value: 533,
            color: '969696',
            description: 'North Pacific Active Volcanic Rock and Cinder Land',
          },
          {
            value: 534,
            color: '969696',
            description: 'Sierra Nevada Cliff and Canyon',
          },
          {
            value: 535,
            color: 'e5e5df',
            description: 'Western Great Plains Badland',
          },
          {
            value: 536,
            color: 'c1c9c7',
            description: 'Southwestern Great Plains Canyon',
          },
          {
            value: 537,
            color: 'c1c9c7',
            description: 'Western Great Plains Cliff and Outcrop',
          },
          {
            value: 538,
            color: '535957',
            description: 'North American Warm Desert Badland',
          },
          {
            value: 539,
            color: '535957',
            description: 'North American Warm Desert Bedrock Cliff and Outcrop',
          },
          {
            value: 540,
            color: '535957',
            description: 'North American Warm Desert Pavement',
          },
          {
            value: 541,
            color: '535957',
            description: 'North American Warm Desert Volcanic Rockland',
          },
          {
            value: 542,
            color: '6e7372',
            description: 'Colorado Plateau Mixed Bedrock Canyon and Tableland',
          },
          {
            value: 543,
            color: '6e7372',
            description: 'Columbia Plateau Ash and Tuff Badland',
          },
          {
            value: 544,
            color: '6e7372',
            description: 'Geysers and Hot Springs',
          },
          {
            value: 545,
            color: '6e7372',
            description: 'Inter-Mountain Basins Active and Stabilized Dune',
          },
          {
            value: 546,
            color: '6e7372',
            description: 'Inter-Mountain Basins Cliff and Canyon',
          },
          {
            value: 547,
            color: '6e7372',
            description: 'Inter-Mountain Basins Shale Badland',
          },
          {
            value: 548,
            color: '6e7372',
            description: 'Inter-Mountain Basins Volcanic Rock and Cinder Land',
          },
          {
            value: 549,
            color: 'eb78f1',
            description: 'Rocky Mountain Alpine Bedrock and Scree',
          },
          {
            value: 550,
            color: 'ecbdf2',
            description: 'Mediterranean California Alpine Bedrock and Scree',
          },
          {
            value: 551,
            color: 'ecbdf2',
            description: 'North Pacific Alpine and Subalpine Bedrock and Scree',
          },
          {
            value: 552,
            color: '8c8e91',
            description: 'Unconsolidated Shore',
          },
          {
            value: 553,
            color: '8c8e91',
            description: 'Undifferentiated Barren Land',
          },
          {
            value: 554,
            color: '8c8e91',
            description: 'North American Alpine Ice Field',
          },
          {
            value: 555,
            color: 'fedac0',
            description: 'Orchards Vineyards and Other High Structure Agriculture',
          },
          {
            value: 556,
            color: 'f4f4dc',
            description: 'Cultivated Cropland',
          },
          {
            value: 557,
            color: 'fefec0',
            description: 'Pasture/Hay',
          },
          {
            value: 558,
            color: 'a0459b',
            description: 'Introduced Upland Vegetation - Annual Grassland',
          },
          {
            value: 559,
            color: 'a0459b',
            description: 'Introduced Upland Vegetation - Perennial Grassland and Forbland',
          },
          {
            value: 560,
            color: 'a0459b',
            description: 'Modified/Managed Southern Tall Grassland',
          },
          {
            value: 561,
            color: 'a0459b',
            description: 'Introduced Upland Vegetation - Shrub',
          },
          {
            value: 562,
            color: 'a0459b',
            description: 'Introduced Riparian and Wetland Vegetation',
          },
          {
            value: 563,
            color: 'a0459b',
            description: 'Introduced Upland Vegetation - Treed',
          },
          {
            value: 564,
            color: '000000',
            description: 'Unmapped 12',
          },
          {
            value: 565,
            color: '862d26',
            description: 'Disturbed, Non-specific',
          },
          {
            value: 566,
            color: '862d26',
            description: 'Recently Logged Areas',
          },
          {
            value: 567,
            color: '862d26',
            description: 'Harvested Forest - Grass/Forb Regeneration',
          },
          {
            value: 568,
            color: '862d26',
            description: 'Harvested Forest-Shrub Regeneration',
          },
          {
            value: 569,
            color: '862d26',
            description: 'Harvested Forest - Northwestern Conifer Regeneration',
          },
          {
            value: 570,
            color: '862d26',
            description: 'Recently Burned',
          },
          {
            value: 571,
            color: '862d26',
            description: 'Recently burned grassland',
          },
          {
            value: 572,
            color: '862d26',
            description: 'Recently burned shrubland',
          },
          {
            value: 573,
            color: '862d26',
            description: 'Recently burned forest',
          },
          {
            value: 574,
            color: '862d26',
            description: 'Disturbed/Successional - Grass/Forb Regeneration',
          },
          {
            value: 575,
            color: '862d26',
            description: 'Disturbed/Successional - Shrub Regeneration',
          },
          {
            value: 576,
            color: '862d26',
            description: 'Disturbed/Successional - Recently Chained Pinyon-Juniper',
          },
          {
            value: 577,
            color: '002cc1',
            description: 'Open Water (Aquaculture)',
          },
          {
            value: 578,
            color: '002cc1',
            description: 'Open Water (Brackish/Salt)',
          },
          {
            value: 579,
            color: '002cc1',
            description: 'Open Water (Fresh)',
          },
          {
            value: 580,
            color: 'df1241',
            description: 'Quarries, Mines, Gravel Pits and Oil Wells',
          },
          {
            value: 581,
            color: 'c94c41',
            description: 'Developed, Open Space',
          },
          {
            value: 582,
            color: 'c94c41',
            description: 'Developed, Low Intensity',
          },
          {
            value: 583,
            color: 'c94c41',
            description: 'Developed, Medium Intensity',
          },
          {
            value: 584,
            color: 'c94c41',
            description: 'Developed, High Intensity',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'GAP CONUS',
        lookat: {
          lat: 38.14,
          lon: -98.58,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              584.0,
            ],
            bands: [
              'landcover',
            ],
          },
        },
      },
    ],
    landcover: {
      minimum: 1.0,
      maximum: 584.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Homer, C.G., Dewitz, J.A., Yang, L., Jin, S., Danielson, P., Xian, G., Coulston, J.,
    Herold, N.D., Wickham, J.D., and Megown, K., 2015,Completion of the 2011 National Land Cover
    Database for the conterminous United States-Representing a decade of land cover change
    information. Photogrammetric Engineering and Remote Sensing, v. 81, no. 5, p. 345-354.
    [https://www.asprs.org/a/publications/pers/2015journals/PERS_May_2015/HTML/index.html](https://www.asprs.org/a/publications/pers/2015journals/PERS_May_2015/HTML/index.html)
  |||,
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs) is available.
  |||,
}
