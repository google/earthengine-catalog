local id = 'projects/mangrovedatahub2/assets/CGMD-AFCC30';
local subdir = 'mangrovedatahub2';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
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
  title: 'Global Annual Mangrove Fractional Canopy Cover (1984-2023)',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,

  description: |||
    This dataset provides global annual mangrove fractional canopy cover (FCC) at 30-m spatial resolution from 1984 to 2023 to support 
    large-scale analyses of long-term mangrove dynamics, including canopy degradation and recovery, blue carbon assessment, and coastal ecosystem monitoring. 
    FCC quantifies the proportion of each Landsat pixel occupied by mangrove canopy and is expressed as a percentage ranging from 0% to 100%.

    The dataset was generated using time-series Landsat imagery within the Google Earth Engine platform. 
    Annual Landsat composites were produced after strict cloud, cloud-shadow, and low-quality observation filtering. 
    FCC was then estimated using a linear spectral unmixing approach and spatially constrained to the global mangrove extent for each year. 

    The FCC estimates were evaluated against high-resolution Planet imagery across different regions, with root mean square error (RMSE) ranging from 9% to 22%.

    Users should note that FCC values are derived from annual median Landsat composites. 
    As a result, canopy changes occurring late in a calendar year may be captured in the following year's composite, 
    which can introduce a one-year lag in the timing of detected FCC change.
    For quick visualization and exploratory analysis, users are encouraged to access 
    [the CGMD Earth Engine App](https://zhenzhang.users.earthengine.app/view/globalmangrovedynamic).   
  |||,
  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],

  'gee:categories': [
    'forest-biomass',
    'vegetation-indices',
  ],

  keywords: [
    'mangrove',
    'wetland',
    'coastal',
    'landsat_derived',
    'annual',
    'global',
  ],

  providers: [
    ee.producer_provider('The Mangrove Lab', 'https://www.themangrovelab.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('1984-01-01T00:00:00Z', '2023-12-31T23:59:59Z'),

  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: 'Data year, ranging from 1984 to 2023.',
        type: ee_const.var_type.int,
      },
      {
        name: 'tile_id',
        description: 'Data region',
        type: ee_const.var_type.string,
      },
      {
        name: 'version',
        description: 'Data version',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [30.0],
    'eo:bands': [
      {
        name: 'FCC',
        description: 'Mangrove fractional canopy cover stored as integer percentage cover from 0 to 100',
        'gee:units': units.percent,
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Mangrove fractional canopy cover',
        lookat: { lon: 133.55, lat: -2.33, zoom: 10 },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            palette: [
              'ffffff',
              'd9f0a3',
              '78c679',
              '238443',
              '005a32',
            ],
            bands: ['FCC'],
          },
        },
      },
    ],

    FCC: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': true,
    },
  },

  'sci:citation': |||
    Zhang, Z., Murray, N., Song, X., ... & Friess, D. (2026) Continuous Global Mangrove Dynamics: Annual mangrove fractional canopy cover, 1984-2023 [Data set]. Zenodo. https://doi.org/10.5281/zenodo.18496588
    
  |||,

  'sci:publications': [
    {
      citation: |||
        Zhang, Z., Murray, N., Song, X., ... & Friess, D. (2026) Unexpected expansion and regrowth in Earth's mangrove forests over the past four decades. Science. https://doi.org/10.1126/science.aec9773
      |||,
      doi: '10.1126/science.aec9773',
    },
  ],

  'gee:interval': { type: 'cadence', unit: 'year', interval: 1 },

  'gee:terms_of_use': |||
    Acknowledgements

    Users should cite the associated scientific paper and the Zenodo data record when using this dataset in publications or derived products.

    License

    The dataset is licensed under the [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).
  |||,

  'gee:user_uploaded': true,
}