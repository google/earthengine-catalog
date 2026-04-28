local id = 'ESA/CCI/Above_Ground_Biomass/V6_0';
local subdir = 'ESA';

local ee_const = import '../earthengine_const.libsonnet';
local ee = import '../earthengine.libsonnet';
local spdx = import '../spdx.libsonnet';
local units = import '../units.libsonnet';

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
  title: 'ESA CCI Above-Ground Biomass for 2007, 2010, 2015-2022 (v6.0)',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset updated to v6.0 provides estimates of forest above-ground
    biomass for the years 2007, 2010, 2015, 2016, 2017, 2018, 2019, 2020,
    2021, and 2022. These estimates are derived from a combination of Earth
    observation data, depending on the year, obtained from the Copernicus
    Sentinel-1 mission, Envisat’s ASAR (Advanced Synthetic Aperture Radar)
    instrument, and JAXA's Advanced Land Observing Satellite (ALOS-1 and
    ALOS-2), along with additional information from other Earth observation
    sources. The dataset has been generated as part of the European Space
    Agency's (ESA's) Climate Change Initiative (CCI) program by the Biomass
    CCI team.

    Compared to version 5, version 6 consists of updated AGB maps for the
    years 2010, 2015, 2016, 2017, 2018, 2019, 2020, 2021 and new AGB maps
    for 2007 and 2022. The dataset includes multi-temporal observations
    at L-band for all biomes and for each year. The above-ground biomass
    (AGB) maps utilize revised allometries, which are now based on a more
    extensive collection of spaceborne LiDAR data from the GEDI and ICESat-2
    missions. The retrieval algorithm incorporates extended ICESat-2
    observations to calibrate retrieval models and a refined cost function
    that preserves temporal features as expressed in the remote sensing
    data, limiting biases between the 2007-2010 and the 2015+ maps.

    The data products consist of two (2) global layers that include
    estimates of:

    Above ground biomass (AGB, unit: tons/ha i.e., Mg/ha) (raster dataset).
    This is defined as the mass, expressed as oven-dry weight of the woody
    parts (stem, bark, branches and twigs) of all living trees excluding
    stump and roots.

    Per-pixel estimates of above-ground biomass uncertainty expressed as
    the standard deviation in Mg/ha (raster dataset).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5285/95913ffb6467447ca72c4e9d8cf30501',
    },
  ],
  keywords: [
    'biomass',
    'cci',
    'esa',
    'forest',
  ],
  'gee:categories': ['ecosystems'],
  providers: [
    ee.producer_provider(
      'ESA Biomass CCI',
      'https://climate.esa.int/en/projects/biomass/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: {
    spatial: {
      bbox: [
        [-180, -90, 180, 90],
      ],
    },
    temporal: {
      interval: [
        ['2007-01-01T00:00:00Z', '2023-01-01T00:00:00Z'],
      ],
    },
  },
  summaries: {
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'agb',
        description: 'Above ground biomass',
        'gee:units': units.area_density_megagrams_per_hectare,
      },
      {
        name: 'agb_sd',
        description: |||
          Per-pixel estimates of above-ground biomass uncertainty expressed as
          the standard deviation
        |||,
        'gee:units': units.area_density_megagrams_per_hectare,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Above Ground Biomass',
        lookat: {
          lat: -3,
          lon: -60,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [500],
            bands: ['agb'],
            palette: ['white', 'green'],
          },
          image_id: ['ESA/CCI/Above_Ground_Biomass/V6_0/2020'],
        },
      },
    ],
  },
  'gee:terms_of_use': |||
    The CCI BIOMASS datasets are made available to the public by ESA and the
    consortium. When using these data please cite them using the citation
    given in this catalog record.
  |||,
  'sci:doi': '10.5285/95913ffb6467447ca72c4e9d8cf30501',
  'sci:citation': |||
    Santoro, M.; Cartus, O. (2025): ESA Biomass Climate Change Initiative
    (Biomass_cci): Global datasets of forest above-ground biomass for the
    years 2007, 2010, 2015, 2016, 2017, 2018, 2019, 2020, 2021 and 2022,
    v6.0. NERC EDS Centre for Environmental Data Analysis, 17 April 2025.
    doi:10.5285/95913ffb6467447ca72c4e9d8cf30501.
  |||
}
