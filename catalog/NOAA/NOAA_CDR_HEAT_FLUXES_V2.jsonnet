local id = 'NOAA/CDR/HEAT_FLUXES/V2';
local subdir = 'NOAA';

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
  title: 'NOAA CDR: Ocean Heat Fluxes, Version 2',
  version: 'V2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Ocean Heat Fluxes dataset is part of the NOAA Ocean Surface Bundle (OSB)
    and provides a high quality Climate Data Record (CDR) of the air/ocean heat
    fluxes over ice-free oceans.

    This dataset is calculated from the OSB CDR parameters of near-surface
    atmospheric and sea surface temperature using a neural-network
    emulator of the TOGA-COARE Bulk Air-Sea Flux Algorithm.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V59K4885',
    },
  ],
  'gee:categories': ['oceans'],
  keywords: [
    'atmospheric',
    'cdr',
    'flux',
    'heat',
    'hourly',
    'noaa',
    'ocean',
    'osb',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncei.noaa.gov/products/climate-data-records/ocean-heat-fluxes'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1988-01-01T00:00:00Z', '2021-08-31T00:00:00Z'),
  summaries: {
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: 'surface_upward_latent_heat_flux',
        description: |||
          Flux of heat from the Earth's surface to the atmosphere which causes a
          change in phase of matter, e.g. evaporation of water at the surface and
          subsequent condensation of water vapor in the troposphere
        |||,
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'surface_upward_sensible_heat_flux',
        description: |||
          Flux of heat from the Earth's surface to the atmosphere which causes a
          change in air temperature, primarily through conduction and convection
        |||,
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'fill_missing_qc',
        description: 'Quality control flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Quality control flags',
              bit_count: 3,
              values: [
                {
                  description: 'Pixel values from neural network',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Unused flag',
                },
                {
                  value: 2,
                  description: 'Snow/ice',
                },
                {
                  value: 3,
                  description: 'Over land',
                },
                {
                  value: 4,
                  description: 'Over lake',
                },
                {
                  value: 5,
                  description: 'High winds; wind speed greater than 45 m/s is clamped to 45 m/s',
                },
                {
                  value: 6,
                  description: 'Failed interpolation, fluxes unresolved',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Heat Flux',
        lookat: {
          lat: -18.98,
          lon: 28.61,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -50.0,
            ],
            max: [
              500.0,
            ],
            bands: [
              'surface_upward_sensible_heat_flux',
              'surface_upward_sensible_heat_flux',
              'surface_upward_latent_heat_flux',
            ],
          },
        },
      },
    ],
    surface_upward_latent_heat_flux: {
      minimum: -50.0,
      maximum: 500.0,
      'gee:estimated_range': true,
    },
    surface_upward_sensible_heat_flux: {
      minimum: -299.99,
      maximum: 1499.93,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V59K4885',
  'sci:citation': |||
    Clayson, Carol Anne, Brown, Jeremiah, and NOAA CDR Program (2016). NOAA
    Climate Data Record Ocean Surface Bundle (OSB) Climate Data Record (CDR) of
    Ocean Heat Fluxes, Version 2. [indicate subset used]. NOAA National Climatic
    Data Center. [doi:10.7289/V59K4885](https://doi.org/10.7289/V59K4885).
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 3,
  },
  'gee:terms_of_use': |||
    The NOAA CDR Program's official distribution point for CDRs is NOAA's
    National Climatic Data Center which provides sustained, open access and
    active data management of the CDR packages and related information in
    keeping with the United States' open data policies and practices as
    described in the President's Memorandum on \"Open Data Policy\" and pursuant
    to the Executive Order of May 9, 2013, \"Making Open and Machine Readable
    the New Default for Government Information\". In line with these policies,
    the CDR data sets are nonproprietary, publicly available, and no
    restrictions are placed upon their use. For more information, see the
    [Fair Use of NOAA's CDR Data Sets, Algorithms and Documentation](https://www1.ncdc.noaa.gov/pub/data/sds/cdr/CDRs/Aerosol_Optical_Thickness/UseAgreement_01B-04.pdf)
    pdf.
  |||,
}
