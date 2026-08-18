local ee_const = import 'earthengine_const.libsonnet';
local units = import 'units.libsonnet';

local common_schema = [
  {
    name: 'cloud_cover',
    description: 'Scene-wide cloud cover estimate',
    type: ee_const.var_type.double,
    units: units.percent,
  },
  {
    name: 'grid_reference',
    description: 'The K-J grid reference identifies the nominal scene center, where K is the column and J is the row of the SPOT Grid Reference System (GRS).',
    type: ee_const.var_type.string,
  },
  {
    name: 'high_quality',
    description: 'Set to TRUE for all images.',
    type: ee_const.var_type.string,
  },
  {
    name: 'incidence_angle',
    description: 'Incidence angle',
    type: ee_const.var_type.double,
    units: units.degree,
  },
  {
    name: 'instrument',
    description: 'Imaging instrument',
    type: ee_const.var_type.string,
  },
  {
    name: 'job_id',
    description: 'Provider-set field denoting unique identifier for processing job.',
    type: ee_const.var_type.string,
  },
  {
    name: 'nadir_lat',
    description: 'Nadir latitude',
    type: ee_const.var_type.double,
    units: units.degree,
  },
  {
    name: 'nadir_lon',
    description: 'Nadir longitude',
    type: ee_const.var_type.double,
    units: units.degree,
  },
  {
    name: 'pixel_size_meters',
    description: 'Nominal scale',
    type: ee_const.var_type.double,
    units: units.meter,
  },
  {
    name: 'processing_level',
    description: 'Indicates the level of radiometric and geometric correction applied. Possible values: 1A (radiometric only)',
    type: ee_const.var_type.string,
  },
  {
    name: 'product_id',
    description: 'Scene identifier',
    type: ee_const.var_type.string,
  },
  {
    name: 'production_date',
    description: 'Date of processing.',
    type: ee_const.var_type.string,
  },
  {
    name: 'satellite',
    description: 'Source satellite: "SPOT2", "SPOT4", or "SPOT5"',
    type: ee_const.var_type.string,
  },
  {
    name: 'satellite_altitude',
    description: 'Satellite orbit altitude',
    type: ee_const.var_type.double,
    units: units.kilometer,
  },
  {
    name: 'sensor_gain_number',
    description: 'Calibration coefficient for converting DNs to radiance for sensor',
    type: ee_const.var_type.double,
  },
  {
    name: 'sensor_gain_value',
    description: 'Calibration coefficient for converting DNs to radiance for sensor',
    type: ee_const.var_type.double,
  },
  {
    name: 'software',
    description: 'Processing software',
    type: ee_const.var_type.string,
  },
  {
    name: 'source_id',
    description: 'Dataset_Sources/Source_Information/SOURCE_ID',
    type: ee_const.var_type.string,
  },
  {
    name: 'sun_azimuth',
    description: 'Sun azimuth',
    type: ee_const.var_type.double,
    units: units.degree,
  },
  {
    name: 'sun_elevation',
    description: 'Sun elevation',
    type: ee_const.var_type.double,
    units: units.degree,
  },
  {
    name: 'viewing_angle',
    description: 'Viewing angle',
    type: ee_const.var_type.double,
    units: units.degree,
  },
];

local common_properties = {
  sun_azimuth: {minimum: 0.0, maximum: 360.0, 'gee:estimated_range': false},
  sun_elevation: {minimum: 0.0, maximum: 90.0, 'gee:estimated_range': false},
  incidence_angle: {minimum: -35.0, maximum: 35.0, 'gee:estimated_range': false},
  viewing_angle: {minimum: 0.0, maximum: 35.0, 'gee:estimated_range': false},
  cloud_cover: {minimum: 0.0, maximum: 100.0, 'gee:estimated_range': false},
  nadir_lat: { minimum: -90.0, maximum: 90.0, 'gee:estimated_range': false },
  nadir_lon: { minimum: -180.0, maximum: 180.0, 'gee:estimated_range': false },
};

local quality_schema = [
  {
    name: 'google_cloud_mask_qa',
    description: 'Google-added field denoting status of manual cloud masking QA. Possible values: "accept", "reject_for_cloud", "reject_for_other", "not_evaluated", or absent if QA has not been performed.',
    type: ee_const.var_type.string,
  },
  {
    name: 'percent_valid_pixels',
    description: 'Google-added property denoting the percent of viable pixels after cloud and cloud shadow removal',
    type: ee_const.var_type.double,
    units: units.percent,
  },
];

local quality_properties = {
  percent_valid_pixels: {minimum: 0.0, maximum: 100.0, 'gee:estimated_range': false},
};

{
  pan_schema: common_schema + [
    {
      name: 'P_bias',
      description: 'Calibration coefficient for converting DNs to radiance for panchromatic band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um,
    },
    {
      name: 'P_gain',
      description: 'Calibration coefficient for converting DNs to radiance for panchromatic band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um_per_dn,
    },
    {
      name: 'P_irradiance',
      description: 'Per-band solar irradiance, essential for TOA reflectance calculations for panchromatic band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_um,
    },
  ],
  pan_properties: common_properties,

  pms_nc_schema: common_schema + quality_schema,
  pms_nc_properties: common_properties + quality_properties,

  ms_nc_schema: common_schema + quality_schema,
  ms_nc_properties: common_properties + quality_properties,

  ms_schema: common_schema + [
    {
      name: 'G_bias',
      description: 'Calibration coefficient for converting DNs to radiance for green band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um,
    },
    {
      name: 'G_gain',
      description: 'Calibration coefficient for converting DNs to radiance for green band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um_per_dn,
    },
    {
      name: 'G_irradiance',
      description: 'Per-band solar irradiance, essential for TOA reflectance calculations for green band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_um,
    },
    {
      name: 'N_bias',
      description: 'Calibration coefficient for converting DNs to radiance for near-infrared band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um,
    },
    {
      name: 'N_gain',
      description: 'Calibration coefficient for converting DNs to radiance for near-infrared band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um_per_dn,
    },
    {
      name: 'N_irradiance',
      description: 'Per-band solar irradiance, essential for TOA reflectance calculations for near-infrared band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_um,
    },
    {
      name: 'R_bias',
      description: 'Calibration coefficient for converting DNs to radiance for red band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um,
    },
    {
      name: 'R_gain',
      description: 'Calibration coefficient for converting DNs to radiance for red band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um_per_dn,
    },
    {
      name: 'R_irradiance',
      description: 'Per-band solar irradiance, essential for TOA reflectance calculations for red band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_um,
    },
    {
      name: 'S_bias',
      description: 'Calibration coefficient for converting DNs to radiance for short-wave infrared band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um,
    },
    {
      name: 'S_gain',
      description: 'Calibration coefficient for converting DNs to radiance for short-wave infrared band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_sr_um_per_dn,
    },
    {
      name: 'S_irradiance',
      description: 'Per-band solar irradiance, essential for TOA reflectance calculations for short-wave infrared band',
      type: ee_const.var_type.double,
      units: units.watt_per_meter_squared_um,
    },
  ],
  ms_properties: common_properties,
}
