local id = 'NASA/EMIT/L2A/RFL';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local template = import 'NASA_EMIT_L2B.libsonnet';
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
  title: 'EMIT L2A Estimated Surface Reflectance and Uncertainty and Masks 60 m',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description + |||
     The Level 2A data product contains estimated surface reflectance,
     uncertainty, and mask data. In addition, the geolocation of all pixel
     centers is included as well as the calculation of observation geometry and
     illumination angles on a pixel-by-pixel basis.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'daily',
    'emit',
    'nasa',
    'reflectance',
  ],
  providers: [
    ee.producer_provider('NASA Jet Propulsion Laboratory', 'https://earth.jpl.nasa.gov/emit/data/data-products/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-08-09T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'ORBIT',
        description: 'Unique Orbit Identification Number',
        type: ee_const.var_type.string,
      },
      {
        name: 'ORBIT_SEGMENT',
        description: 'Orbit Segment',
        type: ee_const.var_type.string,
      },
      {
        name: 'SCENE',
        description: 'Unique scene identification number',
        type: ee_const.var_type.string,
      },
      {
        name: 'SOLAR_AZIMUTH',
        description: 'Solar Azimuth',
        type: ee_const.var_type.string,
      },
      {
        name: 'SOLAR_ZENITH',
        description: 'Solar Zenith',
        type: ee_const.var_type.string,
      },
      {
        name: 'reflectance_fwhm',
        description: |||
          An array of length 285, where the value at index i is the full width
          at half maximum setting for reflectance band i.
        |||,
        type: ee_const.var_type.double_list,
      },
      {
        name: 'reflectance_wavelengths',
        description: |||
          An array of length 285, where the value at index i is the wavelength
          center setting for reflectance band i.
        |||,
        type: ee_const.var_type.double_list,
      },
    ],
    gsd: [
      60.0,
    ],
    'eo:bands': [
      {
        name: 'reflectance_' + x,
        description: |||
          Reflectance observed for the corresponding reflectance_fwhm and
          reflectance_wavelengths settings at index 
        ||| + x,
        'gee:units': units.spectral_reflectance,
      } for x in std.range(0, 284)
    ] + [
      {
        name: 'reflectance_uncertainity_' + x,
        description: |||
          Reflectance uncertainty observed for the corresponding
          reflectance_fwhm and reflectance_wavelengths settings at index 
        ||| + x,
        'gee:units': units.standard_deviation,
      } for x in std.range(0, 284)
    ] + [
      {
        name: 'elev',
        description: 'Total elevation',
        'gee:units': units.meter,
      },
      {
        name: 'cloud_flag',
        description: 'Cloud Coverage',
      },
      {
        name: 'cirrus_flag',
        description: 'Dense Cirrus clouds',
      },
      {
        name: 'water_flag',
        description: 'Water bodies',
      },
      {
        name: 'spacecraft_flag',
        description: |||
          Spacecraft or space station components that intersect the EMIT field
          of view
        |||,
      },
      {
        name: 'dilated_cloud_flag',
        description: 'Cloud coverage + buffer',
      },
      {
        name: 'AOD550',
        description: |||
          Aerosol Optical Depth at 550nm estimates
        |||,
      },
      {
        name: 'H2O',
        description: |||
          Water Vapor estimates
        |||,
        'gee:units': units.surface_density,
      },
      {
        name: 'aggregate_flag',
        description: |||
          Aggregated binary flag of bands, included flags are cloud, cirrus,
          water, spacecraft, and dilated cloud
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Emit Reflectance',
        lookat: {
          lon: -121.4612,
          lat: 38.334,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              0.1,
            ],
            bands: [
              'reflectance_1',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/EMIT/EMITL2ARFL.001',
  'sci:citation': |||
    Green, R. (2022). EMIT L2A Estimated Surface Reflectance and Uncertainty and
    Masks 60 m V001 [Data set]. NASA EOSDIS Land Processes Distributed Active
    Archive Center. Accessed 2024-06-14 from
    [https://doi.org/10.5067/EMIT/EMITL2ARFL.001](https://doi.org/10.5067/EMIT/EMITL2ARFL.001)
  |||,
  'gee:interval': template.interval,
  'gee:terms_of_use': template.gee_terms_of_use
}
