local id = 'ECMWF/CAMS/NRT';
local subdir = 'ECMWF';
local version = '1';

local cds_notice = import 'templates/cds_notice.libsonnet';
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
  title: 'Copernicus Atmosphere Monitoring Service (CAMS) Global Near-Real-Time',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: cds_notice.body + |||

    The Copernicus Atmosphere Monitoring Service provides the capacity to
    continuously monitor the composition of the Earth's atmosphere at global and
    regional scales. The main global near-real-time production system is a data
    assimilation and forecasting suite providing two 5-day forecasts per day for
    aerosols and chemical compounds that are part of the chemical scheme.

    Prior to 2021-07-01 only two parameters were available,
    1. Total Aerosol Optical Depth at 550 nm surface
    2. Particulate matter d < 25 um surface
    Note that system:time_start refers to forecast time.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.license,
      href: 'https://ads.atmosphere.copernicus.eu/api/v2/terms/static/licence-to-use-copernicus-products.pdf',
      type: ee_const.media_type.pdf,
    },
  ],
  keywords: [
    'aerosol',
    'atmosphere',
    'climate',
    'copernicus',
    'ecmwf',
    'forecast',
    'particulate_matter',
  ],
  providers: [
    ee.producer_provider(
      'European Centre for Medium-Range Weather Forecasts (ECMWF)',
      'https://ads.atmosphere.copernicus.eu/cdsapp#!/dataset/cams-global-atmospheric-composition-forecasts'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2016-06-22T12:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'model_initialization_hour',
        description: 'Product creation hour',
        type: ee_const.var_type.int,
      },
      {
        name: 'model_initialization_datetime',
        description: 'Product creation time and date',
        type: ee_const.var_type.string,
      },
      {
        name: 'model_forecast_hour',
        description: 'Product forecast hour',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      44528.0,
    ],
    'eo:bands': [
      {
        name: 'total_aerosol_optical_depth_at_550nm_surface',
        description: 'Total Aerosol Optical Depth at 550 nm',
      },
      {
        name: 'particulate_matter_d_less_than_25_um_surface',
        description: 'Particulate matter d < 2.5 um',
        'gee:units': units.density_si,
      },
      {
        name: 'total_column_nitrogen_dioxide_surface',
        description: 'Total column Nitrogen dioxide surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column_sulphur_dioxide_surface',
        description: 'Total column Sulfur dioxide surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column_carbon_monoxide_surface',
        description: 'Total column Carbon monoxide surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column_formaldehyde_surface',
        description: 'Total column Formaldehyde surface',
        'gee:units': units.area_density,
      },
      {
        name: 'gems_total_column_ozone_surface',
        description: 'Gems Total column ozone surface',
      },
      {
        name: 'sea_salt_aerosol_optical_depth_at_550nm_surface',
        description: 'Sea Salt Aerosol Optical Depth at 550 nm surface',
      },
      {
        name: 'dust_aerosol_optical_depth_at_550nm_surface',
        description: 'Dust Aerosol Optical Depth at 550 nm surface',
      },
      {
        name: 'organic_matter_aerosol_optical_depth_at_550nm_surface',
        description: 'Organic Matter Aerosol Optical Depth at 550 nm surface',
      },
      {
        name: 'black_carbon_aerosol_optical_depth_at_550nm_surface',
        description: 'Black Carbon Aerosol Optical Depth at 550 nm surface',
      },
      {
        name: 'sulphate_aerosol_optical_depth_at_550nm_surface',
        description: 'Sulfate Aerosol Optical Depth at 550 nm surface',
      },
      {
        name: 'total_aerosol_optical_depth_at_469nm_surface',
        description: 'Total Aerosol Optical Depth at 469 nm surface',
      },
      {
        name: 'total_aerosol_optical_depth_at_670nm_surface',
        description: 'Total Aerosol Optical Depth at 670 nm surface',
      },
      {
        name: 'total_aerosol_optical_depth_at_865nm_surface',
        description: 'Total Aerosol Optical Depth at 865nm surface',
      },
      {
        name: 'total_aerosol_optical_depth_at_1240nm_surface',
        description: 'Total Aerosol Optical Depth at 1240 nm surface',
      },
      {
        name: 'var98-0-210-250_surface',
        description: 'Nitrate aerosol optical depth at 550 nm',
      },
      {
        name: 'var98-0-210-251_surface',
        description: 'Ammonium aerosol optical depth at 550 nm',
      },
      {
        name: 'particulate_matter_d_less_than_1_um_surface',
        description: 'Particulate matter d < 1 um surface',
        'gee:units': units.density_si,
      },
      {
        name: 'particulate_matter_d_less_than_10_um_surface',
        description: 'Particulate matter d < 10 um surface',
        'gee:units': units.density_si,
      },
      {
        name: 'uv_biologically_effective_dose_surface',
        description: 'UV biologically effective dose surface',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'total_column__peroxyacetyl_nitrate_surface',
        description: 'Total column peroxyacetyl nitrate surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column__isoprene_surface',
        description: 'Total column isoprene surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column_nitrogen_monoxide_surface',
        description: 'Total column nitrogen monoxide surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column_hydrogen_peroxide_surface',
        description: 'Total column hydrogen peroxide surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column_hydroxyl_radical_surface',
        description: 'Total column hydroxyl radical surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column_methane_surface',
        description: 'Total column methane surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column__ethane_surface',
        description: 'Total column ethane surface',
      },
      {
        name: 'total_column_propane_surface',
        description: 'Total column propane surface',
        'gee:units': units.area_density,
      },
      {
        name: 'total_column_nitric_acid_surface',
        description: 'Total column nitric acid surface',
        'gee:units': units.area_density,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Total Aerosal Optical Depth at 550 nm surface',
        lookat: {
          lat: 16.8,
          lon: -94.18,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              9.6e-05,
            ],
            max: [
              3.582552,
            ],
            palette: [
              '5e4fa2',
              '3288bd',
              '66c2a5',
              'abe0a4',
              'e6f598',
              'ffffbf',
              'fee08b',
              'fdae61',
              'f46d43',
              'd53e4f',
              '9e0142',
            ],
            bands: [
              'total_aerosol_optical_depth_at_550nm_surface',
            ],
          },
        },
      },
    ],
    total_aerosol_optical_depth_at_550nm_surface: {
      minimum: 9.6e-05,
      maximum: 3.582552,
      'gee:estimated_range': true,
    },
    particulate_matter_d_less_than_25_um_surface: {
      minimum: 0.0,
      maximum: 7.6e-05,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.1029/2008JD011115',
  'sci:citation': |||
    Benedetti, A., and Coauthors, 2009: Aerosol analysis and forecast in the
    ECMWF Integrated Forecast System. Part II : Data assimilation,
    J. Geophys. Res., 114, D13205
    [doi:10.1029/2008JD011115](https://doi.org/10.1029/2008JD011115).
  |||,
  'sci:publications': [
    {
      citation: |||
        Morcrette, and Coauthors, 2009: Aerosol analysis and forecast in the
        ECMWF Integrated Forecast System. Part I: Forward modelling,
        J. Geophys. Res., 114, D06206.
        [doi:10.1029/2008JD011235](https://doi.org/10.1029/2008JD011235)
      |||,
      doi: '10.1029/2008JD011235',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    There is no restriction on use or reproduction and redistribution, with or
    without adaptation, for commercial or non-commercial purposes. This data
    policy applies to the data and information generated within the Copernicus
    programme, i.e., Sentinel mission data and Copernicus service information.

    See the
    [full COPERNICUS data license](https://ads.atmosphere.copernicus.eu/api/v2/terms/static/licence-to-use-copernicus-products.pdf).

    The license clauses with attribution requirements are shown below:

    5.1.1. Where the Licensee communicates or distributes Copernicus Products to
    the public, the Licensee shall inform the recipients of the source by using
    the following or any similar notice:

    * 'Generated using Copernicus Climate Change Service information [Year]'
      and/or
    * 'Generated using Copernicus Atmosphere Monitoring Service information
      [Year]'.

    5.1.2. Where the Licensee makes or contributes to a publication or
    distribution containing adapted or modified Copernicus Products, the
    Licensee shall provide the following or any similar notice:

    * 'Contains modified Copernicus Climate Change Service information [Year]';
      and/or
    * 'Contains modified Copernicus Atmosphere Monitoring Service information
      [Year]'

    5.1.3. Any such publication or distribution covered by clauses 5.1.1 and

    5.1.2 shall state that neither the European Commission nor ECMWF is
    responsible for any use that may be made of the Copernicus information or
    data it contains.
  |||,
}
