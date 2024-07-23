local id = 'NASA/EMIT/L1B/RAD';
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
  title: 'EMIT L1B At-Sensor Calibrated Radiance and Geolocation Data 60 m',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description + |||
     The EMIT Level 1B At-Sensor Calibrated Radiance and Geolocation
     (EMITL1BRAD) Version 1 data product provides at-sensor calibrated radiance
     values along with observation data in a spatially raw, non-orthocorrected
     format.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'daily',
    'emit',
    'nasa',
    'radiance',
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
        name: 'radiance_fwhm',
        description: |||
          An array of length 285, where the value at index i is the full width
          at half maximum setting for radiance band i.
        |||,
        type: ee_const.var_type.double_list,
      },
      {
        name: 'radiance_wavelengths',
        description: |||
          An array of length 285, where the value at index i is the wavelength
          center setting for radiance band i.
        |||,
        type: ee_const.var_type.double_list,
      },
    ],
    gsd: [
      60.0,
    ],
    'eo:bands': [
      {
        name: 'radiance_' + x,
        description: |||
          Radiance observed for the corresponding radiance_fwhm and
          radiance_wavelengths settings at index 
        ||| + x,
        'gee:units': units.radiance_nanowatts_cm2_nanometers,
      } for x in std.range(0, 284)
    ] + [
      {
        name: 'elev',
        description: 'Total elevation',
        'gee:units': units.meter,
      },
      {
        name: 'path_length',
        description: 'Distance between sensor and ground',
        'gee:units': units.meter,
      },
      {
        name: 'to_sensor_azimuth',
        description: '0 to 360 degrees clockwise from N',
        'gee:units': units.degree,
      },
      {
        name: 'to_sensor_zenith',
        description: '0 to 90 degrees from zenith',
        'gee:units': units.degree,
      },
      {
        name: 'to_sun_azimuth',
        description: '0 to 360 degrees clockwise from N',
        'gee:units': units.degree,
      },
      {
        name: 'to_sun_zenith',
        description: '0 to 90 degrees from zenith',
        'gee:units': units.degree,
      },
      {
        name: 'solar_phase',
        description: |||
          Degrees between to-sensor and to-sun vectors in principal plane
        |||,
        'gee:units': units.degree,
      },
      {
        name: 'slope',
        description: |||
          Local surface slope as derived from Digital Elevation Model (DEM) in
          degrees
        |||,
        'gee:units': units.degree,
      },
      {
        name: 'aspect',
        description: 'Local surface aspect 0 to 360 degrees clockwise from N',
        'gee:units': units.degree,
      },
      {
        name: 'cosine_i',
        description: |||
          Apparent local illumination factor based on DEM slope and aspect and
          to sun vector, 0 to 1
        |||,
      },
      {
        name: 'utc_time',
        description: 'Fractional hours since UTC midnight',
        'gee:units': units.hour,
      },
      {
        name: 'earth_sun_distance',
        description: 'Distance between the Earth and the Sun',
        'gee:units': units.astronomical_unit,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Emit Radiance',
        lookat: {
          lon: -100.24,
          lat: 32.04,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              10.0,
            ],
            bands: [
              'radiance_1',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/EMIT/EMITL1BRAD.001',
  'sci:citation': |||
    Green, R. (2022). EMIT L1B At-Sensor Calibrated Radiance and Geolocation
    Data 60 m V001 dataset. NASA EOSDIS Land Processes Distributed Active
    Archive Center. Accessed 2024-05-20 from
    [https://doi.org/10.5067/EMIT/EMITL1BRAD.001](https://doi.org/10.5067/EMIT/EMITL1BRAD.001)
  |||,
  'gee:interval': template.interval,
  'gee:terms_of_use': template.gee_terms_of_use
}
