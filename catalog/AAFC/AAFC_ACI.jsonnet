local id = 'AAFC/ACI';
local subdir = 'AAFC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.ogl_canada_2_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Canada AAFC Annual Crop Inventory',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Starting in 2009, the Earth Observation Team of the Science and Technology
    Branch (STB) at Agriculture and Agri-Food Canada (AAFC) began the process
    of generating annual crop type digital maps. Focusing on the Prairie
    Provinces in 2009 and 2010, a Decision Tree (DT) based methodology was
    applied using optical (Landsat-5, AWiFS, DMC) and radar (Radarsat-2) based
    satellite images. Beginning with the 2011 growing season, this activity has
    been extended to other provinces in support of a national crop inventory.
    To date this approach can consistently deliver a crop inventory that meets
    the overall target accuracy of at least 85% at a final spatial resolution of
    30m (56m in 2009 and 2010).
  |||,
  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href:
        'https://www.agr.gc.ca/atlas/data_donnees/agr/annualCropInventory/tif/',
    }],
  keywords: ['canada', 'crop', 'landcover', 'aafc'],
  providers: [
    ee.producer_provider(
      'Agriculture and Agri-Food Canada',
      'https://open.canada.ca/data/en/dataset/ba2645d5-4458-414d-b196-6303ac06c1c9'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-135.17, 36.83, -51.24, 62.25,
                    '2009-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'landcover_class_names',
        description: 'Array of cropland landcover classification names.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'landcover_class_palette',
        description:
          'Array of hex code color strings used for the classification ' +
          'palette.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'landcover_class_values',
        description: 'Value of the land cover classification.',
        type: ee_const.var_type.int_list,
      },
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'landcover',
        description: 'Main crop-specific land cover classification.',
        'gee:classes': [
          {value: 10, color: '000000', description: 'Cloud'},
          {value: 20, color: '3333ff', description: 'Water'},
          {value: 30, color: '996666', description: 'Exposed Land and Barren'},
          {value: 34, color: 'cc6699', description: 'Urban and Developed'},
          {value: 35, color: 'e1e1e1', description: 'Greenhouses'},
          {value: 50, color: 'ffff00', description: 'Shrubland'},
          {value: 80, color: '993399', description: 'Wetland'},
          {value: 85, color: '501b50', description: 'Peatland'},
          {value: 110, color: 'cccc00', description: 'Grassland'},
          {value: 120, color: 'cc6600',
           description: 'Agriculture (undifferentiated)'},
          {value: 122, color: 'ffcc33', description: 'Pasture and Forages'},
          {value: 130, color: '7899f6', description: 'Too Wet to be Seeded'},
          {value: 131, color: 'ff9900', description: 'Fallow'},
          {value: 132, color: '660000', description: 'Cereals'},
          {value: 133, color: 'dae31d', description: 'Barley'},
          {value: 134, color: 'd6cc00', description: 'Other Grains'},
          {value: 135, color: 'd2db25', description: 'Millet'},
          {value: 136, color: 'd1d52b', description: 'Oats'},
          {value: 137, color: 'cace32', description: 'Rye'},
          {value: 138, color: 'c3c63a', description: 'Spelt'},
          {value: 139, color: 'b9bc44', description: 'Triticale'},
          {value: 140, color: 'a7b34d', description: 'Wheat'},
          {value: 141, color: 'b9c64e', description: 'Switchgrass'},
          {value: 142, color: '999900', description: 'Sorghum'},
          {value: 143, color: 'e9e2b1', description: 'Quinoa'},
          {value: 145, color: '92a55b', description: 'Winter Wheat'},
          {value: 146, color: '809769', description: 'Spring Wheat'},
          {value: 147, color: 'ffff99', description: 'Corn'},
          {value: 148, color: '98887c', description: 'Tobacco'},
          {value: 149, color: '799b93', description: 'Ginseng'},
          {value: 150, color: '5ea263', description: 'Oilseeds'},
          {value: 151, color: '52ae77', description: 'Borage'},
          {value: 152, color: '41bf7a', description: 'Camelina'},
          {value: 153, color: 'd6ff70', description: 'Canola and Rapeseed'},
          {value: 154, color: '8c8cff', description: 'Flaxseed'},
          {value: 155, color: 'd6cc00', description: 'Mustard'},
          {value: 156, color: 'ff7f00', description: 'Safflower'},
          {value: 157, color: '315491', description: 'Sunflower'},
          {value: 158, color: 'cc9933', description: 'Soybeans'},
          {value: 160, color: '896e43', description: 'Pulses'},
          {value: 161, color: '996633', description: 'Other Pulses'},
          {value: 162, color: '8f6c3d', description: 'Peas'},
          {value: 163, color: 'b6a472', description: 'Chickpeas'},
          {value: 167, color: '82654a', description: 'Beans'},
          {value: 168, color: 'a39069', description: 'Fababeans'},
          {value: 174, color: 'b85900', description: 'Lentils'},
          {value: 175, color: 'b74b15', description: 'Vegetables'},
          {value: 176, color: 'ff8a8a', description: 'Tomatoes'},
          {value: 177, color: 'ffcccc', description: 'Potatoes'},
          {value: 178, color: '6f55ca', description: 'Sugarbeets'},
          {value: 179, color: 'ffccff', description: 'Other Vegetables'},
          {value: 180, color: 'dc5424', description: 'Fruits'},
          {value: 181, color: 'd05a30', description: 'Berries'},
          {value: 182, color: 'd20000', description: 'Blueberry'},
          {value: 183, color: 'cc0000', description: 'Cranberry'},
          {value: 185, color: 'dc3200', description: 'Other Berry'},
          {value: 188, color: 'ff6666', description: 'Orchards'},
          {value: 189, color: 'c5453b', description: 'Other Fruits'},
          {value: 190, color: '7442bd', description: 'Vineyards'},
          {value: 191, color: 'ffcccc', description: 'Hops'},
          {value: 192, color: 'b5fb05', description: 'Sod'},
          {value: 193, color: 'ccff05', description: 'Herbs'},
          {value: 194, color: '07f98c', description: 'Nursery'},
          {value: 195, color: '00ffcc', description: 'Buckwheat'},
          {value: 196, color: 'cc33cc', description: 'Canaryseed'},
          {value: 197, color: '8e7672', description: 'Hemp'},
          {value: 198, color: 'b1954f', description: 'Vetch'},
          {value: 199, color: '749a66', description: 'Other Crops'},
          {value: 200, color: '009900',
           description: 'Forest (undifferentiated)'},
          {value: 210, color: '006600', description: 'Coniferous'},
          {value: 220, color: '00cc00', description: 'Broadleaf'},
          {value: 230, color: 'cc9900', description: 'Mixedwood'},
        ],
      },
    ],
    'gee:visualizations': [{
      display_name: 'Crop Landcover',
      lookat: {lon: -103.8881, lat: 53.0371, zoom: 10},
      image_visualization: {
        band_vis: {
          min: [0],
          max: [255],
          palette: [
            '000000', '3333ff', '996666', 'cc6699', 'e1e1e1', 'ffff00',
            '993399', '501b50', 'cccc00', 'cc6600', 'ffcc33', '7899f6',
            'ff9900', '660000', 'dae31d', 'd6cc00', 'd2db25', 'd1d52b',
            'cace32', 'c3c63a', 'b9bc44', 'a7b34d', 'b9c64e', '999900',
            'e9e2b1', '92a55b', '809769', 'ffff99', '98887c', '799b93',
            '5ea263', '52ae77', '41bf7a', 'd6ff70', '8c8cff', 'd6cc00',
            'ff7f00', '315491', 'cc9933', '896e43', '996633', '8f6c3d',
            'b6a472', '82654a', 'a39069', 'b85900', 'b74b15', 'ff8a8a',
            'ffcccc', '6f55ca', 'ffccff', 'dc5424', 'd05a30', 'd20000',
            'cc0000', 'dc3200', 'ff6666', 'c5453b', '7442bd', 'ffcccc',
            'b5fb05', 'ccff05', '07f98c', '00ffcc', 'cc33cc', '8e7672',
            'b1954f', '749a66', '009900', '006600', '00cc00', 'cc9900',
          ],
          bands: ['landcover'],
        },
      },
    }],
    // TODO(schwehr): This does not match the gee:classes.
    landcover: {minimum: 1, maximum: 255, 'gee:estimated_range': false},
  },
  'sci:citation': 'Agriculture and Agri-Food Canada Annual Crop Inventory. {YEAR}',
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
