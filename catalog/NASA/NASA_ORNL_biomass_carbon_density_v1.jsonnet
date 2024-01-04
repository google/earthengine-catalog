local id = 'NASA/ORNL/biomass_carbon_density/v1';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'Global Aboveground and Belowground Biomass Carbon Density Maps',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset provides temporally consistent and harmonized global maps of aboveground and
    belowground biomass carbon density for the year 2010 at a 300-m spatial resolution. The
    aboveground biomass map integrates land-cover specific, remotely sensed maps of woody,
    grassland, cropland, and tundra biomass. Input maps were amassed from the published literature
    and, where necessary, updated to cover the focal extent or time period. The belowground biomass
    map similarly integrates matching maps derived from each aboveground biomass map and land-cover
    specific empirical models. Aboveground and belowground maps were then integrated separately
    using ancillary maps of percent tree cover and landcover and a rule-based decision tree. Maps
    reporting the accumulated uncertainty of pixel-level estimates are also provided.

    Provider's note: The UN Environment Programme World Conservation Monitoring
    Centre (UNEP-WCMC) carbon biomass dataset
    represents conditions between 1982 and 2010 depending on land cover type. The relative patterns
    of carbon stocks are well represented with this dataset. The [NASA/ORNL carbon biomass dataset](https://daac.ornl.gov/VEGETATION/guides/Global_Maps_C_Density_2010.html)
    represents biomass conditions for 2010, with uncertainty estimates at the pixel-level.
    Additional biomass of non-dominant land cover types are represented within each pixel. For more
    detailed information, please refer to the papers describing each dataset: [WCMC](WCMC_biomass_carbon_density_v1_0)
    [(Soto-Navarro et al. 2020)](https://royalsocietypublishing.org/doi/full/10.1098/rstb.2019.0128)
    and NASA/ORNL [(Spawn et al. 2020)](https://www.nature.com/articles/s41597-020-0444-4).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.3334/ORNLDAAC/1763',
    },
  ],
  keywords: [
    'aboveground',
    'belowground',
    'biomass',
    'carbon',
    'density',
    'forest',
    'nasa',
    'ornl',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NASA ORNL DAAC at Oak Ridge National Laboratory', 'https://doi.org/10.3334/ORNLDAAC/1763'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -61.1, 180.0, 84.0,
                    '2010-01-01T00:00:00Z', '2010-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      300.0,
    ],
    'eo:bands': [
      {
        name: 'agb',
        description: |||
          Aboveground living biomass carbon stock density of combined woody and herbaceous
          cover in 2010. This includes carbon stored in living plant tissues that are located above
          the earth's surface (stems, bark, branches, twigs). This does not include leaf litter or
          coarse woody debris that were once attached to living plants but have since been deposited
          and are no longer living.
        |||,
        'gee:units': units.area_density_megagrams_per_hectare,
      },
      {
        name: 'agb_uncertainty',
        description: |||
          Uncertainty of estimated aboveground living biomass carbon density of combined
          woody and herbaceous cover in 2010. Uncertainty represents the cumulative standard error
          that has been propagated through the harmonization process using summation in quadrature.
        |||,
        'gee:units': units.area_density_megagrams_per_hectare,
      },
      {
        name: 'bgb',
        description: |||
          Belowground living biomass carbon stock density of combined woody and herbaceous
          cover in 2010. This includes carbon stored in living plant tissues that are located below
          the earth's surface (roots). This does not include dead and/or dislocated root tissue, nor
          does it include soil organic matter.
        |||,
        'gee:units': units.area_density_megagrams_per_hectare,
      },
      {
        name: 'bgb_uncertainty',
        description: |||
          Uncertainty of estimated belowground living biomass carbon density of combined
          woody and herbaceous cover in 2010. Uncertainty represents the cumulative standard error
          that has been propagated through the harmonization process using summation in quadrature.
        |||,
        'gee:units': units.area_density_megagrams_per_hectare,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Aboveground biomass carbon',
        lookat: {
          lat: 7.0,
          lon: -60.0,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              -50.0,
            ],
            max: [
              80.0,
            ],
            palette: [
              'd9f0a3',
              'addd8e',
              '78c679',
              '41ab5d',
              '238443',
              '005a32',
            ],
            bands: [
              'agb',
            ],
          },
        },
      },
    ],
    agb: {
      minimum: 0.0,
      maximum: 129.0,
      'gee:estimated_range': true,
    },
    agb_uncertainty: {
      minimum: 0.0,
      maximum: 85.0,
      'gee:estimated_range': true,
    },
    bgb: {
      minimum: 0.0,
      maximum: 57.0,
      'gee:estimated_range': true,
    },
    bgb_uncertainty: {
      minimum: 0.0,
      maximum: 37.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.3334/ORNLDAAC/1763',
  'sci:citation': |||
    Spawn, S.A., Sullivan, C.C., Lark, T.J. et al. Harmonized global maps of above and
    belowground biomass carbon density in the year 2010. Sci Data 7, 112 (2020).
    [doi:10.1038/s41597-020-0444-4](https://doi.org/10.1038/s41597-020-0444-4)
  |||,
  'sci:publications': [
    {
      citation: |||
        Spawn, S.A., and H.K. Gibbs. 2020. Global Aboveground and Belowground
        Biomass Carbon Density Maps for the Year 2010. ORNL DAAC, Oak Ridge, Tennessee, USA.
      |||,
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
  'gee:user_uploaded': true,
}
