local id = 'projects/sat-io/open-datasets/ESA/ESA_CCI_AGB';
local subdir = 'sat-io';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  // TODO: remove 'gee:skip_indexing'
  'gee:skip_indexing': true,
  'gee:user_uploaded': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'ESA CCI Global Forest Above Ground Biomass',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset provides estimates of forest above-ground biomass for the years 2010, 2017, 2018, 2019, and 2020. These estimates are derived from a combination of Earth observation data, depending on the year, obtained from the Copernicus Sentinel-1 mission, Envisat's ASAR instrument, and JAXA's Advanced Land Observing Satellite (ALOS-1 and ALOS-2), along with additional information from other Earth observation sources. The dataset has been generated as part of the European Space Agency's (ESA's) Climate Change Initiative (CCI) program by the Biomass CCI team.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'biomass',
    'forest',
    'ESA'
  ],
  providers: [
    ee.producer_provider('ESA Climate Office', 'https://climate.esa.int/en/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2010-01-01T00:00:00Z', '2020-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'county',
        description: 'county',
        type: ee_const.var_type.string,
      },
      {
        name: 'year',
        description: 'Year',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      100,
    ],
    'eo:bands': [
      {
        name: 'AGB',
        description: 'Above Ground Biomass',
      },
      {
        name: 'SD',
        description: 'Standard Deviation',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Above Ground Biomass',
        lookat: {
          lat: 39.648,
          lon: -100.576,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
               1,
            ],
            max: [
              450,
            ],
            bands: [
              'AGB',
            ],
            palette:["C6ECAE","A1D490","7CB970","57A751","348E32", "267A29","176520","0C4E15","07320D","031807"],
          },
        },
      },
    ],
    AGB: {
      minimum: 1,
      maximum: 553,
      'gee:estimated_range': true,
    },
  },
  'sci:citation':|||
        Santoro, M.; Cartus, O. (2023): ESA Biomass Climate Change Initiative (Biomass_cci): Global datasets of forest above-ground biomass for the years
        2010, 2017, 2018, 2019 and 2020, v4. NERC EDS Centre for Environmental Data Analysis, 21 April 2023. doi:10.5285/af60720c1e404a9e9d2c145d2b2ead4e.
        https://dx.doi.org/10.5285/af60720c1e404a9e9d2c145d2b2ead4e
  |||,
  'gee:terms_of_use': |||
        Use of these data is covered by the license information found here (http://artefacts.ceda.ac.uk/licences/specific_licences/esacci_biomass_terms_and_conditions.pdf). The CCI BIOMASS datasets have been processed by the CCI BIOMASS consortium led by the University of Aberystwyth (U.K.). They are made available to the public by ESA and the consortium. When using these data you must cite them correctly using the citation given on the catalogue record. The dataset is under a public access with access to these data available to both registered and non-registered users
  |||,
}
