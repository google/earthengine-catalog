local id = 'WUR/radd_alerts';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';

local subdir = 'WUR';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local license = spdx.cc_by_4_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'RADD forest disturbance alerts v1',
   version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
	  Radar satellite imagery from the European Space Agency’s Sentinel-1 mission is used to map new disturbances in primary humid tropical forest at 10 m spatial scale and in near real-time. Sentinel-1’s cloud-penetrating radar provides gap-free observations for the tropics consistently every 6 to 12 days. A new forest disturbance alert is triggered (low confidence alerts) based on a single observation from the latest Sentinel-1 image. Subsequent observations are used to increase confidence and confirm (high confidence alerts) or reject the alert. RADD (Radar for Detecting Deforestation) alerts are operational for the pan-tropics (50 countries) and updated weekly. 
	  The dataset provides a RADD alert layer (alert confidence and alert date) and a primary tropical forest baseline mask separately for four geographies: Central America, South America, Africa, and Asia (Insular Southeast-Asia and parts of the Pacific).
	|||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'deforestation',
    'forest',
    'radar',
    'sentinel',
    'wur',
    ],
  providers: [
    ee.producer_provider('Radar remote sensing group, Wageningen University and Research (WUR)', 'http://radd-alert.wur.nl/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2019-01-01T00:00:00Z', '2024-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.92,
    ],
    'eo:bands': [
      {
        name: 'Alert',
        description: |||
            Low confidence (pixel value 2) and High confidence alerts (pixel value 3). Disturbances are defined as the complete or partial removal of tree cover within a 10 m Sentinel-1 pixel. 
        |||,
      },
      {
        name: 'Date',
        description: |||
            YYDOY (Year-Year-Day-Of-Year). Date of image that triggered the alert. Africa 19000 (Alerts start in 2019-01-01) and other geographies 20000 (Alerts start in 2020-01-01)
        |||,
      },
      {
        name: 'forest_baseline',
        description: |||
            Primary humid tropical forest mask compiled from Turubanova et al (2018) with 2001-2019 (2001-2018 for Africa) forest loss (Hansen et al 2013) and mangrove (Bunting et al 2018) removed
        |||,
      }
    ],
        'gee:visualizations': [
      {
        display_name: 'RADD alert',
        lookat: {
          lat: -6.5,
          lon: -75.5,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [
              2,
            ],
            max: [
              3,
            ],
            palette: [
              'blue',
              'coral',
            ],
            bands: [
              'Alert',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Reiche J, Mullissa A, Slagter B, Gou Y, Tsendbazar N, Odongo-Braun C, Vollrath A, Weisse M, Stolle F, Pickens A, Donchyts G, Clinton N, Gorelick N & Herold M, (2021), Forest disturbance alerts for the Congo Basin using Sentinel-1, Environmental Research Letters, [https://doi.org/10.1088/1748-9326/abd0a8](https://doi.org/10.1088/1748-9326/abd0a8).
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
