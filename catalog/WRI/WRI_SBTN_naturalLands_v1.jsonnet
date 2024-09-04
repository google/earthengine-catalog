local id = 'WRI/SBTN/naturalLands/v1';
local subdir = 'WRI';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_nc_sa_4_0;

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
  title: 'SBTN Natural Lands Map v1',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The SBTN Natural Lands Map v1 is a 2020 baseline map of natural and
    non-natural land covers intended for use by companies setting
    [science-based targets for nature](https://sciencebasedtargetsnetwork.org/companies/take-action/),
    specifically the SBTN Land target #1: no conversion of natural ecosystems.

    "Natural" and "non-natural" definitions were adapted from the
    [Accountability Framework initiative's definition of a natural
    ecosystem](https://accountability-framework.org/use-the-accountability-framework/definitions/natural-ecosystem/)
    as "one that substantially resembles - in terms of species composition,
    structure, and ecological function - what would be found in a given area
    in the absence of major human impacts" and can include managed ecosystems
    as well as degraded ecosystems that are expected to regenerate either
    naturally or through management (AFi 2024). The SBTN Natural Lands Map
    operationalizes this definition by using proxies based on available data
    that align with AFi guidance to the extent possible.

    This map was made by compiling existing global
    and regional data.You can find the full technical note explaining the
    methodology linked on the
    [Natural Lands GitHub](https://github.com/wri/natural-lands-map).
    This work was a collaboration between Land & Carbon Lab at the World
    Resources Institute, World Wildlife Fund US, Systemiq, and SBTN.
  |||,
  license: license.id,
  'gee:unusual_terms_of_use': true,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  keywords: ['wri', 'landcover'],
  providers: [
    ee.producer_provider(
      'WRI',
      'https://github.com/wri/natural-lands-map/tree/main'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180, -60, 180, 75,
                    '2020-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'classification_class_palette',
        description:
          'Array of hex code color strings used for the classification ' +
          'palette.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'classification_class_values',
        description: 'Value of the land cover classification.',
        type: ee_const.var_type.int_list,
      },
      {
        name: 'natural_class_palette',
        description:
          'Array of hex code color strings used for the natural binary mask ' +
          'palette.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'natural_class_values',
        description: 'Value of the natural binary mask',
        type: ee_const.var_type.int_list,
      },
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'classification',
        description: 'Land cover classification.',
        'gee:classes': [
          {value: 2, color: '246E24', description: 'natural forests'},
          {value: 3, color: 'B9B91E', description: 'natural short vegetation'},
          {value: 4, color: '6BAED6', description: 'natural water'},
          {value: 5, color: '06A285', description: 'mangroves'},
          {value: 6, color: 'FEFECC', description: 'bare'},
          {value: 7, color: 'ACD1E8', description: 'snow'},
          {value: 8, color: '589558', description: 'wet natural forests'},
          {value: 9, color: '093D09', description: 'natural peat forests'},
          {value: 10, color: 'DBDB7B', description: 'wet natural short vegetation'},
          {value: 11, color: '99991A', description: 'natural peat short vegetation'},
          {value: 12, color: 'D3D3D3', description: 'crop'},
          {value: 13, color: 'D3D3D3', description: 'built'},
          {value: 14, color: 'D3D3D3', description: 'non-natural tree cover'},
          {value: 15, color: 'D3D3D3', description: 'non-natural short vegetation'},
          {value: 16, color: 'D3D3D3', description: 'non-natural water'},
          {value: 17, color: 'D3D3D3', description: 'wet non-natural tree cover'},
          {value: 18, color: 'D3D3D3', description: 'non-natural peat tree cover'},
          {value: 19, color: 'D3D3D3', description: 'wet non-natural short vegetation'},
          {value: 20, color: 'D3D3D3', description: 'non-natural peat short vegetation'},
          {value: 21, color: 'D3D3D3', description: 'non-natural bare'},
        ],
      },
      {
        name: 'natural',
        description: 'Land cover classification.',
        'gee:classes': [
          {value: 0, color: '969696', description: 'Non-natural land'},
          {value: 1, color: 'a8ddb5', description: 'Natural land'},
        ],
      },
    ],
    'gee:visualizations': [{
      display_name: 'Natural lands',
      lookat: {lon: 0, lat: 0, zoom: 2},
      image_visualization: {
        band_vis: {
          palette: [
            '969696', 'a8ddb5'
          ],
          bands: ['natural'],
        },
      },
    }],
    classification: {minimum: 2, maximum: 21, 'gee:estimated_range': false},
    natural: {minimum: 0, maximum: 1, 'gee:estimated_range': false},
  },
  'sci:citation': |||
    Mazur, E., M. Sims, E. Goldman, M. Schneider, M.D. Pirri, C.R. Beatty, F.
    Stolle, Stevenson, M. 2024. "SBTN Natural Lands Map v1: Technical
    Documentation". Science Based Targets for Land Version 1 - Supplementary
    Material. Science Based Targets Network.
    [https://sciencebasedtargetsnetwork.org/wp-content/uploads/2024/09/Technical-Guidance-2024-Step3-Land-v1-Natural-Lands-Map.pdf](https://sciencebasedtargetsnetwork.org/wp-content/uploads/2024/09/Technical-Guidance-2024-Step3-Land-v1-Natural-Lands-Map.pdf)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
