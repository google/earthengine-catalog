local id = 'NOAA/CDR/SST_PATHFINDER/V53';
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
  title: 'NOAA AVHRR Pathfinder Version 5.3 Collated Global 4km Sea Surface Temperature',
  version: '5.3',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The AVHRR Pathfinder Version 5.3 Sea Surface Temperature dataset (PFV53)
    is a collection of global, twice-daily 4km sea surface temperature data
    produced in a partnership by the NOAA National Oceanographic Data Center
    and the University of Miami's Rosenstiel School of Marine and Atmospheric
    Science. PFV53 was computed from data from the AVHRR instruments
    on board NOAA's polar orbiting satellite series using an entirely
    modernized system based on SeaDAS. PFV53 data are nearly 100%
    compliant with the GHRSST Data Specification Version 2.0 for L3C
    products and only deviate from that standard in that 'sses_bias',
    'sses_standard_deviation', and 'sst_dtime' variables are empty and hence
    not included into EE assets. PFV53 data were collected through the
    operational periods of the NOAA-7 through NOAA-19 Polar Operational
    Environmental Satellites (POES), and are available from 1981 to 2014.
    Additional information is available at the
    [NOAA Pathfinder site](https://www.nodc.noaa.gov/satellitedata/pathfinder4km53/).

    Additional band details can be found in the
    [Tech Specs](https://www.ncei.noaa.gov/pub/data/sds/cdr/CDRs/Sea_Surface_Temperature_Pathfinder/AlgorithmDescription_01B-08.pdf)
    page.

    These data were provided by GHRSST and the US NOAA National
    Centers for Environmental Information (NCEI). This project was
    supported in part by a grant from the NOAA Climate Data Record (CDR)
    Program for satellites.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V52J68XX',
    },
  ],
  keywords: [
    'avhrr',
    'noaa',
    'pathfinder',
    'sea_ice',
    'sst',
    'temperature',
    'wind',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncei.noaa.gov/products/avhrr-pathfinder-sst'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1981-08-24T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'aerosol_dynamic_indicator_offset',
        description: 'Aerosol dynamic indicator offset',
        type: ee_const.var_type.double,
      },
      {
        name: 'aerosol_dynamic_indicator_scale',
        description: 'Aerosol dynamic indicator scale',
        type: ee_const.var_type.double,
      },
      {
        name: 'date_created',
        description: 'Date created',
        type: ee_const.var_type.double,
      },
      {
        name: 'day_or_night',
        description: 'Day or night',
        type: ee_const.var_type.string,
      },
      {
        name: 'dt_analysis_scale',
        description: 'Dt analysis scale',
        type: ee_const.var_type.double,
      },
      {
        name: 'orbit_node',
        description: 'Orbit node',
        type: ee_const.var_type.string,
      },
      {
        name: 'platform',
        description: 'Platform',
        type: ee_const.var_type.string,
      },
      {
        name: 'principal_day_for_collated_orbits',
        description: 'Principal day for collated orbits',
        type: ee_const.var_type.string,
      },
      {
        name: 'principal_year_for_collated_orbits',
        description: 'Principal year for collated orbits',
        type: ee_const.var_type.double,
      },
      {
        name: 'sea_ice_fraction_scale',
        description: 'Sea ice fraction scale',
        type: ee_const.var_type.double,
      },
      {
        name: 'sea_surface_temperature_offset',
        description: 'Sea surface temperature offset',
        type: ee_const.var_type.double,
      },
      {
        name: 'sea_surface_temperature_scale',
        description: 'Sea surface temperature scale',
        type: ee_const.var_type.double,
      },
      {
        name: 'uuid',
        description: 'Universal unique identifier',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4000.0,
    ],
    'eo:bands': [
      {
        name: 'sea_surface_temperature',
        description: 'Skin temperature of the ocean',
        'gee:units': units.kelvin,
        'gee:scale': 0.01,
        'gee:offset': 273.15,
      },
      {
        name: 'dt_analysis',
        description: "The difference between this SST and the previous day's.",
        'gee:units': units.kelvin,
        'gee:scale': 0.1,
      },
      {
        name: 'wind_speed',
        description: |||
          These wind speeds were created by NCEP-DOE Atmospheric Model
          Intercomparison Project (AMIP-II) reanalysis (R-2) and represent winds at
          10 meters above the sea surface.
        |||,
        'gee:units': units.velocity_si,
      },
      {
        name: 'sea_ice_fraction',
        description: |||
          Sea ice concentration data are taken from the EUMETSAT Ocean
          and Sea Ice Satellite Application Facility (OSISAF) [Global Daily Sea Ice
          Concentration Reprocessing Data Set
          accession.nodc.noaa.gov/0068294](https://data.cnra.ca.gov/dataset/global-daily-sea-ice-concentration-reprocessing-data-set-for-1978-2007-from-the-eumetsat-ocean-) when these data are available.
          The data are reprojected and interpolated from their original polar
          stereographic projection at 10km spatial resolution to the 4km Pathfinder
          Version 5.3 grid. When the OSISAF data are not available for both
          hemispheres on a given day, the sea ice concentration data are taken from
          the sea_ice_fraction variable found in the L4 GHRSST DailyOI SST product
          from NOAA/NCDC, and are interpolated from the 25km DailyOI grid to the 4km
          Pathfinder Version 5.3 grid.
        |||,
        'gee:scale': 0.01,
      },
      {
        name: 'aerosol_dynamic_indicator',
        description: |||
          Aerosol optical thickness (100 KM) data are taken from the
          CLASS AERO100 products, which are created from AVHRR channel 1 optical
          thickness retrievals from AVHRR global area coverage (GAC) data. The
          aerosol optical thickness measurements are interpolated from their
          original 1 degree x 1 degree resolution to the 4km Pathfinder Version
          5.3 grid.
        |||,
        'gee:scale': 0.01,
        'gee:offset': 1.1,
      },
      {
        name: 'quality_level',
        description: |||
          Note, the native Pathfinder processing system returns
          quality levels ranging from 0 to 7 (7 is best quality; -1 represents
          missing data) and has been converted to the extent possible into
          the six levels required by the GDS2 (ranging from 0 to 5, where 5
          is best). Below is the conversion table:

          - GDS2 required quality_level 5 = native Pathfinder quality
            level 7 == best_quality

          - GDS2 required quality_level 4 = native Pathfinder quality
            level 4-6 == acceptable_quality

          - GDS2 required quality_level 3 = native Pathfinder quality
            level 2-3 == low_quality

          - GDS2 required quality_level 2 = native Pathfinder
            quality level 1 == worst_quality

          - GDS2 required quality_level 1 = native Pathfinder quality
            level 0 = bad_data

          - GDS2 required quality_level 0 = native Pathfinder quality
            level -1 = missing_data

          The original Pathfinder quality level is recorded in the optional
          variable pathfinder_quality_level.
        |||,
      },
      {
        name: 'pathfinder_quality_level',
        description: |||
          The native Pathfinder processing system quality levels,
          ranging from 0 to 7, where 0 is worst and 7 is best.
        |||,
      },
      {
        name: 'l2p_flags',
        description: |||
          Used to specify the type of input SST data and pass
          through native flags from the input L2 SST data set.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Type of input SST data.',
              bit_count: 1,
              values: [
                {
                  description: 'Always set to zero to indicate infrared data.',
                  value: 0,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Land',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Input pixel is classified as over ocean.',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Pixel area is >= 50% land as determined by
                    rasterizing the Global Self-consistent Hierarchical High-resolution
                    Shoreline (GSHHS) Database from the NOAA National Geophysical Data
                    Center.
                  |||,
                },
              ],
            },
            {
              description: 'Sea ice fraction',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: "'sea_ice_fraction' is less than 0.15.",
                  value: 0,
                },
                {
                  value: 1,
                  description: "'sea_ice_fraction' is 0.15 or greater.",
                },
              ],
            },
            {
              description: 'Lake',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel area is < 50% lake covered.',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Pixel area is >= 50% lake covered as determined from
                    rasterizing US World Wildlife Fund's Global Lakes and Wetlands
                    Database.
                  |||,
                },
              ],
            },
            {
              description: 'River',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel area is < 50% river covered.',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Pixel area is >= 50% river covered as determined form
                    rasterizing US World Wildlife Fund's Global Lakes and Wetlands
                    Database.
                  |||,
                },
              ],
            },
          ],
          total_bit_count: 5,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Sea Surface Temperature',
        lookat: {
          lat: -2.11,
          lon: -121.99,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              2500.0,
            ],
            palette: [
              '030d81',
              '0519ff',
              '05e8ff',
              '11ff01',
              'fbff01',
              'ff9901',
              'ff0000',
              'ad0000',
            ],
            bands: [
              'sea_surface_temperature',
            ],
          },
        },
      },
    ],
    sea_surface_temperature: {
      minimum: -300.0,
      maximum: 3999.0,
      'gee:estimated_range': true,
    },
    dt_analysis: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    wind_speed: {
      minimum: 0.0,
      maximum: 47.0,
      'gee:estimated_range': true,
    },
    sea_ice_fraction: {
      minimum: 8.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    aerosol_dynamic_indicator: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    quality_level: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': false,
    },
    pathfinder_quality_level: {
      minimum: 0.0,
      maximum: 7.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.7289/V52J68XX',
  'sci:citation': |||
    Baker-Yeboah, S., K. Saha, D. Zhang, K. S. Casey, R. Evans,
    and K. A. Kilpatrick (2016). 'Pathfinder Version 5.3 AVHRR Sea Surface
    Temperature Climate Data Record', Fall AGU 2016 Poster
    (manuscript in progress)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 12,
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use. The
    forgoing data is in the public domain and is being provided without
    restriction on use and distribution. For more information see the
    'constraints' section in
    [https://data.nodc.noaa.gov/cgi-bin/iso?id=gov.noaa.nodc:AVHRR_Pathfinder-NCEI-L3C-v5.3](https://data.nodc.noaa.gov/cgi-bin/iso?id=gov.noaa.nodc:AVHRR_Pathfinder-NCEI-L3C-v5.3).
  |||,
}
